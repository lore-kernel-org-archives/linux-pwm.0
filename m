Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000303;
	b=mEqXJNqKg6DsorF4KuIE2JYbrmwdJ1PCWRY0JTUxjrfBp5xZ3dqA6/6sT+XJNdN6qw9b
	 xzCdjFBtT6oYSOTAeNt4MMyIyXi8hNlkyv66AqHF6865lsT3PxfJKU71J50jPOo8V3Y+T
	 2BpNsa37dbncuKgZcG7/yQ6P78LUnp2yCmpBMFYc9pcz8kC7lI2d6FtF5jkDrAti9+PGY
	 qYcYUr6yZBDnwzJoW/ZAXJVamniwmJGKO6WhS2lTxAvYGLp1+DLj4ivQ8CNbFnlPyKsXZ
	 V1uz5ax8W+nJfkhncqhpqG2EzIJmDQZO/QnqLJ93MSgToAcWQWf7ri1x1ubNgg5ZwSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000303;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=26RtvXWyvPMKIsPpPxfp50GdoxTzvUevSoYk/CUFfTE=;
	b=CGdU8NebKUOt6pSgXfr22DUgD9axAUbm/F2qiUjFedBLs5CY521eS14LJ1hhi+wFy3HL
	 YWuJqpf2S6qPWi6jPv58PGuFrOOStoE2SepDJeQ11JbSNwdFwfGTTYeedagB5zDuNiVQZ
	 iBCIjYGFJ/ZlTUTBv7f3LI3fzGlnrIYZwbGZawpfd80tnaiY4GjbNZpEZA+8xDHnIUzIr
	 /zxTSRih0jpO5oQxYhHgXN5BdmgQeA5G1JDxGHVdGj12y+GJQd8Wji+Sz7TmdKAIpaJDB
	 TRHgfjrhTiFEjav457UVmr7fkS3hjuGU6k3HIX8mjm56Opw7ElAtjie+aBKj+LqMx0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b="mYwZ/Oza";
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B120606A33B;
	Fri,  6 Nov 2026 21:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B120606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=mYwZ/Oza
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794000301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26RtvXWyvPMKIsPpPxfp50GdoxTzvUevSoYk/CUFfTE=;
	b=mYwZ/OzayW+UVVF4NjyN2q3DDSAAX51TPZIgU+AT9L3J6O3hJ1z/rEgr9vtVbJk+h5zR9p
	dKBlDzVdz5KT89br4ld9o5yBzS7iByHH6egVxG/lS2Ipdi/JzNeC1jQ875kFvJyUNgDzVj
	BD8SXVlR9wPB5CNTavnNVQepgdbofv8=
Date: Fri, 06 Nov 2026 22:24:51 +0100
Subject: [PATCH v3 2/9] dt-bindings: arm: cpus: Add Apple M5 CPU core
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
Message-Id: <20261106-apple-m5-initial-devicetrees-v3-2-cee55de54b2f@cyberchaos.dev>
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

