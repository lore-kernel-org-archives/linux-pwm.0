From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/4] pwm: jz4740: Add support for the JZ4725B
Date: Mon, 25 May 2020 14:57:22 +0200
Message-ID: <20200525125722.36447-4-paul@crapouillou.net>
References: <20200525125722.36447-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:47098 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYM6F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 08:58:05 -0400
In-Reply-To: <20200525125722.36447-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>

The PWM hardware in the JZ4725B works the same as in the JZ4740, but has
only six channels available.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Simply return -EINVAL if we can't get match data

 drivers/pwm/pwm-jz4740.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index fe06ca8ce30f..5830ac2bdf6a 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -20,7 +20,9 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 
-#define NUM_PWM 8
+struct soc_info {
+	unsigned int num_pwms;
+};
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
@@ -36,7 +38,7 @@ static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
 				   unsigned int channel)
 {
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	u32 pwm_channels_mask = GENMASK(NUM_PWM - 1, 2);
+	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
 
 	device_property_read_u32(jz->chip.dev->parent,
 				 "ingenic,pwm-channels-mask",
@@ -226,6 +228,11 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz4740_pwm_chip *jz4740;
+	const struct soc_info *info;
+
+	info = device_get_match_data(dev);
+	if (!info)
+		return -EINVAL;
 
 	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
 	if (!jz4740)
@@ -239,7 +246,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
-	jz4740->chip.npwm = NUM_PWM;
+	jz4740->chip.npwm = info->num_pwms;
 	jz4740->chip.base = -1;
 	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
 	jz4740->chip.of_pwm_n_cells = 3;
@@ -256,9 +263,18 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&jz4740->chip);
 }
 
+static const struct soc_info __maybe_unused jz4740_soc_info = {
+	.num_pwms = 8,
+};
+
+static const struct soc_info __maybe_unused jz4725b_soc_info = {
+	.num_pwms = 6,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
-	{ .compatible = "ingenic,jz4740-pwm", },
+	{ .compatible = "ingenic,jz4740-pwm", .data = &jz4740_soc_info },
+	{ .compatible = "ingenic,jz4725b-pwm", .data = &jz4725b_soc_info },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.26.2
