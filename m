From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH resend 2/2] pwm: jz4740: Use devm_clk_get()
Date: Sat,  7 Dec 2013 18:13:16 +0100
Message-ID: <1386436396-2307-2-git-send-email-lars@metafoo.de>
References: <1386436396-2307-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386436396-2307-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-pwm@vger.kernel.org

Using the managed version of clk_get() makes the code a bit shorter and the
error paths less complicated.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/pwm/pwm-jz4740.c |   20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a44d890..9c46209 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -165,13 +165,12 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740;
-	int ret;
 
 	jz4740 = devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = clk_get(&pdev->dev, "ext");
+	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
 	if (IS_ERR(jz4740->clk))
 		return PTR_ERR(jz4740->clk);
 
@@ -180,29 +179,16 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	jz4740->chip.npwm = NUM_PWM;
 	jz4740->chip.base = -1;
 
-	ret = pwmchip_add(&jz4740->chip);
-	if (ret < 0) {
-		clk_put(jz4740->clk);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, jz4740);
 
-	return 0;
+	return pwmchip_add(&jz4740->chip);
 }
 
 static int jz4740_pwm_remove(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740 = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pwmchip_remove(&jz4740->chip);
-	if (ret < 0)
-		return ret;
 
-	clk_put(jz4740->clk);
-
-	return 0;
+	return pwmchip_remove(&jz4740->chip);
 }
 
 static struct platform_driver jz4740_pwm_driver = {
-- 
1.7.10.4
