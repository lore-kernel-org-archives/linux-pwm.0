From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH] pwm: samsung: Allow samsung pwm driver to be enabled on Exynos7
Date: Fri, 31 Oct 2014 18:08:46 +0530
Message-ID: <1414759126-4608-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57749 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758758AbaJaMiz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Oct 2014 08:38:55 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so7696201pab.10
        for <linux-pwm@vger.kernel.org>; Fri, 31 Oct 2014 05:38:55 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org, thierry.reding@gmail.com
Cc: kesavan.abhilash@gmail.com

To re-use the existing PWM driver for arm64 based exynos7 SoC,
make the driver depend on ARCH_EXYNOS along with PLAT_SAMSUNG.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/pwm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ef2dd2e..e82ab69 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -235,7 +235,7 @@ config PWM_ROCKCHIP
 
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
-	depends on PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS
 	help
 	  Generic PWM framework driver for Samsung.
 
-- 
1.7.9.5

