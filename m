From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 05/11] pwm: imx: Move PWMv2 software reset code to a separate function
Date: Sun, 29 Jan 2017 22:54:09 +0100
Message-ID: <1485726855-16236-6-git-send-email-lukma@denx.de>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36949 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdA2VzG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Jan 2017 16:55:06 -0500
In-Reply-To: <1485726855-16236-1-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>

From: Lukasz Majewski <l.majewski@majess.pl>

The software reset code has been extracted from imx_pwm_config_v2 function
and moved to new one - imx_pwm_sw_reset().

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
- Add missing parenthesis
---
 drivers/pwm/pwm-imx.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 11e3f3e..f0d78f3 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -120,6 +120,25 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
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
@@ -129,7 +148,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	unsigned long period_cycles, duty_cycles, prescale;
 	unsigned int period_ms;
 	bool enable = pwm_is_enabled(pwm);
-	int wait_count = 0, fifoav;
+	int fifoav;
 	u32 cr, sr;
 
 	/*
@@ -152,15 +171,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
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
