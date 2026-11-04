Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813068;
	b=yCs/aKpYsV6lqkJEC+X5b0Rb1JEEu8+FfbGT/4YFg7taDwSO2Z5bT5Qwyr//eKhcxdiv
	 7KNqq+OcWrkVlbfqKQXsviyfZ08cVBotQXuidokhLPwAaQsGdDLLu7gEnnL/l7vz573KV
	 KULcoFCHysDi5wcapDXKh6OuO0SQOvk3bgvF9ZQozTLo8RioILEU3vCPJZzpHHz/rzxBG
	 dK83oaTNCRj0jBToP2bBbJ/JkIR7nRoDTo06ZFY74Js1yl4j5QW+Kcuu2QGrAO5mkUPg1
	 RxVjkgIQtbbxlJLhg43aC6UzVnbptGplQMyY9/DmudbDQHUMHlpGVqiRFMiHVlJToeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813068;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=bIVg0foxmqTG/8sVU2ZcbJWE1ifg0bPsxbq01Yjc28s=;
	b=TW4ax5xMJt7ESUxb6APX3B7r+7E7YYavaKaMlnJx36JNm17J12GrSajbWRrSZFKbN1j1
	 EumMPiU0KMZpMfTQ5FsLz6vOHp1bowDP33feOnYXhCsx3Lajm1etnG8MorawmLTXa4h+0
	 n4eWtKFjhAo9HdXN6OJ3XmV2xdYcuZxWgXk5sW9Bac1ihbpgo2bYvfFI0ASg47J+vrQoB
	 zbYxMbLvgclufwoAwkvHuc7hc8puOwdnGiozYuF1qSLjqt4GnWApw+ersVIKWFztUYg1a
	 lx995u1bPncgBHTEeWAtAT/Y4QeayjEEdjxIG4IMQLgOVeCiJ++FVq3gzcHgQ7+Nj/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=lLpQSlXJ;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EE606A338;
	Wed,  4 Nov 2026 17:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137EE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=lLpQSlXJ
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793813066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIVg0foxmqTG/8sVU2ZcbJWE1ifg0bPsxbq01Yjc28s=;
	b=lLpQSlXJUz/r4I2/RAZhwV9/lbOT0i3PhA2jYW3igjnj3nk6SQ7a9Ixb2lhFDlUCbasjsl
	GNbQ/aQpQCp8Hy2QDSvE3QkE0paT3F8zLhRQaYwyjv8c6I1tmaOZozWTZ43lrzZF9hdk0W
	OtvtdUbXwVx16iH1mYf50EJJBIGvnfI=
Date: Wed, 04 Nov 2026 18:24:16 +0100
Subject: [PATCH v2 3/9] dt-bindings: arm: power: apple,pmgr-pwrstate: Add
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
Message-Id: <20261104-apple-m5-initial-devicetrees-v2-3-fd727a82d380@cyberchaos.dev>
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

