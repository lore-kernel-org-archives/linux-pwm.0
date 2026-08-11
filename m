Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE814766B5;
	Tue, 11 Aug 2026 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477036; cv=none; b=b6k5u9ZwKQes0tw6msE26Qq3AF4qjvtcWlgwyyTj2jV+fpbvP6QSxcEKr9l6Dk/GWqEkYCaOiRhALmGXk/xLJIoRl0jKhmjxIKJOpC7Wmi70nM7Q05DBzkO1+iAkysi38Ukc2umwusNlKXYVO2BGLZWkzfdOqfFK256Dk+zep+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477036; c=relaxed/simple;
	bh=uCrZoq9hMO3BwCtPxYeBInYsLX6Ph0hM5oymw0p7uBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRoxUuu9PCkRAVgHRUm29RPd59rsyzM270smz1hjAotN2wra6479AqmOjdxfn0/ZEOvR7QfNQXVxQjSntttJkCUK43bOMplhqWoezLBQZ6VZmWSw7esMXwP1xhBJO8Ue45dAIuridJseCpkD1uY4PqYE5HD/d7+U1OaAkZy29e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=dR/yBnpI; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="dR/yBnpI"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786477028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF4U3j1h1VfITySsF+7uOQMAlNKLIP6jXfmWmWtYH5U=;
	b=dR/yBnpIqwWCvcwKiByw8Hybb6/LoW4y+RxsOLkr3IDeIOVBT5t7yWwYU+WRHOe3lgFYTo
	DXfWlXzTXPjWqGSYW6N3djdVhTUa2l5swQVtQZAKZAYM6GRlITwPhBnrMbyJn6Q3o45PZi
	jFK/yxh/wl/00VQUx+QS0viyxYoB0e8=
Date: Tue, 11 Aug 2026 21:36:58 +0200
Subject: [PATCH v3 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-m4-initial-devicetrees-v3-5-6bf32d45ad0b@cyberchaos.dev>
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
 linux-pwm@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The pin controller on the Apple silicon t8132 (M4) SoC is compatible
with t8103. Add "apple,t8132-pinctrl" as SoC specific compatible under
"apple,t8103-pinctrl".

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

