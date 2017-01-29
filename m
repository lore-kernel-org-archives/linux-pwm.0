From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 11/11] pwm: imx: Add polarity inversion support to i.MX's PWMv2
Date: Sun, 29 Jan 2017 22:54:15 +0100
Message-ID: <1485726855-16236-12-git-send-email-lukma@denx.de>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52995 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdA2VzO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Jan 2017 16:55:14 -0500
In-Reply-To: <1485726855-16236-1-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>, Lukasz Majewski <l.majewski@majess.pl>

With this patch the polarity settings for i.MX's PWMv2 is now supported
on top of atomic PWM setting

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v5:
- Adjust to corrected ->apply_v2() code

Changes for v4:
- MX3_PWMCR_POUTC setting adjustements after apply_v2() previous changes

Changes for v3:
- None

Changes for v2:
- New patch
---
 drivers/pwm/pwm-imx.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index e037023..9f7e787 100644
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
@@ -164,6 +165,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_state cstate;
 	unsigned long long c;
 	int ret;
+	u32 cr;
 
 	pwm_get_state(pwm, &cstate);
 
@@ -208,12 +210,15 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
-		writel(MX3_PWMCR_PRESCALER(prescale) |
-		       MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
-		       MX3_PWMCR_EN,
-		       imx->mmio_base + MX3_PWMCR);
+		cr = MX3_PWMCR_PRESCALER(prescale) |
+			MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
+			MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
+			MX3_PWMCR_EN;
+
+		if (state->polarity == PWM_POLARITY_INVERSED)
+			cr |= MX3_PWMCR_POUTC;
 
+		writel(cr, imx->mmio_base + MX3_PWMCR);
 	} else if (cstate.enabled) {
 		writel(0, imx->mmio_base + MX3_PWMCR);
 
@@ -236,6 +241,7 @@ static struct pwm_ops imx_pwm_ops_v2 = {
 };
 
 struct imx_pwm_data {
+	bool polarity_supported;
 	struct pwm_ops *pwm_ops;
 };
 
@@ -244,6 +250,7 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
+	.polarity_supported = true,
 	.pwm_ops = &imx_pwm_ops_v2,
 };
 
@@ -284,6 +291,11 @@ static int imx_pwm_probe(struct platform_device *pdev)
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
