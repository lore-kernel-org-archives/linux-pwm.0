From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 05/12] clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
Date: Wed,  3 Apr 2019 16:11:13 +0200
Message-ID: <20190403141120.32754-6-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

Now that the driver is registered early enough, use the TCB as the
sched_clock which is much more accurate than the jiffies implementation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/tcb_clksrc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index c7eec9808289..10350dffd157 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
 
@@ -114,6 +115,16 @@ static struct clocksource clksrc = {
 	.resume		= tc_clksrc_resume,
 };
 
+static u64 notrace tc_sched_clock_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static u64 notrace tc_sched_clock_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -327,6 +338,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
 	int irq;
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
@@ -416,6 +428,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -427,6 +440,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		}
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read;
 	}
 
 	/* and away we go! */
@@ -439,6 +453,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (ret)
 		goto err_unregister_clksrc;
 
+	sched_clock_register(tc_sched_clock, 32, divided_rate);
+
 	return 0;
 
 err_unregister_clksrc:
-- 
2.20.1
