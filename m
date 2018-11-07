From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date: Wed,  7 Nov 2018 10:36:12 +0100
Message-ID: <20181107093613.26734-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: linux-pwm@vger.kernel.org

The Cygnus architecture use a Kona PWM. This is already present
in the device tree but can't be built actually. Hence, allow the
Kona PWM to be built for Cygnus arch.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..76d56fc8b1b7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -88,7 +88,8 @@ config PWM_BCM_IPROC
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
+	default ARCH_BCM_CYGNUS
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
 
-- 
2.19.1
