Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB539A7FE
	for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681820; cv=none; b=KprLSTaVE5UIMvgZn5O9p4gDRdIlE6Ahz4fHQI3DyGkDeSnpyZCbTPdoycmTjZyZJWTjTqWvzM4hWTW5wNN1TFPm3Zt4q+uyUzT5UGNUvuIVYkJWPxTh4gx6q7x4sfZuV7klO7Uo9lhvGPzYdTuG2hm2IvyZd0VF0upGjp1f5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681820; c=relaxed/simple;
	bh=VhekGTjk/1zXeGIGbEp+mvkiBuKm0sxCLfNTFeimcHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scCqSDf7UAO0ircKVAoGMD4JTchNoLN2g7K74o7Zki/13GSjuK0pFHiOY1+H/k2cFFKDH+RTBLdYtzuLAANKO80LvNQATaMn76ksX5or0dxBwjtG3cdcUSVKKEU32ZqsgF1SwR8V6atF1swPIpiqkXzEPQ76c8s0uqgo6yedk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZco2aAJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZco2aAJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso1313542f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681817; x=1777286617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhm2GeLeG1UM0/AQDKFsQSbZ5IfXuExVpXyI9JPf4cs=;
        b=VZco2aAJ9RKZn+y48b6y5KhQxByBjuwm3Kgk7lgj3BvOUSEqQSdfWaLrzFHMuWg9Tr
         O1rg14RdAxE5MQJKSxSHVLRCP1AjPWJle962XWIHVGTiWOkrX70EvuVASDEEXtvsX3uB
         NESzrhQ8W/FvJFj6s6VbLqJh1N9t0RKlgDkL0tTVXD4yvclwoehbVClSG4NpQuHKKDp6
         3GhhIvAnNuPWRoi04UIJuAz/FdmfGCD7v/LnG2tgFRov2VTZx1KeG1/pmFzOKhbKdi9b
         3qaapAP6JgI71odqO43GtbIQ90GR8wepoEIz8RpaPEUtlanO1RrorWUqKubzcM2A9yPX
         rBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681817; x=1777286617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhm2GeLeG1UM0/AQDKFsQSbZ5IfXuExVpXyI9JPf4cs=;
        b=l33WpxCcUyYMUr9/7n7EGB9iAeO0ENC0j+pMpUoGIZwQlzf1/noEe7+GdswQano1yu
         6aEH3aV0OwmrYTeaD5WHIZBhRtxopIGTUMU4DSPPjPysLTREvR167dsKfvoO0WdeUHrb
         r8jRqLFdGWyy0rWx6jEpk+ltjlSFCHdxsqFgnHM3gnb7TriHVRhfSnEDDLw6MeoOBGVc
         opP7BmfD1Re6CMbhFnx7eeKhZSsPokyS3BCc6ry1hNlBl7Sid+XWj963bQC06YRl0rWM
         /JEgBffk01d51vc8NKwfLywUqBqNRmWbliISx5qk7xebcfN8fqD+PAzYejskBRaHfFNX
         KI1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9xf27yVfkd4psFipk7yOMiOfD5ETfGLK7JkohakSKGHCaeNeQ4OisRYy8nB5DWQIgYiZ65nHf63+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyfeIkwq5+N2UO7jwQvCj4bI6DwRMvfUv21owHPgwJWxcAGa/
	rNusOx6SqcFiuDt31UVh9XQD2Q041aLsSYioh2uszBKrCj/QBJGE5F3D
X-Gm-Gg: AeBDiesGBrNto07C5IkNT/WNTFL5X8C5w7mPaQZc7vHBYt6JccXU1Jab/Hr19zAr8lO
	vVol0AMsT7JKjEGuUpBAE8QvSV8cS9aDNQazD4Dtq9M4ZKiKo+ktbpt+lx2z/cgweXWQdbVxv79
	guABrdre7YkDo02dg/RyjzqAb/5Ml3DcsnZaXB/7NCRSiZwLr+lT35KnWdCcByKEc559HyGqR6W
	KeSPZI6AIZmgjdoT5Mm58iy3xgrNGj89IZCw2VlXMRnihepY0BOOdhSQvAbXNgxvyuGlpjLW3zg
	sYUCTYNN1kBs8ubuT5SvQvB8Xe2mNy6eUkU0O1u6/oEf45VW5ov9o0N9fMk/bxxd1ESvCoGKXOj
	+M5+94mVn7KV6hUxW/WFjAcNBhBNS3aqz1GeTYtCilw7J0vKAIKHVmlx7hstF976AAmLRZE+AGQ
	QQnMIAUyemFJ6vK2NHYge+ts++u02vpXZBMvxKFxfdjJlmaQRPdDwZFuz7VcxCQDQHVrdyog==
X-Received: by 2002:a05:6000:22ca:b0:43d:6f0f:32fe with SMTP id ffacd0b85a97d-43fe3dfd65fmr18556724f8f.31.1776681816481;
        Mon, 20 Apr 2026 03:43:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm28038301f8f.0.2026.04.20.03.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:43:36 -0700 (PDT)
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
Subject: [PATCH v5 1/9] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
Date: Mon, 20 Apr 2026 11:43:18 +0100
Message-ID: <20260420104332.153640-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
References: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
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

