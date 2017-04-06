From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V4 4/4] pwm: tegra: Add support to configure pin state in suspends/resume
Date: Thu, 6 Apr 2017 19:51:01 +0530
Message-ID: <1491488461-24621-5-git-send-email-ldewangan@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491488461-24621-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

In some of NVIDIA Tegra's platform, PWM controller is used to
control the PWM controlled regulators. PWM signal is connected to
the VID pin of the regulator where duty cycle of PWM signal decide
the voltage level of the regulator output.

The tristate (high impedance of PWM pin form Tegra) also define
one of the state of PWM regulator which needs to be configure in
suspend state of system.

Add support to configure the pin state via pinctrl frameworks in
suspend and active state of the system.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes from v1:
- Use standard pinctrl names for sleep and active state.
- Use API pinctrl_pm_select_*()

 drivers/pwm/pwm-tegra.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e9c4de5..af1bd4f 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -29,6 +29,7 @@
 #include <linux/of_device.h>
 #include <linux/pwm.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/slab.h>
 #include <linux/reset.h>
 
@@ -256,6 +257,22 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int tegra_pwm_suspend(struct device *dev)
+{
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int tegra_pwm_resume(struct device *dev)
+{
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+}
+#endif
+
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
 };
@@ -272,10 +289,15 @@ static const struct of_device_id tegra_pwm_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
 
+static const struct dev_pm_ops tegra_pwm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_pwm_suspend, tegra_pwm_resume)
+};
+
 static struct platform_driver tegra_pwm_driver = {
 	.driver = {
 		.name = "tegra-pwm",
 		.of_match_table = tegra_pwm_of_match,
+		.pm = &tegra_pwm_pm_ops,
 	},
 	.probe = tegra_pwm_probe,
 	.remove = tegra_pwm_remove,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
