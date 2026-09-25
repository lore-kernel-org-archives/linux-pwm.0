Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF524CC29A;
	Fri, 25 Sep 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349266; cv=none; b=a6DzFA9e9GDdk8KatI5GFNqqCz2ljkhrEraFRpo8eibYOE/Bag00ppEX4vP5O0l+e+Pn6BtRY/Ywk720DO4rfZNFyyxG8p/7xj0pRbt9moWnVbDhQF5J3yNsSFK1V9tJwU2sWnERnePpXCcl/Zi3iCS+A/daZ4vbbyuizxGNGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349266; c=relaxed/simple;
	bh=m9d4wVem58v8DsnpYMJqcpiHnmAE/BxUBPN1Xs7PVkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWYqlLjDgU32Iz36czdM+bK2O/+yIyRe4Ri0oewxIBr0ehRphLnok2RfDUETKc3YV8oHYveTy3pdouPEXNp8ySEnS/A6N5lYwcws4pdFLmhuG0q+Xkx4T9VrtSokIqFCkqE/ocjJ/pXR1I5N0RhrvweDbzRlPjXcdp8WdFmhEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKdVdV8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKdVdV8x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E89DC2BCB8;
	Fri, 25 Sep 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790349264;
	bh=m9d4wVem58v8DsnpYMJqcpiHnmAE/BxUBPN1Xs7PVkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uKdVdV8xGTbMVqd4tzgVuE0ngb41r7aHYK8hOtg5dpygd9s5GVMmwsocEl8YPODQQ
	 X6HxYJ/8Hr7BKvSrJ6rWrpUcCEcI3weGOd2IJR8hnktXRhmG4kJpUosnI7F33hVod0
	 gNL35mutbXRS/AVefrr3HQuLYZOFDMTdi0sRHa7ZCpaRJOJIcYolcwr7ATslrwd2Re
	 W09pdwL8EA9N9n7i19XGxkb8SORUYQ0jki8U7E9ygSmjik/5kpQ7+DbUgFiF+8qpPo
	 TJFnnK1b35OWSnjxJ3l8gUO8dYb09AB6j/eUjiJHRz/Uxt775D1CUMB0rUkb1eYDXf
	 mKBok39IToq4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA0CC98321;
	Fri, 25 Sep 2026 15:14:24 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 25 Sep 2026 17:13:28 +0200
Subject: [PATCH v2 1/3] dt-bindings: pwm: amlogic: Add core clock for T7
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-add-t7-sys-pwm-clk-v2-1-f23a22b71a5c@aliel.fr>
References: <20260925-add-t7-sys-pwm-clk-v2-0-f23a22b71a5c@aliel.fr>
In-Reply-To: <20260925-add-t7-sys-pwm-clk-v2-0-f23a22b71a5c@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=75yNudVNuwQ3zdJGU8ivK4ndnUVyoW5jHITfU7O4bG4=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a2/kOCizR8E88omVy2KIs9p79i96lthj+PlV7u33mb+
 fqaWXZPO0pZGMS4GGTFFFn651qeeHf56Jmve9RTYOawMoEMYeDiFICJGMkzMvwUXRpb3HAw7neO
 xqHs5e1Lj1tIbZ20xiEyq2Zpkkit6jNGhtlfaj5u3/ZAUzcyLlLcyNG8ZfqHkmV/wqY1FS4OXzV
 xDScA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The T7, A1, C3, and S4 PWM controllers have a system clock in
addition to the two input clocks of channels A and B.

The channel clocks are acquired by index in the pwm driver,
where the core clock is fetched by name, with optional get
which is silent when not provided.

Require clock-names and minimum 3 items for T7, where the
PWM devices do not work without all 3 clocks.

Add an example showing T7 usage with its fallback to
amlogic,meson-s4-pwm.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 33 ++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index c337d85da40f1..59320f288552b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -62,7 +62,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   power-domains:
     maxItems: 1
@@ -140,13 +140,34 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 2
           items:
             - description: input clock of PWM channel A
             - description: input clock of PWM channel B
-        clock-names: false
+            - description: gate clock for the PWM controller
+        clock-names:
+          minItems: 2
+          items:
+            - const: channel-a
+            - const: channel-b
+            - const: core
       required:
         - clocks
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-pwm
+    then:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+      required:
+        - clock-names
+
   - if:
       properties:
         compatible:
@@ -182,3 +203,11 @@ examples:
       clocks = <&pwm_src_a>, <&pwm_src_b>;
       #pwm-cells = <3>;
     };
+  - |
+    pwm@60000 {
+      compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
+      reg = <0x60000 0x24>;
+      clocks = <&channel_a>, <&channel_b>, <&core>;
+      clock-names = "channel-a", "channel-b", "core";
+      #pwm-cells = <3>;
+    };

-- 
2.49.0


