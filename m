From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH 3/6] pwm: imx: Move PWMv2 wait for fifo slot code to a separate function
Date: Sun, 23 Oct 2016 23:45:43 +0200
Message-ID: <1477259146-19167-4-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:60020 "EHLO
        9.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756789AbcJWWBx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Oct 2016 18:01:53 -0400
Received: from player734.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id AD29C3B41C
        for <linux-pwm@vger.kernel.org>; Sun, 23 Oct 2016 23:46:47 +0200 (CEST)
In-Reply-To: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

The code, which waits for fifo slot, has been extracted from
imx_pwm_config_v2 function and moved to new one - imx_pwm_wait_fifo_slot().

This change reduces the overall size of imx_pwm_config_v2() and prepares
it for atomic PWM operation.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
 drivers/pwm/pwm-imx.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index fac5c93..f3577c5 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -149,18 +149,36 @@ static void imx_pwm_sw_reset(struct pwm_chip *chip)
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
@@ -169,19 +187,9 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
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
-	} else
+	if (enable)
+		imx_pwm_wait_fifo_slot(chip, pwm);
+	else
 		imx_pwm_sw_reset(chip);
 
 	c = clk_get_rate(imx->clk_per);
-- 
2.1.4
