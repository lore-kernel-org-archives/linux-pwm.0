Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000305;
	b=LJD4px1+k1oROr95RFpWmiGdlJnxJMOzmHKAJhCwaeeZ5b/Q3Ybc81eOjWa4/HdxWupe
	 0uqhwNPDBozzbqWgX7HXak93eNQEVxaoH2cjOd+vPG/hB0IwmC9JOD9sOlHZrtibmHXx0
	 msCALwKefBj/dwNA9Jaw8h4NrwFWLLXu+tBgpUt7+Ba8nQzDTh2THa9U5inU/NzkZq9xY
	 DbRHezSPl137AT0JvEIp2QxhmXbQQP9LOItkDzEZMo4GiHe0yn0i4/iu9E5TstbIQkgN7
	 iAkhlZrl49Pu5wk3OVzEJPOBgjvK/7J3puD3B4on7MCy+kolxHADUDrWPeLNp5h7I/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000305;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=bIVg0foxmqTG/8sVU2ZcbJWE1ifg0bPsxbq01Yjc28s=;
	b=VVw5f8E4H1M6QoLUCerSHRPLkn2i1BDB0fC9731OjLc5SSyn3n0wyQhbPjrIsF4z0qE8
	 1AmqCZURZqMoLLqa4Y7WQ7fmhQMxK2+K3D6NT8OYZBDV4auSH7CNrbkhA6wm7TWdjUqOY
	 QDhr8EXMAofFLspDojeb9NKlcunvGEdLq+NN75B+r+wNZae0DpaMu7kmfp6w0cQ8e5rmQ
	 myThNJwEJGp6vS2SA/+p+AkujMCpaDNiKjVzTmg9JKCcyAykeJKZO6VsLgjmAMP+hrZ8h
	 +2yNIE7crSq+14Ye9JPAiSiqCGH+7Xmpx9YmpVdVvaHWP1I4qn/FFWcNyhKk3mcuI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=3e+kc3ag;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F233606D805;
	Fri,  6 Nov 2026 21:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F233606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=3e+kc3ag
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794000302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIVg0foxmqTG/8sVU2ZcbJWE1ifg0bPsxbq01Yjc28s=;
	b=3e+kc3ag/Rpn+K1bgd8vuzh0pyJIrhpqlte6vq2e8bzai4HenVpv6KqNHMQ9R9XM9BJQys
	sIk30jzy4345bja2YgXbWBGS0Fu36KBE0OV3yVqfR00m5U1L3aOxTefm7kVbQI9Zy/uFjh
	Xegoc7k0Wc7GmNp5zp9dyfEaS3Im4+A=
Date: Fri, 06 Nov 2026 22:24:52 +0100
Subject: [PATCH v3 3/9] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
 t8142 compatible
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
Message-Id: <20261106-apple-m5-initial-devicetrees-v3-3-cee55de54b2f@cyberchaos.dev>
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

The device power state management of the PMGR blocks on the Apple
silicon M5 SoC (t8142) is compatible with the M1-M4 SoCs.
Add "apple,t8142-pmgr-pwrstate" as M5 specific compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index a37a837a4eac..451f2a80f844 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -51,6 +51,7 @@ properties:
               - apple,t8122-pmgr-pwrstate
               - apple,t8132-pmgr-pwrstate
               - apple,t8140-pmgr-pwrstate
+              - apple,t8142-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.56.0

