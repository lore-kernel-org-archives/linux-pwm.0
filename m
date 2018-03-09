Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] pwm: rcar: add suspend/resume support
Date: Fri,  9 Mar 2018 20:54:58 +0900
Message-Id: <1520596498-4801-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1520596498-4801-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1520596498-4801-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds suspend/resume support for Renesas PWM driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index b942010..f62045c 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -254,11 +254,38 @@ static int rcar_pwm_remove(struct platform_device *pdev)
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 
+#ifdef CONFIG_PM_SLEEP
+static int rcar_pwm_suspend(struct device *dev)
+{
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int rcar_pwm_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = &rcar_pwm->chip;
+	struct pwm_device *pwm = &chip->pwms[0];
+
+	pm_runtime_get_sync(dev);
+
+	rcar_pwm_config(chip, pwm, pwm->state.duty_cycle, pwm->state.period);
+	if (pwm_is_enabled(pwm))
+		rcar_pwm_enable(chip, pwm);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+static SIMPLE_DEV_PM_OPS(rcar_pwm_pm_ops, rcar_pwm_suspend, rcar_pwm_resume);
+
 static struct platform_driver rcar_pwm_driver = {
 	.probe = rcar_pwm_probe,
 	.remove = rcar_pwm_remove,
 	.driver = {
 		.name = "pwm-rcar",
+		.pm	= &rcar_pwm_pm_ops,
 		.of_match_table = of_match_ptr(rcar_pwm_of_table),
 	}
 };
-- 
1.9.1
