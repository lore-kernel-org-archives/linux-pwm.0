From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@gmail.com>
Subject: [PATCHv4 4/4] clocksource: tcb_clksrc: sanitize IRQ request
Date: Sat,  6 Sep 2014 19:52:37 +0200
Message-ID: <1410025957-5952-5-git-send-email-gael.portay@gmail.com>
References: <1410025957-5952-1-git-send-email-gael.portay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410025957-5952-1-git-send-email-gael.portay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@gmail.com>
List-Id: linux-pwm@vger.kernel.org

The clock is not unprepared in case of the request IRQ fails.

Also update to request_irq.

Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clocksource/tcb_clksrc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb=
_clksrc.c
index f922e81..8bdbc45 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -178,12 +178,6 @@ static irqreturn_t ch2_irq(int irq, void *handle)
 	return IRQ_NONE;
 }
=20
-static struct irqaction tc_irqaction =3D {
-	.name		=3D "tc_clkevt",
-	.flags		=3D IRQF_TIMER,
-	.handler	=3D ch2_irq,
-};
-
 static int __init setup_clkevents(struct atmel_tc *tc, int clk32k_divi=
sor_idx)
 {
 	int ret;
@@ -198,15 +192,16 @@ static int __init setup_clkevents(struct atmel_tc=
 *tc, int clk32k_divisor_idx)
=20
 	clkevt.regs =3D tc->regs;
 	clkevt.clk =3D t2_clk;
-	tc_irqaction.dev_id =3D &clkevt;
=20
 	timer_clock =3D clk32k_divisor_idx;
=20
 	clkevt.clkevt.cpumask =3D cpumask_of(0);
=20
-	ret =3D setup_irq(irq, &tc_irqaction);
-	if (ret)
+	ret =3D request_irq(irq, ch2_irq, IRQF_TIMER, "tc_clkevt", &clkevt);
+	if (ret) {
+		clk_disable_unprepare(t2_clk);
 		return ret;
+	}
=20
 	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
=20
--=20
1.9.3
