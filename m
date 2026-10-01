Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CE1F1534;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873788; cv=none; b=UdBkXBEyQrr1Vp4McV2vPBOhga7+BjOTsVeJcG24wxd14+Ky8eANL+rY84klpuvpB/2S+xaqfjJ8Zcg2fZchtqwzazElC6Z9i2+OPuINcCzUVN17Kjqw6QrhnXCFPUpzyqSEh1Y8d4BMZss8MmenIniulnULOM/bq8dnu7jGaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873788; c=relaxed/simple;
	bh=9wSbdKsSPZMztqWcv2eAGWGwTSf1fvmTTyMWoLMeghw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+bJfqSDU4rMcToXeXZfc5CAkC2EDvKg3DGfWVqCb7xu746CR3AncF5Ne2fNkRcqtCmZAx+EVWuHbnqbUX0xEdv3QVHKl3hkphS5hOhHwfMzVFfrYaE4F4Lhm93ya3c5cDuRsZGkXv2qy1fxCtdPXP0zq3YGTno56E7D17Wixug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7N5ewHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7N5ewHq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 617DDC4AF12;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790873788;
	bh=9wSbdKsSPZMztqWcv2eAGWGwTSf1fvmTTyMWoLMeghw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J7N5ewHqP34SogezsdYJCVEAx9f45U2xwrAo9NAh1onfXEULgJjUX5GBXD04E11ZB
	 seBVu+fz/fOdSyKoFXN/LCWG5gRYQBwdT00KVs80CZ/tZzPVyqEjMUB24wuVoOKXdJ
	 zdTgXCK2C+b9wwlHRusujXOIvBIc0XqRB6iQFj8/pcuQzPLx0ICnoTmDxm/0Jrdw0C
	 ftjUgFPU4N/M8t3vgZJub4261249KjNyLudg+Am5WC1uKVqDz0nXg4jVR9ueC4zqFq
	 2svR8nBSMcXhRDT8jjEAQG9zXeZUBSLOxVJ+Zye1NTBlVOvgy/zHib8Pc3wLilh4/p
	 GrTE9R7Bbk3+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA03CA5FCF;
	Thu,  1 Oct 2026 16:56:28 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 01 Oct 2026 18:55:34 +0200
Subject: [PATCH v4 1/3] dt-bindings: pwm: amlogic: Add bus clock for S4
 like
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-add-t7-sys-pwm-clk-v4-1-8ed2b1e0cdfe@aliel.fr>
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
In-Reply-To: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=DajmJPOZU5T3SXCz0k6CFapeDP4KwjcTSjnqHfrN4Go=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a+CRuS50VNubVQaV/S0nmPQ48emvfa5HK8UtD/tZknJ
 357vs8huKOUhUGMi0FWTJGlf67liXeXj575ukc9BWYOKxPIEAYuTgGYiDwfI8PCX4eY90VMeeA+
 +8DTCYv88v5FTmnY/uj3g6KZzwvDv7PpMTJc+7nr2vpanoZ0qcebeza1mPEkBMbZGEV+rt8rqP0
 +4QUzAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The T7, A1, C3, and S4 PWM controllers have a bus system clock in
addition to the two input clocks of channels A and B.

The channel clocks are acquired by index in the pwm driver,
where the bus clock is fetched by name, with optional get
which is silent when not provided.

Require clock-names and minimum 3 items for S4, and devices
which fallback to S4, where the PWM devices do not work
without all 3 clocks.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index c337d85da40f1..6d01adcfe897f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -62,7 +62,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   power-domains:
     maxItems: 1
@@ -143,9 +143,15 @@ allOf:
           items:
             - description: input clock of PWM channel A
             - description: input clock of PWM channel B
-        clock-names: false
+            - description: Bus clock, gates register access to the PWM controller
+        clock-names:
+          items:
+            - const: channel-a
+            - const: channel-b
+            - const: bus
       required:
         - clocks
+        - clock-names
 
   - if:
       properties:
@@ -179,6 +185,7 @@ examples:
     pwm@1000 {
       compatible = "amlogic,meson-s4-pwm";
       reg = <0x1000 0x10>;
-      clocks = <&pwm_src_a>, <&pwm_src_b>;
+      clocks = <&pwm_src_a>, <&pwm_src_b>, <&pwm_src_bus>;
+      clock-names = "channel-a", "channel-b", "bus";
       #pwm-cells = <3>;
     };

-- 
2.49.0


