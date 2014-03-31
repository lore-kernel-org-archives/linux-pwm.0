From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/4] pwm: sunxi: document OF bindings
Date: Mon, 31 Mar 2014 14:07:27 +0200
Message-ID: <1396267649-18009-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This is the documentation for the Allwinner Socs PWM bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: devicetree@vger.kernel.org
 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
new file mode 100644
index 000000000000..e295a50813af
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
@@ -0,0 +1,19 @@
+Allwinner PWM controller
+
+Required properties:
+  - compatible: should be one of:
+    - "allwinner,sun4i-pwm"
+    - "allwinner,sun7i-pwm"
+  - reg: physical base address and length of the controller's registers
+  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+    the cells format.
+
+Example:
+
+	pwm: pwm@01c20e00 {
+		compatible = "allwinner,sun7i-pwm";
+		reg = <0x01c20e00 0xc>;
+		clocks = <&osc24M>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
-- 
1.8.3.2
