From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 36/47] pwm: remobe pwm-bfin driver
Date: Wed, 14 Mar 2018 16:35:49 +0100
Message-ID: <20180314153603.3127932-37-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The blackfin architecture is getting removed, so this driver is now
obsolete as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pwm/Kconfig    |   9 ---
 drivers/pwm/Makefile   |   1 -
 drivers/pwm/pwm-bfin.c | 157 -------------------------------------------------
 3 files changed, 167 deletions(-)
 delete mode 100644 drivers/pwm/pwm-bfin.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..5d9868d23781 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -113,15 +113,6 @@ config PWM_BERLIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-berlin.
 
-config PWM_BFIN
-	tristate "Blackfin PWM support"
-	depends on BFIN_GPTIMERS
-	help
-	  Generic PWM framework driver for Blackfin.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-bfin.
-
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0258a745f30c..9c676a0dadf5 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
-obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
deleted file mode 100644
index a9a88137f2cb..000000000000
-- 
2.9.0
