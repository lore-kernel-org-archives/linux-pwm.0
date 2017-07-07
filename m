From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v3 5/9] dt-bindings: iio: Add STM32 LPTimer trigger binding
Date: Fri, 7 Jul 2017 18:31:04 +0200
Message-ID: <1499445068-7037-6-git-send-email-fabrice.gasnier@st.com>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

Add documentation for STMicroelectronics STM32 Low-Power Timer Trigger
binding.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v3:
- Rob's comments: node name timer@..., update reg property
  description

Changes in v2:
- s/Low Power/Low-Power
- remove leading 0x in example (parent node)
- improve reg property description
---
 .../bindings/iio/timer/stm32-lptimer-trigger.txt   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
new file mode 100644
index 0000000..85e6806
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
@@ -0,0 +1,23 @@
+STMicroelectronics STM32 Low-Power Timer Trigger
+
+STM32 Low-Power Timer provides trigger source (LPTIM output) that can be used
+by STM32 internal ADC and/or DAC.
+
+Must be a sub-node of an STM32 Low-Power Timer device tree node.
+See ../mfd/stm32-lptimer.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-lptimer-trigger".
+- reg:			Identify trigger hardware block. Must be 0, 1 or 2
+			respectively for lptimer1, lptimer2 or lptimer3
+			trigger output.
+
+Example:
+	timer@40002400 {
+		compatible = "st,stm32-lptimer";
+		...
+		trigger@0 {
+			compatible = "st,stm32-lptimer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1
