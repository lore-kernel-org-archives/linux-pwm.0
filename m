From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 02/12] misc: atmel_tclib: drop AVR32 support
Date: Wed,  3 Apr 2019 16:11:10 +0200
Message-ID: <20190403141120.32754-3-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

AVR32 is gone from the kernel, remove its support from tclib.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/misc/atmel_tclib.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 194f774ab3a1..3af27ce7e514 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -17,18 +17,10 @@
  * share individual timers between different drivers.
  */
 
-#if defined(CONFIG_AVR32)
-/* AVR32 has these divide PBB */
-const u8 atmel_tc_divisors[5] = { 0, 4, 8, 16, 32, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#elif defined(CONFIG_ARCH_AT91)
 /* AT91 has these divide MCK */
 const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
 EXPORT_SYMBOL(atmel_tc_divisors);
 
-#endif
-
 static DEFINE_SPINLOCK(tc_list_lock);
 static LIST_HEAD(tc_list);
 
-- 
2.20.1
