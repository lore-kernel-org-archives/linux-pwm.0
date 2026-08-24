Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46642252E
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576163; cv=none; b=IabTxWsuIvVsIBQnkrDwvAL3pprNtTdkBOg1jn8d3pC8msk4AUouFZjfAhYdBsUMq+TDEKGT/bLi1dxboLtdSlWdWpcYLX/7KXbbt/YUcXSQEeXnNF4um9UMOoQPmzJlLcA8cS9d/KbdKQ1vMvKqY6Glq2CnUjdAH7vGwUqdFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576163; c=relaxed/simple;
	bh=2S9ge3Gkux6zzeM+n6dPsFXQ7STMFa+l1y8WPqoTfCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmXcYl7/t/FQBahNzLa+GlnmGsrCYwzj8GNNhM6nixwP5miOb/fuFmu10FrH+XKzMqNCWE46xaIVHYmw6bwwW9BA1OBBUyNkWvna0U8t6DHvOI2/pGk6w/ERiyKVo3ViR13GW6XaW89y2vN+G5/xJYvffp1vkJN1cGA2yQtvEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTBDucYY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTBDucYY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c16794450aeso494049266b.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576160; x=1788180960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEYpVaTK2qGZEqiKTNTTUd76osnkufYUG4ARHqvujuo=;
        b=ZTBDucYYPfcxo8Pw00+LOBPvusYW5BjXQXm8VVnM0MTIByWFp29ebAfW/cBnpALbza
         Cp1XkLDSUvmfQVez21fDXVRnEUzzPBH3W9nU0lbbldAUEgeGqJy4eALBVWP8hrqh3uY4
         kreA/zDNHFX8IlCezOo4ag0iluy4qZQT6hnfri3Gb51GRKluVIctfTnZg5EL8VgC9PNq
         9F4QZi04d/Ue9mDa9wD//PT2+hnR6C5Ez9lyuOkKtN5t+b78tRwB4VbnT+/XFxSN3tA8
         ssas1vswN9vp3I8gNlIsjZ8KfWD08mU/olNKlucf5MVtlik9Uwe+WuV3JIUMroTN2Kqk
         Aq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576160; x=1788180960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEYpVaTK2qGZEqiKTNTTUd76osnkufYUG4ARHqvujuo=;
        b=fbKHgCG1FkEWaxJGhNuqRPq0Boltov4+R/8bnDm5eprq8V1MvM7ncNaUA9/MvNAoDc
         uzmIq/BIyhhihje6Lf0/mK/ti39QeW8Dxxqt5ETSbH2MvbKIlm7RtSPzXBhEvscwFA/Q
         ovHF3w8U8apByJvw47x2PVbeOjdLYii3ZK6lV5hvEoC7bFXlG89UvCq/1tV1qsHXzvyx
         TIW2pBaO5dbclRTMsQ9Arlxaujhq4Q/Kn0RL+v1wA1rr3t2/JEJRXU+Uhx/pSbduXKJ9
         hpM8l0eRo/JzldEGrVfN/aYJRplxQYK8QWG0I8+MR1pTkZfEJmPozVKhk8o0Aby5mpkY
         jGFg==
X-Forwarded-Encrypted: i=1; AHgh+Rox/X0DRXk6T5C2cTyitdnPsJFm9aT2OPoA7J/enaK0CnBj3MaeNdTumYtyH/myM+ojm56PbYarIJA=@vger.kernel.org
X-Gm-Message-State: AFuF++nl9sTpJ8TOXZjgstKF3ZeFPFSeS76RQN9iNYG9jALzv1I+qKYz
	07msKRQEa1ao3VAWL5YjZRnBCe9LIWg1KMpskt0I3eYLL41VA8M6q4uS
X-Gm-Gg: AR+sD12EVHZqaWUDUZCun9fNNFKe0c4vyG0yYWiqiwnBBjFBLUJRpYHsAu+i60+Lw+b
	5WV1PM1ejw1hvU2bJemxylm8EVtv4A7KUaX/qCTrD6nBYEjFjKqMG0ri4sau2PpAV8ZreXQqkwC
	dUuQ2b6FJ+AyyfPDFTL/WuFgE+vjpv6E5iDgWSzhlZl9zFJg1bc5RcKEfT6qs6cw4sWNMiP+tnS
	nBXJxxcxTo0aeYKOsusLr/E2wrU9xeZ9zKBMMOGOWX7/MfazhfC0X4vJ/E3kXgTd8rhS462576o
	bw8LT+S1pgQFIQwDJFFd40+JLmoxM9PYDRiP0xg0Me1Xpd3L8ec7LhM1q2R7lhp+eZB40Y21HaX
	+UGL9RNyQTXVgt+ueC0UhuVbLLxK/8zDt1yO2QGTLTVRXSu/Ab6QEc6auJfl8wuZwxE0GdIwZsH
	MsufERZfeV7DmvbaTVguVFETuGhDOSZ5iY1UyYzEN/iNr+yT+DU+oYwhWSBBmkirlzufqIm4w0X
	yYqgqnFcmugOg==
X-Received: by 2002:a17:907:9346:b0:c1a:5d49:f99d with SMTP id a640c23a62f3a-c246a3ab4c2mr3218865366b.7.1787576159544;
        Mon, 24 Aug 2026 05:55:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:dea4:599b:49a8:96f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm1245403066b.39.2026.08.24.05.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:55:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v7 8/9] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
Date: Mon, 24 Aug 2026 13:55:14 +0100
Message-ID: <20260824125523.131762-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
References: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G2L GPT IP supports output pin disable function by dead time
error and detecting short-circuits between output pins.

Add documentation for the optional property renesas,poegs to
link a pair of GPT IOs with POEG.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change
v5->v6:
 * No change
v5:
 * No change
v24 from [1]:
[1] https://lore.kernel.org/all/20250226144531.176819-1-biju.das.jz@bp.renesas.com/
---
 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
index 13b807765a30..98bcde755fb9 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
@@ -245,6 +245,28 @@ properties:
   resets:
     maxItems: 1
 
+  renesas,poegs:
+    minItems: 1
+    maxItems: 8
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle to POEG instance that serves the output disable
+        - enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+          description: |
+            An index identifying pair of GPT channels.
+              <0> : GPT channels 0 and 1
+              <1> : GPT channels 2 and 3
+              <2> : GPT channels 4 and 5
+              <3> : GPT channels 6 and 7
+              <4> : GPT channels 8 and 9
+              <5> : GPT channels 10 and 11
+              <6> : GPT channels 12 and 13
+              <7> : GPT channels 14 and 15
+    description:
+      A list of phandle and channel index pair tuples to the POEGs that handle the
+      output disable for the GPT channels.
+
 required:
   - compatible
   - reg
@@ -375,4 +397,5 @@ examples:
         power-domains = <&cpg>;
         resets = <&cpg R9A07G044_GPT_RST_C>;
         #pwm-cells = <3>;
+        renesas,poegs = <&poeggd 4>;
     };
-- 
2.43.0

