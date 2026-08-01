Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF83CE0A4;
	Sat,  1 Aug 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620473; cv=none; b=KwbObmS2rjPGd2N2FOSc+mmRyAjYH+7tTsW9m/eU4ZSr1J1KDJfFr+mJIQrycffQjxl/0uv1kYxRXTcMiqXuX1LJ/wJWDJs56Q/0I3ljn0TEvGDrgc2rFwSwcZpfHR0Pnv422sRf/M6adwtCNbke8LvhVmx1y4EnGW/jDPISmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620473; c=relaxed/simple;
	bh=b1+ox9bvvZi6esBCO4i+A29vpkObZzsDgandkj048qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRm4XqyOzL1I7pYhqw9RJC9zRlSMlK6KHFkAtwzXS1VXj2L3DkxE9muQ7uNBj7B/aUdlkh3v9uSB8bXxGghp6VRmVRcGCAt8QXoI5+oKowb43Uiy9tw8O/Ye5WzOW9BkQwU3Bg8+I9JpIUK68ui6KdUfgb5lyZlzz12+rUzAFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=h8NSCCQp; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="h8NSCCQp"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1785620469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGqkzE9J7l8eega5eRBiLNQWdpKKNJCn7O+8KgX4WaU=;
	b=h8NSCCQpwf+Pbc76gFxHGnC/2zorClI9nK1z8yeciR9o7ian3ecQi9KVZKyJ3gNr0PbQvj
	djQ2wTE+ycBi7Z1DIBlGHrSxd5NSknbXqUWkTyDnW0jRzphKPI8Z9VDYblaDakkR9rrLsH
	0g74k9eEKRx1qc9w3XzqmXwppCyQh+U=
Date: Sat, 01 Aug 2026 23:40:32 +0200
Subject: [PATCH v2 2/9] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t8132 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-apple-m4-initial-devicetrees-v2-2-5cb07cc275da@cyberchaos.dev>
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

