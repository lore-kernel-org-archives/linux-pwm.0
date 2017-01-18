From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v8 1/8] MFD: add bindings for STM32 Timers driver
Date: Wed, 18 Jan 2017 15:20:44 +0100
Message-ID: <1484749251-14445-2-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
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
Cc: linaro-kernel@lists.linaro.org, Benjamin Gaignard <benjamin.gaignard@st.com>, arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org, gerald.baeza@st.com, fabrice.gasnier@st.com
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
