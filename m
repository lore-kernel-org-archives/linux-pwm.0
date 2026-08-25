Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DB48B39D
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672942; cv=none; b=tHHHXST4TAlEocTO8Q0uikuun8ECP9dXPL5oXYO/AbwEovG5ifrfjunR692u9FiWcmNU6c4m1JOB4DDYdRyVU++jm1aTvaaNtUcH/K7bcMLO24jQ/COIPP+3Eog1a8yd103NzYa6UYpWO8y81eOp3qCenwrwXPEOPWAaGuIzclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672942; c=relaxed/simple;
	bh=Smy6j+jvyzcjX3oQa5z23WouidnyYH+/yVbzp6giW+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkrxBsG5L24hhLl+k17RzIfp9j1Jr6ZA8GTTRs5pKqcil+4c9uoQGasSkmO1VwbxQpCBXXuaECAklbC8zDrdEKU/VXeov/+t1QVw5MfH88hhYOXUa7yRYcFhurnppKv2iNvL8zoW7T83LQDParVtFLGmYtLrUiX/kM2j+FLDeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBj+GSEV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBj+GSEV"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2074710751so900196666b.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672938; x=1788277738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L41oBJgkTA0hJ2K5fg9Bazx7ynuYkWueRKGvRCk3LHs=;
        b=WBj+GSEVcTcNyakwEAt8Xv5LYvjPfXLf7GZ23d7z1U8c1btd5dOIX3diXN5IeFdK72
         +5htTRyy/7u8dMZA66tzJmJs5wsiVmqWlxfBLSUUeFDAl1RKOafMmdcKMYbXpW9+j0dC
         hPeZVni4/GCXpKSi2WvOfiByTW8ya7aK1nYyntV0U+b/P621ktJnrbVwat7s166JnIam
         WPa8e9Hk8ElktfS88PeiKr2YhwMPjzcf7rxwfQwTjssFznAORH3Rqr40U5HC4/EUQ5IZ
         ec3D72JCQBrPtf1T+oZKmyqWN1ojMQhV7x9lD3u5xGm5RmQbv03tLyfbN+i652iFtkQo
         /LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672938; x=1788277738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L41oBJgkTA0hJ2K5fg9Bazx7ynuYkWueRKGvRCk3LHs=;
        b=HkAw76l5VubfvsjxBE/UqtRj0sh5pyiNIcmS6VYsb9Lh8XRLBzWAwtPRiKgG6gNQ4F
         LbY2dsAjMiv/RqCosbnAdbylCOG2LcoWwbl5PYzoCuCXywhG/HqmqJSBtL2Rrd434fTp
         vS/4kKh5WuPvl9JMaLpwZh8zPVcFE9oF8Zu7XZAY6F0cIAID5JBooDpLuCJzj0272sNq
         sDH1jvr8pCvBsNBw9YkmBn7K5MONwvdiJ4Hza/iW1yNGEge2G7fJ1I0rz8glX8BvE1Bf
         ttFri49gYreCbY2a6+PlFyhFrmvKRHhbX20SVNoGorCgVFNN5XQFYM131ezGOFkKxinO
         iynA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+ZInMNT7gI1YWI2h8MiekaV+8pAIfXwEbSxo3bGAT9n9i1cCuWx8aCl+Vn82hlX19A23RyB22aAw=@vger.kernel.org
X-Gm-Message-State: AFuF++l493CVHHwxdrWheeaA+b1hfKkne4T0Sgdu0dd73vDlaIZdHfKo
	kaUoYootA6j/Kk2dR5wvGuq2ohpkzFJCEQxesHo3j5KGU8HomSNLgqiv
X-Gm-Gg: AR+sD13p0ncMlK3LZDDdTuXLd6QGqKPKU3L+1IMKpBrOUP6VR04puxmi/QeEaj55Z6u
	KNSX/kUNctyflOEX5AcJNSzuL9+S3H1jeU/52gfQA7Oozuo+aBuOmrrnzku+LA1359pAqg/Rsl1
	OWDBg097QCje1jzq/gGpyVwAQWeFOjtQQboOPjTbWao+DmC48NzuhgosM4SRyvgwpifc8Wk4OPP
	6OMUjPBmQ1UR00bS9tNySUEcL03CUgyVl8EdmmzqyPac0TVDX4DhswYPZjzwrs9DTlLXdBSoWVl
	nvaL50gpCTSQ2mu01Y9BDN5pOTMpYrw8EM3GUEYBPTYRcM78raOXYUUnqdCjZHk4nfyoDxSAwa1
	eta3mGVYd6H+c+4yI05IRskberHxwGz2GlAkC4/ftxff6P6DFWU0jxbHyp0c7w0m33dkmDmdtyf
	93Ck2XIF3+WhWRUjLllZcjBwNxbAQukR1ffMx6jSw+2KEn+LJf1QlX3KyQdv9v+q3sH2zBK4GAV
	sKeiLSYoPrw
X-Received: by 2002:a17:907:c8c7:b0:c24:680a:1c42 with SMTP id a640c23a62f3a-c2491c9a6eamr3228063966b.7.1787672937652;
        Tue, 25 Aug 2026 08:48:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd69asm16682066b.18.2026.08.25.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:48:57 -0700 (PDT)
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
Subject: [PATCH v8 8/9] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
Date: Tue, 25 Aug 2026 16:48:36 +0100
Message-ID: <20260825154847.197948-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
References: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
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
v7->v8:
 * No change
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

