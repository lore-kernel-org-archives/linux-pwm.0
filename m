From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it repeatedly
Date: Tue, 24 Sep 2019 16:59:53 +0800
Message-ID: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 434a351..3afee29 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -290,27 +290,28 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwm_imx27_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
+	imx = devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, imx);
 
-	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	imx->clk_ipg = devm_clk_get(dev, "ipg");
 	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
+		dev_err(dev, "getting ipg clock failed with %ld\n",
 				PTR_ERR(imx->clk_ipg));
 		return PTR_ERR(imx->clk_ipg);
 	}
 
-	imx->clk_per = devm_clk_get(&pdev->dev, "per");
+	imx->clk_per = devm_clk_get(dev, "per");
 	if (IS_ERR(imx->clk_per)) {
 		int ret = PTR_ERR(imx->clk_per);
 
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"failed to get peripheral clock: %d\n",
 				ret);
 
@@ -318,7 +319,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	}
 
 	imx->chip.ops = &pwm_imx27_ops;
-	imx->chip.dev = &pdev->dev;
+	imx->chip.dev = dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
-- 
2.7.4
