Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250F4D4871
	for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603732; cv=none; b=EhC0KTBupkBZkE6r5O3fWDWccH+56eoThXFw50nFeN9FL+Gy8ORtb+PNqNW77+PmCxm+WG9xJGx/gumKNLMurtiSf4Zcz3YmoNm5fc3ttOi4R+NCKoJeSyPQu2KQ7bwolLNi5yvbMF3NvCjJAbLGPnOGonMjq/iGGKvL+PE2ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603732; c=relaxed/simple;
	bh=Go39NKKMwkuXXP/SejpjyZo/TgbX2bfpHuiP0B8nCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca5drFhgKvA6YeYsfvGFt4TsOO3fA8v6PVwxpl0MqJqN4D19HryZTX59XX2x7tqcnpCAlmZiId3R6H/Yp9mDkuMH9IlKJGDHzId50aZw8E8HURBYgtXDdkadDdf+EFYZ6R31tpufKXJBXcSEFNLaDT573lYTo4ikuAOYh8VhCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CU8BdcPO; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CU8BdcPO"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so7247366b.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2026 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790603729; x=1791208529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piB6olxsDjTKBBKWtT/80MoIuyo/txOuxpczb55KJIY=;
        b=CU8BdcPOnAMaL1BTI2jhn3KBXRlajTP5cLe0gqrnsKlywJQVurGGDtVLKcEap9kYlc
         /y8/sANIvOHoZTf+KEcK3YXtLVZEF4f2QayIk/EpwjKKCizipC9tX+YVtfegwG2yRlc4
         bTDFL2LfyhxPwHHyyHXQhgTvmtf5isgMUh71p6tvGxH0SDoAHWLIrogUvRQSQrNzEaAV
         2SF/lWKWKCiyTVdW1ptummdSsgJCEi4MUoSq56Kr1uugBZxgD05Mjf4qut5KcPxQOZbJ
         5MGHWCjYAuCgxbZNf7DJPVfkqC4TR3x4f+QaipzIKIudccS9fvr3zdKBUnJTKePFqyaP
         85Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603729; x=1791208529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=piB6olxsDjTKBBKWtT/80MoIuyo/txOuxpczb55KJIY=;
        b=z5+JuU6POsdmwbim0yaFUnzuX2TFNhHCVKoi0rmdFUkBtJ0SIoxEyCWxPo/ku3VGhY
         3J/gjnvd2NS/aHLQaBY2cHy5F1IlL4RIVNlpi4YDHc/mpkOIX3wM8mAXy40PF/44oOz6
         mMwDZgSgLKPbwecEUrl6ZD8chW7KC7Z3beIkxqtmLER2u8ZTYF5ORLX84eydrtbJfsXE
         TP/NT09K7YL2qGqAZvvDUarAvgSR7SkQSZapc0OpeIfeRlu7ge0uvQfSulqmVrEN+I1c
         YRrkEL0/GFpv3/JTMlIPb35vqJAMmIjDi6y+BwY/rbklacGAspprggqtqfAbzetVy/Km
         LCJA==
X-Forwarded-Encrypted: i=1; AKwUvBwqoo/+A02kaCx5pcmGsJwbee66Hgr0+Sxll81da0iLRL4E3KA04SoSRC5285fVk13fwhmDPzazmds=@vger.kernel.org
X-Gm-Message-State: AFuF++mj5o/RAyjTReOXNf65kgY6TYlF3+3zyjCdgJVx1t1ulAZTKnu1
	hKgCsRXIaBt2fe6SIRa6EvVdPBFO2htI0diy8jKfjXOvCZEnnF7hFE04bAHq9ss5CrFrHpwUf4D
	yjhpKJzw=
X-Gm-Gg: AYBFou3c3rnRYM1+6ibkz43xH8to9q4qlF3s2FKzWHTOViI9k9DwneTz7JDGzSqlARC
	Fm1nT19rMkajZb2rCuqDI0kFw6X375sxzkrV58Yldaw3uNchLzfXlKgD7LpvEhjOruuqURQ50il
	IJA4O6g8d69tHeet55jJ5Hf6GxLfYH7ly+r5W7uX4OSwghcf0TgEIgVH87N+T/aDYu6yNfoFNN+
	2GfOJZXAFn2Yd/aAPxRaHCSTasQiqLJ5JnTSLeuZulqUVQYskIdh19pdIbd6GsKVyo89JuS5RdU
	XzbtjQTYhflnY8Uqaa8TQbPpHYg6TyH5sbRlftr+vCPK33KeMiCqFGHB7FU3O5kLaIjze9TgR3e
	WbULvu0HvIpxzW9a+z9NlLli8+8hNzF/kx9A4EqOx4BAgEi1+ee8r85hDwB630/RcBRRy7UUrfF
	5EmOGdQmSwTr0a9WRLbcbQgxO2vcKlPuLodGTpoWZU5jTCYMMDYuhOmENTPQKm1PHrJ19wxw==
X-Received: by 2002:a17:907:c589:b0:c2d:c80e:8366 with SMTP id a640c23a62f3a-c2dc80e8413mr372966366b.0.1790603728763;
        Mon, 28 Sep 2026 06:55:28 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dde41e1f0sm139221066b.11.2026.09.28.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:55:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com,
	Sean Young <sean@mess.org>,
	Julian Braha <julianbraha@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Mon, 28 Sep 2026 15:59:00 +0200
Message-ID: <ee0aa89faa14e0073f1271693bae28678652998b.1790603500.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1790603500.git.andrea.porta@suse.com>
References: <cover.1790603500.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naushir Patuck <naush@raspberrypi.com>

Add the devicetree binding documentation for the PWM
controller found in the Raspberry Pi RP1 chipset.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
new file mode 100644
index 0000000000000..be020583fd0ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/raspberrypi,rp1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi RP1 PWM controller
+
+maintainers:
+  - Naushir Patuck <naush@raspberrypi.com>
+  - Andrea della Porta <andrea.porta@suse.com>
+  - Stanimir Varbanov <svarbanov@suse.de>
+
+allOf:
+  - $ref: pwm.yaml#
+
+description: |
+  The PWM peripheral is a flexible waveform generator with a
+  variety of operational modes. It has the following features:
+   - four independent output channels
+   - 32-bit counter widths
+   - Seven output generation modes
+   - Optional per-channel output inversion
+   - Optional duty-cycle data FIFO with DMA support
+   - Optional sigma-delta noise shaping engine
+  Serves as a fan speed provider to other nodes for a PWM-connected
+  fan.
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  dmas:
+    maxItems: 1
+    description: |
+      Phandle to the DMA controller and the channel specifier for
+      the duty-cycle FIFO.
+
+  dma-names:
+    items:
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@98000 {
+      compatible = "raspberrypi,rp1-pwm";
+      reg = <0x98000 0x100>;
+      clocks = <&rp1_clocks 17>;
+      #pwm-cells = <3>;
+    };
-- 
2.35.3

