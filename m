From: Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH V2 1/2] hwmon: pwm-fan: Add profile support and add remove module support
Date: Mon, 1 Jun 2020 11:49:13 +0530
Message-ID: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-hwmon-owner@vger.kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: treding@nvidia.com, jonathanh@nvidia.com, linux@roeck-us.net, kamil@wypas.org, jdelvare@suse.com, robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Cc: bbasu@nvidia.com, bbiswas@nvidia.com, kyarlagadda@nvidia.com, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Sandipan Patra <spatra@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

Add support for profiles mode settings.
This allows different fan settings for trip point temp/hyst/pwm.
Tegra194 has multiple fan-profiles support.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---

PATCH V2:
	Cleaned pwm_fan_remove support as it is not required.

 drivers/hwmon/pwm-fan.c | 92 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 30b7b3e..1d2a416 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -3,8 +3,10 @@
  * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2020, NVIDIA Corporation.
  *
  * Author: Kamil Debski <k.debski@samsung.com>
+ * Author: Sandipan Patra <spatra@nvidia.com>
  */
 
 #include <linux/hwmon.h>
@@ -21,6 +23,8 @@
 #include <linux/timer.h>
 
 #define MAX_PWM 255
+/* Based on OF max device tree node name length */
+#define MAX_PROFILE_NAME_LENGTH	31
 
 struct pwm_fan_ctx {
 	struct mutex lock;
@@ -38,6 +42,12 @@ struct pwm_fan_ctx {
 	unsigned int pwm_fan_state;
 	unsigned int pwm_fan_max_state;
 	unsigned int *pwm_fan_cooling_levels;
+
+	unsigned int pwm_fan_profiles;
+	const char **fan_profile_names;
+	unsigned int **fan_profile_cooling_levels;
+	unsigned int fan_current_profile;
+
 	struct thermal_cooling_device *cdev;
 };
 
@@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 				       struct pwm_fan_ctx *ctx)
 {
 	struct device_node *np = dev->of_node;
+	struct device_node *base_profile = NULL;
+	struct device_node *profile_np = NULL;
+	const char *default_profile = NULL;
 	int num, i, ret;
 
-	if (!of_find_property(np, "cooling-levels", NULL))
-		return 0;
+	num = of_property_count_u32_elems(np, "cooling-levels");
+	if (num <= 0) {
+		base_profile = of_get_child_by_name(np, "profiles");
+		if (!base_profile) {
+			dev_err(dev, "Wrong Data\n");
+			return -EINVAL;
+		}
+	}
+
+	if (base_profile) {
+		ctx->pwm_fan_profiles =
+			of_get_available_child_count(base_profile);
 
-	ret = of_property_count_u32_elems(np, "cooling-levels");
-	if (ret <= 0) {
-		dev_err(dev, "Wrong data!\n");
-		return ret ? : -EINVAL;
+		if (ctx->pwm_fan_profiles <= 0) {
+			dev_err(dev, "Profiles used but not defined\n");
+			return -EINVAL;
+		}
+
+		ctx->fan_profile_names = devm_kzalloc(dev,
+			sizeof(const char *) * ctx->pwm_fan_profiles,
+							GFP_KERNEL);
+		ctx->fan_profile_cooling_levels = devm_kzalloc(dev,
+			sizeof(int *) * ctx->pwm_fan_profiles,
+							GFP_KERNEL);
+
+		if (!ctx->fan_profile_names
+				|| !ctx->fan_profile_cooling_levels)
+			return -ENOMEM;
+
+		ctx->fan_current_profile = 0;
+		i = 0;
+		for_each_available_child_of_node(base_profile, profile_np) {
+			num = of_property_count_u32_elems(profile_np,
+							"cooling-levels");
+			if (num <= 0) {
+				dev_err(dev, "No data in cooling-levels inside profile node!\n");
+				return -EINVAL;
+			}
+
+			of_property_read_string(profile_np, "name",
+						&ctx->fan_profile_names[i]);
+			if (default_profile &&
+				!strncmp(default_profile,
+				ctx->fan_profile_names[i],
+				MAX_PROFILE_NAME_LENGTH))
+				ctx->fan_current_profile = i;
+
+			ctx->fan_profile_cooling_levels[i] =
+				devm_kzalloc(dev, sizeof(int) * num,
+							GFP_KERNEL);
+			if (!ctx->fan_profile_cooling_levels[i])
+				return -ENOMEM;
+
+			of_property_read_u32_array(profile_np, "cooling-levels",
+				ctx->fan_profile_cooling_levels[i], num);
+			i++;
+		}
 	}
 
-	num = ret;
 	ctx->pwm_fan_cooling_levels = devm_kcalloc(dev, num, sizeof(u32),
 						   GFP_KERNEL);
 	if (!ctx->pwm_fan_cooling_levels)
 		return -ENOMEM;
 
-	ret = of_property_read_u32_array(np, "cooling-levels",
-					 ctx->pwm_fan_cooling_levels, num);
-	if (ret) {
-		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
-		return ret;
+	if (base_profile) {
+		memcpy(ctx->pwm_fan_cooling_levels,
+		  ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
+						num);
+	} else {
+		ret = of_property_read_u32_array(np, "cooling-levels",
+				ctx->pwm_fan_cooling_levels, num);
+		if (ret) {
+			dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
+			return -EINVAL;
+		}
 	}
 
 	for (i = 0; i < num; i++) {
-- 
2.7.4
