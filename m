From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [PATCH 1/8] drivers/gpio/gpiolib: Add support for removing registered consumer lookup table
Date: Wed, 29 Apr 2015 19:29:58 +0530
Message-ID: <1430316005-16480-2-git-send-email-shobhit.kumar@intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31178 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423147AbbD2OAZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 29 Apr 2015 10:00:25 -0400
In-Reply-To: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Lee Jones <lee.jones@linaro.org>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Shobhit Kumar <shobhit.kumar@intel.com>

In case we unload and load a driver module again that is registering a
lookup table, without this it will result in multiple entries. Provide
an option to remove the lookup table on driver unload

v2: Ccing maintainers

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
---
 drivers/gpio/gpiolib.c       | 13 +++++++++++++
 include/linux/gpio/machine.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 59eaa23..2420af9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1658,6 +1658,19 @@ void gpiod_add_lookup_table(struct gpiod_lookup_table *table)
 	mutex_unlock(&gpio_lookup_lock);
 }
 
+/**
+ * gpiod_remove_lookup_table() - unregister GPIO device consumers
+ * @table: table of consumers to unregister
+ */
+void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
+{
+	mutex_lock(&gpio_lookup_lock);
+
+	list_del(&table->list);
+
+	mutex_unlock(&gpio_lookup_lock);
+}
+
 static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 				      unsigned int idx,
 				      enum gpio_lookup_flags *flags)
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index e270614..c0d712d 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -57,5 +57,6 @@ struct gpiod_lookup_table {
 }
 
 void gpiod_add_lookup_table(struct gpiod_lookup_table *table);
+void gpiod_remove_lookup_table(struct gpiod_lookup_table *table);
 
 #endif /* __LINUX_GPIO_MACHINE_H */
-- 
2.1.0
