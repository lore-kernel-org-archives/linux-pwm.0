From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] pwm: pwm-imx-tpm: Use 'dev' instead of dereferencing it repeatedly
Date: Tue, 24 Sep 2019 17:01:07 +0800
Message-ID: <1569315667-1525-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index e8385c1..4385801 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -337,11 +337,12 @@ static const struct pwm_ops imx_tpm_pwm_ops = {
 
 static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct imx_tpm_pwm_chip *tpm;
 	int ret;
 	u32 val;
 
-	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	tpm = devm_kzalloc(dev, sizeof(*tpm), GFP_KERNEL);
 	if (!tpm)
 		return -ENOMEM;
 
@@ -351,23 +352,23 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	if (IS_ERR(tpm->base))
 		return PTR_ERR(tpm->base);
 
-	tpm->clk = devm_clk_get(&pdev->dev, NULL);
+	tpm->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(tpm->clk)) {
 		ret = PTR_ERR(tpm->clk);
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"failed to get PWM clock: %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(tpm->clk);
 	if (ret) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to prepare or enable clock: %d\n", ret);
 		return ret;
 	}
 
-	tpm->chip.dev = &pdev->dev;
+	tpm->chip.dev = dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
 	tpm->chip.base = -1;
 	tpm->chip.of_xlate = of_pwm_xlate_with_flags;
@@ -381,7 +382,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&tpm->chip);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		dev_err(dev, "failed to add PWM chip: %d\n", ret);
 		clk_disable_unprepare(tpm->clk);
 	}
 
-- 
2.7.4
