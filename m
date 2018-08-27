Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] pwm: lpss: Add ACPI HID for second PWM controller on Cherry Trail devices
Date: Mon, 27 Aug 2018 09:52:33 +0200
Message-Id: <20180827075233.6408-1-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org

The second PWM controller on Cherry Trail devices uses a separate ACPI
HID: "80862289", add this so that the driver will properly bind to the
second PWM controller.

The second PWM controller is usually not used, the main thing gained by
this is properly putting the PWM controller in D3 on suspend.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 5561b9e190f8..7304f36ee715 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -81,6 +81,7 @@ static SIMPLE_DEV_PM_OPS(pwm_lpss_platform_pm_ops,
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
 	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
+	{ "80862289", (unsigned long)&pwm_lpss_bsw_info },
 	{ "80865AC8", (unsigned long)&pwm_lpss_bxt_info },
 	{ },
 };
-- 
2.18.0
