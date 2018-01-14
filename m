From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / LPSS: Do not instiate a platform_dev for devs without a mmio resource
Date: Sun, 14 Jan 2018 21:01:48 +0100
Message-ID: <20180114200148.11771-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

acpi_lpss_create_device() skips handling LPSS devices which do not have
a mmio resources in their resource list (typically these devices are
disabled by the firmware). But since the LPSS code does not bind to the
device, acpi_bus_attach() ends up still creating a platform device for
it and the regular platform_driver for the ACPI HID still tries to bind
to it.

This happens e.g. on some boards which do not use the pwm-controller
and have an empty or invalid resource-table for it. Currently this causes
these error messages to get logged:
[    3.281966] pwm-lpss 80862288:00: invalid resource
[    3.287098] pwm-lpss: probe of 80862288:00 failed with error -22

This commit stops the undesirable creation of a platform_device for
disabled LPSS devices by setting pnp.type.platform_id to 0. Note that
acpi_scan_attach_handler() also sets pnp.type.platform_id to 0 when there
is a matching handler for the device and that handler has no attach
callback, so we simply behave as a handler without an attach function
in this case.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 9cfe6b71078b..166a8e582d96 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -610,6 +610,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (!pdata->mmio_base) {
+		/* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
+		adev->pnp.type.platform_id = 0;
 		/* Skip the device, but continue the namespace scan. */
 		ret = 0;
 		goto err_out;
-- 
2.14.3

