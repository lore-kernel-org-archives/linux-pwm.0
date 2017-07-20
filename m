From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] pwm: tiehrpwm: fix clock imbalance in probe error path
Date: Thu, 20 Jul 2017 12:48:17 +0200
Message-ID: <20170720104817.25726-2-johan@kernel.org>
References: <20170720104817.25726-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720104817.25726-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Make sure to unprepare the clock before returning on late probe errors.

Fixes: b388f15fd14c ("pwm: pwm-tiehrpwm: Use clk_enable/disable instead clk_prepare/unprepare.")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pwm/pwm-tiehrpwm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 6e51a075d1a7..387eaf1bac85 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -489,13 +489,18 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
+		goto err_clk_unprepare;
 	}
 
 	pm_runtime_enable(&pdev->dev);
 
 	platform_set_drvdata(pdev, pc);
 	return 0;
+
+err_clk_unprepare:
+	clk_unprepare(pc->tbclk);
+
+	return ret;
 }
 
 static int ehrpwm_pwm_remove(struct platform_device *pdev)
-- 
2.13.3
