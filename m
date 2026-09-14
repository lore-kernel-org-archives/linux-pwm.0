Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C62D2487;
	Mon, 14 Sep 2026 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349906; cv=none; b=D5hvKZL7O477n7xO/9rgHnGLX04jOe+5oVRaVhxs5x5Nr5qZln3bIVHldUGDnxMVowP/iObnz1Y0lC522GFKSpNIVDR8gI58G/HLbLBqhBRlfEfxfcvEuW4HQEDt/UKjaxZH7+6id3UwcQpxHN9yHKUZnJl1MRjVFcrjHq6k/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349906; c=relaxed/simple;
	bh=7JL9gNDWH2ie0dj7BnGopkzEdEM79kAeLzmXLoCuYU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZP+a7a0D5qXcHEmRmYpbUAuooCEEQl2HvOpyrjJbw/bjaSY/vGvq9HRhhhqEjO5yTVmKg3SExHaQTKtNd4LDIU0K5dtj4/0jPVYTtfBYdEkmASA87Pm8d4up4Ho3P58I6vHOi+U3ECy+T8n0inpBFAvxe1D/9HFUsPmH0vaIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M763Me4J; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M763Me4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=l4
	D7Tz+L8yhI/dj0P2qt2ADzZ7B9HHavb0N9lvzGSeM=; b=M763Me4JMFzSDwoeqi
	wxZyGkvqDWVNLL4amNiEONAp6rPUXvLWaFGnWxBlPv1Abb4zouusVr8hwiJUenUm
	kH6N29LzgKTglZQltZEPg/ylahTwNoJ4tN2Duv8n2Ih7gx9Qj8uLoARNKTCDlaRK
	1eQW8+xSxhSbXrfXwEMlyBvhM=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3ZmXwT6dqx8RQAg--.19535S2;
	Mon, 14 Sep 2026 09:37:53 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] dt-bindings: mfd: convert lp3943 to DT schema
Date: Mon, 14 Sep 2026 09:37:52 +0800
Message-ID: <20260914013752.394579-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3ZmXwT6dqx8RQAg--.19535S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrW5JF4xtr1UWrWkGrWDCFg_yoWxuF1kpa
	s7C34xtr1IqF13Kw4Iga18AF13ur1kA3W8KFnrtr1jga98G3Zxtr43Kr90vF1fCFWxWay7
	XF13ur1rtw4kAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUuc_UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xGUCmqnT-FwiwAA3k

Convert the LP3943 MFD binding from free-form text to DT schema.

The LP3943 is an I2C LED driver that contains two sub-devices,
lp3943-gpio and lp3943-pwm.  The GPIO sub-device is already covered by
trivial-gpio.yaml, so only the PWM sub-device needs a schema of its own.

The PWM schema documents the ti,pwm0 and ti,pwm1 properties that select
the output pins for each of the two internal PWM channels, matching what
pwm-lp3943.c reads through of_property_read_u32_array().

Both schemas pass dt_binding_check.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../devicetree/bindings/mfd/lp3943.txt        | 33 --------
 .../devicetree/bindings/mfd/ti,lp3943.yaml    | 64 +++++++++++++++
 .../devicetree/bindings/pwm/pwm-lp3943.txt    | 58 --------------
 .../devicetree/bindings/pwm/pwm-lp3943.yaml   | 80 +++++++++++++++++++
 4 files changed, 144 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp3943.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp3943.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-lp3943.yaml

