From: David Hsu <davidhsu@google.com>
Subject: [PATCH] pwm: Unexport children before chip removal
Date: Tue,  9 Aug 2016 14:57:46 -0700
Message-ID: <1470779866-74776-1-git-send-email-davidhsu@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: gregkh@linuxfoundation.org, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, davidhsu@google.com
List-Id: linux-pwm@vger.kernel.org

Exported pwm channels aren't removed before the pwmchip and are
leaked. This results in invalid sysfs files. This fix removes
all exported pwm channels before chip removal.

Signed-off-by: David Hsu <davidhsu@google.com>
---
 drivers/pwm/core.c  |  2 ++
 drivers/pwm/sysfs.c | 18 ++++++++++++++++++
 include/linux/pwm.h |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ed337a8c..869af84 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -339,6 +339,8 @@ int pwmchip_remove(struct pwm_chip *chip)
 	unsigned int i;
 	int ret = 0;
 
+	pwmchip_sysfs_unexport_children(chip);
+
 	mutex_lock(&pwm_lock);
 
 	for (i = 0; i < chip->npwm; i++) {
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index cb2b376..b3ccb8f 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -400,6 +400,24 @@ void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 	}
 }
 
+void pwmchip_sysfs_unexport_children(struct pwm_chip *chip)
+{
+	struct device *parent;
+	unsigned int i;
+
+	parent = class_find_device(&pwm_class, NULL, chip,
+				   pwmchip_sysfs_match);
+	if (!parent)
+		return;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (test_bit(PWMF_EXPORTED, &pwm->flags))
+			pwm_unexport_child(parent, pwm);
+	}
+}
+
 static int __init pwm_sysfs_init(void)
 {
 	return class_register(&pwm_class);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c038ae3..16a0ae0 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -530,6 +530,7 @@ static inline void pwm_remove_table(struct pwm_lookup *table, size_t num)
 #ifdef CONFIG_PWM_SYSFS
 void pwmchip_sysfs_export(struct pwm_chip *chip);
 void pwmchip_sysfs_unexport(struct pwm_chip *chip);
+void pwmchip_sysfs_unexport_children(struct pwm_chip *chip);
 #else
 static inline void pwmchip_sysfs_export(struct pwm_chip *chip)
 {
@@ -538,6 +539,10 @@ static inline void pwmchip_sysfs_export(struct pwm_chip *chip)
 static inline void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 {
 }
+
+static inline void pwmchip_sysfs_unexport_children(struct pwm_chip *chip)
+{
+}
 #endif /* CONFIG_PWM_SYSFS */
 
 #endif /* __LINUX_PWM_H */
-- 
2.8.0.rc3.226.g39d4020
