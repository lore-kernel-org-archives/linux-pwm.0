From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2] pwm: avoid holding mutex in interrupt context
Date: Sun, 17 Jan 2016 21:01:57 +0000
Message-ID: <1453064517-12315-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34543 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcAQVCW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2016 16:02:22 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

The introduction of the mutex in commit d1cd21427747 ("pwm: Set enable
state properly on failed call to enable") effectively makes all PWM drivers
potentially sleeping. That in turn makes the .can_sleep field obsolete
since all drivers can now sleep.

Changes fix the below bug by using spinlocks instead of mutex

[   22.300239] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
[   22.307212] in_atomic(): 1, irqs_disabled(): 0, pid: 2257, name: sh
[   22.313454] Preemption disabled at:[<  (null)>]   (null)
[   23.655232] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
[   23.662174] in_atomic(): 1, irqs_disabled(): 0, pid: 2404, name: upowerd
[   23.668932] Preemption disabled at:[<  (null)>]   (null)
[   25.010207] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
[   25.017125] in_atomic(): 1, irqs_disabled(): 0, pid: 2262, name: indicator-keybo
[   25.024491] Preemption disabled at:[<  (null)>]   (null)
[   26.355237] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
[   26.362141] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0
[   26.368728] Preemption disabled at:[<  (null)>]   (null)
[   27.680220] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
[   27.687119] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0
[   27.693698] Preemption disabled at:[<  (null)>]   (null)
[   29.005199] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
[   29.012124] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0

[thierry.reding@gmail.com: Fixed the commit message]
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes logs: droped my prevoius approch.
---
 drivers/pwm/core.c  | 10 +++++-----
 include/linux/pwm.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f..58e7091 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -269,7 +269,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->polarity = polarity;
-		mutex_init(&pwm->lock);
+		spin_lock_init(&pwm->lock);
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -474,7 +474,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm->chip->ops->set_polarity)
 		return -ENOSYS;
 
-	mutex_lock(&pwm->lock);
+	spin_lock_irq(&pwm->lock);
 
 	if (pwm_is_enabled(pwm)) {
 		err = -EBUSY;
@@ -488,7 +488,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	pwm->polarity = polarity;
 
 unlock:
-	mutex_unlock(&pwm->lock);
+	spin_unlock_irq(&pwm->lock);
 	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
@@ -506,7 +506,7 @@ int pwm_enable(struct pwm_device *pwm)
 	if (!pwm)
 		return -EINVAL;
 
-	mutex_lock(&pwm->lock);
+	spin_lock_irq(&pwm->lock);
 
 	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
 		err = pwm->chip->ops->enable(pwm->chip, pwm);
@@ -514,7 +514,7 @@ int pwm_enable(struct pwm_device *pwm)
 			clear_bit(PWMF_ENABLED, &pwm->flags);
 	}
 
-	mutex_unlock(&pwm->lock);
+	spin_unlock_irq(&pwm->lock);
 
 	return err;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cfc3ed4..86ad4c2 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,7 +2,7 @@
 #define __LINUX_PWM_H
 
 #include <linux/err.h>
-#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/of.h>
 
 struct pwm_device;
@@ -100,7 +100,7 @@ struct pwm_device {
 	unsigned int pwm;
 	struct pwm_chip *chip;
 	void *chip_data;
-	struct mutex lock;
+	spinlock_t lock;
 
 	unsigned int period;
 	unsigned int duty_cycle;
-- 
2.1.4
