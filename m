From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 11/11] pwm: imx: Add polarity inversion support to i.MX's PWMv2
Date: Mon, 26 Dec 2016 23:56:01 +0100
Message-ID: <1482792961-12702-12-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:46774 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754253AbcLZW6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Dec 2016 17:58:46 -0500
Received: from player716.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 53863747C
        for <linux-pwm@vger.kernel.org>; Mon, 26 Dec 2016 23:58:45 +0100 (CET)
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

With this patch the polarity settings for i.MX's PWMv2 is now supported
on top of atomic PWM setting

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v3:
- None

Changes for v2:
- New patch
---
 drivers/pwm/pwm-imx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index b636526..03b01a4 100644
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
@@ -215,6 +216,9 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled)
 		cr |= MX3_PWMCR_EN;
 
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		cr |= MX3_PWMCR_POUTC;
+
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
 	/* Disable the clock if the PWM is being disabled. */
@@ -237,6 +241,7 @@ static struct pwm_ops imx_pwm_ops_v2 = {
 };
 
 struct imx_pwm_data {
+	bool polarity_supported;
 	struct pwm_ops *pwm_ops;
 };
 
@@ -245,6 +250,7 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
+	.polarity_supported = true,
 	.pwm_ops = &imx_pwm_ops_v2,
 };
 
@@ -285,6 +291,11 @@ static int imx_pwm_probe(struct platform_device *pdev)
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
