From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v2 10/10] pwm: imx: Add polarity inversion support to i.MX's PWMv2
Date: Thu, 27 Oct 2016 08:29:45 +0200
Message-ID: <1477549785-4972-10-git-send-email-l.majewski@majess.pl>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:43457 "EHLO
        6.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbcJ0Gla (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Oct 2016 02:41:30 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3528016155
        for <linux-pwm@vger.kernel.org>; Thu, 27 Oct 2016 08:31:59 +0200 (CEST)
In-Reply-To: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

With this patch the polarity settings for i.MX's PWMv2 is now supported
on top of atomic PWM setting

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v2:
- New patch
---
 drivers/pwm/pwm-imx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 0132439a..92b4ba0 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -38,6 +38,7 @@
 #define MX3_PWMCR_DOZEEN		(1 << 24)
 #define MX3_PWMCR_WAITEN		(1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
+#define MX3_PWMCR_POUTC			(1 << 18)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
 #define MX3_PWMCR_SWR			(1 << 3)
@@ -234,6 +235,9 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled)
 		cr |= MX3_PWMCR_EN;
 
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		cr |= MX3_PWMCR_POUTC;
+
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	/* Disable the clock if the PWM is being disabled. */
@@ -258,6 +262,7 @@ static struct pwm_ops imx_pwm_ops_v2 = {
 };
 
 struct imx_pwm_data {
+	bool polarity_supported;
 	struct pwm_ops *pwm_ops;
 };
 
@@ -266,6 +271,7 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
+	.polarity_supported = true,
 	.pwm_ops = &imx_pwm_ops_v2,
 };
 
@@ -313,6 +319,11 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 	imx->chip.can_sleep = true;
+	if (data->polarity_supported) {
+		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
+		imx->chip.of_xlate = of_pwm_xlate_with_flags;
+		imx->chip.of_pwm_n_cells = 3;
+	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
-- 
2.1.4
