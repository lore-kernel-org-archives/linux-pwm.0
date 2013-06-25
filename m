Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Wed, 26 Jun 2013 06:55:18 +0800
Message-ID: <CAPgLHd8g2ChKSfyGUkFWBB-Z_6At2awyMAMRvA1fTvmCmeea+g@mail.gmail.com>
Subject: [PATCH -next] pwm: samsung: fix return value check in pwm_samsung_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, tomasz.figa@gmail.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pwm/pwm-samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 2eb5439..6689c55 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -482,8 +482,8 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	chip->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!chip->base)
-		return -ENOMEM;
+	if (IS_ERR(chip->base))
+		return PTR_ERR(chip->base);
 
 	chip->base_clk = devm_clk_get(&pdev->dev, "timers");
 	if (IS_ERR(chip->base_clk)) {
