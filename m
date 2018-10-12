Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/6] pwm: lpss: Add ACPI HID for second PWM controller on Cherry Trail devices
Date: Fri, 12 Oct 2018 12:12:25 +0200
Message-Id: <20181012101229.27805-3-hdegoede@redhat.com>
In-Reply-To: <20181012101229.27805-1-hdegoede@redhat.com>
References: <20181012101229.27805-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

The second PWM controller on Cherry Trail devices uses a separate ACPI
HID: "80862289", add this so that the driver will properly bind to the
second PWM controller.

The second PWM controller is usually not used, the main thing gained by
this is properly putting the PWM controller in D3 on suspend.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.19.0
