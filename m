From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v9 2/2] PWM: atmel-pwm: add device tree binding document
Date: Fri, 13 Dec 2013 14:41:50 +0800
Message-ID: <1386916910-24832-3-git-send-email-voice.shen@atmel.com>
References: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, alexandre.belloni@free-electrons.com, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>
List-Id: linux-pwm@vger.kernel.org

Add atmel pwm driver device tree binding document

Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Kumar Gala <galak@codeaurora.org>
---
 .../devicetree/bindings/pwm/atmel-pwm.txt          |   41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
new file mode 100644
index 0000000..1c1a5fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
@@ -0,0 +1,41 @@
+Atmel PWM controller
+
+Required properties:
+  - compatible: should be one of:
+    - "atmel,at91sam9rl-pwm"
+    - "atmel,sama5d3-pwm"
+  - reg: physical base address and length of the controller's registers
+  - #pwm-cells: Should be 3. See pwm.txt in this directory for a
+    description of the cells format
+
+Example:
+
+	pwm0: pwm@f8034000 {
+		compatible = "atmel,at91sam9rl-pwm";
+		reg = <0xf8034000 0x400>;
+		#pwm-cells = <3>;
+	};
+
+The following the pwm led based example:
+
+	pwm0: pwm@f8034000 {
+		compatible = "atmel,at91sam9rl-pwm";
+		reg = <0xf8034000 0x400>;
+		#pwm-cells = <3>;
+	};
+
+	pwdleds {
+		compatible = "pwm-leds";
+
+		d1 {
+			label = "d1";
+			pwms = <&pwm0 3 5000 0>
+			max-brightness = <255>;
+		};
+
+		d2 {
+			label = "d2";
+			pwms = <&pwm0 1 5000 1>
+			max-brightness = <255>;
+		};
+	};
-- 
1.7.9.5
