Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000309;
	b=1hR25ausU7FerP4cBmn7DUnEjZKJnoacLrdmh/nLT1XG/YTSdSGhWjjIXlAuDh6SpzFT
	 jTcjv+AWsdFILSuZALGHZRTAA+tuIaxVwH6MmloXAzdydfZNaM0+rW3TtAz0fTpSOiWYs
	 qYiOCWfhDUPCExvkoQo6lBD2OD/0uyiVA7wVhIsYWJmShHzqbdSZwkD26LllxfJ0MAEs7
	 SPVpzqICkCa41dG+8qXoIP88k7hSV1/Hie+ZgBqBmca8l2AA04F/PBzQB2AwtRlkinenX
	 2MMYPlf0grElE/40c7mlHWMLgf1eFO2koBub5e8yfwm3aHn3uoO4ZTAbc1wvwH/ZfEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000309;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=/8PGdx3b4XeHSkdMg3JZrgGdQeSTkjaMcXJhL5UCfH8=;
	b=0Ab+u0V4XD2umNeyE9Gz9uGq4p5p3+kE62fL8eAlFdoZkldaYnrsEw4Wgf8gDlCEE4jw
	 gh2ZbFfP4BR6TvTa0CPavvJZm35C5czsX2KYd+yphARzAP9XG+DW9w5BkSU4b7cXXIsMA
	 1ESDxGlPWo9fVKaq69UBev4P90RSETJnFs7GUZx6jwCT1oJA8O1Jx5IrGKVKdq7jxnEnj
	 iVikpE6WLOapSam46zN9lexAdFi68YaInrI83tfhUvM5dMou2Bp6wbGWAT35PwMUh6HsU
	 yZs7PWaip3CtwTiv926Et/FDV/Ag+rezAhluQJZOmasmIjoRPjJu9OELqwuJVXnxgzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=HdhkKLn8;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CA606D839;
	Fri,  6 Nov 2026 21:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93CA606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=HdhkKLn8
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794000307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8PGdx3b4XeHSkdMg3JZrgGdQeSTkjaMcXJhL5UCfH8=;
	b=HdhkKLn81x9s1QHnG2IDcWuAs8jdfPSIl+gwJvS9k49diIMMFtIQHrrPejwU4l0rQDRwwG
	Y2DbgbU6fFxi5NvO4lZjEAc56JBCtIEaV0yvXOb/+jke66BQ34jJa8Lm9s72GEa1unJY4k
	NrzZAlNmzZZu9lj/p34HkZZM3Km+ciE=
Date: Fri, 06 Nov 2026 22:24:56 +0100
Subject: [PATCH v3 7/9] dt-bindings: i2c: apple,i2c: Add t8142 compatible
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
Message-Id: <20261106-apple-m5-initial-devicetrees-v3-7-cee55de54b2f@cyberchaos.dev>
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

The i2c block on the Apple Silicon T8142 (M5) SoC is compatible with
t8103. Add "apple,t8142-i2c" as SoC specific compatible under
"apple,t8103-i2c".

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index b817a8f0a9df..e7ed1efb7b64 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -30,6 +30,7 @@ properties:
               - apple,t8122-i2c
               - apple,t8132-i2c
               - apple,t8140-i2c
+              - apple,t8142-i2c
           - const: apple,t8103-i2c
       - items:
           - enum:

-- 
2.56.0

