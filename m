From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v9 1/8] MFD: add bindings for STM32 Timers driver
Date: Fri, 20 Jan 2017 10:15:02 +0100
Message-ID: <1484903709-11650-2-git-send-email-benjamin.gaignard@st.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com, arnaud.pouliquen@st.com, linaro-kernel@lists.linaro.org, benjamin.gaignard@linaro.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

Add bindings information for STM32 Timers

version 6:
- rename stm32-gtimer to stm32-timers
- change compatible
- add description about the IPs

version 2:
- rename stm32-mfd-timer to stm32-gptimer
- only keep one compatible string

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/stm32-timers.txt       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
new file mode 100644
index 0000000..bbd083f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -0,0 +1,46 @@
+STM32 Timers driver bindings
+
+This IP provides 3 types of timer along with PWM functionality:
+- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
+  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
+- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
+  programmable prescaler and PWM outputs.
+- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
+
+Required parameters:
+- compatible: must be "st,stm32-timers"
+
+- reg:			Physical base address and length of the controller's
+			registers.
+- clock-names:		Set to "int".
+- clocks: 		Phandle to the clock used by the timer module.
+			For Clk properties, please refer to ../clock/clock-bindings.txt
+
+Optional parameters:
+- resets:		Phandle to the parent reset controller.
+			See ../reset/st,stm32-rcc.txt
+
+Optional subnodes:
+- pwm:			See ../pwm/pwm-stm32.txt
+- timer:		See ../iio/timer/stm32-timer-trigger.txt
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm {
+			compatible = "st,stm32-pwm";
+			pinctrl-0	= <&pwm1_pins>;
+			pinctrl-names	= "default";
+		};
+
+		timer@0 {
+			compatible = "st,stm32-timer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1
