From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 25/27] MIPS: GCW0: Reduce system timer to 750 kHz
Date: Thu, 27 Dec 2018 19:13:17 +0100
Message-ID: <20181227181319.31095-26-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The default clock (12 MHz) is too fast for the system timer.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v8: New patch

     v9: Don't configure clock timer1, as the OS Timer is used as
         clocksource on this SoC

 arch/mips/boot/dts/ingenic/gcw0.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
index 35f0291e8d38..c26572f8b8ae 100644
--- a/arch/mips/boot/dts/ingenic/gcw0.dts
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -60,3 +60,9 @@
 	/* The WiFi module is connected to the UHC. */
 	status = "okay";
 };
+
+&tcu {
+	/* 750 kHz for the system timer */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>;
+	assigned-clock-rates = <750000>;
+};
-- 
2.11.0
