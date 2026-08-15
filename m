Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286B757EA
	for <linux-pwm@vger.kernel.org>; Sat, 15 Aug 2026 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786780109; cv=none; b=K6t9tSL0no0e9zPU39ez0HTQRTVYTrne6Qaz4gkLK+RdHaHJQ2RmrbpPlWN8HpE97hdp5TMjWlgUTG/zY6iT/WtYWW6y2tmtKJ/yM/lvofieXwJqR3BH8qPL+IM8frm2KyCWK7GAEF/NlbY+5jvI5yx2JVoutqKCiqwCiy00/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786780109; c=relaxed/simple;
	bh=OE/EaKm9mUhgWVUKXL8BasIrYws6tS8WDyPptYHAFSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4tKJr9WqxtVqR4tzx6inVagK+QgNsVrGwJBK5kq+33aJJgk93gKqhOejZuiZ+GeP7jzMV+AaCwl1P7zfJwcyZ7nPZIL/753OwM5fDG2MS38nwX2+xfp35Y9jxNPVygK0vngChM292yf0U2j+vuSBJ4r3WU8bdvzOd/Qeq/KkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDQokXPP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDQokXPP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1103052f8f.0
        for <linux-pwm@vger.kernel.org>; Sat, 15 Aug 2026 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786780106; x=1787384906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYEHZ3sfVEZD5CwCuEkCOIaM8Qg4WJAH1yfaH+AnSOM=;
        b=CDQokXPPXrr7icDE3XT8I7ixR0tEO+uQMRFKTLIDdx7PURi3R+mCTnqaRwP4cqTmwk
         /06q7VJTYLsAXVF8DPAZd+wV/jEdSWzekLhjLcB9Vtj5/i3pjXLEmtgPM+GEAJodeSXA
         AdlDCK1hRjLjG+yNkkRtO9BjOXjN9IJFYsKJWvVFUxeNON6xK5PlIoAM6gY1GgHkW5mD
         DF4yAXaZMVT3ewYvjFvCMcyVaAtIqnlLyHr30vBR5pFaHcon8pK/SQLGtRZuXpAnD5q/
         nLR2c/tVYKunhUJisoId3HVMHmy8mOWINrSZsukmGJJdHrSzzBm/W610Vo+CQehah/x6
         6e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786780106; x=1787384906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYEHZ3sfVEZD5CwCuEkCOIaM8Qg4WJAH1yfaH+AnSOM=;
        b=e3s4Hqwpps89Lr67+9PmVL9yRuZByGVSTrLLSI+/KKswoMyIMG0eDbzoMxrelbY4xc
         Pxk0xccsR3IBpIGOYk0/3VdOA9sZ/9g7iJ+M6Lu/uBfh2yCXfrqnjBP+9+gUlNrQxdG6
         ItylakbgVtt0U0AGcR+7TpEHEJEwn8qM0/8oLdEHt7Ho5giGjgL5aI+5ZEFWkyDy84XK
         ylKL6pOiivr3t9js/VjAaSWNG78t3JIijAalDfDE/D12eLdnwzMY0X6gzzXtWpsJqMh9
         u4jvnmXc825WWwSMswSZHzQJEov23q4BZz7leTLtw+w2u+99ZOH0988rGIewm7TnWD/7
         94vA==
X-Forwarded-Encrypted: i=1; AHgh+RrEJVwm8YbY2GDGZ2DnXabYiQ806Aj0kuVrif6O2I4/X7mfHZt7MR792YvaEJ1oBSI5hRf4PZrr/44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJH/DmcYAgsCOExGqky5ZSbsaNtfxaWUTlcPEz4sJ0e1VmiYhX
	3TVuLjh3Xkt+QpKKHcOdkpvQnPy5ne837kPikHS2sjl32LDU0vN56AYA
X-Gm-Gg: AR+sD117u+g0wBhIsDo5fYAFrAHQdPktAoEK7ER8H8DN8IhOiZX4WhM4By+JMqW4Mle
	GE5eBSx2AsIwJUUji8PWHMW6uStrqGVDTstAwAkqS0hPcczWFf+cfrb1cOgbo+vS5J6R2MAp3Ck
	lU/zK8Jn9rhDCfqRKmYb9DGcaMCqhiAuKBBLoXw1c3eTNzgichhL6qlBHVenx2pOWEujjmYpLhA
	jy//YzgpHHtDJCw5QpzMiY+wLYWTO+EqQeLj9BZNsjhkYbi+2ErBzyQc7WznskZ6SSvH8PejtoN
	CBTkJBW/+bpCX7ptPQuHAgjNjFtv9Q1ENqE5CbrSMxwmtvJg6qX/ydvu50og66v6JbOI6u+Ksj5
	xJtk+r9MAciIYdKYm5ssThytkvz/GsEMzqyNRuYGWxKH25Eik11SNdytJ3U7L6mSiU39BclqwAw
	wTcKjkoqgjlTbOk3mpXbXvcw8yWGIWLok9amMZGp4famia6mGoZ9OHfhApAPaYN+wCUic6LVQen
	z+9XrEVwGX/1gETXkYseS/P68tivwU=
X-Received: by 2002:a05:6000:2a0c:b0:47f:77dc:b066 with SMTP id ffacd0b85a97d-481607318acmr13686859f8f.5.1786780106045;
        Sat, 15 Aug 2026 00:48:26 -0700 (PDT)
Received: from localhost.localdomain ([82.137.32.242])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4815f2c129dsm14487942f8f.26.2026.08.15.00.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 00:48:25 -0700 (PDT)
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
Subject: [PATCH v3] dt-bindings: pwm: Convert TI PWM Subsystem to DT schema
Date: Sat, 15 Aug 2026 07:48:17 +0000
Message-ID: <20260815074817.2117916-1-egbostina@gmail.com>
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
Changes in v3:
- Completed the single example by adding the required 'clocks',
  'clock-names' and 'interrupts' properties to the ECAP, EQEP and EHRPWM
  child nodes, so the example passes a full dt_binding_check.

Changes in v2:
- Renamed the file to ti,am33xx-pwmss.yaml to match the base compatible.
- Required a 'compatible' property in the child nodes.
- Reduced the binding to a single example and included the PWM child
  nodes (ECAP, EQEP, EHRPWM) in it.

Link to v2: https://lore.kernel.org/all/20260812094420.1057067-1-egbostina@gmail.com/
Link to v1: https://lore.kernel.org/all/20260811092208.687731-1-egbostina@gmail.com/

 .../devicetree/bindings/pwm/pwm-tipwmss.txt   | 58 -------------
 .../bindings/pwm/ti,am33xx-pwmss.yaml         | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 58 deletions(-)
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
index 000000000000..89ce6b02b70c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml
@@ -0,0 +1,82 @@
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
+            clocks = <&l4ls_gclk>;
+            clock-names = "fck";
+        };
+
+        counter@48300180 {
+            compatible = "ti,am3352-eqep";
+            reg = <0x48300180 0x80>;
+            clocks = <&l4ls_gclk>;
+            interrupts = <79>;
+        };
+
+        pwm@48300200 {
+            compatible = "ti,am3352-ehrpwm";
+            #pwm-cells = <3>;
+            reg = <0x48300200 0x80>;
+            clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
+            clock-names = "tbclk", "fck";
+        };
+    };
-- 
2.43.0

