From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v10 1/1] pwm: core: Set enable state properly on failed call to enable
Date: Fri, 16 Oct 2015 17:40:58 -0700
Message-ID: <1445042458-30725-2-git-send-email-jonathar@broadcom.com>
References: <1445042458-30725-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:50274 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbbJQAkN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2015 20:40:13 -0400
In-Reply-To: <1445042458-30725-1-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

The pwm_enable function didn't clear the enabled bit if a call to a
clients enable function returned an error. The result was that the state
of the pwm core was wrong. Clearing the bit when enable returns an error
ensures the state is properly set.

Tested-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/pwm/core.c  | 33 ++++++++++++++++++++++++++-------
 include/linux/pwm.h |  2 ++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3f9df3e..b8f6c30 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -269,6 +269,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->polarity = polarity;
+		mutex_init(&pwm->lock);
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -473,16 +474,22 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
 	if (!pwm->chip->ops->set_polarity)
 		return -ENOSYS;
 
-	if (pwm_is_enabled(pwm))
-		return -EBUSY;
+	mutex_lock(&pwm->lock);
+
+	if (pwm_is_enabled(pwm)) {
+		err = -EBUSY;
+		goto unlock;
+	}
 
 	err = pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
 	if (err)
-		return err;
+		goto unlock;
 
 	pwm->polarity = polarity;
 
-	return 0;
+unlock:
+	mutex_unlock(&pwm->lock);
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_set_polarity);
 
@@ -494,10 +501,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
-		return pwm->chip->ops->enable(pwm->chip, pwm);
+	int err = 0;
+
+	if (!pwm)
+		return -EINVAL;
+
+	mutex_lock(&pwm->lock);
+
+	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
+		err = pwm->chip->ops->enable(pwm->chip, pwm);
+		if (err)
+			clear_bit(PWMF_ENABLED, &pwm->flags);
+	}
+
+	mutex_unlock(&pwm->lock);
 
-	return pwm ? 0 : -EINVAL;
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_enable);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d681f68..dee7d65 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,6 +3,7 @@
 
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/mutex.h>
 
 struct pwm_device;
 struct seq_file;
@@ -98,6 +99,7 @@ struct pwm_device {
 	unsigned int pwm;
 	struct pwm_chip *chip;
 	void *chip_data;
+	struct mutex lock;
 
 	unsigned int period;
 	unsigned int duty_cycle;
-- 
1.9.1
