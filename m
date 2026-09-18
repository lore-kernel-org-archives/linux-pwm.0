Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905A42E436
	for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725337; cv=none; b=c+RluZyK++Cfb89sZM6WuQoCtL0Mqe1QnXMI/y3DJ7X38rvsUuuosA8Jw56hqY+MB+yKGNQSFLycAxGbJ1ewyrl2ZF89uzVkbgtbwq/yKafR3sXreZ0COsjIr5qtpp+UZS4twh2BgPNdqbVvFBZR5GHF9vgHVUnKPghyvvfAbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725337; c=relaxed/simple;
	bh=Go39NKKMwkuXXP/SejpjyZo/TgbX2bfpHuiP0B8nCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og9gEhNVeANFHqeeeZKWLAtMTgSzjyWtpqhOUHH5gEAF9tc51FIXufqKfDChlyaoE/gY4ZyGzv/vYyrBhMXFijJLSS+yVbOD69LLHqEJV4u4L7gxjSup50BdnCVGreGBPJ2dx3X3Pu/vob1Ef/TYJbJ2AMk2Oevpb4u8bIO+iJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TCyTeD3r; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TCyTeD3r"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so171309f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Sep 2026 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789725327; x=1790330127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piB6olxsDjTKBBKWtT/80MoIuyo/txOuxpczb55KJIY=;
        b=TCyTeD3r1rWRXVHPBT/wWxFFGTMJFKpAxfL0orZq2hMkItYdl/MXae5y8jiNemT0uU
         /BXziqBLyypXngR1Cs316bM8pt00O4wvCFnQY8FcPFf02zycmwgLTK8EeDmmA6u+URGZ
         mX2utb0El90eZ/Pr3G6JYY5byU7JvtbAvEHCOuS5R4Tk9PUCfDddeQNMLWmaC/LApDfM
         6lvVidftX57Fcr2JkgkJgRVlEBA/x5d1cLwMVsJUuI70IVD0/VZK/C91G+56ZGLUG3cM
         v9x31ZSpdsexIuJrkp9tTbTZnCQsJmwPM7eHpBRZmPIp750WnA6kvwWKi37woWAG9DY2
         xzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725327; x=1790330127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=piB6olxsDjTKBBKWtT/80MoIuyo/txOuxpczb55KJIY=;
        b=uzIWr5uUHQ67EL2HMuVuZPEKEkKzqDB3uXN3rWXBuxZPZxNWXJ/S8wCN4jFOPoohXF
         PDoyWWs/GO8CO6D3EWm+8ou90uJvQoc7e8VcIYZ+/uylYBOBpBsUTqgDVc4CEFzJzzWG
         aBkPwARnHP/SelOSwKRnCpO5DlaUDjqvG6lgRD2nuiIfE7bFsaaMpiASKxYyQxEZv9be
         hdw0q98sN9xlU3mCMW0yxugYB1fPvhZP6rBrboulSPawrLsh0WpD08irt3ZzBZGXdxL4
         Va93pppiWovKuHN6i5zxOeP14DCtsnMyCsPs+hTwFE6lH9QnOOQ+7zLjywTbSaB5yXq7
         wWAw==
X-Forwarded-Encrypted: i=1; AKwUvBxaaeIrGUYf00Hh+KabE/x3EgdzDf5qWPdWy7h3G0rxkI4v0WIEMcPbMi9ZlqTFeTEiQSRwj4uf9Rc=@vger.kernel.org
X-Gm-Message-State: AFuF++mldSQkZMBBJ1vpNGp7TDZqYX23KyhlR+JJ6ZTDLGyvzQJbb4Bi
	4q4F8ckyIl9ynsL5n4Rdm3LNDtkoeDsN8pp72TEOD4nJJN75S5mHAWN5ATKGTyUa1kQ=
X-Gm-Gg: AYBFou3slr2CbbssoGbr/9lZWXujlOlDLmnpj1QDWIdDJIcei2PZr5LGJjGmNXllKRs
	erPxJ5ia/Qfd5DXjcFBZzovfGMnbuS7WYwK27AZcJ3cuwbVmqbXPaDwygQyAStm84Tvk/isQs1F
	UltKm1mVfbaRc3shkDIfeiiA/COMiYBCMdQ6EJv3f3V9oE4/1Dss/T+h6MltLvNnUNV8PSjVDKZ
	cRc/DZw6rqRoDoUQlhDbbUzd079stqk5dXzhiQBf0PJwFZPOnQOYsLRethoQEJq8oHVo8aL2EHq
	SJC03/6AXaMiVt4vtv9ivspK8Vi7AKv7+tqA+7QkaY+NclyOPGb/CzXmoIVIpscIIXWoq3EPPpB
	vPItfS0X52Js1CZ6GTF2byywSInIVUCJYS51LirwdMHFeSZL86y+zq0ZTqm3stl1WnwlTwXFPPw
	rIq0th4qu6R5x/ip3N0szA5L1dN1b81DuqpYZqMjbQJTeBwtf7ZECVDjkakiYPDmR2t7srcw==
X-Received: by 2002:a05:6000:614:b0:487:fa3:764f with SMTP id ffacd0b85a97d-4871db0c610mr3127079f8f.20.1789725327020;
        Fri, 18 Sep 2026 02:55:27 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871ff3a928sm3077276f8f.13.2026.09.18.02.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:55:26 -0700 (PDT)
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
Subject: [PATCH v9 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Fri, 18 Sep 2026 11:59:00 +0200
Message-ID: <ee0aa89faa14e0073f1271693bae28678652998b.1789724999.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1789724999.git.andrea.porta@suse.com>
References: <cover.1789724999.git.andrea.porta@suse.com>
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

