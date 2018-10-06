Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/2] pwm: lpss: Move struct pwm_lpss_chip definition to the header file
Date: Sat,  6 Oct 2018 11:22:29 +0200
Message-Id: <20181006092230.8575-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Move struct pwm_lpss_chip definition from pwm-lpss.c to pwm-lpss.h,
so that the pci/platform drivers can access the info member
(struct pwm_lpss_boardinfo *).

This is a preparation patch for adding platform specific quirks, which
the drivers need access to, to pwm_lpss_boardinfo.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes in v2 of this patch-set
---
 drivers/pwm/pwm-lpss.c | 9 ---------
 drivers/pwm/pwm-lpss.h | 9 ++++++++-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 4721a264bac2..e602835fd6de 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -32,15 +32,6 @@
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
 
-#define MAX_PWMS			4
-
-struct pwm_lpss_chip {
-	struct pwm_chip chip;
-	void __iomem *regs;
-	const struct pwm_lpss_boardinfo *info;
-	u32 saved_ctrl[MAX_PWMS];
-};
-
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 7a4238ad1fcb..8f029ed263af 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -16,7 +16,14 @@
 #include <linux/device.h>
 #include <linux/pwm.h>
 
-struct pwm_lpss_chip;
+#define MAX_PWMS			4
+
+struct pwm_lpss_chip {
+	struct pwm_chip chip;
+	void __iomem *regs;
+	const struct pwm_lpss_boardinfo *info;
+	u32 saved_ctrl[MAX_PWMS];
+};
 
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
-- 
2.19.0
