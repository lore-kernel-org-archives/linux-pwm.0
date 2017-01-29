From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 04/11] pwm: imx: Rewrite imx_pwm_*_v1 code to facilitate switch to atomic pwm operation
Date: Sun, 29 Jan 2017 22:54:08 +0100
Message-ID: <1485726855-16236-5-git-send-email-lukma@denx.de>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485726855-16236-1-git-send-email-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

From: Lukasz Majewski <l.majewski@majess.pl>

The code has been rewritten to remove "generic" calls to
imx_pwm_{enable|disable|config}.

Such approach would facilitate switch to atomic PWM (a.k.a ->apply())
implementation.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v5:
- None

Changes for v4:
- None

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
index 0fa480d..11e3f3e 100644
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
@@ -240,9 +255,9 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
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
 
@@ -261,8 +276,6 @@ struct imx_pwm_data {
 };
 
 static struct imx_pwm_data imx_pwm_data_v1 = {
-	.config = imx_pwm_config_v1,
-	.set_enable = imx_pwm_set_enable_v1,
 	.pwm_ops = &imx_pwm_ops_v1,
 };
 
-- 
2.1.4
