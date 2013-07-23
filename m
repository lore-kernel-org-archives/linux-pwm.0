Return-Path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 15/27] drivers/pwm: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:48 +0200
Message-Id: <1374602524-3398-16-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 drivers/pwm/pwm-lpc32xx.c     |    3 ---
 drivers/pwm/pwm-renesas-tpu.c |    5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index efb6c7b..efac99e0 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -124,9 +124,6 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
 	lpc32xx->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(lpc32xx->base))
 		return PTR_ERR(lpc32xx->base);
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 2600892..444d589 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -404,11 +404,6 @@ static int tpu_probe(struct platform_device *pdev)
 
 	/* Map memory, get clock and pin control. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
-	}
-
 	tpu->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(tpu->base))
 		return PTR_ERR(tpu->base);
-- 
1.7.10.4
