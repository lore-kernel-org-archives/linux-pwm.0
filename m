From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/12] clocksource/drivers/tcb_clksrc: move Kconfig option
Date: Wed,  3 Apr 2019 16:11:15 +0200
Message-ID: <20190403141120.32754-8-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

Move the ATMEL_TCB_CLKSRC option to drivers/clocksource and make it silent
if COMPILE_TEST is not selected.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/Kconfig |  7 +++++++
 drivers/misc/Kconfig        | 14 --------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..e38ef4906e30 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -410,6 +410,13 @@ config ATMEL_ST
 	help
 	  Support for the Atmel ST timer.
 
+config ATMEL_TCB_CLKSRC
+	bool "Atmel TC Block timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select TIMER_OF if OF
+	help
+	  Support for Timer Counter Blocks on Atmel SoCs.
+
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 268a01d3d6f3..c84033909395 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -59,20 +59,6 @@ config ATMEL_TCLIB
 	  blocks found on many Atmel processors.  This facilitates using
 	  these blocks by different drivers despite processor differences.
 
-config ATMEL_TCB_CLKSRC
-	bool "TC Block Clocksource"
-	depends on ARCH_AT91
-	select TIMER_OF if OF
-	default y
-	help
-	  Select this to get a high precision clocksource based on a
-	  TC block with a 5+ MHz base clock rate.  Two timer channels
-	  are combined to make a single 32-bit timer.
-
-	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode
-	  (delays of up to two seconds) based on the 32 KiHz clock.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
-- 
2.20.1
