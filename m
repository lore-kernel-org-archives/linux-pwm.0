From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 07/15] ARM: at91: move SoC specific definitions to SoC folder
Date: Thu,  9 May 2019 13:10:40 +0200
Message-ID: <20190509111048.11151-7-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Chas Williams <3chas3@gmail.com>, "moderated list:MICROCHIP TIMER
        COUNTER TC AND CLOCKSOURCE DR..." <linux-arm-kernel@lists.infradead.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "moderated list:ATM" <linux-atm-general@lists.sourceforge.net>, "open list:ATM" <netdev@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tcb_clksrc.c                   | 2 +-
 drivers/misc/atmel_tclib.c                         | 2 +-
 drivers/pwm/pwm-atmel-tcb.c                        | 2 +-
 include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c4d6fa..138a12090149 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
-#include <linux/atmel_tc.h>
+#include <soc/at91/atmel_tcb.h>
 
 
 /*
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index ac24a4bd63f7..194f774ab3a1 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -1,4 +1,3 @@
-#include <linux/atmel_tc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -10,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <soc/at91/atmel_tcb.h>
 
 /*
  * This is a thin library to solve the problem of how to portably allocate
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 0d0f8376bc35..7da1fdb4d269 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,10 +17,10 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/atmel_tc.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <soc/at91/atmel_tcb.h>
 
 #define NPWM	6
 
diff --git a/include/linux/atmel_tc.h b/include/soc/at91/atmel_tcb.h
similarity index 99%
rename from include/linux/atmel_tc.h
rename to include/soc/at91/atmel_tcb.h
index 468fdfa643f0..c3c7200ce151 100644
--- a/include/linux/atmel_tc.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -7,8 +7,8 @@
  * (at your option) any later version.
  */
 
-#ifndef ATMEL_TC_H
-#define ATMEL_TC_H
+#ifndef __SOC_ATMEL_TCB_H
+#define __SOC_ATMEL_TCB_H
 
 #include <linux/compiler.h>
 #include <linux/list.h>
-- 
2.17.1
