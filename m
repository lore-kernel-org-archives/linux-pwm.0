From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v3 3/3] pwm: core: add consumer device link
Date: Wed, 13 Feb 2019 11:50:12 +0100
Message-ID: <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add a device link between the PWM consumer and the PWM provider. This
enforces the PWM user to get suspended before the PWM provider. It
allows proper synchronization of suspend/resume sequences: the PWM user
is responsible for properly stopping PWM, before the provider gets
suspended: see [1]. Add the device link in:
- of_pwm_get()
- pwm_get()
- devm_ variants
as it requires a reference to the device for the PWM consumer.

[1] https://lkml.org/lkml/2019/2/5/770

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v3:
- add struct device to of_get_pwm() arguments to handle device link from
  there.
---
 drivers/pwm/core.c  | 14 +++++++++++---
 include/linux/pwm.h |  6 ++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6a..8cb5d4bc 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 
 /**
  * of_pwm_get() - request a PWM via the PWM framework
+ * @dev: device for PWM consumer
  * @np: device node to get the PWM from
  * @con_id: consumer name
  *
@@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id)
 {
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
@@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (IS_ERR(pwm))
 		goto put;
 
+	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		pr_debug("%s(): device link not added\n", __func__);
+
 	/*
 	 * If a consumer name was not given, try to look it up from the
 	 * "pwm-names" property if it exists. Otherwise use the name of
@@ -771,7 +776,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	/* look up via DT first */
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev->of_node, con_id);
+		return of_pwm_get(dev, dev->of_node, con_id);
 
 	/*
 	 * We look up the provider in the static table typically provided by
@@ -851,6 +856,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
 
+	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
+		pr_debug("%s(): device link not added\n", __func__);
+
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(pwm_get);
@@ -939,7 +947,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
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
