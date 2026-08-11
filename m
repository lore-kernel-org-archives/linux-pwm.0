Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A580476CCC;
	Tue, 11 Aug 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477035; cv=none; b=O24cAtvzt832pM+oRm+UZls4eS6NWtmCb+VZy1o7HOzE+Txkh7a7hxYGNZN6o6j22ccK4QX+tRznoFhLo3bNTNL8gOl4Va1zbAU3kCGJhsgYlzoBE0GCF5t88M2fF3aGgt6ZblJ8d1rQN6LaFzQpeGbqIOx3GXSdnCPxoiDnqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477035; c=relaxed/simple;
	bh=4Ll6UalzXq5TeKpxwb4XG2sshOdGsYwoQRY2dbFg3Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjAg6M0VYgXJ8CT0Lh7sXq/jxJs7e9ETAnmkiPzaL6eo/GK/buX6S43NZ1aHtskid38BVMrsGxDMBcLKOEDdcbceXarYjVS7x6MpNejXZe9t2BgML2asJCpt+h7JAquigZDjkKwvLd8587vepK+/bRa8f2CzyCGRrqZuNZsWik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=M/yKqom8; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="M/yKqom8"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786477026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wvhJvl8V/UCRIKi03HOG9kNnF6pjoj6mjPMcmy9q1U=;
	b=M/yKqom8oC0X59FtMHL36plaW/EN8JAAh2csOiwbPGvkZqy//VIZ334BqZWqGwQaFjSNQT
	NzMtGwDqvx5EFJ1ykHt1xRVBc6lTr8tya3lT9pXFKKeuJFVdD6e5dGCmhaLQ3n/IO2m8VB
	Zao3gZKwZRMmJnVtsnGDAXzPG6pgaSM=
Date: Tue, 11 Aug 2026 21:36:56 +0200
Subject: [PATCH v3 3/9] dt-bindings: arm: apple: apple,pmgr: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-m4-initial-devicetrees-v3-3-6bf32d45ad0b@cyberchaos.dev>
References: <20260811-apple-m4-initial-devicetrees-v3-0-6bf32d45ad0b@cyberchaos.dev>
In-Reply-To: <20260811-apple-m4-initial-devicetrees-v3-0-6bf32d45ad0b@cyberchaos.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

The PMGR blocks on Apple silicon M4 SoCs (t8132) are compatible with the
M1/M2/M3 predecessors. Add "apple,t8132-pmgr" as M4 specific compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 1d2001836eb4..da660fa13f77 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -41,6 +41,7 @@ properties:
               - apple,t6030-pmgr
               - apple,t6031-pmgr
               - apple,t8122-pmgr
+              - apple,t8132-pmgr
           - const: apple,t8103-pmgr
           - const: syscon
           - const: simple-mfd

-- 
2.55.0

