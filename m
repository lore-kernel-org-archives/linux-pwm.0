From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 43/61] pwm: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:13 +0200
Message-ID: <20180419140641.27926-44-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/pwm/pwm-atmel-tcb.c | 6 ++----
 drivers/pwm/pwm-rcar.c      | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 4fb1be246c44..0d0f8376bc35 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -460,8 +460,7 @@ MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 #ifdef CONFIG_PM_SLEEP
 static int atmel_tcb_pwm_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
 	void __iomem *base = tcbpwm->tc->regs;
 	int i;
 
@@ -478,8 +477,7 @@ static int atmel_tcb_pwm_suspend(struct device *dev)
 
 static int atmel_tcb_pwm_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
 	void __iomem *base = tcbpwm->tc->regs;
 	int i;
 
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 91d11f2e2fef..748f614d5375 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -261,8 +261,7 @@ MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 #ifdef CONFIG_PM_SLEEP
 static struct pwm_device *rcar_pwm_dev_to_pwm_dev(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct rcar_pwm_chip *rcar_pwm = dev_get_drvdata(dev);
 	struct pwm_chip *chip = &rcar_pwm->chip;
 
 	return &chip->pwms[0];
-- 
2.11.0
