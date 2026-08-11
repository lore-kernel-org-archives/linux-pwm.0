Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74E476CF1;
	Tue, 11 Aug 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477038; cv=none; b=fPdMerl4k2xD8ZHxXSyktlYbStqbp0Hz//WREDZoYeFP3xldSzi0FxzIzCfhGA/PaYPodYstn00W68+8trDNnaZUMJcNHH+MBjq7e6+vAzVmAYrbKGpZpLHJFY+20MjHV4sLh8SCv1pti/mJHAqoyrRlSwQEeUndrgiaGSLltGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477038; c=relaxed/simple;
	bh=JhpKQ19kWyYgLTa20tUdASpqThoMRjXuSWeNvFaBBos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/vC6X3ivVwf+KKGwUlzUwdPjxOrlJczGLnjTGqUP1ecd6pM881XqYvROzTHEO0uM488bvkBPlwSbIzX4YqhvRmeFmzNYoCoUxmpflPxYcg8J8r9nR6LDAnRqUCRdVgIY5qsW0GnUXpLBqUTp9pJxk9q9Jkzy7iIDWnM7gQKCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=vbU1l8KR; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="vbU1l8KR"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786477030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6exrCVVV5bAtISYB5zaIXRdtD23Gj0eYc8uQWomTODw=;
	b=vbU1l8KRQ0L00K3g9fLL1REnxGXkyIs5A0TFdmSLOm6RQ6+oj3fZqiQAsa29J03FmfJIv7
	UzAQvtX5lJC2lu2Mwv+B9TFLo9x6EqW9QgaMlCHGsNRKuwX6AmDL4093l8gpCkmzVw876q
	BrgZ3VaEJ3z+EJCupJ/WP9q1KfUvH+o=
Date: Tue, 11 Aug 2026 21:37:00 +0200
Subject: [PATCH v3 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-apple-m4-initial-devicetrees-v3-7-6bf32d45ad0b@cyberchaos.dev>
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

The PWM controller on the Apple silicon t8132 (M4) SoC is compatible
with t8103. Add "apple,t8132-fpwm" as SoC specific compatible under
"apple,s5l-fpwm".

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index dd95037ea5ee..ae8baa5f7bcd 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -19,6 +19,7 @@ properties:
           - apple,t8103-fpwm
           - apple,t8112-fpwm
           - apple,t8122-fpwm
+          - apple,t8132-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
           - apple,t6030-fpwm

-- 
2.55.0

