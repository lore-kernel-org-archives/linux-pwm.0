Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416661;
	b=rQi+hTwOpxkaSHRtxTEIHRyKM1iaGDBet0SQ4j6FdQqGXygu2b7zmblnhTA/FirFbJh8
	 cazaaQrSFCu6O/Tpp3y/TtxVQLzCGTiF06KlJYVa5nwWGl4zYZ3NyzcTpL43fV4L15Atf
	 E/2o1NtErPmk5mciN9JBi6QpwZ5I8kEkBjc0X6n//bHg89Vqn8woFUkl4IrAu9BmMOwmt
	 K0JhIKGDgwfE973VFxCZb0ibRxIMYMGq2IarjDwkL2jUwcA0ttR8KOoW3/g23nXkcVFR9
	 F/fkjKYd79irS2ys6hkksWsBoxZzVymZ546DwI03QShhlAgtnKMIws0/h01T3DwGHGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
	b=aUWDrhLAnE6YfnerKZ5JZtipo2hCru4FHi3X0yRfPNI1Qt+4WpCj8hLlvr//ANsqOSSX
	 yD/O3TldrPI2r5SeQIgSZBczo/S0HO5xhAyLxr6HwpVgf5iC3rP6ANgAK6AjGfkx+XvTO
	 eDSamA6j5qMdp/1+D3QVnKJm3buGLrasHcOxhv5448ay0pJweR4L9CpOZb/H51MYbOrhH
	 LAuH26LzyTjlhB7007RX0mq2QLkSs4gH3o4RYsKYHw0QvjCw6+xbiQYMxqGZk0MnHsfA1
	 PBVPo8L9PoLBhQxwUDOa5dGH3IPLJy58jbj+Xmpk4tRb5oqbfCr8EHl1OzjvxfnwOfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osGx5X4K;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F0606A32D
	for <linux-pwm@vger.kernel.org>; Mon, 23 Nov 2026 06:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 883F0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=osGx5X4K
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b4021b572dso1857168a91.2
        for <linux-pwm@vger.kernel.org>; Sun, 22 Nov 2026 22:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416660; x=1796021460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=osGx5X4K+tP+brbe/Jq/ezSTXsZfwiId4NNXJrH0yADP23Nwe39iKVSJ3IkHvvzLme
         TQNQ1Xc4iwc0emV47AeRD6FP4QvRsBCMQGp70itnWisvAsmXACYqaG6etG2T4kLqqtlW
         fQS3vm8BS+m5fBYIC/rxNAyOeaQAwb/zsVfEd6XSXe3ANb2Cuoac1lQowb99dCTLmgeI
         2RSHWhc83UwWAhymEhfK9EerVVLUqnJ4duhY7akO8IK/AWiq+gCrciRbxOoCcidp//k3
         1SLxZq5kUR3GMKXa2nM1cAyYy4+/VS+ApvakJ28u6hDof96f+u4v1dfpzMWK1lDZ7vd1
         K9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416660; x=1796021460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=sLEuQfWub9p7yEuasut7j2dBu5p8CvQPyM+1XJCkVO97kCBlnYnTDteQZVRtwFphal
         1hq/yz8U6FMgYje5+gW12bJDjKiYjn4TESLnPrUP/+nQ/reK9I9fqLUBKJgJQVkZq3LW
         gxA+ifd/UjN4Mz/fqP3IwY34rDoZ4KoGdNj1TTf95iAe6eE42DZE1PcXAjjV5WLwi6Ne
         /XZhlyQ3+EbWEVWIlQ9GQN4C3plndB2ewQaivGvMSfsRC2w6g0E4B9GZjsU4ghU/remn
         YmuyLFdk/Glt/jLYlZGCn/LoVXF+I05RAmy7mSph4nxaHYrg+xlomwsFC2zBeT91K/iI
         xilQ==
X-Forwarded-Encrypted: i=1; AL+hErHB9r6pudATf2GBajwKqQmWscDcCKYYTLQLZNXDQX9VjQaYpx8A9Sv0zEwpCZwQr7/d4MZXcZG0m+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bO0c4HLQiIECEMMe5wa0d1tXCvIg5IYHDTgwTtV62AZFgR6e6
	6FF3T6w6qwTFT/7C6kr6GWd+SW8Dyf5VIiluJPAK7VraWqWaAjWWkW2BpK8+nQ==
X-Gm-Gg: AZFdTZdobFImGybPU6+exrAHtCcdlV9DHAJuFwuXjrKFomGL9LfBI2HX0UwySo+B52v
	FaMOfC/HNMqS0rwnmkkaYgOkMS7zl5VGBKVMCnC0R9UJL43rYoWzAgoHx8lxUYOcG/P4iJFipug
	dzDVkhikZJfQLhhey0v0wAWNeSYPi7hjgku6a+pj3d0xMrhLUDvigytTGUlhI08h8qycXioiTrx
	C3+jsmXTvHeRo82SwQpHq3EqqOVlkgzFBKtAYCniXNh6ZXjk1DZSc6gFnV5UjZx3OxM+2OkluMn
	rp54R4jNK6aFBH81TzHfpEU/Pne9nc9bRk8ua08Ng7zSZvROP3RYzBlYojXSq+RL2ZtoFb2vcEq
	cPpWvPe5QYpyfqPNiufN+LR2iyJbcBVIeRYiPXw59VZImXAkh79eojILvfn38aiPSBzzp4Mkojv
	VlYU1Gw9yByeNcFtdocKQeRMeCcHss4+4Yj+xnvjy93ZGUJmDt2yvUSFTR/I2XiEiwR77Mm2SJi
	PQsC0OHmZHoGkG1uPz1IibduNGdgvPDjm002GryV7SEaqbifYWWkL/35089BWJuq/PiMccQVGcF
	bC6XUMYKgO0kV98qmieHO8KgPC9gW8MPG1+YC1hFBQJDlBc8zGH4AvF59qOzqy/fJn8CxLiRekp
	YVxLIgnmu9CCdEyg=
X-Received: by 2002:a17:90b:2ec4:b0:3b4:1934:721a with SMTP id 98e67ed59e1d1-3b41c9613b0mr10185031a91.60.1795416659799;
        Sun, 22 Nov 2026 22:50:59 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm5224811a91.9.2026.11.22.22.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:50:59 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: pwm: Add Nuvoton MA35D1 PWM controller
Date: Mon, 23 Nov 2026 14:50:05 +0800
Message-Id: <20261123065006.28768-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261123065006.28768-1-cwweng.linux@gmail.com>
References: <20261123065006.28768-1-cwweng.linux@gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add device tree binding for the Nuvoton MA35D1 PWM controller.

The MA35D1 PWM controller provides 6 PWM channels and uses one register
region and one functional clock. The binding uses the standard PWM binding
with three PWM cells.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
new file mode 100644
index 000000000000..47a59bdd14d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nuvoton,ma35d1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PWM controller
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pwm
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
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pwm@40580000 {
+      compatible = "nuvoton,ma35d1-pwm";
+      reg = <0x40580000 0x400>;
+      clocks = <&clk EPWM0_GATE>;
+      #pwm-cells = <3>;
+    };
-- 
2.25.1

