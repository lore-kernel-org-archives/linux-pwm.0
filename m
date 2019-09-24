From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/2] pwm: pwm-mxs: Use 'dev' instead of dereferencing it repeatedly
Date: Tue, 24 Sep 2019 17:42:49 +0800
Message-ID: <1569318169-12327-2-git-send-email-Anson.Huang@nxp.com>
References: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-pwm@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-mxs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index b14376b..6255ffc 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -124,11 +124,12 @@ static const struct pwm_ops mxs_pwm_ops = {
 
 static int mxs_pwm_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct mxs_pwm_chip *mxs;
 	int ret;
 
-	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
+	mxs = devm_kzalloc(dev, sizeof(*mxs), GFP_KERNEL);
 	if (!mxs)
 		return -ENOMEM;
 
@@ -136,23 +137,23 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs->base))
 		return PTR_ERR(mxs->base);
 
-	mxs->clk = devm_clk_get(&pdev->dev, NULL);
+	mxs->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
 
-	mxs->chip.dev = &pdev->dev;
+	mxs->chip.dev = dev;
 	mxs->chip.ops = &mxs_pwm_ops;
 	mxs->chip.base = -1;
 
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
+		dev_err(dev, "failed to get pwm number: %d\n", ret);
 		return ret;
 	}
 
 	ret = pwmchip_add(&mxs->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		dev_err(dev, "failed to add pwm chip %d\n", ret);
 		return ret;
 	}
 
-- 
2.7.4
