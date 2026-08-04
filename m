Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120143F0A2
	for <linux-pwm@vger.kernel.org>; Tue,  4 Aug 2026 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878862; cv=none; b=iYQNIrXDCW1f9RAjsJVpefvyresRchLUU5mf/CelMQy2C4k0oJ3KZgYY/W3TroVF/BWom9N7G7BqR71Qu3/b/TurZd65BfiGrNXhKpA5V2zat0rgflbZDv5nYgsRs4T9g1JWJkrXYHVLD3Cc692CEypjnYSMeyyuHbSvI7d1tNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878862; c=relaxed/simple;
	bh=3czOY9Okboe0CqTWBtAucidFmXyF0lxRkuvX9UtfqlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtrOvgf930ez1a4CdWBChrB366qxY4L48D0Eea+27fkCqOH4DsC7o08XiJsv8nL8DRysRzycWwN8UDMsE9g3B9D3pW4emJQtQDR0TLXU14UhcoWUrBWnmmQlbutRZCTEOBMDlBbFntbaWrUZgthHLPp8Ji5SsgFrjQ8HW7lDIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3RY14Yx; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3RY14Yx"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a40bcc8d69so215524b6e.3
        for <linux-pwm@vger.kernel.org>; Tue, 04 Aug 2026 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785878858; x=1786483658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JzLX9GA0PMOy5TOxJvHxVnH9yoPV2TfmIgWpC5Rtigc=;
        b=X3RY14YxX7Eq+p9uCC8u2F6E6lqy59LWRP551BMmOy4jRv3BZHNj0b2mj+yrwa8XbG
         dJytdoshunJRbWHwImtBD+eWuLgEn7hJRCqCwwARWfJdWaBOSg7sP1e7btIJUnl0t2MC
         7Rj14flg0Zf5aETVf1Qb9CBvHhXJUNOeFQ+g3fligUkmHidLLFWNVCU5L/31rCwHFNIu
         qm4a7LQZM38jjC8inpYaTq5alk9mVv/zlDmAqeZifJqZGCAYRiRD0DSCp2/ygyXJQjQo
         tTGBCcEXZMNdUpgvzlsGwk7F1tPKI993+vj5VUGw0LDvB+2MsJjvyWcAhAfHrqWfkFeU
         C1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878858; x=1786483658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzLX9GA0PMOy5TOxJvHxVnH9yoPV2TfmIgWpC5Rtigc=;
        b=K3/LO/cfdq/7KFPGupP+UTlp1gyAcoaGaShWUKPdCLtPyi0+mYymK7iKRL6iT3iiak
         hSj40K7gURUDagtzEvu1gR6LQyg6t6/N6q+bDxF5ZwtxC7DLxok7gMYO7nR9NFkXoqMf
         ATJtnv7lAD7k175wnEgFsJQ5yPv2DB+YUjNgsh7an1i9MdrDtrr1fS7onCmT2AxCTjVg
         MzP2erXaY7LDTyTneFoyQr+GKX4XVliREwKPavAjl5KPtgkve9r7e2iqDZA9kpxuWZVm
         J9PVzrOAK7+SddFlez4FPLHx7uwrBAVLXjP4sxOknslXEM+mE6W2NrL2mUisdL+dIXeI
         rI1A==
X-Gm-Message-State: AOJu0YwfzWJgRrQlewVqkAeaAj4Fsz/X8BcRuOAqfQtL+JCZj8+I19wg
	EYYWvVf0u0sXCE6L7U7BkAhC7bvn/Ds9G0LNrzhgjeKXMco3qaIhpMJl
X-Gm-Gg: AR+sD13CUEPjPDjPHOSx9a+6mreDsqjPhSSRWC44p4WcAgtt24ij/Jl1O6XW7i224Wu
	JytHpEoy/7o6WU6yU3yRe4YyVze/vpDI3WAr+kbGyfY61rdd26+W55JrD+/+aE7m7Iv8CNZoXzu
	Mof6Lq9dx8S+19+u+CsFYkynH6sCz8Bj2Kq90kUGbntxKvyETzw1hVAPyrneNK5IMnZt9bHywvX
	IKgr1dpyJ9NRTObRiTrUs0fKFljlpoZk7x3pffyCfsIaje01BrYxuszOiq9MmXHzmlLoazvm4j3
	jkN9iAti6cUAFA2KlsxKl909/2M28dDN4fnp5sKEdfQvshmYJBaFyXsST3NuBcBFj3EjPNKypOQ
	ebTNjXpx2zVJlntz7MCS9b1X8K1PvwQ3EFwbdG2+ahv21ApcKwLezQ5/ADIW4GHsEYtFZR7QOeE
	iIz8f6Tj82mQ92MgTMTnAmKxfMjjCyCT1zTeutbtS18lr3k4/zhDooAc/bC6pLSdGBV1cfuM1YI
	SQa6k+9iHvshTuv9AJQnv16bjx4ITiKfjE3u22Ek2yD3q2/N/wSnItIxtJYCs0fl00oCJSC18cB
	/BAm2u+a7dAikN26mXFG6oHXWWLJUGkb5ibjdc9yG3h0tRp7Nb0xF0+owJ94RPtZ7L77hkfyaur
	+yl9TBypBW4/tCgBGspWMIFsim0hk
X-Received: by 2002:a05:6808:524a:b0:496:11f1:f2ad with SMTP id 5614622812f47-4afadd7f963mr1120843b6e.6.1785878858060;
        Tue, 04 Aug 2026 14:27:38 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae7c50e9sm451659b6e.17.2026.08.04.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:27:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 15:27:24 -0600
Subject: [PATCH v8 1/4] dt-bindings: pwm: allwinner: add h616 pwm
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-h616-pwm-v8-v8-1-db37ab8624ae@gmail.com>
References: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
In-Reply-To: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Paul Kocialkowski <paulk@sys-base.io>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, 
 bigunclemax@gmail.com, linux-clk@vger.kernel.org, 
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
Changes v7 -> v8:
  - require both the module and bus input clocks for H616
  - require #clock-cells for the H616 clock provider  (reported by Sashiko)
  - describe the channel-indexed hardware bypass clock cells
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

