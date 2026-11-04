Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813070;
	b=hwKg7DoHxo3di2EyNyY0aDF02QtXpOWfhN2lL5RDRdI5YqKryInOLizloG39QQYbazWg
	 4J26b/zZkYrNQBXqC7jZXbyQ7UMkwHtLaPq2aRiE7eRc/ADeINFcgZQkN4FvRpcYPlCxQ
	 4o/LvHPX3qMq6tfXotdR4EFXZGYhyZPYNoDuSXmyYNs7rY38r6UU2u9u6WsZD48NUFlhj
	 Fewx3Ez+OzkrtnLVKPhqLy54Br5jRDet8ZuCqcngZtFMMxOwnFc6ii3v4ZSdagl7OxQkm
	 AymbsmKZTqzE1S1e9p906/dwPPRqtP/c1bs4OoljdZ0IkuLu+ckim+Cg1HXwLslci/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813070;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=vNw98TulTGI8RlWvt5yNDg9lFfwWrwXKijxuB0xHpIc=;
	b=APGlfHA8SNcQdFaWpB77aq/QHzMMkvrCDhXwLbLHN2tXM3bcnd+jYY/cQWgvXqjNVj05
	 AYFwiTb0j0DsWJf8H9UvlgIiPtbMAck0m0XuK+zaVJ3+VzDwtHW50ja1SZIaFW/C++3Nv
	 SVEeqv7amTuPu4Unpl1XZR1BKjKMae6EM07cENk92aO3EVgdHSkOCj6y4j6NM0ZRbaOpi
	 oubXkxxz2G5PMJf6oJmpeFlDnqLihs5tMtmnPaYW79RT75/KGgr6ZE8NDgnKR7BgYq2Wi
	 Lj4N41+0VFy+svQW0YafGZ/6IKisKwTZrluwOgoPF0lgy+GGIFBmUZFl5oVVuazzf0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=qtvwA5GU;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79852606A33E;
	Wed,  4 Nov 2026 17:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79852606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=qtvwA5GU
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793813067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNw98TulTGI8RlWvt5yNDg9lFfwWrwXKijxuB0xHpIc=;
	b=qtvwA5GU7eikNUdoQCOehV+PyKxLfklf6heK7K7d/Qmjdhkz0qKG367Kw977LwPgqiUj6N
	88T0febrM8IN8q2U/PiPZlzvMrOcVOqoIm1npjVVUcizv4kaFYbPZho9WgymAMPGboZfxE
	SVBjZ/7uYHGLCF/STZ3Jn8PWQrsao9E=
Date: Wed, 04 Nov 2026 18:24:17 +0100
Subject: [PATCH v2 4/9] dt-bindings: arm: apple: apple,pmgr: Add t8142
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
Message-Id: <20261104-apple-m5-initial-devicetrees-v2-4-fd727a82d380@cyberchaos.dev>
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

The PMGR blocks on the Apple Silicon M5 SoC (t8142) are compatible
with the M1-M4 SoCs. Add "apple,t8142-pmgr" as M5 specific
compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 3967fcfc1663..015a5b6834d0 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -44,6 +44,7 @@ properties:
               - apple,t8122-pmgr
               - apple,t8132-pmgr
               - apple,t8140-pmgr
+              - apple,t8142-pmgr
           - const: apple,t8103-pmgr
           - const: syscon
           - const: simple-mfd

-- 
2.56.0

