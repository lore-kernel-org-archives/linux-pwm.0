Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695237;
	b=OKULO87TedSORBnnvYiqV747T/Iy0uYiaLZDuJH1ZtkgY8lFvabjAcGULkIdq2C7ah4a
	 Q+Mcetn5ifwuqI9VkhIssa4t9Wwv9qgvY6IsrKLixCr/RjjSM96MUrNJgzLdRHm1OYifI
	 NAH+qr7BXAgjHDB7L8GRoKus8cRFE/8XthrqIEU8RMU/36h02JhyiT5yocLCGJeqadHjj
	 fPk0I4F96Djx0LSckXzvRpZxrxwcy04BGxnCHtbaVY+dhNCxMf2rUDj9g+yaK6sxczIKz
	 Tf71KWMqyTuQGmT0ka7Fkr9v5t8QeR661544rxIjD6/ljx9oaPMp7qly/1QuWv8ybtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
	b=WgJZp5J8ggkVItnIRUzzvpRv645nsNsva4kQZHeFaPPLWp0hiwPGTfY3JjbXoyrPUs1c
	 Hmm3NIKg3/NWnnVBEGzdP6H/jh2ORIINKofs96zx9cNZj4SftZ7hpxCmCnqB1Rn7u156P
	 cszGyxXVn7sazfco/Fmurpp+dlQnxhFWTkOSUrkL/fKdpEP+aF/u5dNynfrlGwTCH4FHa
	 326HxLsJW0hsBvx+6baoYhlz5kmBcX/rcF+q2+5ZQu+hitWliTizG+aSIi9LwMB6lNfQD
	 AVzxjCr+6+8Xms1hUyPuCq+M5DOiTJp4gNsJzy2x4TNFHfYmjzhs7JuZdiaFy1DKJUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gmRIarE9;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA56606A97C
	for <linux-pwm@vger.kernel.org>; Tue,  3 Nov 2026 08:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA56606A97C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gmRIarE9
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-706113e92f9so2172732eaf.2
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2026 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695235; x=1794300035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
        b=gmRIarE9Q49e3N+eyYDYeIXbSWIUOWqXSi/WRTjOsafRsqRgrmitK+Katzb2O5y9uh
         pve7zQeiIP65hLlCihVpiyH7V80U8w4C73mL7cFjlA2pUEYKqCOGLlXlT00mDh/zaxfX
         tP+Usw2C3yV511it/eB6j08OlEGr3GNziSPj9TH9Zd4MhBUkmbkD3AeZVUYK/rotwd71
         vqXDz52/NBq+Jc0sHuMfLZs70hzrhSDd86ZtW8OXOMNpdsSx/kg+Plgq4L2jFrUDnQqA
         ZuqBxx0NO9hY8aEHuiweq3a4Gj693iYyPaNki0+Ft46GntbZmF7A+Il4V8znqbc+27Yb
         S2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695235; x=1794300035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4cUR/bgVx/Ef4Tc/Iqux+0dgmZ5BenjLrR4X+eBZEU=;
        b=cY5yshNA0LpFWabEMBcbnL4MhtT5La8oQORu9rE070x3n+9OVn9i4zU6DiWTGBhW2V
         uNlG0XERUJVDt0rXlPPZf+mns5979DiYlqZ4Uh09IZq7lsfpzsZ3d97uYAyqRV350Ce/
         69tvFx9pOkSTLw0vnchIdsbKMxeXfGWRFlyBLNDucAmQucVYuN5uFs7wX405s3+qCz0g
         ghlZbhm+xpDarHbPnX0can6Hft5WXjzVFI7J83dcPuiKkJBu/MWUa38ZgRvNnwETD0MX
         WdWeU4w1suJnBuxTzyKEf17OS6nEwPR9cCdNJxyF6RGwj9g/atYkxk2cAzZbm9Ce5Z7e
         l+9w==
X-Forwarded-Encrypted: i=1; AKwUvBzR7ZPE0uJuAgS1lNIvybsgt5zp6TnBSbmRONm4Lu0w1itpSjChjG2Kw76FM5Ol9G4uintGWMhs8yA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+JhTOsePrUM3nLJiY2c6Y64cSz9YmlXPoYjSUnap3fM/b0yD2
	5WCKqX59KGIWpCdjfF/+9SuTIXazPUYuA3gXaBWFp1iab6ucb4LQt6sa
X-Gm-Gg: AYBFou3U9MGvC1kkXtTJHRPCShAyRyjU9w2eArfLQ57ko0LKraYu3DtS3m5517ntmPf
	ewPkiISSMKxM77WgIql6BUPjFW4SjY6byNNWG9HP0d9PEvO0cbgn+AQx2afXzua9Fqh4JW2Dnvf
	vI18D2Lg4RH6Obk8rXRuz/+Y/HGhDCI59WrxkOazAFh+Aksypfq7kEb9jiwh004YQfFXydEsve9
	c/MM8S+2I8lVUi8E8ak1sksjgJxNU5CPXtuCqZtzolYhbuCxnkr5tlL8lqhIJk2BAaGTXTzZ9nH
	Ad6I3g0LHazm0ijcFUsYOzOdTYHdWAudw/pUtiTXxgcjC/OQiZqsiqei2SoJY2oeVJZssCBn+Fg
	1cv3Mm330uQtID4xX8Q/XyGFCB38m9u3OV7poxwZ0Wod22wm4dkwylbU2DSH/A/gxSjTyVF4NNN
	2dcFe2gzswx7LbmP3hzQAQWtj3S6oZRYXPgIcXDa41bLNQRt//OwSMPW4rquywlJ8/cPWHA2vsD
	Zn+SWIRRywQ39cClZLD6+GzAi70i6ej0VXmgW59sIbu6/44vxaiQVfShKIoGXJHymUdlq9qSBJt
	5no63vFNVyphCvxrOYMA9xQ16T+nVczc/zrMIpTLZx2cNQC3KrS8cAniKJvFPWLQK6NerBQGKW2
	Zi2DkWpPIICuqWmVU7f8YOz7W91cDIngR+NBBAPKwv+Zhl9rWtkIEgv5gNpaqT02ZaJQtIJD+2F
	A9lRJ0jydXDjiGyVLFuZJCereuTQPTr+hpj7/usOwT7OCBvuV/SIQ=
X-Received: by 2002:a05:6820:a50f:10b0:6ff:3c41:8153 with SMTP id 006d021491bc7-714f299c8cfmr4772331eaf.54.1793695235466;
        Tue, 03 Nov 2026 00:40:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f3081097sm10520397eaf.13.2026.11.03.00.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:40:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 01:40:26 -0700
Subject: [PATCH v11 1/5] dt-bindings: pwm: allwinner: add h616 pwm
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
Message-Id: <20261103-h616-pwm-v8-v11-1-07abb59575c3@gmail.com>
References: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
In-Reply-To: <20261103-h616-pwm-v8-v11-0-07abb59575c3@gmail.com>
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

