From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v9 7/8] ARM: dts: stm32: add Timers driver for stm32f429 MCU
Date: Fri, 20 Jan 2017 10:15:08 +0100
Message-ID: <1484903709-11650-8-git-send-email-benjamin.gaignard@st.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484903709-11650-1-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add Timers and it sub-nodes into DT for stm32f429 family.

version 9:
- re-order timers node per addresses

version 6:
- split patch in two: one for SoC family and one for stm32f469
  discovery board.

version 5:
- rename gptimer node to timers
- re-order timers node per addresses

version 4:
- remove unwanted indexing in pwm@ and timer@ node name
- use "reg" instead of additional parameters to set timer
  configuration

version 3:
- use "st,stm32-timer-trigger" in DT

version 2:
- use parameters to describe hardware capabilities
- do not use references for pwm and iio timer subnodes

Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stm32f429.dtsi | 275 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index e4dae0e..b608935 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -79,6 +79,27 @@
 			status = "disabled";
 		};
 
+		timers2: timers@40000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000000 0x400>;
+			clocks = <&rcc 0 128>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@1 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+		};
+
 		timer3: timer@40000400 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000400 0x400>;
@@ -87,6 +108,27 @@
 			status = "disabled";
 		};
 
+		timers3: timers@40000400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000400 0x400>;
+			clocks = <&rcc 0 129>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@2 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
 		timer4: timer@40000800 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000800 0x400>;
@@ -95,6 +137,27 @@
 			status = "disabled";
 		};
 
+		timers4: timers@40000800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000800 0x400>;
+			clocks = <&rcc 0 130>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@3 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+
 		timer5: timer@40000c00 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
@@ -102,6 +165,27 @@
 			clocks = <&rcc 0 131>;
 		};
 
+		timers5: timers@40000c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40000C00 0x400>;
+			clocks = <&rcc 0 131>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@4 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <4>;
+				status = "disabled";
+			};
+		};
+
 		timer6: timer@40001000 {
 			compatible = "st,stm32-timer";
 			reg = <0x40001000 0x400>;
@@ -110,6 +194,22 @@
 			status = "disabled";
 		};
 
+		timers6: timers@40001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001000 0x400>;
+			clocks = <&rcc 0 132>;
+			clock-names = "int";
+			status = "disabled";
+
+			timer@5 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <5>;
+				status = "disabled";
+			};
+		};
+
 		timer7: timer@40001400 {
 			compatible = "st,stm32-timer";
 			reg = <0x40001400 0x400>;
@@ -118,6 +218,73 @@
 			status = "disabled";
 		};
 
+		timers7: timers@40001400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001400 0x400>;
+			clocks = <&rcc 0 133>;
+			clock-names = "int";
+			status = "disabled";
+
+			timer@6 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <6>;
+				status = "disabled";
+			};
+		};
+
+			timers12: timers@40001800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001800 0x400>;
+			clocks = <&rcc 0 134>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@11 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <11>;
+				status = "disabled";
+			};
+		};
+
+		timers13: timers@40001c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40001C00 0x400>;
+			clocks = <&rcc 0 135>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers14: timers@40002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40002000 0x400>;
+			clocks = <&rcc 0 136>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40004400 0x400>;
@@ -169,6 +336,48 @@
 			status = "disabled";
 		};
 
+		timers1: timers@40010000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40010000 0x400>;
+			clocks = <&rcc 0 160>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <0>;
+				status = "disabled";
+			};
+		};
+
+		timers8: timers@40010400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40010400 0x400>;
+			clocks = <&rcc 0 161>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@7 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <7>;
+				status = "disabled";
+			};
+		};
+
 		usart1: serial@40011000 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40011000 0x400>;
@@ -201,6 +410,57 @@
 			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
 		};
 
+		timers9: timers@40014000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40014000 0x400>;
+			clocks = <&rcc 0 176>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@8 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <8>;
+				status = "disabled";
+			};
+		};
+
+		timers10: timers@40014400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40014400 0x400>;
+			clocks = <&rcc 0 177>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers11: timers@40014800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-timers";
+			reg = <0x40014800 0x400>;
+			clocks = <&rcc 0 178>;
+			clock-names = "int";
+			status = "disabled";
+
+			pwm {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "syscon";
 			reg = <0x40007000 0x400>;
@@ -355,6 +615,21 @@
 					slew-rate = <2>;
 				};
 			};
+
+			pwm1_pins: pwm@1 {
+				pins {
+					pinmux = <STM32F429_PA8_FUNC_TIM1_CH1>,
+						 <STM32F429_PB13_FUNC_TIM1_CH1N>,
+						 <STM32F429_PB12_FUNC_TIM1_BKIN>;
+				};
+			};
+
+			pwm3_pins: pwm@3 {
+				pins {
+					pinmux = <STM32F429_PB4_FUNC_TIM3_CH1>,
+						 <STM32F429_PB5_FUNC_TIM3_CH2>;
+				};
+			};
 		};
 
 		rcc: rcc@40023810 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
