From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] drivers/pwm/Kconfig: Let PWM_CLPS711X depend on HAS_IOMEM
Date: Sat, 04 Oct 2014 17:48:42 +0800
Message-ID: <542FC27A.8050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52147 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbaJDJmz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Oct 2014 05:42:55 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

PWM_CLPS711X needs HAS_IOMEM, so depend on it, the related error (with
allmodconfig under um):

    MODPOST 1205 modules
  ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefined!
  ERROR: "devm_ioremap" [drivers/net/phy/mdio-bcm-unimac.ko] undefined!

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3865dfb..de1ffb5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -82,7 +82,7 @@ config PWM_BFIN
 
 config PWM_CLPS711X
 	tristate "CLPS711X PWM support"
-	depends on ARCH_CLPS711X || COMPILE_TEST
+	depends on (ARCH_CLPS711X || COMPILE_TEST) && HAS_IOMEM
 	help
 	  Generic PWM framework driver for Cirrus Logic CLPS711X.
 
-- 
1.9.3
