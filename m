Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B58386453;
	Wed, 12 Aug 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505046; cv=none; b=dQiIC8lG4+McSsSCM3ovsQKdylBKUc+Rblep7zVp49vf3o8IjLBupX26pLDLMj3w2TAN/TCtZv+MkUMvOe/qeFI+08Bl+6gC7Mouishu0wBlAgj2H85/iGZQhXfH6bXvAAD+Zte/cTBJ7QtDMdYyCkaoVJ4sc/7qO7FlPRgvDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505046; c=relaxed/simple;
	bh=kgoSJfCQHW0+Dg62ei7S7n3mzCu8wyzu0Bm2onZRb/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ec7qcGAvkZZ41lXl9iyTKQXaU65Syle6TF2ViYHAoAF0Qcz5/isSf+WmUhmSwM7xSvcar9tLWvZ1Quod4EIVE3ytIk8PizCedQ3vdAqibkaUXGssy4ctTj8tFSR++mE5HcUlDlppOetGoMmhVK+eKLK+9ACX8uxYg1Zrt7mGlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W88hO110; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W88hO110"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50BD1C2BCF5;
	Wed, 12 Aug 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786505046;
	bh=kgoSJfCQHW0+Dg62ei7S7n3mzCu8wyzu0Bm2onZRb/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W88hO110mV2R9+DkHRAdklqrnq66sZ+V3IRCNl0nLkFcz2viWwfH6wdTbgq5Zyozm
	 bMcutLiJLWk9vscKbGRMsZ2sOAz+SYaUWGr/Oi0cG5b73VXN6vdRxm6A71dI9LHSQP
	 HKwl+AGJvisJ/LZBHGPQs3iff3t3Iq/txDGVxMuSZmx76HxzftUiWT3TbOcgRQx66K
	 irmKwVbyFAANVt9ePIsez8JLZjjaD7g49VCu1fIme32TxZuS5kjhtoWQ5bak7btCWF
	 m+B9BA5vmEawKM9mQ8EbHqorCHz5aEO1efZ2bUA/qmI/QMriDZGGBaYUOQXWfSkZlz
	 OzDbAiapDIBEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4026DC5B567;
	Wed, 12 Aug 2026 03:24:06 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 12 Aug 2026 11:24:04 +0800
Subject: [PATCH v7 1/3] dt-bindings: pwm: add support for AE350 PWM
 controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-andes-pwm-v7-1-a806da8185d1@andestech.com>
References: <20260812-andes-pwm-v7-0-a806da8185d1@andestech.com>
In-Reply-To: <20260812-andes-pwm-v7-0-a806da8185d1@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-09770
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786505045; l=2621;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=AlnVaPc7CqtbKonPziakNqedexQPh0xwvAlumniDgw0=;
 b=Uven+JtvvWPDfRJ8NXATFqn9rZkWQE3ntU9nH4nlQQnqgfENI06Kpb7/Ppbww/jh+smbFxwos
 b17UCUZVzWoAAJqDjK5H6vnO57Kl7+dtHezvg774//+PGiIA5j5/yw/
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

The ATCPIT100 is a set of compact multi-function timers, which can be
used as pulse width modulators (PWM) as well as simple timers.
ATCPIT100 supports up to 4 PIT channels, and each PIT channel may be
configured as a simple timer or PWM, or a combination of the timer and
the PWM. This IP block is a core component of the Andes AE350 platform,
which serves as a reference architecture for SoC designs. The QiLai SoC
also integrates this controller.

The binding introduces the following compatible strings:
- "andestech,qilai-pwm": For the implementation integrated into the
  Andes QiLai SoC.
- "andestech,ae350-pwm": As a fallback compatible string representing
  the base IP design used across the AE350 platform architecture.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 .../bindings/pwm/andestech,ae350-pwm.yaml          | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml
new file mode 100644
index 000000000000..287f3c62965f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/andestech,ae350-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes PWM controller on AE350 platform
+
+description:
+  This controller has 4 channels and two clock sources. Each channel can
+  switch the clock source by programming the corresponding register.
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-pwm
+          - const: andestech,ae350-pwm
+      - const: andestech,ae350-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: APB bus clock
+      - description: External clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: extclk
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@f0400000 {
+        compatible = "andestech,ae350-pwm";
+        reg = <0xf0400000 0x100000>;
+        #pwm-cells = <3>;
+        clocks = <&pclk>, <&extclk>;
+        clock-names = "pclk", "extclk";
+    };

-- 
2.34.1


