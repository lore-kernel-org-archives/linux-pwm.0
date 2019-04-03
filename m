From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 12/12] clocksource/drivers/timer-atmel-tcb: Use ARRAY_SIZE instead of hardcoded size
Date: Wed,  3 Apr 2019 16:11:20 +0200
Message-ID: <20190403141120.32754-13-alexandre.belloni@bootlin.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

Use ARRAY_SIZE to replace the hardcoded size so we will never have a
mismatch.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-tcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 10350dffd157..eab5beadf2ca 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -396,7 +396,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < ARRAY_SIZE(atmel_tc_divisors); i++) {
 		unsigned divisor = atmel_tc_divisors[i];
 		unsigned tmp;
 
-- 
2.20.1
