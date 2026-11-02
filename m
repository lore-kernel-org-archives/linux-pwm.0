Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650484;
	b=qjyjT8lcMcDekun4RQhWB9bhpLMFrce929p5zjp92CGBDtreMh4R63fx9wgc4sHL/rbX
	 hpfTAOsduKOP4mNM/vDIpfRt/s++GgI6oWfy6X1FBimlA+RoqISsMpy3DDVWrm+aDgLMz
	 GIqlxhvLzQktucou3BRD1ho9FBJXlmrAdZlM+G6Hiuoyj2QT7UoQ3taJQR+lvc3vmzPv3
	 LWRFOpXWl3WYn3PU1q5uRatCVLnj2wCTFtECow5BAgfnmhCt0WihI3TOUlIEbFPwQn5W/
	 YUsuNEd+Nmx3rIBg5FrUEOgzj09TTm/qYK4ea+asdsjT0B70H+3QhC1DGst+0mrkicg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VJpG0KekBa/NY2yha/o6EWqyLiVRn3sfx78mJkKNt7k=;
	b=CoQGn4Y+x2/lV6n85NJeYH2OApho/0mq4KDIU+RT+XWgBEZNy6JKXAoU5qN1z+s4guAr
	 Gv75eyHKqOpxrmxlmsuvjJbxCkhQ1iXAM6Xfs8Z2R5ZkEIWV7/l9IczXHqq27v9o+Aow3
	 acxe+dKwMK7RUXZSRE7FT0DbFBIxuqBUvj3DptpLlvY+fqamd9remvMY7RnQqedNU0dj2
	 YD/PHbCmoCC0SZlf31k4KQGQi9uqH1TAd3JESxaAXTmmBJPLCh+7ziGxFzOZZgUcKBNZE
	 /2/rS9tywIJA4dWLDvNVjqRVbxo25DjY7JcuzC3b5t94/RZpha3MunRIhIxYomF/t+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JdfJlGfz;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EB606A336
	for <linux-pwm@vger.kernel.org>; Mon,  2 Nov 2026 20:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 880EB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JdfJlGfz
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d05d51553so22174685e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 02 Nov 2026 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793650482; x=1794255282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJpG0KekBa/NY2yha/o6EWqyLiVRn3sfx78mJkKNt7k=;
        b=JdfJlGfze7wgCvUiIjxkJp5J7LkEQXr9SCfaD7lCrcEwTnSqiV6V/Fgu59HmJ7yPs0
         LmHn1MKW+31ahNi6cQvICo99kKjjHD7tkTlbGtAyiuIRxhYyghB4bco7AjcWD4lg5O7F
         OEos0sTuRA9Xpe0Qu8B31IXVmPg4mV7SsZYGNQyZxGk7zDu7zffAcSkfy45wpJSypm+x
         mi62d4hyhN5nL6F2byc36z2JH6KJuEnBFmSvppDy/Eg9D3X1SwFQHjLfrlaXAQpQ+Uii
         RlF0Lj+LsDJc6WiBAH4tKGn340mb1qs3j8ZYC3QqGO7htcb2oUhdbtjwqUuZmSC/AsXK
         9beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650482; x=1794255282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJpG0KekBa/NY2yha/o6EWqyLiVRn3sfx78mJkKNt7k=;
        b=yHTrudr8BEuLKm2dihtmfPryprZ1N1EVAUUgFlxiKNsuRTgR1ONqIFbKifqQP6zioA
         6bQJkmV5wMdZkzHO7HnI9kNspN6i1v9VtJeoIzzSq/Zhq2GYAe27Ya50LR015QI6fkG/
         Ok/lAZrwycfUF98jotEnJGu0bOxAvybufyh7/nuygkHOqyMGlxNXdg2uTn6lWZdxBc6c
         V/S+8YNY0ZUdG0V2VsDwgIMXudMGvIfzuZxq7/R20DYaeeZZVAOBWNFzGFNj9HF2oIAO
         EDKqTMm/7YjXy2685Bk4XV7XrPdDyBfha835XGg5D4Gw132+TAlE4gnNXw/O4Vpd0LlQ
         stfQ==
