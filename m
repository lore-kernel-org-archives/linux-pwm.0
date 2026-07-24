Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602D41685D;
	Fri, 24 Jul 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917023; cv=none; b=K5v534+9M8WMZaeSvDMxX98FTVnoHBoINrz+cfhiS4mvMwI935G5yfxgsQGhXR6mjrNHx95T9KE9S0mYl/zivCDfbQlkmMHx7gOodic5oyLOqDROUS94IJJuh+9Ccwo7/JphMYyiAb2yDpU36x6Y9oMLzoUaojsjnOO7laZFtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917023; c=relaxed/simple;
	bh=GDAcLzUVKgsaSayFIqUH1HECZbzpn/awNHaCk0rT/Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qDAwj6/qPtZEq4fD5utuzyBQowcI/omi5Xz499Ao1wSc+fU0MYCK2k3w+1q5zepVn6NhwZIbfUO3a6milPwpJkvb+mDDv1r6FztsQ95atFDHemrezjxki+RIk5IM3Vr2CGMSSWkgMtNaN5X7qHEKL0stm898GgdQkx29BbJoY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=fczEDv87; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E02OSiRQ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="fczEDv87";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E02OSiRQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 243F17A0144;
	Fri, 24 Jul 2026 14:17:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jul 2026 14:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784917019;
	 x=1785003419; bh=E7TvtJzRcRw2DNiEVSBV+87jxpIm3RIlwa5Grydb1Ek=; b=
	fczEDv87UPjDV1BsgmrlxO9qFNGyoqjPa6a2ZHkpDxHHsma3iQHOyKYnCodJxX+9
	3JZn7UkPKNPSEyM9lVwaZ+5fcz8iv0unIafGPeci4R6tZ8OE+9xlVECUkccQjv6+
	03cWWvFNTG0LrO5R2VeB+HFe8R09rJdbFTfOVk31FpkBbeORG93bUr+7FbyCwmeF
	VOiTEQUk6xosQOP49yyGHfrXC1kBUjjFiLLUfUi06VrENIz4dvnpz9VkyjRk74Mu
	eWkNk0+seMa2fnjJndhLJjTYfhlwhka5E+Njmh7FMIzhDBZt8gSN9YEqa9Ztk5+d
	bCCbn+khXxtcqVBpI/s2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784917019; x=
	1785003419; bh=E7TvtJzRcRw2DNiEVSBV+87jxpIm3RIlwa5Grydb1Ek=; b=E
	02OSiRQQKIq8kEc8ySUUONk33Z6yyrsK6+NobZ4/nJNsSVOcpHJ5QOJz56rltqba
	ec7X1Cjle1hKaQPgLo/gRX+6uYlYJq3f7WziBebX6xB0saCwgW8H9/njdcQ7KUA2
	s8+QayK2GPY3VbM9iYwOALotYCKlo/vkJhLDZN4o62S1NlePu96dXtgnfRi8pJZG
	97/c0AEPd4rg5OhZGauvMwaxzbSU5pdxwO6GZbEQtCjohH6RIGN/QNv28VsgKPUT
	obZkTazIY8PfodqEm65zmBE0ur9B4zg4GqY1n7HOqYQ/JtwcalEyjX3Yuq3YTC0r
	ADWBqvEgSSKqFGPiXK0ZA==
X-ME-Sender: <xms:G6xjano_jni6IPDUkpoiNdw_3S_ZPt5mqJwt3jPQrEfSnIvGeEj4Nw>
    <xme:G6xjasV7tpRUoUIqMgeidLg5EtQyYCkSlf5fDinwnew4iJGTTL9BWNi4AZ6jrWJTO
    -3xt14lYgMdcMbgaii9959AMY4pFas8cBZ85a7wYjicGRg6PaR-QikS>
