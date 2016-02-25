From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] pwm: rcar: Use ARCH_RENESAS
Date: Thu, 25 Feb 2016 10:03:23 +0900
Message-ID: <1456362203-21038-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-pwm@vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 Based on v4.5-rc1

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8cf0dae78555..c182efc62c7b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -316,7 +316,7 @@ config PWM_RCAR
 
 config PWM_RENESAS_TPU
 	tristate "Renesas TPU PWM support"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
-- 
2.7.0.rc3.207.g0ac5344
