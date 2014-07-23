From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] pwm: imx: don't reprogram PWMSAR if PWM is disabled
Date: Wed, 23 Jul 2014 12:09:47 +0400
Message-ID: <1406102987-14797-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33896 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaGWIKI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jul 2014 04:10:08 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so613224lbg.20
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jul 2014 01:10:06 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

Writing several values to PWMSAR register with PWM being disabled can
lead to FIFO (connected to PWMSAR) being overflown. Then after enabling
PWM, hardware will use stale values. Instead cache the duty cycles and
write them to the hardware only before enabling PWM.

Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
---
 drivers/pwm/pwm-imx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index c735127..79c2b24 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -46,6 +46,7 @@ struct imx_chip {
 	struct clk	*clk_ipg;
 
 	void __iomem	*mmio_base;
+	unsigned long	duty_cycles;
 
 	struct pwm_chip	chip;
 
@@ -105,7 +106,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 {
 	struct imx_chip *imx = to_imx_chip(chip);
 	unsigned long long c;
-	unsigned long period_cycles, duty_cycles, prescale;
+	unsigned long period_cycles, prescale;
 	u32 cr;
 
 	c = clk_get_rate(imx->clk_per);
@@ -118,7 +119,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	period_cycles /= prescale;
 	c = (unsigned long long)period_cycles * duty_ns;
 	do_div(c, period_ns);
-	duty_cycles = c;
+	imx->duty_cycles = c;
 
 	/*
 	 * according to imx pwm RM, the real period value should be
@@ -134,7 +135,8 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 
 	period_cycles -= 2;
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	if (test_bit(PWMF_ENABLED, &pwm->flags))
+		writel(imx->duty_cycles, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	cr = readl(imx->mmio_base + MX3_PWMCR);
@@ -157,6 +159,9 @@ static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
 	struct imx_chip *imx = to_imx_chip(chip);
 	u32 val;
 
+	if (enable)
+		writel(imx->duty_cycles, imx->mmio_base + MX3_PWMSAR);
+
 	val = readl(imx->mmio_base + MX3_PWMCR);
 
 	if (enable)
-- 
1.9.3

