From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 22/27] MIPS: qi_lb60: Reduce system timer and clocksource to 750 kHz
Date: Sat,  2 Mar 2019 20:34:08 -0300
Message-ID: <20190302233413.14813-23-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The default clock (12 MHz) is too fast for the system timer, which fails
to report time accurately.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v5: New patch
    
         v6: Remove ingenic,clocksource-channel property
    
         v7: No change
    
         v8: No change
    
         v9: No change
    
         v10: No change

 arch/mips/boot/dts/ingenic/qi_lb60.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index 85529a142409..de9d45e2c24a 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -45,3 +45,9 @@
 		bias-disable;
 	};
 };
+
+&tcu {
+	/* 750 kHz for the system timer and clocksource */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>;
+	assigned-clock-rates = <750000>, <750000>;
+};
-- 
2.11.0
