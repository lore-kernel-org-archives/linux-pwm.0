From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v5 7/7] ARM: dts: stm32: add STM32 General Purpose Timer
 driver in DT
Date: Thu,  8 Dec 2016 13:20:50 +0100
Message-ID: <1481199650-22484-8-git-send-email-benjamin.gaignard@st.com>
References: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linaro-kernel@lists.linaro.org, Benjamin Gaignard <benjamin.gaignard@st.com>, linus.walleij@linaro.org, arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org, gerald.baeza@st.com, fabrice.gasnier@st.com
List-Id: linux-pwm@vger.kernel.org

Add General Purpose Timers and it sub-nodes into DT for stm32f4.
Define and enable pwm1 and pwm3 for stm32f469 discovery board

version 5:
- rename gptimer node to timers
- re-order timers node par addresses

version 4:
- remove unwanted indexing in pwm@ and timer@ node name
- use "reg" instead of additional parameters to set timer
  configuration

version 3:
- use "st,stm32-timer-trigger" in DT

version 2:
- use parameters to describe hardware capabilities
- do not use references for pwm and iio timer subnodes

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi      | 275 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f469-disco.dts |  28 ++++
 2 files changed, 303 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index bca491d..fd68513 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
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
@@ -426,6 +441,266 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		timers2: timers@40000000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000000 0x400>;
+			clocks = <&rcc 0 128>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <1>;
+				status = "disabled";
+			};
+		};
+
+		timers3: timers@40000400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000400 0x400>;
+			clocks = <&rcc 0 129>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
+		timers4: timers@40000800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000800 0x400>;
+			clocks = <&rcc 0 130>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+
+		timers5: timers@40000C00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40000C00 0x400>;
+			clocks = <&rcc 0 131>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <4>;
+				status = "disabled";
+			};
+		};
+
+		timers6: timers@40001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001000 0x400>;
+			clocks = <&rcc 0 132>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <5>;
+				status = "disabled";
+			};
+		};
+
+		timers7: timers@40001400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001400 0x400>;
+			clocks = <&rcc 0 133>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <6>;
+				status = "disabled";
+			};
+		};
+
+		timers12: timers@40001800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001800 0x400>;
+			clocks = <&rcc 0 134>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <9>;
+				status = "disabled";
+			};
+		};
+
+		timers13: timers@40001C00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40001C00 0x400>;
+			clocks = <&rcc 0 135>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers14: timers@40002000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40002000 0x400>;
+			clocks = <&rcc 0 136>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers1: timers@40010000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40010000 0x400>;
+			clocks = <&rcc 0 160>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
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
+			compatible = "st,stm32-gptimer";
+			reg = <0x40010400 0x400>;
+			clocks = <&rcc 0 161>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <7>;
+				status = "disabled";
+			};
+		};
+
+		timers9: timers@40014000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40014000 0x400>;
+			clocks = <&rcc 0 176>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+
+			timer@0 {
+				compatible = "st,stm32-timer-trigger";
+				reg = <8>;
+				status = "disabled";
+			};
+		};
+
+		timers10: timers@40014400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40014400 0x400>;
+			clocks = <&rcc 0 177>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
+
+		timers11: timers@40014800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32-gptimer";
+			reg = <0x40014800 0x400>;
+			clocks = <&rcc 0 178>;
+			clock-names = "clk_int";
+			status = "disabled";
+
+			pwm@0 {
+				compatible = "st,stm32-pwm";
+				status = "disabled";
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..780f193 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -81,3 +81,31 @@
 &usart3 {
 	status = "okay";
 };
+
+&timers1 {
+	status = "okay";
+
+	pwm@0 {
+		pinctrl-0 = <&pwm1_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer@0 {
+		status = "okay";
+	};
+};
+
+&timers3 {
+	status = "okay";
+
+	pwm@0 {
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer@0 {
+		status = "okay";
+	};
+};
-- 
1.9.1
