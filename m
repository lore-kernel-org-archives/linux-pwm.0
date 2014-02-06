From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ARM: pxa: don't select HAVE_PWM
Date: Thu, 06 Feb 2014 18:00:39 +0900
Message-ID: <000e01cf2319$e8837e80$b98a7b80$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Eric Miao' <eric.y.miao@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 'Arnd Bergmann' <arnd@arndb.de>, 'Linus Walleij' <linus.walleij@linaro.org>, 'Thierry Reding' <thierry.reding@gmail.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pwm@vger.kernel.org

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. PXA platforms
use the generic PWM framework, after the commit "17b2b47 pwm:
Move PXA PWM driver to PWM framework".

In the case of "CONFIG_HAVE_PWM=y && CONFIG_PWM=n", PXA platforms
make the build errors as below. Thus, selecting HAVE_PWM should
be removed from PXA platforms.

drivers/built-in.o: In function `lm3630a_pwm_ctrl':
drivers/video/backlight/lm3630a_bl.c:168: undefined reference to `pwm_config'
drivers/video/backlight/lm3630a_bl.c:172: undefined reference to `pwm_disable'
drivers/video/backlight/lm3630a_bl.c:170: undefined reference to `pwm_enable'
drivers/built-in.o: In function `lp855x_pwm_ctrl':
drivers/video/backlight/lp855x_bl.c:249: undefined reference to `pwm_config'
drivers/video/backlight/lp855x_bl.c:253: undefined reference to `pwm_disable'
drivers/video/backlight/lp855x_bl.c:251: undefined reference to `pwm_enable'

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-pxa/Kconfig |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 96100db..b96244c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -7,7 +7,6 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 config MACH_PXA3XX_DT
 	bool "Support PXA3xx platforms from device tree"
 	select CPU_PXA300
-	select HAVE_PWM
 	select POWER_SUPPLY
 	select PXA3xx
 	select USE_OF
@@ -23,12 +22,10 @@ config ARCH_LUBBOCK
 
 config MACH_MAINSTONE
 	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
-	select HAVE_PWM
 	select PXA27x
 
 config MACH_ZYLONITE
 	bool
-	select HAVE_PWM
 	select PXA3xx
 
 config MACH_ZYLONITE300
@@ -69,7 +66,6 @@ config ARCH_PXA_IDP
 config ARCH_VIPER
 	bool "Arcom/Eurotech VIPER SBC"
 	select ARCOM_PCMCIA
-	select HAVE_PWM
 	select I2C_GPIO
 	select ISA
 	select PXA25x
@@ -120,7 +116,6 @@ config MACH_CM_X300
 	bool "CompuLab CM-X300 modules"
 	select CPU_PXA300
 	select CPU_PXA310
-	select HAVE_PWM
 	select PXA3xx
 
 config MACH_CAPC7117
@@ -211,7 +206,6 @@ config TRIZEPS_PCMCIA
 
 config MACH_LOGICPD_PXA270
 	bool "LogicPD PXA270 Card Engine Development Platform"
-	select HAVE_PWM
 	select PXA27x
 
 config MACH_PCM027
@@ -222,7 +216,6 @@ config MACH_PCM027
 config MACH_PCM990_BASEBOARD
 	bool "PHYTEC PCM-990 development board"
 	depends on MACH_PCM027
-	select HAVE_PWM
 
 choice
 	prompt "display on pcm990"
@@ -246,7 +239,6 @@ config MACH_COLIBRI
 config MACH_COLIBRI_PXA270_INCOME
 	bool "Income s.r.o. PXA270 SBC"
 	depends on MACH_COLIBRI
-	select HAVE_PWM
 	select PXA27x
 
 config MACH_COLIBRI300
@@ -275,7 +267,6 @@ comment "End-user Products (sorted by vendor name)"
 
 config MACH_H4700
 	bool "HP iPAQ hx4700"
-	select HAVE_PWM
 	select IWMMXT
 	select PXA27x
 
@@ -289,14 +280,12 @@ config MACH_HIMALAYA
 
 config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
-	select HAVE_PWM
 	select IWMMXT
 	select PXA27x
 
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
 	select GPIO_SYSFS
-	select HAVE_PWM
 	select IWMMXT
 	select PXA27x
 	help
@@ -306,7 +295,6 @@ config MACH_MIOA701
 
 config PXA_EZX
 	bool "Motorola EZX Platform"
-	select HAVE_PWM
 	select IWMMXT
 	select PXA27x
 
@@ -346,7 +334,6 @@ config MACH_MP900C
 
 config ARCH_PXA_PALM
 	bool "PXA based Palm PDAs"
-	select HAVE_PWM
 
 config MACH_PALM27X
 	bool
@@ -444,7 +431,6 @@ config MACH_TREO680
 config MACH_RAUMFELD_RC
 	bool "Raumfeld Controller"
 	select CPU_PXA300
-	select HAVE_PWM
 	select POWER_SUPPLY
 	select PXA3xx
 
@@ -608,7 +594,6 @@ config MACH_E800
 
 config MACH_ZIPIT2
 	bool "Zipit Z2 Handheld"
-	select HAVE_PWM
 	select PXA27x
 endmenu
 
-- 
1.7.10.4
