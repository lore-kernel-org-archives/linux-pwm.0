Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000308;
	b=VCDf1RDgLeu7/D+cN3Uqivb2op96KV4+8/GZGWRsM5Kl0nzbUxTOq1/BNZXFnnn1MFwl
	 FJ8EDJVkaYGxSwjYV/Nisqbc0oMxrY30ulM10GZd3hn+xKiJ0BtNgQa7DfHNeQikOmqi6
	 GonlSuwWpU7S5QUNAPdVUt5B1PRi9WJ1ai4KUHqkJaPOMgjn7XeR4qcJ7I6caIw/Eo7SO
	 xnN+f023BOhCmr0tOfP1k3RzmX6n5kwRkJSfMdhtlol1/gmkf5FDcHGWXOHrcFvpQo4s0
	 EE3HtOjzxbSIiOvVGL3yuZp7wmkZND1A6ggkKVp4JPuzEI+krcy/eZ4cXZWEH/EnlUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000308;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=2AYHzRX018yeT4DRUy6H3UKeO548rYehdzwG2De2FNc=;
	b=Uwv5/6CsA4g3SSFMuhSaS3YJSkfvilMyU0p07gBCHym8gWQgwbFKaW7X9Kg9vlKOhroq
	 FVUvsZa3lWwHpQ0xPjPPy9Sv8f/eojlI99pdAZbCTvhMVJ0sSSJ7a2yAti20GXYastMAT
	 P4aJXV/nnQINL7EbuKouoyr4tEbTQ+jhoB34+7nOotyMrPNWqDg73ouH1bFRsBvNMiifF
	 xzOD+YEWUsVASnnV/X6o/uGP1KnIydh5Hr6Wkj8tW4RFfJPhir+60nn5/kLTp3TefP2sc
	 kKdiG+3+ePDJMvozCXbzWPAxjx/QwlMRgJn1qtmM4QYemdMzrx5pxMbsMkHIIlQOWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=wVbVL2mg;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDD606D815;
	Fri,  6 Nov 2026 21:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DDD606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=wVbVL2mg
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794000306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AYHzRX018yeT4DRUy6H3UKeO548rYehdzwG2De2FNc=;
	b=wVbVL2mgoH4HIUcPprPedUHGYjgprKwHDMWOXKFpW15wJdRXxXdSaoIu182S1TR4XeYZ8E
	K62B7hB6w3EKQ0XZ7guL3UyNnWq7m8IubVnsIGDsNQcJDGRJs1E5AJEaVvtGGWgfH9ovAR
	mIIG2zPAox0HcE4tMILdK3gDyE0iolA=
Date: Fri, 06 Nov 2026 22:24:55 +0100
Subject: [PATCH v3 6/9] dt-bindings: pinctrl: apple,pinctrl: Add t8142
 compatible
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
Message-Id: <20261106-apple-m5-initial-devicetrees-v3-6-cee55de54b2f@cyberchaos.dev>
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

The pin controller on the Apple Silicon T8142 (M5) SoCs is compatible
with t8140. Add "apple,t8142-pinctrl" as SoC specific compatible under
"apple,t8140-pinctrl".

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index 0984e4e58af3..13ece17eca9c 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -27,6 +27,9 @@ properties:
               - apple,t8122-pinctrl
               - apple,t8132-pinctrl
           - const: apple,t8103-pinctrl
+      - items:
+          - const: apple,t8142-pinctrl
+          - const: apple,t8140-pinctrl
       - items:
           # Do not add additional SoC to this list.
           - enum:

-- 
2.56.0

