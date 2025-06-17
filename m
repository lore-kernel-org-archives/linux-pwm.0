Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5B1482E8;
	Tue, 17 Jun 2025 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120160; cv=none; b=bm/HlC9DowSgKdxCJJnYiBsg/QFfORLt0BZu1XAF0qetzAN2KhR1/i6lNwq62VJZdrcLc91Zmh9eQyQZiiAqele9ZpdoDjPRGQpNnlrg1eAUUeiHGsHOBBnGupKtr+dg6Ov5z0cPHKVu6iiZ5uPkazBoev93YYsCzKUvaoEEPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120160; c=relaxed/simple;
	bh=uzaGkd5MnD0nh+2mjG+UCXhgd0fDuj4sTMkiSU4FBkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV5LkTn0GcCs0D6mmFz64SBxyIBO4JrPByLBX4A8vzV0Jx4nikyxyQnSlOgjPusxzO174MJ3SOPlG/f63x2btcnmOIeLTjz+0Lz//nIb3P7xXK0ot7+/nLY1XvYOrNbudSrRAyt+C99jOU+zcy0Co3+EZmVejshDEH8GU0NJmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y0rJF2W+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=X/7yzYa5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y0rJF2W+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X/7yzYa5"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bLnms1Lf8z9sW9;
	Tue, 17 Jun 2025 02:29:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfjKBuILh+lGyoeENWT9EbuJIIX/Qfrx6E5cHWxChUQ=;
	b=Y0rJF2W+2z6fEu6UzqcBj8xiz0LHWW9v1fe46Iu8M34bnA+pzcZcgMgvO0OMtL8mdegP6L
	xdHAXdC9648bybUDxljDXH2J5unzSI11BSoJdfW6vNxv/2ASBlnnLv0HjSPa4A+TBgQ0SL
	ScKM3eHPO9/8Ijep60R8lJQZfhEQ22/1x5nimATyXMucIz1FiZ0OaiG7dJ2QcA7StkYQni
	3TDreag9HN7Ou92KI1WkqRnjYeasWmVHJy8jaazCJdGDxpfcUY3s5eYEZ8QxpfjeNLHNKk
	ehaFrCqklsp95sXvsmAztLpcO8O94TX52Q5YAWG5HU8kj+fYuvDzTaEvhgiwPw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750120155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfjKBuILh+lGyoeENWT9EbuJIIX/Qfrx6E5cHWxChUQ=;
	b=X/7yzYa53gAraScr+CbYTcVDubAjp+nU4yDkCRLQDaj7lxShaNGC/WKrIbdU2oERHvTNT0
	weyxL3j+wIKk2iam7MdlPDd39nnQtPNsXIAWbcBKyAhYIkRxpCzD3loxXVJhhX30gMokH5
	LxdE8KCgRurR92EYGgmTU0N1j0JIeelhCcpqWwcZgotWSDPCVMvKjyTN2bhhd0T7/wvTQI
	VrIy285FvusIgw/e3fkxHznUIDyYoRNXvsrr9vn9W40CB40nteSqU/2etsjzMtup1n7MJF
	qUNg0cBKCkbAOHHD83jJ1dLvLcoNi0h5sI9Sow+pewGxx38zSszaK2SvZ01W7Q==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: pwm: argon40,fan-hat: Document Argon40 Fan HAT
Date: Tue, 17 Jun 2025 02:28:01 +0200
Message-ID: <20250617002852.606409-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
References: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 77q3wiaytdynszqds1oa6n5enotjsp46
X-MBO-RS-ID: e864ad3c274dbe6be95

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
---
 .../bindings/pwm/argon40,fan-hat.yaml         | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml

diff --git a/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
new file mode 100644
index 000000000000..2725eee5328c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
@@ -0,0 +1,47 @@
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
+  hat which can be controlled over I2C, generates a fixed duty cycle PWM
+  signal with configurable period to control the fan speed.
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
+    const: 2
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

