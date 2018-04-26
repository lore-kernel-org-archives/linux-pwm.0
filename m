From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices
Date: Thu, 26 Apr 2018 14:10:24 +0200
Message-ID: <20180426121024.22023-2-hdegoede@redhat.com>
References: <20180426121024.22023-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180426121024.22023-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The LPSS PWM device on on Bay Trail and Cherry Trail devices has a set
of private registers at offset 0x800, the current lpss_device_desc for
them already sets the LPSS_SAVE_CTX flag to have these saved/restored
over device-suspend, but the current lpss_device_desc was not setting
the prv_offset field, leading to the regular device registers getting
saved/restored instead.

This is causing the PWM controller to no longer work, resulting in a black
screen,  after a suspend/resume on systems where the firmware clears the
APB clock and reset bits at offset 0x804.

This commit fixes this by properly setting prv_offset to 0x800 for
the PWM devices.

Cc: stable@vger.kernel.org
Fixes: e1c748179754 ("ACPI / LPSS: Add Intel BayTrail ACPI mode PWM")
Fixes: 1bfbd8eb8a7f ("ACPI / LPSS: Add ACPI IDs for Intel Braswell")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Fixes and Cc:stable tags
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 2bcffec8dbf0..c4ba9164e582 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -229,11 +229,13 @@ static const struct lpss_device_desc lpt_sdio_dev_desc = {
 
 static const struct lpss_device_desc byt_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX,
+	.prv_offset = 0x800,
 	.setup = byt_pwm_setup,
 };
 
 static const struct lpss_device_desc bsw_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
+	.prv_offset = 0x800,
 	.setup = bsw_pwm_setup,
 };
 
-- 
2.17.0
