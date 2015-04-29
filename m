From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [PATCH 3/8] drivers/mfd: Add lookup table for Panel Control as GPIO signal
Date: Wed, 29 Apr 2015 19:30:00 +0530
Message-ID: <1430316005-16480-4-git-send-email-shobhit.kumar@intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Lee Jones <lee.jones@linaro.org>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Shobhit Kumar <shobhit.kumar@intel.com>
List-Id: linux-pwm@vger.kernel.org

On some Intel SoC platforms, the panel enable/disable signals are
controlled by CRC PMIC. Add those control as a new GPIO in a lookup
table for gpio-crystalcove chip during CRC driver load

v2: Make the lookup table static (Thierry)
    Remove the lookup table during driver remove (Thierry)

CC: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
---
 drivers/mfd/intel_soc_pmic_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index 7b50b6b..f3d918e 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -24,8 +24,19 @@
 #include <linux/acpi.h>
 #include <linux/regmap.h>
 #include <linux/mfd/intel_soc_pmic.h>
+#include <linux/gpio/machine.h>
 #include "intel_soc_pmic_core.h"
 
+/* Lookup table for the Panel Enable/Disable line as GPIO signals */
+static struct gpiod_lookup_table panel_gpio_table = {
+	/* Intel GFX is consumer */
+	.dev_id = "0000:00:02.0",
+	.table = {
+		/* Panel EN/DISABLE */
+		GPIO_LOOKUP("gpio_crystalcove", 94, "panel", GPIO_ACTIVE_HIGH),
+	},
+};
+
 static int intel_soc_pmic_find_gpio_irq(struct device *dev)
 {
 	struct gpio_desc *desc;
@@ -85,6 +96,9 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
 
+	/* Add lookup table binding for Panel Control to the GPIO Chip */
+	gpiod_add_lookup_table(&panel_gpio_table);
+
 	ret = mfd_add_devices(dev, -1, config->cell_dev,
 			      config->n_cell_devs, NULL, 0,
 			      regmap_irq_get_domain(pmic->irq_chip_data));
@@ -104,6 +118,9 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 
 	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
 
+	/* Remove lookup table for Panel Control from the GPIO Chip */
+	gpiod_remove_lookup_table(&panel_gpio_table);
+
 	mfd_remove_devices(&i2c->dev);
 
 	return 0;
-- 
2.1.0
