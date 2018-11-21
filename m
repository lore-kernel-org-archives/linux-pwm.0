From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date: Wed, 21 Nov 2018 13:35:08 +0100
Message-ID: <20181121123508.25119-1-peron.clem@gmail.com>
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
 drivers/pwm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 27e5dd47a01f..982f4059f4e8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -88,7 +88,9 @@ config PWM_BCM_IPROC
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+	default ARCH_BCM_CYGNUS
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
 
-- 
2.19.1
