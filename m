Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22620 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3HBGLZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Aug 2013 02:11:25 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQW00JVX3UUOG50@mailout1.samsung.com> for
 linux-pwm@vger.kernel.org; Fri, 02 Aug 2013 15:11:18 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pwm: tiecap: add CONFIG_PM_SLEEP to
 ecap_pwm_{save,restore}_context()
Date: Fri, 02 Aug 2013 15:11:18 +0900
Message-id: <000901ce8f47$1a3e17d0$4eba4770$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: 'Thierry Reding' <thierry.reding@avionic-design.de>
Cc: linux-pwm@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, 'Jingoo Han' <jg1.han@samsung.com>

ecap_pwm_save_context() and ecap_pwm_restore_context() are only used
when CONFIG_PM_SLEEP is selected.

drivers/pwm/pwm-tiecap.c:293:13: warning: 'ecap_pwm_save_context' defined but not used [-Wunused-function]
drivers/pwm/pwm-tiecap.c:302:13: warning: 'ecap_pwm_restore_context' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-tiecap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 72ca42d..c2e2e58 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -290,6 +290,7 @@ static int ecap_pwm_remove(struct platform_device *pdev)
 	return pwmchip_remove(&pc->chip);
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
 {
 	pm_runtime_get_sync(pc->chip.dev);
@@ -306,7 +307,6 @@ static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
 	writew(pc->ctx.ecctl2, pc->mmio_base + ECCTL2);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ecap_pwm_suspend(struct device *dev)
 {
 	struct ecap_pwm_chip *pc = dev_get_drvdata(dev);
-- 
1.7.10.4


