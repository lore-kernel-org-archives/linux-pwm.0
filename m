From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3] pwm: add depends, COMPILE_TEST and default y for brcm-iproc-pwm
Date: Sat,  8 Oct 2016 13:54:05 -0700
Message-ID: <1475960045-19313-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36493 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbcJHUyL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Oct 2016 16:54:11 -0400
Received: by mail-pf0-f176.google.com with SMTP id i85so37628767pfa.3
        for <linux-pwm@vger.kernel.org>; Sat, 08 Oct 2016 13:54:11 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Scott Branden <scott.branden@broadcom.com>

- Add depends on COMMON_CLK for PWM_BCM_IPROC
- Enable COMPILE_TEST for broader compile coverage.
- Default y for IPROC PWM driver for IPROC SoCs.
This allows you to turn it on simply by selecting CONFIG_PWM.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pwm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 80a566a..3eb1b6b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -76,7 +76,9 @@ config PWM_ATMEL_TCB
 
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
-	depends on ARCH_BCM_IPROC
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	depends on COMMON_CLK
+	default ARCH_BCM_IPROC
 	help
 	  Generic PWM framework driver for Broadcom iProc PWM block. This
 	  block is used in Broadcom iProc SoC's.
-- 
2.5.0