X-ME-Received: <xmr:G6xjaq1jQUEEBjr5LsJBqVLS_z6Ei6z1sqpspTvdDCHao4QNsls-SGytgRXjlt7rR5vk_XQMKlMeZnTE4ETMN0Rib1L6KXqcLWk>
X-ME-Proxy-Cause: dmFkZTF1FX2rMAzDkHprU+9SOL/dAhdcZMnSKVMN5sSZpEXUKt0tpgGTqps5g9gzvwIbS9
    s+sfCmoO948cbdaFVKnKsFQZWlQG5l94gQ3OMj/lpmOBEFweLBWIwVRLX2N9lNc3poNr7O
    L977RANIhWLezmIkgwNFbh0KndpYGeRMYxoZTX0qtVRW146Bj7liiLUvZi0nEietp5Cetj
    sJsRGwTLW9VSWvYD3J5JA907Ht+C8uVy8a9gtIre/v7Ls/lg7fJiukWLBXmui4C8aVyG7o
    /Kp+oo5oKDhOQFee530ewC3yY4DxTEPsylZrAsmd6ePp8Q01nTX08+81q9r13bu3UjqCCB
    p3tcB3mDIsdqlX+l2czNK5xu2Qr3BPFqjKlY+pqcrh3nieZ+W64k+u+T+IBDUWnsVmYrWg
    /kQwTH1EzY9b0c4Ep8Gs2tGj9mEN8bCxZpJdbHig7ffIlFFfipkZRW0/Hsd5zivqOzgSPM
    onl8n1EgshwMpSqDQO+QuDvprVdrZakrm/3733D/f/WSxvZCLj9bDSJ9oUMkyOXeqP9PgP
    OsLqTxRxrXmiFrvTfml2Vo2pdG06YP/0xwrAF/X5qzKprZMicGlfkKrNwWoDis1PRsCMUJ
    ct4TQieTSkeWAS5RLvhqYeM/ChDUxAWhjexHpg/OXwTDJ8OyNgPOcuZLgAsg
X-ME-Proxy: <xmx:G6xjal16CQ9yr3w0IkyJAT8k6QTvQZc8UTQvOPqcNW-CKD2qwO9R0Q>
    <xmx:G6xjahnHU6n7mS9OrizTInLxxH35imFDcG0S4HjHDvkLk7pWFKhKyA>
    <xmx:G6xjauPSsviCMYVpRyADuWbFZN3bB9ulZZMbRbq11WQIs7gns1np5Q>
    <xmx:G6xjag58lmxLgX4UyezVPJRt2H9rYwcIJ2OuNMWHajC8wKE5QHKjXA>
    <xmx:G6xjagsLro3xvzqEDM4uKVfIExXPQ49XHGX86_gfoj0zKX7A0BcmJbNN>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:16:59 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 24 Jul 2026 20:16:43 +0200
Subject: [PATCH v3 3/9] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t6031-aic3 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-apple-t603x-initial-devices-v3-3-bbeba0420603@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=j@jannau.net;
 h=from:subject:message-id; bh=GDAcLzUVKgsaSayFIqUH1HECZbzpn/awNHaCk0rT/Bg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNXwBMa9cOg70/o84fHtXeN12dmFlE67YpR+Nihfp7
 ZaIbdnRMZGFQYyLwVJMkSVJ+2UHw+oaxZjaB2Ewc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6xjhEDF6cATLX5cUaGWyKVN27cOWysv7D3SX6+WWav0rOgd0ZKZbu2fbrM+PhHCyPDfPYGifq
 oM9eZZd4U9xj53nI0izOO+Xi65aGPm9KFk7E8AA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The Apple M3 Max and Ultra SoCs use AICv3 as interrupt controller. It is
compatible to the base M3 AICv3. Add "apple,t6031-aic3" as compatible
and add it to the list for 4 #interrupt-cells used for multi-die SoCs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index a94787939d34..726a6720e05f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -44,6 +44,7 @@ properties:
       - items:
           - enum:
               - apple,t6030-aic3
+              - apple,t6031-aic3
           - const: apple,t8122-aic3
       - const: apple,t8122-aic3
 
@@ -130,6 +131,7 @@ allOf:
             enum:
               - apple,t6000-aic
               - apple,t6020-aic
+              - apple,t6031-aic3
     then:
       properties:
         '#interrupt-cells':

-- 
2.55.0

