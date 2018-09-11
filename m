Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] pwm: lpss: Check PWM powerstate after resume on Cherry Trail devices
Date: Tue, 11 Sep 2018 19:30:50 +0200
Message-Id: <20180911173050.2374-2-hdegoede@redhat.com>
In-Reply-To: <20180911173050.2374-1-hdegoede@redhat.com>
References: <20180911173050.2374-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

The _PS0 method for the integrated graphics on some Cherry Trail devices
(observed on a HP Pavilion X2 10-p0XX) turns on the PWM chip (puts it in
D0), causing an inconsistency between the state the pm-core thinks it is
in (left runtime suspended as it was before the suspend/resume) and the
state it actually is in.

Interestingly enough this is done on a device where the pwm controller is
not used for the backlight at all, since it uses an eDP panel. On devices
where the PWM is used this is not a problem since we will resume it
ourselves anyways.

This inconsistency causes us to never suspend the pwm controller again,
which causes the device to not be able to reach S0ix states when suspended.

This commit adds a resume-complete handler, which when we think the device
is still run-time suspended checks the actual power-state and if necessary
updates the rpm-core's internal state.

This fixes the Pavilion X2 10-p0XX not reaching S0ix states when suspended.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 26 +++++++++++++++++++++++---
 drivers/pwm/pwm-lpss.h          |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 7304f36ee715..00b2b18c8f6d 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -30,6 +30,7 @@ static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
 	.clk_rate = 19200000,
 	.npwm = 1,
 	.base_unit_bits = 16,
+	.check_power_on_resume = true,
 };
 
 /* Broxton */
@@ -74,9 +75,28 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 	return pwm_lpss_remove(lpwm);
 }
 
-static SIMPLE_DEV_PM_OPS(pwm_lpss_platform_pm_ops,
-			 pwm_lpss_suspend,
-			 pwm_lpss_resume);
+static void pwm_lpss_complete(struct device *dev)
+{
+	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
+	unsigned long long psc;
+	acpi_status status;
+
+	/* The PWM may be turned on by AML code, update our state to match */
+	if (pm_runtime_suspended(dev) && lpwm->info->check_power_on_resume) {
+		status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_PSC",
+					       NULL, &psc);
+		if (ACPI_SUCCESS(status) && psc == ACPI_STATE_D0) {
+			pm_runtime_disable(dev);
+			pm_runtime_set_active(dev);
+			pm_runtime_enable(dev);
+		}
+	}
+}
+
+static const struct dev_pm_ops pwm_lpss_platform_pm_ops = {
+	.complete = pwm_lpss_complete,
+	SET_SYSTEM_SLEEP_PM_OPS(pwm_lpss_suspend, pwm_lpss_resume)
+};
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 8f029ed263af..1a2575d25bea 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -30,6 +30,8 @@ struct pwm_lpss_boardinfo {
 	unsigned int npwm;
 	unsigned long base_unit_bits;
 	bool bypass;
+	/* Some devices have AML code messing with the state underneath us */
+	bool check_power_on_resume;
 };
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
-- 
2.19.0.rc0
