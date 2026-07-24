Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D993442B05;
	Fri, 24 Jul 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917031; cv=none; b=npsE9DqwHqKtLIFjKlIsomMIVdsHnThoNdlndFv5Fqw6ERt4rNMf1DZjWdUw4bhaZS7XFXvBliS2eUJtcMEkPd3HQOIcHqoGdS4hnZKoM6Z+6z22ELt8yu4QAPY6J1Feh3RichMCJBs1tOeMkWtkNElMTS0gsg94DhgCGyHtEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917031; c=relaxed/simple;
	bh=UeodmP8zjm6vT7hJS7cbsmjEW7Hjxj6/HXGYdSRLKaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQ0MbRGFm2SLkWBIKNKxixPT8/IF4gvbGYw6lHwQJV7MQko27Puu3I3yZHQeJCeet6bCfG4sFz35ylYNyA+iBEvRdP2XdQSxtPjFLNzeY23W6OaadQ0xX19b+l+FMpaQgkaiUaAqsrtSeYGI6qnEj8XG40njchzPl+aGvKlcUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=In7aU3Vi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpyOj+kR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="In7aU3Vi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpyOj+kR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 396907A0145;
	Fri, 24 Jul 2026 14:17:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jul 2026 14:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784917027;
	 x=1785003427; bh=TUGR3AOxbRaSK8UEKWhgT5UkqNmO9F4tXNaOGXVpiXc=; b=
	In7aU3VidhI6YSS7tFRROThN20ZQfgi7IRTDZPRhHPjLucd8yj1q5Z+XKkudwuzH
	rGhSAajLnCRo0WWILmsfahP+i9iy7WwZ7OYoJcgPO+dNQKBnhZ2devEcGoZi9E+P
	n56HAmCzEJHKdbdrdbnmhNfJu9UpDMU8oEOIBImkos3JwFVhBuDnveqDU/4fJw4M
	wZrVD3IQm/nk+8bv4OHS8ydA79tKzlrK0rkX5qJ09z/9+Y0QYyKMZn90pk/ujm3Y
	1XT0rGDaTZkl7vPsm/q0VBtE6YohkZj5qRQxtnrsQlLQ08PPE0syDqf5FyoY5MaO
	+9z1dO11TerD00aDeKfGbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784917027; x=
	1785003427; bh=TUGR3AOxbRaSK8UEKWhgT5UkqNmO9F4tXNaOGXVpiXc=; b=Q
	pyOj+kRp8nZfp3M4iktF9qLubgz41V+nmQfMFxm4CNi6rQEq838a6efaT/QB90CX
	DviCkx3hsP0KyLDvSolygEfMgjdpJplOmjTgLd5rezmlx2e2efSEGgGfESQJWfu4
	q+xuStAScdxBrPs4bUjYzlZVK3xtJ54FC63eNsd8Dw5qxhKdXA263YwXSpc+2am8
	J29yZY/mG0LjvdNEdv5c/R+MHJjns+vxe0froiyPRXYWcJtW3Ic+1id0FJM582K4
	+YCs92IRQypjS3CkVfFTxHxuQVRuGTGELIVcFitR+7m3N78Ohbm+pTOrdlmTyU8v
	bBxqoPpfdxJlOjQiE+3tg==
X-ME-Sender: <xms:IqxjanuRzDksbVT-EsGtO0PrWltLiWKt4Zi7D03vvTlwcFXZ-Bl-Pw>
    <xme:Iqxjaism8jptv2lI7wy-ECKzdAwfnBrJLezCEjMKj3V7wVKSAF0bAlemPjll7oRS4
    EfFOEkFSZgy9RFGoQhUrOjN4gAA0u3v5wNx0_EEiC77L6ML3LbbN1E>
