From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi: lpss: call pwm_add_table() for bsw pwm device
Date: Thu, 19 Jan 2017 18:53:38 +0100
Message-ID: <20170119175338.3543-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pwm@vger.kernel.org

On x86 we do not have devicetree to link the pwm controller and
the display controller together. So someone needs to call
pwm_add_table() to create the link, so that the i915 driver's
pwm_get(dev, "pwm_backlight") call returns the lpss' pwm0.

The pwm subsystem does not want to have pwm_add_table() calls
directly in pwm drivers (this leads to probe ordering issues),
so lets do it here since the acpi-lpss code is always builtin.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 8ea836c..1b4bcf6 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -20,6 +20,7 @@
 #include <linux/platform_data/clk-lpss.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwm.h>
 #include <linux/delay.h>
 
 #include "internal.h"
@@ -154,6 +155,17 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
 }
 
+/* BSW PWM used for backlight control by the i915 driver */
+static struct pwm_lookup bsw_pwm_lookup[] = {
+	PWM_LOOKUP("80862288:00", 0, "0000:00:02.0", "pwm_backlight", 0,
+		   PWM_POLARITY_NORMAL),
+};
+
+static void bsw_pwm_setup(struct lpss_private_data *pdata)
+{
+	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
+}
+
 static const struct lpss_device_desc lpt_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
 	.prv_offset = 0x800,
@@ -191,6 +203,7 @@ static const struct lpss_device_desc byt_pwm_dev_desc = {
 
 static const struct lpss_device_desc bsw_pwm_dev_desc = {
 	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
+	.setup = bsw_pwm_setup,
 };
 
 static const struct lpss_device_desc byt_uart_dev_desc = {
-- 
2.9.3

