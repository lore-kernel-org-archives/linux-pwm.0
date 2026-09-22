Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0F30568B;
	Tue, 22 Sep 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057993; cv=none; b=f6t5v6z1/lafiXrSydfnm0hcyz0EkEcWKz5sMBJHlSjVAuz231SlIm01cwWugs5XSl/csi/QbTyNW2Bk0U9Qk5BULuvD2+F2FRNG+4GWPsffZ7SyBg1PaRcGKAsFwVl4Pvc10DK+x580I+T+Nxg81PpNDScJw8ZL7AJf1N6UwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057993; c=relaxed/simple;
	bh=MjkxYsgZfi1ENMq6oD+JZlpmwvBVoXRm4CNxKkFQCDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TakA03IVfUZWhrmYCK7hM/ywvEr7FKmphz1i23NaQ5y0ipleXpk9XU2Gd2H7XToBVI6DCk206qWSUIKu2xuyPZ9wnvCimOPek8RErxFpcVWH2OSxKyayKNMH453iS+6O4/cPVBoZ0W19rDGenHKGNutKmIG8xki/8VbkvK9TagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=in8YwjSS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="in8YwjSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ao
	HMNpZZeCvgyXjU5ouI34mrD2A1Vq2PGowe6O3nbAE=; b=in8YwjSSTL1osBt8bL
	AzHktdmFPYfr0hGBLD58l3DQVPJm4Okp4+uugvLD6XjwAcI/vHbIjjX91X0TbqQh
	RiphyzYM72X9sDtjKjRjM+YuUfizjLs2zoRt8nTsMmV3hoVTb1tFmCxQHrHcOBbt
	HYz7MWCY4k0Y+eTuC0FOjv9RE=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnd1HkHbJqkgs+AA--.25598S2;
	Tue, 22 Sep 2026 14:19:17 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: mfd: convert lp3943 to DT schema
Date: Tue, 22 Sep 2026 14:19:07 +0800
Message-ID: <20260922061907.56372-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnd1HkHbJqkgs+AA--.25598S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyxurWxGw48Zw13KFWrAFb_yoWxtry7pa
	s7C34xtF1IqF13Kw4Iga18ZF13uF1kA3W8KF17tr1jga93G3Zxtr43Kr90v3WfCFWxWay7
	XF1a9r1rtw4kAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRDl1gUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wXHPWqyHeULEQAA3m

Convert the LP3943 MFD binding from free-form text to DT schema.

The LP3943 is an I2C LED driver with two sub-devices, lp3943-gpio and
lp3943-pwm. The GPIO sub-device is covered by trivial-gpio.yaml, so only
the PWM sub-device gets a schema of its own.

The PWM schema documents ti,pwm0 and ti,pwm1, which select the output pins
of the two internal PWM channels and are read by pwm-lp3943.c with
of_property_read_u32_array().

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

v2:
 - Add Assisted-by and the Reviewed-by tag received on v1. No content change.

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
index ca5324ed0df4..000000000000
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
index 000000000000..4bee4f4c3aaf
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
index f214305a8f5e..000000000000
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
index 000000000000..8c91db9756a0
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

