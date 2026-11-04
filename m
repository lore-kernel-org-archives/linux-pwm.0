Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813067;
	b=Ioeme10LL2cP9sn0zG31yGajA2vLOxw2sUQgwyK7cNf4jddsfMDZ7ygu8Tndq7xfqMg8
	 Z7JDOmREyGxpJq/9vUX+JVoBFtx3/+tda2nuMgOmJCySl42y3rx+C1GRWg73QLMkI/Fd+
	 nui+SLb3jMTzIIhYHCzoUnDtf0be5yeoCQWL/6B8iWUELSy97nVG0lmiG5CVyRj2RnCa7
	 VgzoGTCxMqWpNawaM68NXSVkQlM0vrONLLvWSSiVNgzvFpo7f1vLh9Bgc9oYC2xzw0Y+q
	 13mcS785kvjajZ/U42jzbSy08nG4DX19Q8lTtBVn5zcwi9A8/oHKGPOZGch2WrXYzqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813067;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=26RtvXWyvPMKIsPpPxfp50GdoxTzvUevSoYk/CUFfTE=;
	b=S0hB5BtmojN0JhWgejrHYdgnaF/KGKFRffdWM2OZoDwbINVEYw/CVWHLSwvh/hZSINnJ
	 IabqC7fbk6g03Cv5OMszoYE/J/bkL6jRbgNdJx8d8LhYwFaghSwUuMom1T1AGcbgRQDF0
	 8wpoceTXKOWrpCrlhdt35GM6jcjblwd6n97VAYnXAmx/ElxR47hrBWAphuoYT4otALO5p
	 HrIzpode25OHViu2eziPnCKzrzl6b8iYaFNPycwzWfmmt3MCJFczvP1ygqacvl+CRzoRC
	 Pgi+hsz6B8LfXpm2fMaZVlViUXs0b+X3QJVtq5CRCUzH9X4/ULuk+Q/1gH0gRWbEMyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=FY0vJ4Uy;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D94606A337;
	Wed,  4 Nov 2026 17:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D94606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=FY0vJ4Uy
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793813065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26RtvXWyvPMKIsPpPxfp50GdoxTzvUevSoYk/CUFfTE=;
	b=FY0vJ4Uynh/5NlYa9ooailxfSerg5egQnft3vg9y1Ur0cAr2kyOlkhYnEI2yZDHKOyldgk
	j8bQbd4RlMLnLV+KLIcFdtiNfP1xNemCeoqX8y45n0djSyPVCEwehBQpcS96miGVFI4nNR
	toYsewx6XJm33o2xc5b1d2Q56PwaMJk=
Date: Wed, 04 Nov 2026 18:24:15 +0100
Subject: [PATCH v2 2/9] dt-bindings: arm: cpus: Add Apple M5 CPU core
 compatibles
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
Message-Id: <20261104-apple-m5-initial-devicetrees-v2-2-fd727a82d380@cyberchaos.dev>
References: <20261104-apple-m5-initial-devicetrees-v2-0-fd727a82d380@cyberchaos.dev>
In-Reply-To: <20261104-apple-m5-initial-devicetrees-v2-0-fd727a82d380@cyberchaos.dev>
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

Add "apple,hidra-e" and "apple,hidra-p" compatibles for the M5
efficiency and performance CPU cores respectively.
The compatible strings are chosen based on SoC codename ("Hidra") plus
core type (E-Core / P-Core).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index b2fc99f74a15..c3cc0c48ca54 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -92,6 +92,8 @@ properties:
           - apple,donan-p
           - apple,everest
           - apple,firestorm
+          - apple,hidra-e
+          - apple,hidra-p
           - apple,hurricane-zephyr
           - apple,icestorm
           - apple,mistral

-- 
2.56.0