X-ME-Received: <xmr:IqxjagN-Mb51ygKP0nmXIdFLeptYnXQAm9iVkWyFRrmzcFct0ljC-I0FYrfHE53AE5dtV4F_KLvbKGmCApkHUV730HCU1Mfuok4>
X-ME-Proxy-Cause: dmFkZTF1FX2rMAzDkHprU+9SOL/dAhdcZMnSKVMN5sSZpEXUKt0tpgGTqps5g9gzvwIbS9
    s+sfCmoO948cbdaFVKnKsFQZWlQG5l94gQ3OMj/lpmOBEFweLBWIwVRLX2N9lNc3poNr7O
    L977RANIhWLezmIkgwNFbh0KndpYGeRMYxoZTX0qtVRW146Bj7liiLUvZi0nEietp5Cetj
    sJsRGwTLW9VSWvYD3J5JA907Ht+C8uVy8a9gtIre/v7Ls/lg7fJiukWLBXmui4C8aVyG7o
    /Kp+oo5oKDhOQFee530ewC3yY4DxTEPsylZrAsmd6ePp8Q01nTX08+81q9r13bu3UjqCCQ
    o0HZEbCjK7IGH+6y4cqRrbVXmZLtCh5bzAXQEnPZmq3Sv64xKjT8XMi/4CttpO3Pu8TSFz
    VvcPAR5/jXb/apNdvuXiyHdn6K48yK5R7bDzX3VLQIXGgKGZUNeVa5qsJCx3cUUVYQxES7
    WJRVw2Mlg4Jj/xVcOYXGQLFBsdqtCb2a/FA22S93S0pXNCtJfSSPX/X9e22aDUHWus6Kie
    lCjLP4WCe48ee77oP6XLvm9usVfWkXRU35NRGJhNHqj4PUpXSuTrcbw+JK+U6kdVuZhqhB
    SnHW3yGCJtFoVaZinKuLjxcGUYTbgu/sFGYknd2f4L+qDX83Ba5CPGGDz9wQ
X-ME-Proxy: <xmx:Iqxjasd4rIGLlwcrtEWwqUkNvSDBAZX4jb3tHZR6_ngMqaS1Y0egaQ>
    <xmx:IqxjavnNgHbqAK0N-DcQ5l1Va1kj5lnY2XJ70F-0K3p-oLPqoJzN1A>
    <xmx:IqxjamwoKJnD3OF_spZKTCck5RHOAvfUP25-jrLfX805Zy1gA1EgRg>
    <xmx:IqxjaqP08DkXuOSGdKY80H3PCL6UCNwLlwClfyS6ymHT81kbnkwhcA>
    <xmx:I6xjau2ntso-G0hqvpBs1U3YA3xEUuWjMo2tSZLrcXFTl_01JlpLzOoo>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:17:06 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 24 Jul 2026 20:16:46 +0200
Subject: [PATCH v3 6/9] dt-bindings: i2c: apple,i2c: Add t6030 and t6031
 compatibles
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-apple-t603x-initial-devices-v3-6-bbeba0420603@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=j@jannau.net;
 h=from:subject:message-id; bh=UeodmP8zjm6vT7hJS7cbsmjEW7Hjxj6/HXGYdSRLKaI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzkNfw33a9ICC0Pu/h+xkdDM5O1Ezg5d/huj9u9wPnTu
 00Gl7/965jIwiDGxWAppsiSpP2yg2F1jWJM7YMwmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKba8gPDf9fg+cGhwqnHH5dWLsrs+GcTsFnn2Got3l/BdU3nzr2MfMfwTyHt1eO
 HglND6m52T7BMjvRe6y5rIvm7x03q4dWuwAI9DgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The i2c block on Apple silicon M3 Pro, Max and Ultra SoCs are compatible
with the t8103 (M1) one. Add "apple,t6030-i2c" for M3 Pro and
"apple,t6031-i2c" for M3 Max and Ultra as per-SoC compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 9e59200ad37b..d39f5e3f1df4 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -24,6 +24,8 @@ properties:
       - items:
           - enum:
               - apple,t6020-i2c
+              - apple,t6030-i2c
+              - apple,t6031-i2c
               - apple,t8122-i2c
           - const: apple,t8103-i2c
       - items:

-- 
2.55.0

