Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D03D0BEC;
	Sat,  1 Aug 2026 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620489; cv=none; b=aCQWBeEMP4wWZZkbiD/HBGOi2Ge2cfEgPnQHmS+B9MJ+bxtvXyBn/Yy4jWUDtqwJapHCpZZz1D+3916/F/+S6PPXa7P+sCGW2UnxYlWtBgKcKTo8Vq5KiJdB08bzlLNFohdGW7uDClBDXCl/FQxf/MKy6zZkFNiGDh8CTxffmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620489; c=relaxed/simple;
	bh=pFLYQi5N0grlRyhBVTWl/ONAbg8Yhqx+NF8t6AOTI0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgNehBgjl9qvnd012teInGXUefruSJ8ZSUUOrQWFssfUycoMHovi4wbgRi6gwWSdYIoZX+jIJ1mumX7OX6123c4Brd3eOy1z+Jjm2nPYlUilDlaAoq0x4DI/Zl2DEJdBPyeYQdzDPdydoau62AaXuN01vIutGFbH4xjwVG142R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=fLnD8MAG; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="fLnD8MAG"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1785620485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq/C7RB1k+jJBxtWuGdu+hRvxYIcrl2ZqGrbd1/PVa4=;
	b=fLnD8MAGbJyCcSBEzaey+h7VBLnveTeK+V1x454NZmiFik5coTCsyLRo3FLKieM9EZQw3k
	LnrEpoF6NLc9EKWCN0MuQ0UTyxvTBKc+pOu1Y0yvH4C5VMzrJUu5K19afe20XXgpDZ+Ifm
	JexVP6++MUi/lqSYhXCyz+zqfMZTLcs=
Date: Sat, 01 Aug 2026 23:40:35 +0200
Subject: [PATCH v2 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-apple-m4-initial-devicetrees-v2-5-5cb07cc275da@cyberchaos.dev>
References: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
In-Reply-To: <20260801-apple-m4-initial-devicetrees-v2-0-5cb07cc275da@cyberchaos.dev>
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
 linux-pwm@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The pin controller on the Apple silicon t8132 (M4) SoC is compatible
with t8103. Add "apple,t8132-pinctrl" as SoC specific compatible under
"apple,t8103-pinctrl".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

---
This should be pulled via the pinctrl subtree, since it depends on
"dt-bindings: pinctrl: apple,pinctrl: Add t6030 and t6031 compatibles"[1]
which has been applied in the pinctrl tree. Thanks!

Link: https://lore.kernel.org/all/20260709-apple-t603x-initial-devices-v1-7-55b305833123@jannau.net/ [1]
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index f08d2c4f5784..bc6d41b63b5d 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -23,6 +23,7 @@ properties:
               - apple,t6030-pinctrl
               - apple,t6031-pinctrl
               - apple,t8122-pinctrl
+              - apple,t8132-pinctrl
           - const: apple,t8103-pinctrl
       - items:
           # Do not add additional SoC to this list.

-- 
2.55.0

