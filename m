Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813071;
	b=AuROrcQIO5P+QEa4RPfdoIptvj5eLfTB3h8O/dALZR7u9+MSpKeuwG2QrkyoSGfTgcvR
	 tM7HylImRWwDp6errXqkvoDWrbTsHXbVZ43WhG+qKam8jgoI3wXa+Iib5G5UdR7c6X+vb
	 KzzrZ25N4F8n0MYHVHXs9jn1RjI2eTRSjeTZ7xn6VFMoJOAVl6eHzhVPCFLgsVQoJOwph
	 SrpiesR+jr3cHqQtUuME25mUKZGKqitjdyZYMP6HwiLQlP58TT9eEoJVmGW50IgClT8wU
	 v32hxyjPQI8LxO85gziReWuorYkoLQW3o133yuaN04uhfZZDlmLay1kGrIKPSl+HA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813071;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=lXroUYdDolHv5lN9NNHseRZOE3JAoYxuFQHyAq1l5kg=;
	b=Pf4BqFziYDoyfXjBYEmbrRXigtfsiBjVDUWPoKFe7ta7ydQLa0YdLIe12cMLhuFYvS3j
	 oT0dmVFocZ4rIBA4JQFR5IJOa3tA3oEKcoguKVODUcswKYpDdZfu41gHFP2Nlly03ffMc
	 hR93Nk7Ni+b6DpQS/KZAIBftNjUuHjlBX0zxe1+EPY5Hx0ZSwptlCarJbEjX8aOBuVKBt
	 Y6tZO5p0sr8n11FE3o86dVBx1JzoCCLki8T2rZObQpOZ1m0nyvbf6xEmz9MR473i2qwmN
	 bonsMPHAiUVdIjT+TxUys9M5ApNUA0E701JlnXBiKPjxfGmV5YpV2mTO0/TS+1QFy8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=DJwpMKdv;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0601606D820;
	Wed,  4 Nov 2026 17:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0601606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=DJwpMKdv
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793813069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXroUYdDolHv5lN9NNHseRZOE3JAoYxuFQHyAq1l5kg=;
	b=DJwpMKdva4+LvkjgpVco78Vvg36/plBKCLnLJqrWhEDLgSYMwvncg0riXhVwCKxOFDH1uJ
	sXajS54WD3qTEd5VmJRNfO7/COvzYNlYjMQCtxcwIeHo/GIb/eWfN0nLSmqvJVvf+asm9T
	Y7JDOXQl4T8MjDouNJz8sgsyLO+EbkM=
Date: Wed, 04 Nov 2026 18:24:18 +0100
Subject: [PATCH v2 5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
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
Message-Id: <20261104-apple-m5-initial-devicetrees-v2-5-fd727a82d380@cyberchaos.dev>
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

The PWM controller on the Apple silicon t8142 (M5) SoC is compatible
with t8103. Add "apple,t8142-fpwm" as SoC specific compatible under
"apple,s5l-fpwm".

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index 48cafd391ca2..7c9e148727a7 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -20,6 +20,7 @@ properties:
           - apple,t8112-fpwm
           - apple,t8122-fpwm
           - apple,t8132-fpwm
+          - apple,t8142-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
           - apple,t6030-fpwm

-- 
2.56.0

