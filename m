From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 06/11] pwm: imx: Move PWMv2 wait for fifo slot code to a separate function
Date: Mon, 26 Dec 2016 23:55:56 +0100
Message-ID: <1482792961-12702-7-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:50890 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755758AbcLZW5n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Dec 2016 17:57:43 -0500
Received: from player716.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 94EAD7471
        for <linux-pwm@vger.kernel.org>; Mon, 26 Dec 2016 23:57:40 +0100 (CET)
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

The code, which waits for fifo slot, has been extracted from
imx_pwm_config_v2 function and moved to new one - imx_pwm_wait_fifo_slot().

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
- None
---
 drivers/pwm/pwm-imx.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index b4e5803..ebe9b0c 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -137,18 +137,36 @@ static void imx_pwm_sw_reset(struct pwm_chip *chip)
 		dev_warn(dev, "software reset timeout\n");
 }
 
+static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
+				   struct pwm_device *pwm)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	struct device *dev = chip->dev;
+	unsigned int period_ms;
+	int fifoav;
+	u32 sr;
+
+	sr = readl(imx->mmio_base + MX3_PWMSR);
+	fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
+	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
+		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
+					 NSEC_PER_MSEC);
+		msleep(period_ms);
+
+		sr = readl(imx->mmio_base + MX3_PWMSR);
+		if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
+			dev_warn(dev, "there is no free FIFO slot\n");
+	}
+}
 
 static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
-	struct device *dev = chip->dev;
 	unsigned long long c;
 	unsigned long period_cycles, duty_cycles, prescale;
-	unsigned int period_ms;
 	bool enable = pwm_is_enabled(pwm);
-	int fifoav;
-	u32 cr, sr;
+	u32 cr;
 
 	/*
 	 * i.MX PWMv2 has a 4-word sample FIFO.
@@ -157,21 +175,10 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	 * wait for a full PWM cycle to get a relinquished FIFO slot
 	 * when the controller is enabled and the FIFO is fully loaded.
 	 */
-	if (enable) {
-		sr = readl(imx->mmio_base + MX3_PWMSR);
-		fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
-		if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-			period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
-						 NSEC_PER_MSEC);
-			msleep(period_ms);
-
-			sr = readl(imx->mmio_base + MX3_PWMSR);
-			if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
-				dev_warn(dev, "there is no free FIFO slot\n");
-		}
-	} else {
+	if (enable)
+		imx_pwm_wait_fifo_slot(chip, pwm);
+	else
 		imx_pwm_sw_reset(chip);
-	}
 
 	c = clk_get_rate(imx->clk_per);
 	c = c * period_ns;
-- 
2.1.4
