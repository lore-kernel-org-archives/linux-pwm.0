Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F503C2B95
	for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2026 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527879; cv=none; b=Vz/T9lSl9nOs5xpY4eSd0YEAfnubwUfjGcMCKmYdb+ceehDYjdRFbwB96mubflDG6PnXe+OJmnpmG+Z3wO120B3eZAF4bkqLis+3wW1RwJPg0fgT+Hz2nYlQQWSL7WB1SD1JFfseuNMezQfiCOdUq3QUW32Ka/fq03knaBfGnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527879; c=relaxed/simple;
	bh=PpDfC2Tuyo5YjU2wo9TBE8kPfPT50b3VsheCcSY3Isk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvMl3LewhmPX/01N2eBVbxF5of7ZvpgEUPC+LscZYTN3Qgx9HQzOX/Zn0XnHjQgyAuh7eTlEzdF2zj7OYXs/eek7RJl6uuQm7dDe9erBb9atcrDwHSHf7rQlBmpqE0tMq/LS2iLpX1QjB7zHSP2W9IoiL8MC3PyDGzUlrt+kmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui3ij459; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui3ij459"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4957eefd361so5362165e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2026 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786527876; x=1787132676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UucCKK+1Aw9bHQZ3/MFTmOPB7i1MglVVL5+xpM31PX4=;
        b=Ui3ij4594S1wRXbXtPLdzRq49vrnRWRTmT0NReGBA9LYUuXfHxLGPzdyPXw96jE8cn
         2pS2Xo7xK3ddL/3W8fM7Xu9PysAnaLbPUVZrIxutzszLfRD/uEn9ZWDMSyas0kRMsjVz
         5L/65mpXO881xi9BVSQEdgN+UX91tICmzrdU11Q38whFZmxwJ6BhW1jMQGqDC1mBgV0Y
         v3v2ydKdyGcd/MT5Ct1LARdUuYG4/cL1Z6AVp9oCbcPL8QI+ohZ+BUwz2Vm+935LvlHK
         YqJCM/CFcBEOVGy7yPJEVc54y4fdo1ZBqYBPil2DUpsitnjdEdCFgv5WdAPCwRCQ/KmE
         ROiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527876; x=1787132676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UucCKK+1Aw9bHQZ3/MFTmOPB7i1MglVVL5+xpM31PX4=;
        b=OH4qX6QuIfeM7VCHLaXt4Xvr4hGZAJnm0tvQReG0/YfknjyI7OhMINpgmVONArG+ov
         oWlka/k5dzee35xxtoq9AYENqM3VHcHm/cZxLCKHq1C8/KD1WWhe8Xyw/ypFkjJ3XZAp
         pTcWw/Kl/YHFfvtkUMfEnib2AECRp8kBbHsH1ioVICJRL55jGnDy41SzhUa7d2K5ptal
         ZfyqvNZ08gk+9y7urGffxrgifBM8TgQJMZ7SdVfrPBPYnszIN4PrmBKMkHEHMmCB8o5P
         YibwO5RNps2qBwZAf6PhN8QsstoRIvvs+2g0YCw4q9uSvH++ZfvwO+ewt0CXK6xHYXZw
         7pzw==
X-Forwarded-Encrypted: i=1; AHgh+RrGO3teNw5ZNiEduEkrrbHRTJyX1Oti0uImHuz9pEYOLnilXvCYJXgDJqxducsikWBWPIRuCQXCZQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tDGXlUMLQG8GYAeR0JBeSCkCxifHXZghuXyyteDt4X9hn+mc
	ZgfbUlfD3mcjQOFaOWE8OwEbc/9lBV+ctC/fK1VgYjIlbT9nH5Cl6X4b
X-Gm-Gg: AR+sD12MayCudL4GJbtGMQ3+jwLeiXUX9eyapiez2CqP1NoQyAafYDnaHYH5YOSKMG5
	VpOcLFgzFiX4qVk5NdZCiz3/RVuEpGF3EsT0qMkifD7hmtXD7ak4mNbFE53LKIstQzJnJJr54Jm
	dSeMXYq+DHISk4Xe9bRxmuUs73d8bZ7LHOSDDnNPFjb8WpwVw0Uh0d3v8T86f6vfM1K6FBul18k
	AMEYy094AC7N9/goY9va7SFnFlecn4TUiAcnJQWM2jxnDE/ZSMM1p/gj6b+650m5Y3VZL7VTU/e
	1zQcCr2BzvrjjZz57G7bAd9KBE3xKulIHNL8Sgj6UtMzYJbR17z95Etr58Cx4tRXh6g+JVhlurk
	NKB7v/sAgKK94+VJ4PenrBFW+OyOmbo1K6JFRQiwFp0IOHtzbRT1P9CPpwx+j+kO59LsCrD0RJq
	2TADXJKGceIdDLkQM7rdAc0K2q9pcqcLFjNCzO/yJrcBEfmeU7yYkyCH/8Takuh7A202Q5bB9ft
	/bzoZRHuINxjb+RlntDBAhoY+RXVg==