X-Forwarded-Encrypted: i=1; AKwUvByvpJHlAhWo9Qdhr+k9K8wyiDKw63Cgdqc/0QiiX9AjAdOHTMvHCCBNS7vfH4OGrv2QocYqL/tainI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd6nYocPqEveE+pGYQQq58Cpa9KsnfjnJDHlP82XIIbzA4j8Ct
	NqDB7t7oq07s+rIsszUqJ7w002xu9YFiDqbg6pSFv7ak3agNWrnOwrXEIrNHqv3G26E=
X-Gm-Gg: AYBFou1v88SSGiPh3IJTzFA0h0DEG1MgSWFAPzAP+PLQTAdfG8iOnuMmPGmOv6b3eFL
	vZAayDBgglmCwCvLMK3JHATMKNj8pHoMSi006kPDiIYVSJH9QMLX668ClDI31gztEbVbhq74w8L
	PfDcVR5P8AprkUUPiCJJmisAf+zccyH4GsT2IdgP/o9SIPJZeUhDD4FY0+o9nsflsPB0CVgORhv
	zvCO5l7iVE/36wyUqmMjm9EoDrpukxfpRXTVBQDMAPhqE8j0pymGl5nkBO9oKC1kCL07BG7N9lt
	kzy4V4tGGTB4FPTZD2U7cfNH3AW4P/Ez+TU8xaxuqSA+J9Ql5fibxU0SqsJEF7FanzVt92L1T5A
	SfnyN+u74CEf5D/ykE7k32PCM+NXiIussiL/4tgR+ZDOFgwvo6KUVLaTa1v0TN1lGw7J7vJtVBU
	YnExeZvKe6wG8xyZCjuZd3hvPlOAJJAvbhZOlHqhLYXo7l9Y+uHeL/qCCg1y81IqpJIjlbohVqC
	riuI4CHosiakNATPMfUvOM6kKJUsHANgVPcBX/nWjnv3vjgZU7SN3Hq6Wp18hqpgiuJYGzVM5x0
	Banceqrrvwy/l4FBDD8G9VayurPWeUAFX96uksnm9Ddib+RKXtLoAwJQ4EzP
X-Received: by 2002:a05:600c:8b46:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4ac18c73238mr261757445e9.33.1793650481932;
        Mon, 02 Nov 2026 12:14:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6412:7406:ded:3229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60bc5sm9559305e9.8.2026.11.02.12.14.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 12:14:41 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: pwm: Add the Ingenic X1600 PWM controller
Date: Mon,  2 Nov 2026 21:13:24 +0100
Message-ID: <20261102201325.29507-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102201325.29507-1-olivier@mgcrea.io>
References: <20261102201325.29507-1-olivier@mgcrea.io>
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

The X1600 has an eight-channel PWM controller of its own, separate from
the TCU timers that drive the PWMs of earlier Ingenic SoCs
(ingenic,tcu.yaml), so it gets a binding of its own.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/pwm/ingenic,x1600-pwm.yaml       | 47 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml b/Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
new file mode 100644
index 000000000000..3ecaa92a5ca2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/ingenic,x1600-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 PWM controller
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The eight-channel PWM controller of the Ingenic X1600 SoC, separate from
+  the TCU timers that drive the PWMs of earlier Ingenic SoCs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: ingenic,x1600-pwm
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
+  - "#pwm-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@134c0000 {
+        compatible = "ingenic,x1600-pwm";
+        reg = <0x134c0000 0x200>;
+        clocks = <&cgu 21>;
+        #pwm-cells = <3>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..c905aa13bcbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12878,6 +12878,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 PWM DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
-- 
2.54.0

