From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v4 3/3] pwm: core: add consumer device link
Date: Thu, 14 Feb 2019 11:25:51 +0100
Message-ID: <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: u.kleine-koenig@pengutronix.de, tduszyns@gmail.com, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Add a device link between the PWM consumer and the PWM provider. This
enforces the PWM user to get suspended before the PWM provider. It
allows proper synchronization of suspend/resume sequences: the PWM user
is responsible for properly stopping PWM, before the provider gets
suspended: see [1]. Add the device link in:
- of_pwm_get()
- pwm_get()
- devm_*pwm_get() variants
as it requires a reference to the device for the PWM consumer.

[1] https://lkml.org/lkml/2019/2/5/770

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v4:
- rework error handling following Thierry's comments
- turn/split pr_debug() into dev_err()/pr_warn().

Changes in v3:
- add struct device to of_get_pwm() arguments to handle device link from
  there as discussed with Uwe.
---
 drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h |  6 ++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..64e10a6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -636,8 +636,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct device_link *pwm_device_link_add(struct device *dev,
+					       struct pwm_device *pwm)
+{
+	struct device_link *dl;
+
+	if (!dev) {
+		/*
+		 * No device for the PWM consumer has been provided. It may
+		 * impact the PM sequence ordering: the PWM supplier may get
+		 * suspended before the consumer.
+		 */
+		pr_warn("no consumer dev, can't create device link to %s\n",
+			dev_name(pwm->chip->dev));
+		return NULL;
+	}
+
+	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!dl) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(pwm->chip->dev));
+			return ERR_PTR(-EINVAL);
+	}
+
+	return dl;
+}
+
 /**
  * of_pwm_get() - request a PWM via the PWM framework
+ * @dev: device for PWM consumer
  * @np: device node to get the PWM from
  * @con_id: consumer name
  *
@@ -655,10 +682,12 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id)
 {
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
+	struct device_link *dl;
 	struct pwm_chip *pc;
 	int index = 0;
 	int err;
@@ -689,6 +718,14 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (IS_ERR(pwm))
 		goto put;
 
+	dl = pwm_device_link_add(dev, pwm);
+	if (IS_ERR(dl)) {
+		/* of_xlate ended up calling pwm_request_from_chip() */
+		pwm_free(pwm);
+		pwm = ERR_CAST(dl);
+		goto put;
+	}
+
 	/*
 	 * If a consumer name was not given, try to look it up from the
 	 * "pwm-names" property if it exists. Otherwise use the name of
@@ -764,6 +801,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct pwm_device *pwm;
 	struct pwm_chip *chip;
+	struct device_link *dl;
 	unsigned int best = 0;
 	struct pwm_lookup *p, *chosen = NULL;
 	unsigned int match;
@@ -771,7 +809,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	/* look up via DT first */
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev->of_node, con_id);
+		return of_pwm_get(dev, dev->of_node, con_id);
 
 	/*
 	 * We look up the provider in the static table typically provided by
@@ -848,6 +886,12 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ERR(pwm))
 		return pwm;
 
+	dl = pwm_device_link_add(dev, pwm);
+	if (IS_ERR(dl)) {
+		pwm_free(pwm);
+		return ERR_CAST(dl);
+	}
+
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
 
@@ -939,7 +983,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	pwm = of_pwm_get(np, con_id);
+	pwm = of_pwm_get(dev, np, con_id);
 	if (!IS_ERR(pwm)) {
 		*ptr = pwm;
 		devres_add(dev, ptr);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d5199b5..895e074 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -406,7 +406,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id);
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
@@ -494,7 +495,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct pwm_device *of_pwm_get(struct device_node *np,
+static inline struct pwm_device *of_pwm_get(struct device *dev,
+					    struct device_node *np,
 					    const char *con_id)
 {
 	return ERR_PTR(-ENODEV);
-- 
1.9.1
