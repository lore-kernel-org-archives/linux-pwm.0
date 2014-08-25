From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] pwm: lpss: make it buildable only on X86
Date: Mon, 25 Aug 2014 12:38:31 +0300
Message-ID: <1408959511-4360-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53258 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbaHYJie (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 25 Aug 2014 05:38:34 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no sign of this IP block on non-x86 architectures and rather will not
be. Thus, make this explicit by applying a direct dependency to X86.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0907416..3865dfb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -150,6 +150,7 @@ config PWM_LPC32XX
 
 config PWM_LPSS
 	tristate "Intel LPSS PWM support"
+	depends on X86
 	help
 	  Generic PWM framework driver for Intel Low Power Subsystem PWM
 	  controller.
-- 
2.1.0

