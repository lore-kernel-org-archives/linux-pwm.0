From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] pwm: lpss: Remove ->free() callback
Date: Wed,  9 Dec 2015 16:05:59 +0200
Message-ID: <1449669959-55013-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50607 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118AbbLIOHb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 9 Dec 2015 09:07:31 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pwm@vger.kernel.org

The LPSS PWM driver calls pwm_lpss_disable() when the PWM device is
released (for example unexported from sysfs). This in turn calls
pm_runtime_put() which makes runtime PM count to be unbalanced if the
device has not been enabled at this point.

This is easy to reproduce:

  # cd /sys/class/pwm/pwmchip0
  # echo 0 > export
  # echo 0 > unexport

The count is unbalanced and prevents the PWM device from being powered on
next time.

Fix this by removing ->free() callback. There are no resources to be
released anyway.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 6063c3dcbd46..ba9f17443843 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -159,7 +159,6 @@ static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops pwm_lpss_ops = {
-	.free = pwm_lpss_disable,
 	.config = pwm_lpss_config,
 	.enable = pwm_lpss_enable,
 	.disable = pwm_lpss_disable,
-- 
2.6.2
