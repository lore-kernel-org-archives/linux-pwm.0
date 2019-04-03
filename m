From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 01/12] ARM: at91: move SoC specific definitions to SoC folder
Date: Wed,  3 Apr 2019 16:11:09 +0200
Message-ID: <20190403141120.32754-2-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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
index 0d0f8376bc35..d7e92fd552e4 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,7 +17,7 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/atmel_tc.h>
+#include <soc/at91/atmel_tcb.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
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
2.20.1
