From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 7/7] ARM: dts: stm32: add stm32 general purpose timer driver in DT
Date: Thu, 24 Nov 2016 16:14:23 +0100
Message-ID: <1480000463-9625-8-git-send-email-benjamin.gaignard@st.com>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480000463-9625-1-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add general purpose timers and it sub-nodes into DT for stm32f4.
Define and enable pwm1 and pwm3 for stm32f469 discovery board

version 2:
- use parameters to describe hardware capabilities
- do not use references for pwm and iio timer subnodes

Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stm32f429.dtsi      | 305 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/stm32f469-disco.dts |  28 ++++
 2 files changed, 332 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index bca491d..8f217b1 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -48,7 +48,7 @@
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
-
+#include <dt-bindings/iio/timer/st,stm32-iio-timer.h>
 / {
 	clocks {
 		clk_hse: clk-hse {
@@ -355,6 +355,21 @@
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
@@ -426,6 +441,294 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		gptimer1: gptimer1@40010000 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40010000 0x400>;
+			clocks = <&rcc 0 160>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm1@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <4>;
+				st,breakinput;
+				st,complementary;
+				status = "disabled";
+			};
+
+			iiotimer1@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <27>;
+				st,input-triggers-names = TIM5_TRGO,
+							  TIM2_TRGO,
+							  TIM4_TRGO,
+							  TIM3_TRGO;
+				st,output-triggers-names = TIM1_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer2: gptimer2@40000000 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000000 0x400>;
+			clocks = <&rcc 0 128>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm2@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <4>;
+				st,32bits-counter;
+				status = "disabled";
+			};
+
+			iiotimer2@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <28>;
+				st,input-triggers-names = TIM1_TRGO,
+							  TIM8_TRGO,
+							  TIM3_TRGO,
+							  TIM4_TRGO;
+				st,output-triggers-names = TIM2_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer3: gptimer3@40000400 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000400 0x400>;
+			clocks = <&rcc 0 129>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm3@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <4>;
+				status = "disabled";
+			};
+
+			iiotimer3@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <29>;
+				st,input-triggers-names = TIM1_TRGO,
+							  TIM8_TRGO,
+							  TIM5_TRGO,
+							  TIM4_TRGO;
+				st,output-triggers-names = TIM3_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer4: gptimer4@40000800 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000800 0x400>;
+			clocks = <&rcc 0 130>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm4@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <4>;
+				status = "disabled";
+			};
+
+			iiotimer4@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <30>;
+				st,input-triggers-names = TIM1_TRGO,
+							  TIM2_TRGO,
+							  TIM3_TRGO,
+							  TIM8_TRGO;
+				st,output-triggers-names = TIM4_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer5: gptimer5@40000C00 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000C00 0x400>;
+			clocks = <&rcc 0 131>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm5@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <4>;
+				st,32bits-counter;
+				status = "disabled";
+			};
+
+			iiotimer5@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <50>;
+				st,input-triggers-names = TIM2_TRGO,
+							  TIM3_TRGO,
+							  TIM4_TRGO,
+							  TIM8_TRGO;
+				st,output-triggers-names = TIM5_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer6: gptimer6@40001000 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001000 0x400>;
+			clocks = <&rcc 0 132>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			iiotimer6@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <54>;
+				st,output-triggers-names = TIM6_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer7: gptimer7@40001400 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001400 0x400>;
+			clocks = <&rcc 0 133>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			iiotimer7@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <55>;
+				st,output-triggers-names = TIM7_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer8: gptimer8@40010400 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40010400 0x400>;
+			clocks = <&rcc 0 161>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm8@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <4>;
+				st,complementary;
+				st,breakinput;
+				status = "disabled";
+			};
+
+			iiotimer8@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <46>;
+				st,input-triggers-names = TIM1_TRGO,
+							  TIM2_TRGO,
+							  TIM4_TRGO,
+							  TIM5_TRGO;
+				st,output-triggers-names = TIM8_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer9: gptimer9@40014000 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40014000 0x400>;
+			clocks = <&rcc 0 176>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm9@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <2>;
+				status = "disabled";
+			};
+
+			iiotimer9@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <24>;
+				st,input-triggers-names = TIM2_TRGO,
+							  TIM3_TRGO;
+				st,output-triggers-names = TIM9_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer10: gptimer10@40014400 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40014400 0x400>;
+			clocks = <&rcc 0 177>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm10@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <1>;
+				status = "disabled";
+			};
+		};
+
+		gptimer11: gptimer11@40014800 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40014800 0x400>;
+			clocks = <&rcc 0 178>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm11@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <1>;
+				status = "disabled";
+			};
+		};
+
+		gptimer12: gptimer12@40001800 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001800 0x400>;
+			clocks = <&rcc 0 134>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm12@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <2>;
+				status = "disabled";
+			};
+
+			iiotimer12@0 {
+				compatible = "st,stm32-iio-timer";
+				interrupts = <43>;
+				st,input-triggers-names = TIM4_TRGO,
+							  TIM5_TRGO;
+				st,output-triggers-names = TIM12_TRGO;
+				status = "disabled";
+			};
+		};
+
+		gptimer13: gptimer13@40001C00 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001C00 0x400>;
+			clocks = <&rcc 0 135>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm13@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <1>;
+				status = "disabled";
+			};
+		};
+
+		gptimer14: gptimer14@40002000 {
+			compatible = "st,stm32-gptimer";
+			reg = <0x40002000 0x400>;
+			clocks = <&rcc 0 136>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm14@0 {
+				compatible = "st,stm32-pwm";
+				st,pwm-num-chan = <1>;
+				status = "disabled";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..0c93846 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -81,3 +81,31 @@
 &usart3 {
 	status = "okay";
 };
+
+&gptimer1 {
+	status = "okay";
+
+	pwm1@0 {
+		pinctrl-0	= <&pwm1_pins>;
+		pinctrl-names	= "default";
+		status = "okay";
+	};
+
+	iiotimer1@0 {
+		status = "okay";
+	};
+};
+
+&gptimer3 {
+	status = "okay";
+
+	pwm3@0 {
+		pinctrl-0	= <&pwm3_pins>;
+		pinctrl-names	= "default";
+		status = "okay";
+	};
+
+	iiotimer3@0 {
+		status = "okay";
+	};
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
