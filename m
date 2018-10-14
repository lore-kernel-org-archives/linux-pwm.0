Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] pwm: lpss: Force runtime-resume on suspend on Cherry Trail
Date: Sun, 14 Oct 2018 17:12:01 +0200
Message-Id: <20181014151202.29955-2-hdegoede@redhat.com>
In-Reply-To: <20181014151202.29955-1-hdegoede@redhat.com>
References: <20181014151202.29955-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Cherry Trail devices under Windows the PWM controller used for the
backlight is considered part of the GPU even though it is part of the LPSS
block and thus is an entirely different independent hardware unit.

Because of this on Cherry Trail the GPU's (GFX0 ACPI node) _PS3 and _PS0
methods save and restore the PWM controller registers.

If userspace blanks the screen before suspending, such as e.g. GNOME
does, then the PWM controller will be runtime-suspended when the suspend
starts. This causes the GFX0 _PS? methods to save a value of 0xffffffff
for the PWM control register and to restore this value on resume.

0xffffffff is not a valid value for the register and writing this causes
problems such as e.g. a flickering backlight.

This commit adds a prepare method to the dev_pm_ops and makes it return 0
on Cherry Trail devices forcing a runtime-resume before other device's
suspend methods run. This fixes the reading and writing back of 0xffffffff.

Since we now always runtime-resume the device on suspend, it will be
resumed on resume too and we no longer need to check for the GFX0 _PS0
method having resumed it underneath us, so this commit removes the now no
longer necessary complete dev_pm_op.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 24 +++++++++++-------------
 drivers/pwm/pwm-lpss.h          |  7 +++++--
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index b6edf8af26cc..757230e1f575 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -30,7 +30,7 @@ static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
 	.clk_rate = 19200000,
 	.npwm = 1,
 	.base_unit_bits = 16,
-	.check_power_on_resume = true,
+	.other_devices_aml_touches_pwm_regs = true,
 };
 
 /* Broxton */
@@ -61,6 +61,7 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lpwm);
 
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
@@ -75,25 +76,22 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 	return pwm_lpss_remove(lpwm);
 }
 
-static void pwm_lpss_complete(struct device *dev)
+static int pwm_lpss_prepare(struct device *dev)
 {
 	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
-	int ret, state;
 
-	/* The PWM may be turned on by AML code, update our state to match */
-	if (pm_runtime_suspended(dev) && lpwm->info->check_power_on_resume) {
-		pm_runtime_disable(dev);
+	/*
+	 * If other device's AML code touches the PWM regs on suspend/resume
+	 * force runtime-resume the PWM controller to allow this.
+	 */
+	if (lpwm->info->other_devices_aml_touches_pwm_regs)
+		return 0; /* Force runtime-resume */
 
-		ret = acpi_device_get_power(ACPI_COMPANION(dev), &state);
-		if (ret == 0 && state == ACPI_STATE_D0)
-			pm_runtime_set_active(dev);
-
-		pm_runtime_enable(dev);
-	}
+	return 1; /* If runtime-suspended leave as is */
 }
 
 static const struct dev_pm_ops pwm_lpss_platform_pm_ops = {
-	.complete = pwm_lpss_complete,
+	.prepare = pwm_lpss_prepare,
 	SET_SYSTEM_SLEEP_PM_OPS(pwm_lpss_suspend, pwm_lpss_resume)
 };
 
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 1a2575d25bea..3236be835bd9 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -30,8 +30,11 @@ struct pwm_lpss_boardinfo {
 	unsigned int npwm;
 	unsigned long base_unit_bits;
 	bool bypass;
-	/* Some devices have AML code messing with the state underneath us */
-	bool check_power_on_resume;
+	/*
+	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
+	 * messes with the PWM0 controllers state,
+	 */
+	bool other_devices_aml_touches_pwm_regs;
 };
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
-- 
2.19.0
