From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] pwm: remove depends on AVR32
Date: Thu, 18 Jan 2018 20:58:14 +0100
Message-ID: <20180118195814.6576-1-clabbe.montjoie@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36547 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755141AbeARUA3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jan 2018 15:00:29 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

AVR32 is gone, so no more need to depends on it.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..f16aad3bf5d6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -43,7 +43,7 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on ARCH_AT91 || AVR32
+	depends on ARCH_AT91
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
-- 
2.13.6
