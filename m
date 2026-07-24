Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB14483B7;
	Fri, 24 Jul 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917033; cv=none; b=IVbrhk3YaHU4Gzq08viyd81LJvBLpXusEIGLWKldyGzGmbOi6gDARVBZMnV53sAFvy5ZiswYjE++XjbPUOw2eiX8oxP56NY4YI7IhFIdkHQ3VEcz7bv/5NaMnpahifT8a4Jx4/gohOi6T86dN5/z+S1wg7F6eoF1ZV4DDt/wR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917033; c=relaxed/simple;
	bh=hoexqVQCY+ejGnrBu1mfICEMGGXuczIAOnwrV9ILD/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpcFeWxVSW3lbpXBQs1GWUysP1DaNLJffo6N+gip6Jpl6tImBITiCFus+GjRT0Qn01H5FwfIz+pIFNSxtcDCjcHvD6uMb75+MxvzxXoDshRYKMM4uEqBjecXhB0BlBzD1usLKG04r8iudvuJ9mb7dEkCnGa2FwXnc/udTw9IDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=ElccVbPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rfkpbqq0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="ElccVbPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rfkpbqq0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E0FE7A0144;
	Fri, 24 Jul 2026 14:17:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jul 2026 14:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784917029;
	 x=1785003429; bh=zi59ASSM6k6bm3TNmkwEUv9G2QaykG8US+WNhargWSo=; b=
	ElccVbPGfUNY8rnhXy2QALR4Ytds195IrP0ymxP9CcazX+2fOOs52ZArcKr/Z2kx
	rOktrmPjk2kipTN/cc8NvCNgUueEhqW+zZHjjovn75wy5FO3BzUX/aNpuVvZ2tbt
	qqSTpIeXsx33TG4JLua8poIcdoYgO5d/lZL9giDMTnL9TQycjSuarSiZG5pir1TP
	lGyJRYkvvQNUZAs8XV/TxADWNYj4gXJNhxgSuU6pk8xNRYonyR/q6ILV4ZfGfxYg
	M+8FxnsA9d6/1erKDVftUPvV5cITiH4Ziv2xiNdops1O8devp3Y86njCUVDadkP/
	AN354bP26ErUKcR/pulnHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784917029; x=
	1785003429; bh=zi59ASSM6k6bm3TNmkwEUv9G2QaykG8US+WNhargWSo=; b=R
	fkpbqq0w9WnZ4K1iLzYDg4TYtOEaduld5Zm4cMyxwQ5t0OcmJ5lLRDHbP8dKedew
	vtu5CzaikBFgeJ5cDHj7Wc/eAtTi2jc9+9R0JSs4Xn5FMOcKAfqGly9gUGx8ggly
	X+1ilQAzEw6OXmxKs7WrY9pBAYhdqtTl/T7fT9uB9bZbMsO4dTf1wjNwg5RrBn7b
	taSS7ZofllzWZd38d6V585i7rAmjcBILskA/7WiPJODri+0BmxcIrR378Q1iXmmU
	S6zU8wY6eZzl1GtiA8XyaVwG4qHaL4jIKFwP88iVzGM7Bm+ogz3DWEc+hJBdtcrY
	h9SEC4733hJWCeEb6SUOg==
X-ME-Sender: <xms:JaxjapxapRiRA2o6UOwJM90AkiQybOuOHaR-z1qbpcx13wVrOqu63A>
    <xme:Jaxjaj-VRQA7qLGyWe9t6LDp2TLHFUZnJqGSRyfyuM0-TyufcSeW2z6ed-AnAguS-
    jhkDcG2Zg2w9CWY4MK_Qiq2G2h7Llmp7pRr85NYv2dkac1l6DY9psQ>
