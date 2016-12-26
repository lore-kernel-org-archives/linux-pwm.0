From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 05/11] pwm: imx: Move PWMv2 software reset code to a separate function
Date: Mon, 26 Dec 2016 23:55:55 +0100
Message-ID: <1482792961-12702-6-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:46093 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755718AbcLZW53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Dec 2016 17:57:29 -0500
Received: from player716.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id EC7927449
        for <linux-pwm@vger.kernel.org>; Mon, 26 Dec 2016 23:57:27 +0100 (CET)
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

The software reset code has been extracted from imx_pwm_config_v2 function
and moved to new one - imx_pwm_sw_reset().

This change reduces the overall size of imx_pwm_config_v2() and prepares
it for atomic PWM operation.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>

---
Changes for v3:
- None

Changes for v2:
- Add missing parenthesis
---
 drivers/pwm/pwm-imx.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 8497902..b4e5803 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -119,6 +119,25 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(imx->clk_per);
 }
 
+static void imx_pwm_sw_reset(struct pwm_chip *chip)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	struct device *dev = chip->dev;
+	int wait_count = 0;
+	u32 cr;
+
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		usleep_range(200, 1000);
+		cr = readl(imx->mmio_base + MX3_PWMCR);
+	} while ((cr & MX3_PWMCR_SWR) &&
+		 (wait_count++ < MX3_PWM_SWR_LOOP));
+
+	if (cr & MX3_PWMCR_SWR)
+		dev_warn(dev, "software reset timeout\n");
+}
+
+
 static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -128,7 +147,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	unsigned long period_cycles, duty_cycles, prescale;
 	unsigned int period_ms;
 	bool enable = pwm_is_enabled(pwm);
-	int wait_count = 0, fifoav;
+	int fifoav;
 	u32 cr, sr;
 
 	/*
@@ -151,15 +170,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 				dev_warn(dev, "there is no free FIFO slot\n");
 		}
 	} else {
-		writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
-		do {
-			usleep_range(200, 1000);
-			cr = readl(imx->mmio_base + MX3_PWMCR);
-		} while ((cr & MX3_PWMCR_SWR) &&
-			 (wait_count++ < MX3_PWM_SWR_LOOP));
-
-		if (cr & MX3_PWMCR_SWR)
-			dev_warn(dev, "software reset timeout\n");
+		imx_pwm_sw_reset(chip);
 	}
 
 	c = clk_get_rate(imx->clk_per);
-- 
2.1.4
