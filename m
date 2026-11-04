Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820306;
	b=jz05zkAkYTp2bzzZGXnAqe2/hKvINiZ6Mxuq/DnUa20yXq5vItMausvejMP3NLZ5N/7X
	 +6cdzzYdNCVQZnHVXYSOVOyeYyifQVx77OGCJ5A6BEpvuupaN8dTEYibC8mLw7+S7H5Nn
	 JP7QydN+Y1fCTW7oFrDOI1EsOTT4nNRKCmHkgqglpLQqjgKpgmF4mOZYXsqm80uoCZI9O
	 7ZTGdA/tGgOVIPIo/uHWGtdVcsCyCH+Z+Rr4U7NeoiNro2i6AHj/mF6KhIGqfaKP9ClIG
	 57SWJUneQdGamoRVHPnWQkhuJRwdR79MbC/14t+dYSCvg+vrGpZsxYsi/tmZCfpZMeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
	b=ztjfOoiRVF/5/S6YNiR/KjNm8bSLuJCM0mikRACcz60iYKJ92RdJPPRJRJryvJ4f/tRc
	 VbbszlnfzNfKgOKFOf1GGZV5SA09Ncs5xJMuVLgUrmH1PB9P0sut3VRzz+4aFKbxFR8eY
	 JdCrafOS++ycimPMLMiGs43gSpUT6hF/sHdcwUFvqsFC62CmySt76vAU3E++t+LvOkYLk
	 WGaIowJj+K55JVT6HJWaSiSgnGXoF49+65OkJwa90nJiwrN7n4sJHV9J1JQjmOKu5R0bR
	 6iKySWt7Wot+eym/gr7vHdVrAwaCtuh0N2Xs2/ui4tTTYuuHExuXuCEoFq1HOVwnmSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3d0Ev0P;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74C607E934
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 19:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A74C607E934
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G3d0Ev0P
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4f488ba6e90so442813b6e.3
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2026 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820304; x=1794425104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
        b=G3d0Ev0PzTKoH9/qkmm1xdyYMItYLtR9472uuxqYDGGE3DTSJDpNdW5KhoxyxluyOn
         bDJ4RdQtvjttKH/Jbe621LTmeAdFhbfq5FcDRI2p0aBcOl62R2c3QdLw0jIgQFq8BkYa
         Rw3733tFokoCWR1RpQc6qIPQix/VVjjpj2qYOOfwn24mnZ/6oHTcvUVoWxyp9r3HFDfM
         khvKJVKxfAdrC2gtj+aFX0JLL+N5mtIOaKAl6tOPQkT3XTwNru6mxU5tsDFZV4NGMFl3
         TIBDEUtPsj1WwMA8a8H21JNq9F1B/R8FDGAFaPj76P08+TiGta82bulTdIFbVzc2KRgs
         Rdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820304; x=1794425104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
        b=jWPtzvGOY1sYagAXpZZEJMSOludLK83yJPyk+eUDFuiELdDphw+Ap24Jy/6sAA+cQz
         g2NbSCGSy3vBiAevOzKMcoQkHw+mnOvEqjGefirAeF+azurVdAIaUitE5dsuY5g5BYsm
         tSiMc6SqljPE+tM37170huvqvohsRrSiLIf/q2hpC03JsdLsH2WnHANtNo17Whe/h34T
         +Dfb75eLh5MZr89MtD73hL5oJcHeEE7juw7yhn7h6gXsah2OhLJGtg8eoFU8HlVyD/eN
         Dzh9X5zpxTvBXls0jBzkVYa6uDi9SoNObuLMFAnJpyylX3c7gNumQNjfv09sI2XjIyYy
         wZ+A==
X-Forwarded-Encrypted: i=1; AKwUvBzPo0lvWS/EBUd7RBDFE0fIO4pCol84y7nfVYeCAonyeZSZNoTW/K44Pxt6xt783HMYWXl60w4tHgk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d2lsiOomUogGuF9HBykXMeuDyqQdppIltlcYyGGDKczLmp00v
	PU2RCSb+qkRdCqIg7qVYgYghWCDOW2olAMEeYouT6uSGYJ56OgIWN0AN
X-Gm-Gg: AYBFou3Sfvjmja71K+Ob9qyg8wLXZe20mtrorfcJpPLdcMGiw5ML4w+TPefRKfgs4k2
	XZahVrx86slUcupnEJnQfVBpyDw8DJ8cCUIxqtrjk6puXCFm6kA+6HET/3x5/nzaVI2GSLseLLq
	HoHxXlXa4mNpR9YMwqzlFYG6CEPYsHuJOkay21+z+f+U2oMWr10q9vjbqZTwWEn30+Hihp483qX
	WhM3LcAsmqQMQjoHrzqh1WbpK2retsoFQUe0iWcW9C9idTTx7jWBxv5s+sab523Czutub8+cx9Z
	WhBTHydWSzqqs3TI/F3UvSigt/8xEafByAG3W9lDLotz2TKHW49GSpdZhOCkw9Fip+AVUG6gC62
	K8FQvVePyhnqzlu6/gpQF5H+qgk9fpDkxmtHNppN7/iu47elc3CISFW360tNsznOMixg3L0Ljw0
	QgReCC6HtPFNiKBXiLsyG8nzkfGS9jH9+Kb/gC2fy352xXf006k3MrmqBjNYOOlxAMh62BBxTKH
	oHyJilW7pl11NGoi3Qe55s5iu/YGiD7QOQ02RDoWnMfwv96wuyTqm9KoMQNOrCD5K7FJMFbNFHG
	70MRCn5G/PSht/NCQ3O1ZfFazFmy4lIJumHpR4R39eQLUvPenc894c9/Yib9pJ4+xZJhhgQvqYZ
	m68xmCdjCWixkzKIuRaJoGuGf2Z1KunVH7/BKhxr64T2QOchMkbsCDAMTW06Vuy7nJpTqMOUPof
	6Pe778rLiih7NGuYNnzm8jo7PelKKarZ4qNHJxtX/jpgS6PMp7zhtfS3Om4p/herWGHZZwiiPWW
	Es=
X-Received: by 2002:a05:6808:50a1:b0:539:596f:6623 with SMTP id 5614622812f47-5640de36536mr13164089b6e.64.1793820304255;
        Wed, 04 Nov 2026 11:25:04 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm2328723b6e.1.2026.11.04.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:25:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 12:24:51 -0700
Subject: [PATCH v12 1/5] dt-bindings: pwm: allwinner: add h616 pwm
 compatible
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-h616-pwm-v8-v12-1-8ed39b0dba69@gmail.com>
References: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
In-Reply-To: <20261104-h616-pwm-v8-v12-0-8ed39b0dba69@gmail.com>
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