X-ME-Received: <xmr:Jaxjap_Yiub5X3RmH4PqRUPwemU4LrVOXHNQDWPI2b3Tvcg-YTVnRhp054m3-XLA_nMEZIZEIXCSLS9my95uli8IgC5hbdg8_9M>
X-ME-Proxy-Cause: dmFkZTGL7FLLQEcSonvczkk0aOwpP/oHoJf7kMhD5+yydUJC40tvWw/Oa3sMpaefdM/BrJ
    OI2/GZO6/kj7uLWYVH8cNxXGYG4wEBx6gDqSn3kXny24ctmQlTKtf5NDtKr/CsvOTq4qgD
    1PVRrexzn794tjDx3d3Eo6TjkwRxmvAOI3NX+/dgWAfK6JPiGyf9PCpPeHqwWYcEIdkTaO
    CRnAm4/S+JC7+Uzza8WbBa46uo+gY5EnT87vF+yZ+iIl8cnbsdsiTboa7JN0BtHde7Q/Jv
    zaz3s+Vab8N9H3KPKBBBy2jJCjZvmHjwM1EOPk5Khu2M0HJac5DDd+WsgWlRdpY9BCODmH
    j1vXM24PQVfZiq39HX5Qz3ZSXuPRYLHOY/qvVJPU613e/CsqvRiMIHxZqE5NeyKfpIlvZK
    /SrNxUi28IJnHw0teG4d5wJxkzHmc3KZyuMHGv7+Fn9snO8Mn2P0efbUx7tXnxN5gacSQq
    Vr29mSiTbB3eqnZUpPv+w8kNjnyVGde/4dIb4yqIMt/ZtTgpbUC6jPfAFeVl4NwMXJzjYz
    gjW7jnIFVSEtm3hoHyiViMTuP7vN+WzgXJz71cJ3Y8iUXiBdUIOq8vfiU/y6mOOWwnGJ0l
    +oZXKC66UdNGtXyixJO01RoEpqtlyfOH7ytfDg3DuM8LsniFGTh4/ayGxnfw
X-ME-Proxy: <xmx:JaxjamexeRmSVeTHFpQlgQNQcvHjDOwiOHyg9_AIsRRywPpy3IwrCw>
    <xmx:JaxjalsyxlU3NRWv_wiPEGDTaErpNqXKJ1W7LfVlWKOOSajTodW9Yw>
    <xmx:Jaxjav3Jn05PtfCVW7Vo5wEKTH7Fczawqz5Whmys9xx0BUnMqVXwEA>
    <xmx:JaxjaiAOdUCQbIkr5ePx4ygnEmcib8iKEEkrinexamFUDunA8ccLqA>
    <xmx:JaxjaiVWoBJF3ZGPT2HAhZQEH0Y8vj8iFrHLqICvDULcxFYlMJABq2Ck>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:17:08 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 24 Jul 2026 20:16:47 +0200
Subject: [PATCH v3 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-apple-t603x-initial-devices-v3-7-bbeba0420603@jannau.net>
References: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
In-Reply-To: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=j@jannau.net;
 h=from:subject:message-id; bh=hoexqVQCY+ejGnrBu1mfICEMGGXuczIAOnwrV9ILD/o=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNfxzTkcfmWseJbIqdLLOBxbn+OuBO7cnpl/w37BsK
 a+M7F6ejoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKqzaxgZPts8PZS4U0W30CNZLnuBpuw5/VUHpRwubVuaa892ZMbBlwz/Szvf32q
 bdCD/Yqy23KJjGxaprnMMKsycZ6pw8cb0YP0ffAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The PWM controller on Apple silicon M3 Pro, Max and Ultra SoCs is
compatible with the t8103 (M1) one. Add "apple,t6030-fpwm" for M3 Pro
and "apple,t6031-fpwm" for M3 Max and Ultra as per-SoC compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index 25ef04b60ca1..dd95037ea5ee 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -21,6 +21,8 @@ properties:
           - apple,t8122-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
+          - apple,t6030-fpwm
+          - apple,t6031-fpwm
       - const: apple,s5l-fpwm
 
   reg:

-- 
2.55.0

