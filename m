Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0749E129;
	Thu, 24 Sep 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262913; cv=none; b=plUco10T/ansGpvjuFnlT84PmCYJnUKqSuUgPYIAVVEMt1lz0aTQ+5WsCC11pbKoPR/4C0iqt5bTm84PerPCc7grqUf5QwMZIJSpr9vTjDqDrbNbB+zLI3PgxmCYcJXUYTm7Ty8hNnPFxDLE62Xs68qZMjiEI5wq8xnjxrLl6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262913; c=relaxed/simple;
	bh=jHTjyUhwbmdr3rZ/8ntP2rA+m2eMUqGo8zOOdp2Y5QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtyVdG6CcU1YaPV2focmZmiySwIgup+CtAYqPqVBM1vGl5eTIFlIeU/JJK2yzkF/7IXesoe3pI7gnhy+x5iCXdNihbPV47UAcU3Jq1ad1NaFLregX0wyp/8oYdTlE+4dNB98LuczXZwPuJjTJWf0PygRUz01kkqyrdmMy4pxrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAP1ubUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAP1ubUD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD32AC2BCF7;
	Thu, 24 Sep 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790262912;
	bh=jHTjyUhwbmdr3rZ/8ntP2rA+m2eMUqGo8zOOdp2Y5QY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WAP1ubUDPo1g7WaGyJvyMxlMxt4P2TJspbzeBNuq7RPVzMExY/W/E0yuTg5nocxBD
	 37xN9pb7ooL9kjicHg/03DVmrdMJNuqtHAvaHLb/oJO8/Hebe4sy4ynWC7rmnKwBbe
	 gng05qA7YbZK9uSrxq+PJ3vJZUvx37FHBEt+6FOqIBnlU2mofxQ6+IgYEWNysACfgZ
	 TOOI9Xl3vXKSs1nNdezKBPtTkYvBZENKbgPjHFO1WvtIGPZaQN1qWMUobH8nDBCDBu
	 JexBjwD3nEhi5Ec1kYpeVy326pF7Nvwvvz5ogvQxtSsYZPyBGKZ1BsPsN9ut7JBWm2
	 C8n9uBf7nqp1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A489C98321;
	Thu, 24 Sep 2026 15:15:12 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 24 Sep 2026 17:14:28 +0200
Subject: [PATCH 1/3] dt-bindings: pwm: amlogic: Add core clock for T7
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-add-t7-sys-pwm-clk-v1-1-05b91e87f0a9@aliel.fr>
References: <20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr>
In-Reply-To: <20260924-add-t7-sys-pwm-clk-v1-0-05b91e87f0a9@aliel.fr>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=OnCP0bAi6s6lcclaZx+bp76WGWFDL4G9lrIRokcYtRo=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9ZWu8oHL7rtNW2Wzchcu9uQp30tT43As6vON7ulfh76O
 XuB9BbrjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAi3B8YGdqa3/m+yb8vsPKC
 pfqerIKi0uoK1RSVtexfc3zPGPz94MfIMGe7FGdNeuNL/YXdE25v4xE75v647sGqzfMzPGW3bzz
 HywMA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The T7 PWM controller has a system clock (the register access clock)
in addition to the two input clocks of channels A and B. Add it as a
third clock, named "core", for the amlogic,t7-pwm compatible, and
require clock-names for this SoC for clarity.

The other compatibles are left unchanged. Add an example showing the
T7 usage with its fallback to amlogic,meson-s4-pwm.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 37 +++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index c337d85da40f1..9212a40d9fe48 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -62,7 +62,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   power-domains:
     maxItems: 1
@@ -135,17 +135,38 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - amlogic,meson-s4-pwm
+            const: amlogic,t7-pwm
     then:
       properties:
         clocks:
           items:
             - description: input clock of PWM channel A
             - description: input clock of PWM channel B
-        clock-names: false
+            - description: gate clock for the PWM controller
+        clock-names:
+          items:
+            - const: clk_a
+            - const: clk_b
+            - const: core
       required:
         - clocks
+        - clock-names
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - amlogic,meson-s4-pwm
+      then:
+        properties:
+          clocks:
+            items:
+              - description: input clock of PWM channel A
+              - description: input clock of PWM channel B
+          clock-names: false
+        required:
+          - clocks
 
   - if:
       properties:
@@ -182,3 +203,11 @@ examples:
       clocks = <&pwm_src_a>, <&pwm_src_b>;
       #pwm-cells = <3>;
     };
+  - |
+    pwm@60000 {
+      compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
+      reg = <0x60000 0x24>;
+      clocks = <&clk_a>, <&clk_b>, <&core>;
+      clock-names = "clk_a", "clk_b", "core";
+      #pwm-cells = <3>;
+    };

-- 
2.49.0