diff --git a/Documentation/devicetree/bindings/mfd/lp3943.txt b/Documentation/devicetree/bindings/mfd/lp3943.txt
deleted file mode 100644
index ca5324ed0..000000000
--- a/Documentation/devicetree/bindings/mfd/lp3943.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-TI/National Semiconductor LP3943 MFD driver
-
-Required properties:
-  - compatible: "ti,lp3943"
-  - reg: I2C slave address. From 0x60 to 0x67.
-
-LP3943 consists of two sub-devices, lp3943-gpio and lp3943-pwm.
-
-For the LP3943 GPIO properties please refer to:
-Documentation/devicetree/bindings/gpio/trivial-gpio.yaml
-
-For the LP3943 PWM properties please refer to:
-Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
-
-Example:
-
-lp3943@60 {
-	compatible = "ti,lp3943";
-	reg = <0x60>;
-
-	gpioex: gpio {
-		compatible = "ti,lp3943-gpio";
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	pwm3943: pwm {
-		compatible = "ti,lp3943-pwm";
-		#pwm-cells = <2>;
-		ti,pwm0 = <8 9 10>;
-		ti,pwm1 = <15>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp3943.yaml b/Documentation/devicetree/bindings/mfd/ti,lp3943.yaml
new file mode 100644
index 000000000..4bee4f4c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lp3943.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lp3943.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI/National Semiconductor LP3943 MFD driver
+
+maintainers:
+  - Quchaosheng <quchaosheng000406@163.com>
+
+description:
+  LP3943 is an integrated device capable of driving LEDs. It contains two
+  sub-devices, lp3943-gpio and lp3943-pwm, which are instantiated by the MFD
+  core from the child nodes described below.
+
+properties:
+  compatible:
+    const: ti,lp3943
+
+  reg:
+    maxItems: 1
+    description: I2C slave address, from 0x60 to 0x67
+
+patternProperties:
+  "^gpio":
+    type: object
+    $ref: /schemas/gpio/trivial-gpio.yaml#
+
+  "^pwm":
+    type: object
+    $ref: /schemas/pwm/pwm-lp3943.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lp3943: gpio@60 {
+            compatible = "ti,lp3943";
+            reg = <0x60>;
+
+            gpio {
+                compatible = "ti,lp3943-gpio";
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            pwm {
+                compatible = "ti,lp3943-pwm";
+                #pwm-cells = <2>;
+                ti,pwm0 = <8 9 10>;
+                ti,pwm1 = <15>;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt b/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
deleted file mode 100644
index f214305a8..000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-TI/National Semiconductor LP3943 PWM controller
-
-Required properties:
-  - compatible: "ti,lp3943-pwm"
-  - #pwm-cells: Should be 2. See pwm.yaml in this directory for a
-                description of the cells format.
-                Note that this hardware limits the period length to the
-                range 6250~1600000.
-  - ti,pwm0 or ti,pwm1: Output pin number(s) for PWM channel 0 or 1.
-    0 = output 0
-    1 = output 1
-    .
-    .
-    15 = output 15
-
-Example:
-PWM 0 is for RGB LED brightness control
-PWM 1 is for brightness control of LP8557 backlight device
-
-&i2c3 {
-	lp3943@60 {
-		compatible = "ti,lp3943";
-		reg = <0x60>;
-
-		/*
-		 * PWM 0 : output 8, 9 and 10
-		 * PWM 1 : output 15
-		 */
-		pwm3943: pwm {
-			compatible = "ti,lp3943-pwm";
-			#pwm-cells = <2>;
-			ti,pwm0 = <8 9 10>;
-			ti,pwm1 = <15>;
-		};
-	};
-
-};
-
-/* LEDs control with PWM 0 of LP3943 */
-pwmleds {
-	compatible = "pwm-leds";
-	rgb {
-		label = "indi::rgb";
-		pwms = <&pwm3943 0 10000>;
-		max-brightness = <255>;
-	};
-};
-
-&i2c4 {
-	/* Backlight control with PWM 1 of LP3943 */
-	backlight@2c {
-		compatible = "ti,lp8557";
-		reg = <0x2c>;
-
-		pwms = <&pwm3943 1 10000>;
-		pwm-names = "lp8557";
-	};
-};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-lp3943.yaml b/Documentation/devicetree/bindings/pwm/pwm-lp3943.yaml
new file mode 100644
index 000000000..8c91db975
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-lp3943.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-lp3943.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI/National Semiconductor LP3943 PWM controller
+
+maintainers:
+  - Quchaosheng <quchaosheng000406@163.com>
+
+description:
+  LP3943 has two internal PWM channels. Each channel can be routed to one or
+  more of the 16 outputs of the device.
+
+  Note that the hardware limits the period length to the range 6250~1600000.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: ti,lp3943-pwm
+
+  "#pwm-cells":
+    const: 2
+
+  ti,pwm0:
+    description: Output pin number(s) for PWM channel 0.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      minimum: 0
+      maximum: 15
+
+  ti,pwm1:
+    description: Output pin number(s) for PWM channel 1.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    items:
+      minimum: 0
+      maximum: 15
+
+anyOf:
+  - required:
+      - ti,pwm0
+  - required:
+      - ti,pwm1
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gpio@60 {
+            compatible = "ti,lp3943";
+            reg = <0x60>;
+
+            /*
+             * PWM 0 : output 8, 9 and 10
+             * PWM 1 : output 15
+             */
+            pwm {
+                compatible = "ti,lp3943-pwm";
+                #pwm-cells = <2>;
+                ti,pwm0 = <8 9 10>;
+                ti,pwm1 = <15>;
+            };
+        };
+    };
+...
-- 
2.43.0

