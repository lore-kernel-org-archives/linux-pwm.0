From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 2/4] ARM: dts: sun8i: Add PWM controller node in H3
Date: Wed, 31 Aug 2016 17:25:18 +0900
Message-ID: <20160831082520.25962-3-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831082520.25962-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 05d0c4b..860e355 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -396,6 +396,14 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pwm: pwm@01c21400 {
+			compatible = "allwinner,sun8i-h3-pwm";
+			reg = <0x01c21400 0x8>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial@01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.9.3
