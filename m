From: Shobhit Kumar <shobhit.kumar@intel.com>
Subject: [PATCH 2/8] drivers/pwm/core: Add support to remove registered consumer lookup tables
Date: Wed, 29 Apr 2015 19:29:59 +0530
Message-ID: <1430316005-16480-3-git-send-email-shobhit.kumar@intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Lee Jones <lee.jones@linaro.org>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Shobhit Kumar <shobhit.kumar@intel.com>
List-Id: linux-pwm@vger.kernel.org

In case some drivers are unloading, they can remove lookup tables which
they would have registered during their load time to avoid redundant
entries if loaded again

v2: Ccing maintainers

CC: Samuel Ortiz <sameo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
---
 drivers/pwm/core.c  | 17 +++++++++++++++++
 include/linux/pwm.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ba34c7d..d2fe7c8d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -586,6 +586,23 @@ void pwm_add_table(struct pwm_lookup *table, size_t num)
 }
 
 /**
+ * pwm_remove_table() - un-register PWM device consumers
+ * @table: array of consumers to un-register
+ * @num: number of consumers in table
+ */
+void pwm_remove_table(struct pwm_lookup *table, size_t num)
+{
+	mutex_lock(&pwm_lookup_lock);
+
+	while (num--) {
+		list_del(&table->list);
+		table++;
+	}
+
+	mutex_unlock(&pwm_lookup_lock);
+}
+
+/**
  * pwm_get() - look up and request a PWM device
  * @dev: device for PWM consumer
  * @con_id: consumer name
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e90628c..cfe2d8d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -290,10 +290,15 @@ struct pwm_lookup {
 
 #if IS_ENABLED(CONFIG_PWM)
 void pwm_add_table(struct pwm_lookup *table, size_t num);
+void pwm_remove_table(struct pwm_lookup *table, size_t num);
 #else
 static inline void pwm_add_table(struct pwm_lookup *table, size_t num)
 {
 }
+
+static inline void pwm_remove_table(struct pwm_lookup *table, size_t num)
+{
+}
 #endif
 
 #ifdef CONFIG_PWM_SYSFS
-- 
2.1.0

