From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 04/11] pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate switch to atomic pwm operation
Date: Mon, 26 Dec 2016 23:55:54 +0100
Message-ID: <1482792961-12702-5-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

The code has been rewritten to remove "generic" calls to
imx_pwm_{enable|disable|config}.

Such approach would facilitate switch to atomic PWM (a.k.a ->apply())
implementation.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
[Minor code adjustment according to Stefan Agner comment]

Changes for v3:
- Remove ipg clock

Changes for v2:
- Add missing clock unprepare for clk_ipg
- Enable peripheral PWM clock (clk_per)
---
 drivers/pwm/pwm-imx.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d594501..8f911b9 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -90,19 +90,34 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
 	return 0;
 }
 
-static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
+static int imx_pwm_enable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	int ret;
 	u32 val;
 
+	ret = clk_prepare_enable(imx->clk_per);
+	if (ret)
+		return ret;
+
 	val = readl(imx->mmio_base + MX1_PWMC);
+	val |= MX1_PWMC_EN;
+	writel(val, imx->mmio_base + MX1_PWMC);
 
-	if (enable)
-		val |= MX1_PWMC_EN;
-	else
-		val &= ~MX1_PWMC_EN;
+	return 0;
+}
+
+static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	u32 val;
+
+	val = readl(imx->mmio_base + MX1_PWMC);
+	val &= ~MX1_PWMC_EN;
 
 	writel(val, imx->mmio_base + MX1_PWMC);
+
+	clk_disable_unprepare(imx->clk_per);
 }
 
 static int imx_pwm_config_v2(struct pwm_chip *chip,
@@ -231,9 +246,9 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static struct pwm_ops imx_pwm_ops_v1 = {
-	.enable = imx_pwm_enable,
-	.disable = imx_pwm_disable,
-	.config = imx_pwm_config,
+	.enable = imx_pwm_enable_v1,
+	.disable = imx_pwm_disable_v1,
+	.config = imx_pwm_config_v1,
 	.owner = THIS_MODULE,
 };
 
@@ -252,8 +267,6 @@ struct imx_pwm_data {
 };
 
 static struct imx_pwm_data imx_pwm_data_v1 = {
-	.config = imx_pwm_config_v1,
-	.set_enable = imx_pwm_set_enable_v1,
 	.pwm_ops = &imx_pwm_ops_v1,
 };
 
-- 
2.1.4
