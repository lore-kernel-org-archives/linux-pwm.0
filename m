From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 24/26] MIPS: GCW0: Reduce system timer and clocksource to 750 kHz
Date: Wed, 12 Dec 2018 23:13:33 +0100
Message-ID: <20181212221335.19404-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Malaterre <malat@debian.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The default clock (12 MHz) is too fast for the system timer, which fails
to report time accurately.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v8: New patch

 arch/mips/boot/dts/ingenic/gcw0.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
index 8abab14eb852..651c3f505fa5 100644
--- a/arch/mips/boot/dts/ingenic/gcw0.dts
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -61,6 +61,12 @@
 	status = "okay";
 };
 
+&tcu {
+	/* 750 kHz for the system timer and clocksource */
+	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER2>;
+	assigned-clock-rates = <750000>, <750000>;
+};
+
 &pwm {
 	/* Channels 1 and 3-7 are for PWM use */
 	reg = <0x50 0x10>, <0x70 0x50>;
-- 
2.11.0
