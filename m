From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/2] pwm: allow to fetch pwm via index
Date: Fri,  6 Feb 2015 19:18:48 +0100
Message-ID: <1423246729-4932-2-git-send-email-bigeasy@linutronix.de>
References: <1423246729-4932-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1423246729-4932-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pwm@vger.kernel.org

This patch introduces of_pwm_get_index() (and its devm based friend)
which works like of_pwm_get() except that you are able to specify which
pwm you need instead using a name (which is optional anyway).
This comes handy if you have multiple pwms specified in device tree and
you need to grab one by one (in a loop) and you don't have any specific
names for them.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/pwm/core.c  | 101 +++++++++++++++++++++++++++++++++++++---------------
 include/linux/pwm.h |  16 +++++++++
 2 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d10c6e..f9b679c5d9fa 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -493,35 +493,24 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 }
 
 /**
- * of_pwm_get() - request a PWM via the PWM framework
+ * of_pwm_get_index() - request a PWM via the PWM framework
  * @np: device node to get the PWM from
- * @con_id: consumer name
+ * @index: The number of the PWN within the property
  *
  * Returns the PWM device parsed from the phandle and index specified in the
  * "pwms" property of a device tree node or a negative error-code on failure.
  * Values parsed from the device tree are stored in the returned PWM device
  * object.
  *
- * If con_id is NULL, the first PWM device listed in the "pwms" property will
- * be requested. Otherwise the "pwm-names" property is used to do a reverse
- * lookup of the PWM index. This also means that the "pwm-names" property
- * becomes mandatory for devices that look up the PWM device via the con_id
- * parameter.
  */
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+struct pwm_device *of_pwm_get_index(struct device_node *np, int index)
 {
-	struct pwm_device *pwm = NULL;
+	struct pwm_device *pwm;
 	struct of_phandle_args args;
+	const char *con_id;
 	struct pwm_chip *pc;
-	int index = 0;
 	int err;
 
-	if (con_id) {
-		index = of_property_match_string(np, "pwm-names", con_id);
-		if (index < 0)
-			return ERR_PTR(index);
-	}
-
 	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
 					 &args);
 	if (err) {
@@ -547,23 +536,47 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (IS_ERR(pwm))
 		goto put;
 
-	/*
-	 * If a consumer name was not given, try to look it up from the
-	 * "pwm-names" property if it exists. Otherwise use the name of
-	 * the user device node.
-	 */
-	if (!con_id) {
-		err = of_property_read_string_index(np, "pwm-names", index,
-						    &con_id);
-		if (err < 0)
-			con_id = np->name;
+	err = of_property_read_string_index(np, "pwm-names", index,
+					    &con_id);
+	if (err < 0) {
+		con_id = np->name;
+		pwm->label = con_id;
 	}
-
-	pwm->label = con_id;
-
 put:
 	of_node_put(args.np);
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(of_pwm_get_index);
 
+/**
+ * of_pwm_get() - request a PWM via the PWM framework
+ * @np: device node to get the PWM from
+ * @con_id: consumer name
+ *
+ * Returns the PWM device parsed from the phandle and index specified in the
+ * "pwms" property of a device tree node or a negative error-code on failure.
+ * Values parsed from the device tree are stored in the returned PWM device
+ * object.
+ *
+ * If con_id is NULL, the first PWM device listed in the "pwms" property will
+ * be requested. Otherwise the "pwm-names" property is used to do a reverse
+ * lookup of the PWM index. This also means that the "pwm-names" property
+ * becomes mandatory for devices that look up the PWM device via the con_id
+ * parameter.
+ */
+struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+{
+	struct pwm_device *pwm;
+	int index = 0;
+
+	if (con_id) {
+		index = of_property_match_string(np, "pwm-names", con_id);
+		if (index < 0)
+			return ERR_PTR(index);
+	}
+
+	pwm = of_pwm_get_index(np, index);
+	pwm->label = con_id;
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(of_pwm_get);
@@ -740,6 +753,36 @@ struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id)
 EXPORT_SYMBOL_GPL(devm_pwm_get);
 
 /**
+ * devm_of_pwm_get_index() - resource managed of_pwm_get_index()
+ * @dev: device for PWM consumer
+ * @np: device node to get the PWM from
+ * @index: pwm index
+ *
+ * This function performs like of_pwm_get_index() but the acquired PWM device
+ * will automatically be released on driver detach.
+ */
+struct pwm_device *devm_of_pwm_get_index(struct device *dev,
+					 struct device_node *np, int index)
+{
+	struct pwm_device **ptr, *pwm;
+
+	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	pwm = of_pwm_get_index(np, index);
+	if (!IS_ERR(pwm)) {
+		*ptr = pwm;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(devm_of_pwm_get_index);
+
+/**
  * devm_of_pwm_get() - resource managed of_pwm_get()
  * @dev: device for PWM consumer
  * @np: device node to get the PWM from
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e90628cac8fa..91eb4404bc19 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -192,10 +192,13 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
+struct pwm_device *of_pwm_get_index(struct device_node *np, int index);
 struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
+struct pwm_device *devm_of_pwm_get_index(struct device *dev,
+					 struct device_node *np, int index);
 struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 				   const char *con_id);
 void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
@@ -235,6 +238,12 @@ static inline struct pwm_device *pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct pwm_device *of_pwm_get_index(struct device_node *np,
+						  int index)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct pwm_device *of_pwm_get(struct device_node *np,
 					    const char *con_id)
 {
@@ -251,6 +260,13 @@ static inline struct pwm_device *devm_pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct pwm_device *devm_of_pwm_get_index(struct device *dev,
+						 struct device_node *np,
+						 int index)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
 						 struct device_node *np,
 						 const char *con_id)
-- 
2.1.4
