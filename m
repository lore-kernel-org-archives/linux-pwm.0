From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 09/12] clocksource/drivers/tcb_clksrc: Rename the file for consistency
Date: Wed,  3 Apr 2019 16:11:17 +0200
Message-ID: <20190403141120.32754-10-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

For the sake of consistency, let's rename the file to a name similar
to other file names in this directory.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/Makefile                            | 2 +-
 drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be6e0fbc7489..923b9b60c909 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_TIMER_OF)		+= timer-of.o
 obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
-obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
+obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= timer-atmel-tcb.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= timer-cs5535.o
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/timer-atmel-tcb.c
similarity index 100%
rename from drivers/clocksource/tcb_clksrc.c
rename to drivers/clocksource/timer-atmel-tcb.c
-- 
2.20.1
