Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E01476CC5;
	Tue, 11 Aug 2026 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477037; cv=none; b=fPHdB9SKJRYyxYVsylb5JbKgstsj3ym2Zshuh9HhXDRoNWfvcxp9PZhAx1SW0P/jBtDxtOT9Q2LteqgrJfM1HiVlLPkg4bG0T0pBqGx7ZqEsB2UJa09vAODzeElWTpuuJHbnxOcAAOdBNrQT+luvIDxoo/TvWhexfCE8Q/mor1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477037; c=relaxed/simple;
	bh=b1+ox9bvvZi6esBCO4i+A29vpkObZzsDgandkj048qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVjvU5RiW55goeTBmYEogy7DPTkXT+Ze18mNf0lxEanf35IDmn/5fQ1JH8TJBZNQQIyuE97V2L46y7pVZjXfjyFuwgozblhrMuFDFjva3bwOWsGRE8U5BegNGNqtxWubDRYyzR5cHmXz87Op8Zk2615pA1mI9J+M8MBbM77dLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=LxWp0Oxy; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="LxWp0Oxy"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786477025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGqkzE9J7l8eega5eRBiLNQWdpKKNJCn7O+8KgX4WaU=;
	b=LxWp0Oxyiq9e4y6NZpeAvfpmPC8/Q2kmwCELrzaq6Lt8XzC33j4tS6XMKEHfW1J+HfAoEt
	abYHRzLxKJsVJ2w9qN/D3TT1P8bMttE3lPTdbgesCAmAVgvFsgC5WUyLuiDXQzh8we6zA6
	K1QWgMsqnZ/JfQ56OOYSeAlneJWv8CM=
Date: Tue, 11 Aug 2026 21:36:55 +0200
Subject: [PATCH v3 2/9] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t8132 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-m4-initial-devicetrees-v3-2-6bf32d45ad0b@cyberchaos.dev>
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

The Apple t8132 (M4) SoC uses an AIC3 as interrupt controller, same as
the M3 predecessor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index 726a6720e05f..1cb886785173 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -45,6 +45,7 @@ properties:
           - enum:
               - apple,t6030-aic3
               - apple,t6031-aic3
+              - apple,t8132-aic3
           - const: apple,t8122-aic3
       - const: apple,t8122-aic3
 

-- 
2.55.0

