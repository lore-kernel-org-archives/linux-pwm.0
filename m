Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC6292906;
	Tue, 17 Jun 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152061; cv=none; b=IbAEgAZL3UGpchX1C5McalK8gUecHKFsBZtFhCFxSbiCEC5BOYwup9liO0i7q5ZeH8pDWPDlXwBdIiN3+rQR15sO70rhCeORK6DKuxMT23fhgpDvRzjw+kzyuZn4PGGlrbOJdN/xr2GGJjx8g9I+rZCU6fuhW6CB0KzePQ/Z5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152061; c=relaxed/simple;
	bh=Cg7bNW18gTtvXdogyRUXdd4wS9qmTHouMzpmSLMFjI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlwR9CBPNbCELjkqWh+1taykwjmh4f4B2EAipKf3czgRMgefPFr3S7CTpdeyMPygX8vZGeGXwrYHJAAMHt+FbA5IgupSI96Q3758NPp1iSQN8ioD+Y8eaDMt9Vmt0EDvais+4hw1t70gNto0aXNggn45l2cdc1H/6IRLzaM3Acg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=s6kTcZdj; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Nu8fPyHO; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s6kTcZdj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nu8fPyHO"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bM1ZJ3RS6z9sdT;
	Tue, 17 Jun 2025 11:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750152056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xBKxs6A6Sj/ErjpswUUb0kS0ca5cTCWfG6pJV/ssbw=;
	b=s6kTcZdjWE1d9fLCo3+MBgcdsyqw3/ka/IsSvITGOC/0o4/G3pB6X4NCP7XRreSlJcTrt4
	ZWwdZvWT7w6Y2y7/VTDAIXS1hh+f5AaRsUvIzlpDlUvAmzX45ScIepzYCoGQFXsMtWm2Pj
	u7kKnSoJ1/eTnaNUtBPVMtfdLAFl7S4Nm4ieZYjAGDhLCoc4DKQs/OVCNhmwQo6gf3L3iR
	9APHDKnaaUkUR+VDNiN8voR8fDmZNRe3O62xmpF/9hU5p2wZVZmzry3qwbg+U6GinEkz8R
	rMKjZIoY6knoaR104n0zgElMynwDJQM5HDDrwo0fRQWCxwWmO9gJ6bCJ8pUtnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750152054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xBKxs6A6Sj/ErjpswUUb0kS0ca5cTCWfG6pJV/ssbw=;
	b=Nu8fPyHOMzgNhhvfpNDnewnrZnJcPQdGvYuH1YBCz1yy2YKOcs5YCDWBBfsjzbDL7PGWws
	t4xCMnJXIHoj63SXUyPg5Ri15KG1IgeyimISdIAic7N8shGH7C3E7GDFbyxIg9biyJYqCh
	QO+1Vh2GQmQnBck/QkfEF2PHdR3PxgH5LJiMPJxLGpCixIYe7yZMhcTL0SDqJRMGuF9aTs
	kreFaWAS/UjX9ip+Lj8j3MEoErDC0iPC3pVdv3y3EZSkny8W+DFCxxpkETj/pFmNjGUxUd
	2lHFX941hk+R4stKRaFQvyPCckRp4PORfPI5W4iwOq5poG4PYkEJGdCJCNrgUA==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document Argon40 Fan HAT
Date: Tue, 17 Jun 2025 11:19:35 +0200
Message-ID: <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eafen9gohxtfjt7ydk6i93byxdzummw4
X-MBO-RS-ID: 9fbf8e07dc1d7155313

Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
blower fan hat which can be controlled over I2C.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Implement dedicated binding document
V3: Update the description and pwm-cells
---
 .../bindings/pwm/argon40,fan-hat.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml

diff --git a/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
new file mode 100644
index 000000000000..a0010700ab12
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Argon40 Fan HAT PWM controller
+
+maintainers:
+  - Marek Vasut <marek.vasut+renesas@mailbox.org>
+
+description: |
+  The trivial PWM on Argon40 Fan HAT, which is a RaspberryPi blower fan
+  hat which can be controlled over I2C, generates a fixed 30 kHz period
+  PWM signal with configurable 0..100% duty cycle to control the fan
+  speed.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: argon40,fan-hat
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pwm@1a {
+        compatible = "argon40,fan-hat";
+        reg = <0x1a>;
+        #pwm-cells = <2>;
+      };
+    };
-- 
2.47.2

