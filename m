From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v9 2/2] pwm: core: Set enable state properly on failed call to enable
Date: Mon, 15 Jun 2015 14:21:02 -0700
Message-ID: <1434403262-24198-3-git-send-email-jonathar@broadcom.com>
References: <1434403262-24198-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:41577 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbFOVRf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2015 17:17:35 -0400
In-Reply-To: <1434403262-24198-1-git-send-email-jonathar@broadcom.com>
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
 drivers/pwm/core.c  |   19 ++++++++++++++++---
 include/linux/pwm.h |    2 ++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 76b0386..c255267 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -263,6 +263,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->polarity = polarity;
+		mutex_init(&pwm->lock);
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -474,10 +475,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
  */
 int pwm_enable(struct pwm_device *pwm)
 {
-	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
-		return pwm->chip->ops->enable(pwm->chip, pwm);
+	int err = 0;
 
-	return pwm ? 0 : -EINVAL;
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
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_enable);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 9daf0ef..50f28e6 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,6 +3,7 @@
 
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/mutex.h>
 
 struct pwm_device;
 struct seq_file;
@@ -86,6 +87,7 @@ struct pwm_device {
 	unsigned int		pwm;
 	struct pwm_chip		*chip;
 	void			*chip_data;
+	struct mutex		lock;
 
 	unsigned int		period; 	/* in nanoseconds */
 	unsigned int		duty_cycle;	/* in nanoseconds */
-- 
1.7.9.5
