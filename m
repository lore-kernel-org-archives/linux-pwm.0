From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 08/11] pwm: imx: Remove redundant i.MX PWMv2 code
Date: Tue,  1 Nov 2016 08:10:27 +0100
Message-ID: <1477984230-18071-9-git-send-email-l.majewski@majess.pl>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:53586 "EHLO
        5.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945082AbcKAHMt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2016 03:12:49 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 9E2E8D18F
        for <linux-pwm@vger.kernel.org>; Tue,  1 Nov 2016 08:12:47 +0100 (CET)
In-Reply-To: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Sascha Hauer <s.hauer@pengutronix.de>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

The code providing functionality surpassed by the atomic PWM is not needed
anymore and hence can be removed.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes for v3:
- None

Changes for v2:
- None
---
 drivers/pwm/pwm-imx.c | 118 --------------------------------------------------
 1 file changed, 118 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cd53c05..b636526 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -53,10 +53,6 @@ struct imx_chip {
 	void __iomem	*mmio_base;
 
 	struct pwm_chip	chip;
-
-	int (*config)(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns);
-	void (*set_enable)(struct pwm_chip *chip, bool enable);
 };
 
 #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
@@ -228,109 +224,6 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int imx_pwm_config_v2(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	unsigned long long c;
-	unsigned long period_cycles, duty_cycles, prescale;
-	bool enable = pwm_is_enabled(pwm);
-	u32 cr;
-
-	/*
-	 * i.MX PWMv2 has a 4-word sample FIFO.
-	 * In order to avoid FIFO overflow issue, we do software reset
-	 * to clear all sample FIFO if the controller is disabled or
-	 * wait for a full PWM cycle to get a relinquished FIFO slot
-	 * when the controller is enabled and the FIFO is fully loaded.
-	 */
-	if (enable)
-		imx_pwm_wait_fifo_slot(chip, pwm);
-	else
-		imx_pwm_sw_reset(chip);
-
-	c = clk_get_rate(imx->clk_per);
-	c = c * period_ns;
-	do_div(c, 1000000000);
-	period_cycles = c;
-
-	prescale = period_cycles / 0x10000 + 1;
-
-	period_cycles /= prescale;
-	c = (unsigned long long)period_cycles * duty_ns;
-	do_div(c, period_ns);
-	duty_cycles = c;
-
-	/*
-	 * according to imx pwm RM, the real period value should be
-	 * PERIOD value in PWMPR plus 2.
-	 */
-	if (period_cycles > 2)
-		period_cycles -= 2;
-	else
-		period_cycles = 0;
-
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
-	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
-
-	cr = MX3_PWMCR_PRESCALER(prescale) |
-		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
-
-	if (enable)
-		cr |= MX3_PWMCR_EN;
-
-	writel(cr, imx->mmio_base + MX3_PWMCR);
-
-	return 0;
-}
-
-static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	u32 val;
-
-	val = readl(imx->mmio_base + MX3_PWMCR);
-
-	if (enable)
-		val |= MX3_PWMCR_EN;
-	else
-		val &= ~MX3_PWMCR_EN;
-
-	writel(val, imx->mmio_base + MX3_PWMCR);
-}
-
-static int imx_pwm_config(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-
-	return imx->config(chip, pwm, duty_ns, period_ns);
-}
-
-static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	int ret;
-
-	ret = clk_prepare_enable(imx->clk_per);
-	if (ret)
-		return ret;
-
-	imx->set_enable(chip, true);
-
-	return 0;
-}
-
-static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-
-	imx->set_enable(chip, false);
-
-	clk_disable_unprepare(imx->clk_per);
-}
-
 static struct pwm_ops imx_pwm_ops_v1 = {
 	.enable = imx_pwm_enable_v1,
 	.disable = imx_pwm_disable_v1,
@@ -339,17 +232,11 @@ static struct pwm_ops imx_pwm_ops_v1 = {
 };
 
 static struct pwm_ops imx_pwm_ops_v2 = {
-	.enable = imx_pwm_enable,
-	.disable = imx_pwm_disable,
-	.config = imx_pwm_config,
 	.apply = imx_pwm_apply_v2,
 	.owner = THIS_MODULE,
 };
 
 struct imx_pwm_data {
-	int (*config)(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns);
-	void (*set_enable)(struct pwm_chip *chip, bool enable);
 	struct pwm_ops *pwm_ops;
 };
 
@@ -358,8 +245,6 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
-	.config = imx_pwm_config_v2,
-	.set_enable = imx_pwm_set_enable_v2,
 	.pwm_ops = &imx_pwm_ops_v2,
 };
 
@@ -406,9 +291,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	imx->config = data->config;
-	imx->set_enable = data->set_enable;
-
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
2.1.4
