From: hao_zhang <hao5781286@gmail.com>
Subject: [PATCH v1 1/4] dt-bindings: pwm: binding allwinner sun8i R40/V40/T3.
Date: Thu, 11 Jan 2018 19:31:57 +0800
Message-ID: <20180111113157.GA21913@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, maxime.ripard@free-electrons.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, hao5781286@gmail.com
List-Id: linux-pwm@vger.kernel.org

This patch adds allwinner R40, V40, T3 pwm binding documents.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
new file mode 100644
index 0000000..2c86c67
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
@@ -0,0 +1,18 @@
+Allwinner sun8i R40/V40/T3 SoC PWM controller
+
+Required properties:
+  - compatible: should be one of:
+    - "allwinner,sun8i-r40-pwm"
+  - reg: physical base address and length of the controller's registers
+  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+    the cells format.
+  - clocks: From common clock binding, handle to the parent clock.
+
+Example:
+
+pwm: pwm@1c23400 {
+	     compatible = "allwinner,sun8i-r40-pwm";
+	     reg = <0x01c23400 0x154>;
+	     clocks = <&osc24M>;
+	     #pwm-cells = <3>;
+};
-- 
2.7.4

