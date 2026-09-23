Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F789428841
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141786; cv=none; b=RGnTHLGjThVXNAm3G33MHiKws3ysSnV5KErfAkIUSMt767sVK43DOAzFeM6rpXF5AIEhATCa5I2oFea+XYWmvvyoSCDRgKuUr0NLNNT5atGKpWQLlIUVx1S/flhA8DNua8VmyByxf3imiZ1XqDTRkuASyFQbSthwsrg7kGzPW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141786; c=relaxed/simple;
	bh=5k9VLU6OvtrGZi0gO1yZy16OfwqfrZmQwujeqIifWv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLpt5d7wYxF2U4P6fQdFtY+fMyldZd3yyuJmL213WjW+q0clX4Xp34798MumbmZaiIKxfrmEhDhshf847vt8iTdxpYEKq4qOJTZfenZOcC4hMN+I5VlmrKBzhMq1tIqVUAFyjIErAoox1VI1GZfdpgcNNpyBwsjDrb6WCXnw6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8XH63Z4; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8XH63Z4"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a36887bso376318b6e.2
        for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2026 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790141784; x=1790746584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
        b=F8XH63Z4doIji6bAgrFxU4KEekuBBKmXL51+Wdkbkecnt3xzvQGiJ1lj6kBiiQE78l
         6vt0ZXymtZwSyYJYb3xeB4CmuzVVdbvwsvON9Pmdscl6FcrzMXmyawBtN9dynJ+8gwNN
         YRUrlwN1ZBsGdgrlCvm4KY6vI00oR6JgtnCqXh3Al3/tQWCPvopqWqeScOzz3ApR3aMF
         qSRL/1UsfSmgkSPUXWGNkGBcZRViDMufWKGPqpKEkvu0eyJHIDhDYBCEAH3MEwB3n2dY
         eFQMaLv4if3U391jU5QfTeY3iz8JDef7iyMh5NtrfQdMcNMF4tqbUgVjIHsb3OXZfhhQ
         /FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790141784; x=1790746584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
        b=lhaehwkg86OTmd/gUuwoXIFxYPFu7N3APV2GQRWfefVXgCoH4Oo/Fhg36VAd7+bFem
         jtUjpzG/NTZK8QQRf96jSwN/tm3rT3uFMaZFVrNZwuTB5mkx7knZUOPXD63sP5Itn7gn
         9fJ3JzD6CC2n2t4HvbuutLKGixKNOwE5GD4BDwcPq7Oay4x+OAMT2TV6H3JcEbAJZ6Zu
         +6757RrX8zfCA56Tg2kdER6t2sXN1DHJ6IBrbx0GUKLRr924OQRvBYhlOpSoYMukloI1
         Uey4PNrdYIyL4iUOZAnjjcvr7ETO2x8XG/h2zR0aOQj3NvFifaPSMlvzRT5fNMMyooeG
         r4+w==
X-Forwarded-Encrypted: i=1; AKwUvBx3/TYfV66V8TJJFXvIM84LyV2lQGSFwvgHLJ0UvJLmP8EI7n3uMs+Ki7nR4oYjudwp9AXvaeCPY3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lKeNxO68eGm8pO2e6tg4RwxlYLyOI1iI0SKDEaRuT3rxDXjAQE
	QqR9g9f58sa2cnB5RdpzWhjZi4GXCw78Pzf2KFgIBy2wmbxHPm/1d49x
X-Gm-Gg: AYBFou1BryJm7E/AVKXxHv8uL1xfteHArua3RGZcurbEFDkooAOoHpPFVi0tf8aWuSS
	BqCdfSrcwQ2OmueGIgmcLJQSZ1+ay894I0dtDccL319qNLDAkm6tR1oK+uGHtYwjIKDIY6MOZNL
	HFzeBofHr4agVaaNPIlKUeUQrTv/H3tZSLlrV+wSdzzYkY6YsxSYR7Y5D7mi+ee2nTdgo0XWQ/Y
	VG55nD2mjCw0EJNFOieXWFHy57o88Iq5V2ezZZF70nJhBMx4PtQFACJuPuXv/XsXdX3rAc+Tcj0
	vJm2q07HvUZ78ku9j4+dlE+nnxN0lQ+QOwVUB0JfldfWatJSqcw8ibTftaUYJN8iWhmB8H/LjfK
	uJVH0PwdiWqNTu0n63Qun4EjkTfxatjyUNRw8cW1LrkOIojMZHyYHRVXYXUtjNdErRYNe9VHxza
	hFxTisj8W7aIXDgtnMtVN7OzIEtmsjd7c03BD0SORA9PAIf88NAJsED5jK2E/Tjd2b5ghY/3jlI
	MledeNgSPt6fhSXQn9C6+5yWBYpDIyQfCxmiN629C/DxB3yo3v1pV80PBWJdLbK0m9+y2yUkS0s
	ZEWzGBmDzD7MKTrvOIrFqTI6PELCvaNQxbV5muZqQ2JaERj8usDUq/66+7b3dTFwgFj2kt25f7p
	1ST0asKrrH6ZxeScbLoic
X-Received: by 2002:a05:6808:6b8a:b0:4c1:9127:c0fb with SMTP id 5614622812f47-4d5ba3c38b4mr1883196b6e.36.1790141784089;
        Tue, 22 Sep 2026 22:36:24 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4aed99bsm1436896b6e.12.2026.09.22.22.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 22:36:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 22 Sep 2026 23:36:14 -0600
Subject: [PATCH v10 1/5] dt-bindings: pwm: allwinner: add h616 pwm
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-h616-pwm-v8-v10-1-dccebbe1aabf@gmail.com>
References: <20260922-h616-pwm-v8-v10-0-dccebbe1aabf@gmail.com>
In-Reply-To: <20260922-h616-pwm-v8-v10-0-dccebbe1aabf@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

From: Richard Genoud <richard.genoud@bootlin.com>

The Allwinner H616 PWM block differs from the A10 and H6 blocks, but it
uses the same input clocks as H6, so extend the existing Allwinner PWM
binding.

The block has six channels that can generate PWM waveforms. Each channel
also has a bypass that turns its output into a clock suitable for consumers
such as the integrated X-Powers AC200 or AC300 Ethernet PHY.

Require #clock-cells for H616 because the bypass clocks are part of its
provider interface, while continuing to disallow the property for the older
variants.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      | 33 +++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 1197858e431f..3b1819c8630c 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -14,6 +14,13 @@ properties:
   "#pwm-cells":
     const: 3
 
+  "#clock-cells":
+    const: 1
+    description:
+      The cell selects the PWM channel whose hardware bypass path is exported
+      as a clock. Its rate follows the selected shared pair source and divider;
+      the PWM period, duty-cycle and polarity logic is bypassed.
+
   compatible:
     oneOf:
       - const: allwinner,sun4i-a10-pwm
@@ -36,6 +43,7 @@ properties:
           - const: allwinner,sun50i-h5-pwm
           - const: allwinner,sun5i-a13-pwm
       - const: allwinner,sun50i-h6-pwm
+      - const: allwinner,sun50i-h616-pwm
 
   reg:
     maxItems: 1
@@ -62,7 +70,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun50i-h6-pwm
+            enum:
+              - allwinner,sun50i-h6-pwm
+              - allwinner,sun50i-h616-pwm
 
     then:
       properties:
@@ -83,6 +93,27 @@ allOf:
         clocks:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h616-pwm
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+
+        clock-names:
+          minItems: 2
+
+      required:
+        - "#clock-cells"
+
+    else:
+      properties:
+        "#clock-cells": false
+
 required:
   - compatible
   - reg

-- 
2.53.0

