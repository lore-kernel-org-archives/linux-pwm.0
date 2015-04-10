From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v6 1/4] drivers: pwm: core: Add pwmchip_add_inversed
Date: Fri, 10 Apr 2015 11:58:50 -0700
Message-ID: <1428692333-14400-2-git-send-email-jonathar@broadcom.com>
References: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Tim Kryger <tim.kryger@gmail.com>

Add a new function to register a PWM chip with channels that have their
initial polarity as inversed.  This benefits drivers of controllers that
by default operate with inversed polarity by removing the need to modify
the polarity during initialization.

Signed-off-by: Tim Kryger <tim.kryger@gmail.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/pwm/core.c  |   36 ++++++++++++++++++++++++++++--------
 include/linux/pwm.h |    6 ++++++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 810aef3..c0a550b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -222,14 +222,8 @@ void *pwm_get_chip_data(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_get_chip_data);
 
-/**
- * pwmchip_add() - register a new PWM chip
- * @chip: the PWM chip to add
- *
- * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
- * will be used.
- */
-int pwmchip_add(struct pwm_chip *chip)
+static int pwmchip_add_with_polarity(struct pwm_chip *chip,
+				     enum pwm_polarity polarity)
 {
 	struct pwm_device *pwm;
 	unsigned int i;
@@ -259,6 +253,7 @@ int pwmchip_add(struct pwm_chip *chip)
 		pwm->chip = chip;
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
+		pwm->polarity = polarity;
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -279,9 +274,34 @@ out:
 	mutex_unlock(&pwm_lock);
 	return ret;
 }
+
+/**
+ * pwmchip_add() - register a new PWM chip
+ * @chip: the PWM chip to add
+ *
+ * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
+ * will be used.  The initial polarity for all channels is normal.
+ */
+int pwmchip_add(struct pwm_chip *chip)
+{
+	return pwmchip_add_with_polarity(chip, PWM_POLARITY_NORMAL);
+}
 EXPORT_SYMBOL_GPL(pwmchip_add);
 
 /**
+ * pwmchip_add_inversed() - register a new PWM chip
+ * @chip: the PWM chip to add
+ *
+ * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
+ * will be used.  The initial polarity for all channels is inversed.
+ */
+int pwmchip_add_inversed(struct pwm_chip *chip)
+{
+	return pwmchip_add_with_polarity(chip, PWM_POLARITY_INVERSED);
+}
+EXPORT_SYMBOL_GPL(pwmchip_add_inversed);
+
+/**
  * pwmchip_remove() - remove a PWM chip
  * @chip: the PWM chip to remove
  *
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e90628c..358547f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -183,6 +183,7 @@ int pwm_set_chip_data(struct pwm_device *pwm, void *data);
 void *pwm_get_chip_data(struct pwm_device *pwm);
 
 int pwmchip_add(struct pwm_chip *chip);
+int pwmchip_add_inversed(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
@@ -217,6 +218,11 @@ static inline int pwmchip_add(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
+static inline int pwmchip_add_inversed(struct pwm_chip *chip)
+{
+	return -EINVAL;
+}
+
 static inline int pwmchip_remove(struct pwm_chip *chip)
 {
 	return -EINVAL;
-- 
1.7.9.5
