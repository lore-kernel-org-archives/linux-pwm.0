From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] pwm: tiehrpwm: don't build PM related functions when not needed
Date: Wed,  2 Apr 2014 13:56:21 +0200
Message-ID: <1396439802-6813-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51352 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758407AbaDBL4w (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 2 Apr 2014 07:56:52 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Wolfram Sang <wsa@sang-engineering.com>, Thierry Reding <thierry.reding@gmail.com>

From: Wolfram Sang <wsa@sang-engineering.com>

Fixes following warnings on AM335X with no PM_SLEEP

drivers/pwm/pwm-tiehrpwm.c:534:13: warning: 'ehrpwm_pwm_save_context' defined but not used [-Wunused-function]
drivers/pwm/pwm-tiehrpwm.c:548:13: warning: 'ehrpwm_pwm_restore_context' defined but not used [-Wunused-function]

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index aee4471424d1..b2544296430a 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -531,6 +531,7 @@ static int ehrpwm_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 {
 	pm_runtime_get_sync(pc->chip.dev);
@@ -557,7 +558,6 @@ static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
 	ehrpwm_write(pc->mmio_base, TBCTL, pc->ctx.tbctl);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ehrpwm_pwm_suspend(struct device *dev)
 {
 	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
-- 
1.9.0

