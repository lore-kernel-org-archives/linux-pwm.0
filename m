From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2] pwm: berlin: Add PM support
Date: Wed, 25 Nov 2015 17:41:25 +0800
Message-ID: <1448444485-4857-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40736 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845AbbKYJpd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Nov 2015 04:45:33 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com, antoine.tenart@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

This patch adds S2R support for berlin pwm driver.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v1:
 - implement .request and .free hooks, allocate/free the channel in
   berlin_pwm_request/berlin_pwm_free. Then use pwm_get_chip_data in
   suspend/resume implementation.
 - s/int/unsigned int
 - check return value of clk_prepare_enable
 - remoev BERLIN_PWM_PM_OPS macro
 drivers/pwm/pwm-berlin.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 6510812..a66b9ff 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/slab.h>
 
 #define BERLIN_PWM_EN			0x0
 #define  BERLIN_PWM_ENABLE		BIT(0)
@@ -27,6 +28,15 @@
 #define BERLIN_PWM_TCNT			0xc
 #define  BERLIN_PWM_MAX_TCNT		65535
 
+#define NUM_PWM_CHANNEL			4	/* berlin PWM channels */
+
+struct berlin_pwm_channel {
+	u32	enable;
+	u32	ctrl;
+	u32	duty;
+	u32	tcnt;
+};
+
 struct berlin_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
@@ -55,6 +65,28 @@ static inline void berlin_pwm_writel(struct berlin_pwm_chip *chip,
 	writel_relaxed(value, chip->base + channel * 0x10 + offset);
 }
 
+static int berlin_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm_dev)
+{
+	struct berlin_pwm_channel *chan;
+
+	if (pwm_dev->hwpwm >= NUM_PWM_CHANNEL)
+		return -EINVAL;
+
+	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	return pwm_set_chip_data(pwm_dev, chan);
+}
+
+static void berlin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm_dev)
+{
+	struct berlin_pwm_channel *chan = pwm_get_chip_data(pwm_dev);
+
+	kfree(chan);
+	pwm_set_chip_data(pwm_dev, NULL);
+}
+
 static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 			     int duty_ns, int period_ns)
 {
@@ -137,6 +169,8 @@ static void berlin_pwm_disable(struct pwm_chip *chip,
 }
 
 static const struct pwm_ops berlin_pwm_ops = {
+	.request = berlin_pwm_request,
+	.free = berlin_pwm_free,
 	.config = berlin_pwm_config,
 	.set_polarity = berlin_pwm_set_polarity,
 	.enable = berlin_pwm_enable,
@@ -176,7 +210,7 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &berlin_pwm_ops;
 	pwm->chip.base = -1;
-	pwm->chip.npwm = 4;
+	pwm->chip.npwm = NUM_PWM_CHANNEL;
 	pwm->chip.can_sleep = true;
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
@@ -204,12 +238,66 @@ static int berlin_pwm_remove(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int berlin_pwm_suspend(struct device *dev)
+{
+	unsigned int i;
+	struct berlin_pwm_chip *pwm = dev_get_drvdata(dev);
+
+	for (i = 0; i < pwm->chip.npwm; i++) {
+		struct pwm_device *pwm_dev = &pwm->chip.pwms[i];
+		struct berlin_pwm_channel *chan = pwm_get_chip_data(pwm_dev);
+
+		if (!chan)
+			continue;
+
+		chan->enable = berlin_pwm_readl(pwm, i, BERLIN_PWM_ENABLE);
+		chan->ctrl = berlin_pwm_readl(pwm, i, BERLIN_PWM_CONTROL);
+		chan->duty = berlin_pwm_readl(pwm, i, BERLIN_PWM_DUTY);
+		chan->tcnt = berlin_pwm_readl(pwm, i, BERLIN_PWM_TCNT);
+	}
+	clk_disable_unprepare(pwm->clk);
+
+	return 0;
+}
+
+static int berlin_pwm_resume(struct device *dev)
+{
+	int ret;
+	unsigned int i;
+	struct berlin_pwm_chip *pwm = dev_get_drvdata(dev);
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < pwm->chip.npwm; i++) {
+		struct pwm_device *pwm_dev = &pwm->chip.pwms[i];
+		struct berlin_pwm_channel *chan = pwm_get_chip_data(pwm_dev);
+
+		if (!chan)
+			continue;
+
+		berlin_pwm_writel(pwm, i, chan->ctrl, BERLIN_PWM_CONTROL);
+		berlin_pwm_writel(pwm, i, chan->duty, BERLIN_PWM_DUTY);
+		berlin_pwm_writel(pwm, i, chan->tcnt, BERLIN_PWM_TCNT);
+		berlin_pwm_writel(pwm, i, chan->enable, BERLIN_PWM_ENABLE);
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
+			 berlin_pwm_resume);
+
 static struct platform_driver berlin_pwm_driver = {
 	.probe = berlin_pwm_probe,
 	.remove = berlin_pwm_remove,
 	.driver = {
 		.name = "berlin-pwm",
 		.of_match_table = berlin_pwm_match,
+		.pm = &berlin_pwm_pm_ops,
 	},
 };
 module_platform_driver(berlin_pwm_driver);
-- 
2.6.2
