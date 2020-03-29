From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH RFC 6/6] arm64: dts: clearfog-gt-8k: add cooling maps
Date: Sun, 29 Mar 2020 11:48:30 +0100
Message-ID: <E1jIVUU-0005hk-AO@rmk-PC.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35734 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2KtQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:49:16 -0400
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 .../marvell/armada-8040-clearfog-gt-8k.dts    | 122 +++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index a514ae51ccbf..1e7b47affe26 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -31,8 +31,11 @@
 		ethernet2 = &cp1_eth2;
 	};
 
-	pwm {
+	fan: pwm {
 		compatible = "pwm-fan";
+		/* 20% steps */
+		cooling-levels = <0 51 102 153 204 255>;
+		#cooling-cells = <2>;
 		pwms = <&cp0_gpio2 16 40000>;
 	};
 
@@ -107,6 +110,123 @@
 	};
 };
 
+&ap_thermal_ic {
+	polling-delay = <1000>; /* milliseconds */
+	trips {
+		ap_active: trip-active {
+			temperature = <40000>; /* millicelsius */
+			hysteresis = <4000>; /* millicelsius */
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map0 {
+			trip = <&ap_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+		map1 {
+			trip = <&ap_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+&cp0_thermal_ic {
+	polling-delay = <1000>; /* milliseconds */
+	trips {
+		cp0_active0: trip-active0 {
+			temperature = <40000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp0_active1: trip-active1 {
+			temperature = <45000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp0_active2: trip-active2 {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp0_active3: trip-active3 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map0 {
+			trip = <&cp0_active0>;
+			cooling-device = <&fan 0 1>;
+		};
+		map1 {
+			trip = <&cp0_active1>;
+			cooling-device = <&fan 1 2>;
+		};
+		map2 {
+			trip = <&cp0_active2>;
+			cooling-device = <&fan 2 3>;
+		};
+		map3 {
+			trip = <&cp0_active3>;
+			cooling-device = <&fan 3 4>;
+		};
+		map4 {
+			trip = <&cp0_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+&cp1_thermal_ic {
+	polling-delay = <1000>; /* milliseconds */
+	trips {
+		cp1_active0: trip-active0 {
+			temperature = <40000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp1_active1: trip-active1 {
+			temperature = <45000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp1_active2: trip-active2 {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp1_active3: trip-active3 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map0 {
+			trip = <&cp1_active0>;
+			cooling-device = <&fan 0 1>;
+		};
+		map1 {
+			trip = <&cp1_active1>;
+			cooling-device = <&fan 1 2>;
+		};
+		map2 {
+			trip = <&cp1_active2>;
+			cooling-device = <&fan 2 3>;
+		};
+		map3 {
+			trip = <&cp1_active3>;
+			cooling-device = <&fan 3 4>;
+		};
+		map4 {
+			trip = <&cp1_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-0 = <&uart0_pins>;
-- 
2.20.1
