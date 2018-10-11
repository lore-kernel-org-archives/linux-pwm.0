Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 1/3] ACPI / PM: Export acpi_device_get_power() for use by modular build drivers
Date: Thu, 11 Oct 2018 18:14:42 +0200
Message-Id: <20181011161444.328-2-hdegoede@redhat.com>
In-Reply-To: <20181011161444.328-1-hdegoede@redhat.com>
References: <20181011161444.328-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Export acpi_device_get_power() for use by modular build drivers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-New patch in v4 of this patch-set
---
 drivers/acpi/device_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index a7c2673ffd36..824ae985ad93 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -126,6 +126,7 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
 
 	return 0;
 }
+EXPORT_SYMBOL(acpi_device_get_power);
 
 static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
 {
-- 
2.19.0
