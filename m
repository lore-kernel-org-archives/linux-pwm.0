From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 06/11] pwm: imx: Move PWMv2 wait for fifo slot code to a separate function
Date: Sun, 29 Jan 2017 22:54:10 +0100
Message-ID: <1485726855-16236-7-git-send-email-lukma@denx.de>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41916 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdA2VzL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Jan 2017 16:55:11 -0500
In-Reply-To: <1485726855-16236-1-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>

From: Lukasz Majewski <l.majewski@majess.pl>

The code, which waits for fifo slot, has been extracted from
imx_pwm_config_v2 function and moved to new one - imx_pwm_wait_fifo_slot().

This change reduces the overall size of imx_pwm_config_v2() and prepares
it for atomic PWM operation.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v5:
- None

Changes for v4:
- None

Changes for v3:
- None

Changes for v2:
- None
---
 drivers/pwm/pwm-imx.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index f0d78f3..60cdc5c 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -138,18 +138,36 @@ static void imx_pwm_sw_reset(struct pwm_chip *chip)
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
@@ -158,21 +176,10 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
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
