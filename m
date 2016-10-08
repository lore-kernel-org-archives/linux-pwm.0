From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] pwm: add COMPILE_TEST and default y for brcm-iproc-pwm
Date: Sat,  8 Oct 2016 10:26:39 -0700
Message-ID: <1475947599-5022-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33204 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756723AbcJHR0z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Oct 2016 13:26:55 -0400
Received: by mail-pf0-f172.google.com with SMTP id 190so36667242pfv.0
        for <linux-pwm@vger.kernel.org>; Sat, 08 Oct 2016 10:26:54 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Scott Branden <scott.branden@broadcom.com>

Enable COMPILE_TEST for broader compile coverage.
Default y for IPROC PWM driver for IPROC SoCs.
This allows you to turn it on simply by selecting CONFIG_PWM.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pwm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 80a566a..0c04ec3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -77,6 +77,7 @@ config PWM_ATMEL_TCB
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC
+	default y
 	help
 	  Generic PWM framework driver for Broadcom iProc PWM block. This
 	  block is used in Broadcom iProc SoC's.
-- 
2.5.0
