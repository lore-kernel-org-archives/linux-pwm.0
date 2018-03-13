Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/2] pwm: rcar: add suspend/resume support
Date: Tue, 13 Mar 2018 17:18:18 +0900
Message-Id: <1520929098-20873-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds suspend/resume support for Renesas PWM driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index b942010..34069ae 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -254,11 +254,53 @@ static int rcar_pwm_remove(struct platform_device *pdev)
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 
+#ifdef CONFIG_PM_SLEEP
+static struct pwm_device *rcar_pwm_dev_to_pwm_dev(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = &rcar_pwm->chip;
+
+	return &chip->pwms[0];
+}
+
+static int rcar_pwm_suspend(struct device *dev)
+{
+	struct pwm_device *pwm = rcar_pwm_dev_to_pwm_dev(dev);
+
+	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+		return 0;
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int rcar_pwm_resume(struct device *dev)
+{
+	struct pwm_device *pwm = rcar_pwm_dev_to_pwm_dev(dev);
+
+	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
+		return 0;
+
+	pm_runtime_get_sync(dev);
+
+	rcar_pwm_config(pwm->chip, pwm, pwm->state.duty_cycle,
+			pwm->state.period);
+	if (pwm_is_enabled(pwm))
+		rcar_pwm_enable(pwm->chip, pwm);
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
