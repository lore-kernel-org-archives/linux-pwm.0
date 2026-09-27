Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF83E49F4;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519353; cv=none; b=lpXejF8BDhzL67QIph+6ULtXkIMZA21ziLB0yu99FCg27zcPXED7ZzqUnqz7w3lU9wtRZw65XUa/bfAMcj7pFtv7IkkF5YrrVKdlNQZJyiVR/L+VRGCWa/c2RS3ABzihSg0qeLFLAhb1P9n3avUBIMG8XXealwXyylEqMI3pFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519353; c=relaxed/simple;
	bh=loY1pCAhdkrgIbxRkXzPM7ibYgJ5rizQ5x2h+dPCtoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+P6kZGk5VrlDlj1C4vjjigdC75pH3do2nLqC9ych5724NRH9WpN03GEQClR4hWEvi1/0Fqn0CNHmePHXnov02+5cVXiWh2Po6nmswqkofooRXT+FEBiRyfB143OPaEHjN+Y0k/XSEpP+D2ZHAd6zMnIepuhUPlofEErXER55xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+ESTPNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+ESTPNU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FFEC2BCB3;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790519352;
	bh=loY1pCAhdkrgIbxRkXzPM7ibYgJ5rizQ5x2h+dPCtoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e+ESTPNUtIG1RPO5PkUKC14pL/VXDPErti1u5o0ZCk+whGnnQ82raRnlsTVhjvY6i
	 mcRCFZA50h+B+/1sYCualbgq9A3EJI+UDTcr2rfgXMD9swiRC+v9s83HElSah6/N8R
	 DjTi7YFULXjYNhwjyto5KOVYIagmw6mURbNganer+vYFyZJfdNuFCx0xjiFbR62nXM
	 vNCBQ4+0uYEuUB4y6jrIcLh4rDl155BiD02Oz+Ucwover/rvWecNevmKDkF+ppICsj
	 7Dfr+goPhkjpIf+rBI7G7yC5OPGNX6eZTqZitU5C+48Rhatv/UpZSD7O8WQunj0FuG
	 Ssy4YVvQlnPhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ABFC9830E;
	Sun, 27 Sep 2026 14:29:12 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sun, 27 Sep 2026 16:28:15 +0200
Subject: [PATCH v3 1/3] dt-bindings: pwm: amlogic: Add core clock for S4
 like
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-add-t7-sys-pwm-clk-v3-1-18d66abea4d1@aliel.fr>
References: <20260927-add-t7-sys-pwm-clk-v3-0-18d66abea4d1@aliel.fr>
In-Reply-To: <20260927-add-t7-sys-pwm-clk-v3-0-18d66abea4d1@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=ocfAHBxwQh4nneVCIVvdqenheD8RusX+bkEk3wRZMOY=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9ZODbVS60nc1qt+uhw9c+XHjH1HP8zOuP7u1qkp7q95/
 B7EbP20u6OUhUGMi0FWTJGlf67liXeXj575ukc9BWYOKxPIEAYuTgGYSKo2I8OqrvAHN1oY5t9Y
 5C++5U9CUZF7w6wn2qdj/qzMnmX88KYhI8P6v1uVs3QOL2vumnNsYflKL7HNlgKzN8sJcoveZ1C
 9mMoCAA==
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

Require clock-names and minimum 3 items for S4, and devices
which fallback to S4, where the PWM devices do not work
without all 3 clocks.

Add an example showing T7 usage with its fallback to
amlogic,meson-s4-pwm.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml        | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index c337d85da40f1..e9cd5f1fdf264 100644
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
+            - description: gate clock for the PWM controller
+        clock-names:
+          items:
+            - const: channel-a
+            - const: channel-b
+            - const: core
       required:
         - clocks
+        - clock-names
 
   - if:
       properties:
@@ -179,6 +185,15 @@ examples:
     pwm@1000 {
       compatible = "amlogic,meson-s4-pwm";
       reg = <0x1000 0x10>;
-      clocks = <&pwm_src_a>, <&pwm_src_b>;
+      clocks = <&pwm_src_a>, <&pwm_src_b>, <&pwm_src_core>;
+      clock-names = "channel-a", "channel-b", "core";
+      #pwm-cells = <3>;
+    };
+  - |
+    pwm@60000 {
+      compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
+      reg = <0x60000 0x24>;
+      clocks = <&channel_a>, <&channel_b>, <&core>;
+      clock-names = "channel-a", "channel-b", "core";
       #pwm-cells = <3>;
     };

-- 
2.49.0


