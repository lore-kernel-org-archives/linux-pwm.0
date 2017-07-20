From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] pwm: tiehrpwm: fix runtime pm imbalance at unbind
Date: Thu, 20 Jul 2017 12:48:16 +0200
Message-ID: <20170720104817.25726-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Remove unbalanced RPM put at driver unbind which resulted in a negative
usage count.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pwm/pwm-tiehrpwm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b5c6b0636893..6e51a075d1a7 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -504,7 +504,6 @@ static int ehrpwm_pwm_remove(struct platform_device *pdev)
 
 	clk_unprepare(pc->tbclk);
 
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return pwmchip_remove(&pc->chip);
 }
-- 
2.13.3
