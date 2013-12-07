From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH resend 1/2] pwm: jz4740: Pass device to clk_get()
Date: Sat,  7 Dec 2013 18:13:15 +0100
Message-ID: <1386436396-2307-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-pwm@vger.kernel.org

In preparation to switching the jz4740 clk driver to the common clk framework
make sure to pass the device to clk_get().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/pwm/pwm-jz4740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 0a2ede3..a44d890 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -171,7 +171,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = clk_get(NULL, "ext");
+	jz4740->clk = clk_get(&pdev->dev, "ext");
 	if (IS_ERR(jz4740->clk))
 		return PTR_ERR(jz4740->clk);
 
-- 
1.7.10.4
