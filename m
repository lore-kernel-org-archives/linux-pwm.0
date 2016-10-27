From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v2 04/10] pwm: imx: Move PWMv2 software reset code to a separate function
Date: Thu, 27 Oct 2016 08:29:40 +0200
Message-ID: <1477549785-4972-5-git-send-email-l.majewski@majess.pl>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

The software reset code has been extracted from imx_pwm_config_v2 function
and moved to new one - imx_pwm_sw_reset().

This change reduces the overall size of imx_pwm_config_v2() and prepares
it for atomic PWM operation.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>

---
Changes for v2:
- Add missing parenthesis
---
 drivers/pwm/pwm-imx.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 822eb5a..8174ae6 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -134,6 +134,25 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
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
@@ -143,7 +162,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	unsigned long period_cycles, duty_cycles, prescale;
 	unsigned int period_ms;
 	bool enable = pwm_is_enabled(pwm);
-	int wait_count = 0, fifoav;
+	int fifoav;
 	u32 cr, sr;
 
 	/*
@@ -166,15 +185,7 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
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
