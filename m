From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
Date: Mon,  9 Dec 2019 15:25:03 -0800
Message-ID: <20191209232503.7252-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
driver, make it possible to build it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bd21655c37a6..0bb8a40c8d6c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -100,7 +100,7 @@ config PWM_BCM_KONA
 
 config PWM_BCM2835
 	tristate "BCM2835 PWM support"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB
 	help
 	  PWM framework driver for BCM2835 controller (Raspberry Pi)
 
-- 
2.17.1