X-Received: by 2002:a05:600c:4e87:b0:499:5e9e:1f50 with SMTP id 5b1f17b1804b1-4997c0fd83bmr33477925e9.4.1786527875446;
        Wed, 12 Aug 2026 02:44:35 -0700 (PDT)
Received: from localhost.localdomain ([82.137.32.40])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c9942aesm31508155e9.13.2026.08.12.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:44:35 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Eduard Bostina <egbostina@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2] dt-bindings: pwm: Convert TI PWM Subsystem to DT schema
Date: Wed, 12 Aug 2026 09:44:20 +0000
Message-ID: <20260812094420.1057067-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments SoC PWM Subsystem bindings
to DT schema.

During the conversion, the following updates were made:
- 'counter' node was added to the allowed child nodes
  list to resolve dtbs_check warnings. Some eqep nodes
  use 'counter' instead of 'eqep'.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
Changes in v2:
- Renamed the file to ti,am33xx-pwmss.yaml to match the base compatible.
- Required a 'compatible' property in the child nodes.
- Reduced the binding to a single example and included the PWM child
  nodes (ECAP, EQEP, EHRPWM) in it.

Link to v1: https://lore.kernel.org/all/2026081109d-up2208.687731-1-egbostina@gmail.com/

 .../devicetree/bindings/pwm/pwm-tipwmss.txt   | 58 --------------
 .../bindings/pwm/ti,am33xx-pwmss.yaml         | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
deleted file mode 100644
index 4633697fbda1..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-TI SOC based PWM Subsystem
-
-Required properties:
-- compatible: Must be "ti,<soc>-pwmss".
-  for am33xx  - compatible = "ti,am33xx-pwmss";
-  for am4372  - compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
-  for dra746 - compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss"
-
-- reg: physical base address and size of the registers map.
-- address-cells: Specify the number of u32 entries needed in child nodes.
-		  Should set to 1.
-- size-cells: specify number of u32 entries needed to specify child nodes size
-		in reg property. Should set to 1.
-- ranges: describes the address mapping of a memory-mapped bus. Should set to
-	   physical address map of child's base address, physical address within
-	   parent's address  space and length of the address map. For am33xx,
-	   3 set of child register maps present, ECAP register space, EQEP
-	   register space, EHRPWM register space.
-
-Also child nodes should also populated under PWMSS DT node.
-
-Example:
-epwmss0: epwmss@48300000 { /* PWMSS for am33xx */
-	compatible = "ti,am33xx-pwmss";
-	reg = <0x48300000 0x10>;
-	ti,hwmods = "epwmss0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-		  0x48300180 0x48300180 0x80   /* EQEP */
-		  0x48300200 0x48300200 0x80>; /* EHRPWM */
-
-	/* child nodes go here */
-};
-
-epwmss0: epwmss@48300000 { /* PWMSS for am4372 */
-	compatible = "ti,am4372-pwmss","ti,am33xx-pwmss"
-	reg = <0x48300000 0x10>;
-	ti,hwmods = "epwmss0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0x48300100 0x48300100 0x80   /* ECAP */
-		  0x48300180 0x48300180 0x80   /* EQEP */
-		  0x48300200 0x48300200 0x80>; /* EHRPWM */
-
-	/* child nodes go here */
-};
-
-epwmss0: epwmss@4843e000 { /* PWMSS for DRA7xx */
-	compatible = "ti,dra746-pwmss", "ti,am33xx-pwmss";
-	reg = <0x4843e000 0x30>;
-	ti,hwmods = "epwmss0";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	/* child nodes go here */
-};
diff --git a/Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml b/Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml
new file mode 100644
index 000000000000..e2b6ae326cb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ti,am33xx-pwmss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments SoC PWM Subsystem
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,am33xx-pwmss
+      - items:
+          - enum:
+              - ti,am4372-pwmss
+              - ti,dra746-pwmss
+          - const: ti,am33xx-pwmss
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^(ecap|eqep|pwm|counter)@[0-9a-f]+$":
+    type: object
+    description: Child nodes for ECAP, EQEP (counter), and EHRPWM
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@48300000 {
+        compatible = "ti,am33xx-pwmss";
+        reg = <0x48300000 0x10>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x48300100 0x48300100 0x80>,   /* ECAP */
+                 <0x48300180 0x48300180 0x80>,   /* EQEP */
+                 <0x48300200 0x48300200 0x80>;   /* EHRPWM */
+
+        pwm@48300100 {
+            compatible = "ti,am3352-ecap";
+            #pwm-cells = <3>;
+            reg = <0x48300100 0x80>;
+        };
+
+        counter@48300180 {
+            compatible = "ti,am3352-eqep";
+            reg = <0x48300180 0x80>;
+        };
+
+        pwm@48300200 {
+            compatible = "ti,am3352-ehrpwm";
+            #pwm-cells = <3>;
+            reg = <0x48300200 0x80>;
+        };
+    };
-- 
2.43.0

