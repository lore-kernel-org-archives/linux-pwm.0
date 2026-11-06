Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000311;
	b=ZnH1oYUkYtzNKF3e0r8/AAtZJYUoNEXvGxhSGYILIvTpUl0TeXlvu38Ir99c58HygLBR
	 66vOt+OIXYcJUN7gvJmJTTkFvxo+B0d2YaLaRGzrrkgZdGYUJHtvs47hIwo+gJNhVIwK8
	 laxDS9hh7nSOERWxX2OWv+md11MOEbkS+PNM2oLPlITnN7sTDl0HwCmJRWVsHAVeFrea1
	 j8u5cwHXx+oEOh2LQrDEzZ+IrNaZx9QqQVpEluQy4Zz+bLd4jmlDlEN328mUo2A2CH5hS
	 q3gtC5cGnxafXjU5/GlHtGMYgRv5pkWpXdftQRGCmD6FeYGdiRHJq6HcuA8Rj/hd5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000311;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=FmFhmHqchVrqj+0DB2A1OfSUsKoVGkJJrNsEk9xPgCc=;
	b=pi6xUO5Xg5QNFqgixVO++wj/lZ3nF938lCIHag9w3yAt88xeaaiFZhMkcwVyt7LNTTAf
	 BJLR8vLxuoGX4xTABfkUY9KH59tVzGfdL9svj+uA43PDI//Hx1tJLEOLHvyUXPaiiN1Y+
	 Y1u2kZOlkaolbc5KSe3H3hfhravkSRU6I5AYzIrN9sDy8OWtuCBCkR9avwKMelt2/pEz0
	 rJ1GK5tyI433sve2+TwTN0AMaBpgg2qqMTOg20E+72rorAVEsbZJn8EGqMUEYX6Eg3Om0
	 DkkOz2hhVwPoyS3EWo7hrW3QOcQ+JZlsWAPKM4eCh5B0oclesNod9cuu9EpbXLvk0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=3CQlsABc;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA71606D804;
	Fri,  6 Nov 2026 21:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA71606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=3CQlsABc
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794000308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmFhmHqchVrqj+0DB2A1OfSUsKoVGkJJrNsEk9xPgCc=;
	b=3CQlsABc/M7fJT77nzNv+Yd+dYK9FHTMMZI6rXM3gPpojUfLHV0y1h+yrUtC6Sv1WvFCCZ
	v4USYsgmHD2fochuTUR3O/ZRDUE1Q1qM8zIqFoxLYXYtOAe+7ySVW46/hb7UDDAFdGfKhK
	bnxM2iVMamNsv36Xs8ZqGBFrQmjUn3E=
Date: Fri, 06 Nov 2026 22:24:57 +0100
Subject: [PATCH v3 8/9] dt-bindings: arm: apple: Add M5 based devices
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
Message-Id: <20261106-apple-m5-initial-devicetrees-v3-8-cee55de54b2f@cyberchaos.dev>
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
In-Reply-To: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Yureka Lilian <yureka@cyberchaos.dev>, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Only the MacBook Pro (14-inch) and MacBook Air (13/15-inch) were offered
with the M5 (t8142) SoC. Add the corresponding compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index da6f043ad07a..f78c89780355 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -116,6 +116,12 @@ description: |
   - MacBook Air (15-inch, M4, 2025)
   - Mac mini (M4, 2024)
 
+  Devices based on the "M5" SoC:
+
+  - MacBook Pro (14-inch, M5, 2026)
+  - MacBook Air (13-inch, M5, 2026)
+  - MacBook Air (15-inch, M5, 2026)
+
   Devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
 
   - MacBook Pro (14-inch, M1 Pro, 2021)
@@ -364,6 +370,15 @@ properties:
           - const: apple,t8132
           - const: apple,arm-platform
 
+      - description: Apple M5 SoC based platforms
+        items:
+          - enum:
+              - apple,j704  # MacBook Pro (14-inch, M5, 2025)
+              - apple,j813  # MacBook Air (13-inch, M5, 2026)
+              - apple,j815  # MacBook Air (15-inch, M5, 2026)
+          - const: apple,t8142
+          - const: apple,arm-platform
+
       - description: Apple M1 Pro SoC based platforms
         items:
           - enum:

-- 
2.56.0

