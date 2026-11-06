Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000306;
	b=QJbr+9twMVVoC7QKSw25nllcwrsH4hutAeQ6tjj/UdnpO/+UX24Hghzfcc8G2ROilejo
	 oJRtIOyKzgpXHD9B5s0TOU60u41d+ZIWPHbjeRc3Yz0t1PDa6BtYMmsrImXlr7xNtnHLh
	 cK6bQrtdy4v5E4JWkGV8kWUqWyTptssO6V3vTb9eUnrYCoKmw+2l2WLjJ+pu5Y6eaiVWD
	 AeG1YrRmop9d3ksfURuDs3gd/9B72K+A9t7ic0HynBDhFmNsL0ZE+WJIC3kRz9hmwqZgq
	 eM/69KNTFZ9hO1TWvCbSPJsRz1qVvfBiKo9DujrTACA4NHhlUNNgTw1c/r5/BrA/67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000306;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=vNw98TulTGI8RlWvt5yNDg9lFfwWrwXKijxuB0xHpIc=;
	b=1OlQ+Xhx/0zym1JYIvcEyVTeqAhzTVaPq+WNd1w+A0QvExJSJkhu2Bu3MgQEZHgBk1oW
	 tLkq7DkNp4VP2g8Qikw/Dc9jaykW2m9BkVWkQbQU1HfAPbYo0C5V1ACOmKlJOols5YMpF
	 xNekkmNUDvNJa8g8IIa7r5dMY6bRaGRcIXGK2TjTT5aERNZM+ypRXFuV+l+oyi0QapiKe
	 DCX10Zqsa6TniD7xvWVuhlYZs5C2nuk6SNnJGyuxgc2MtqOJfxXV52ZFDHO7ei6bq8yCj
	 /LEeFYK0/1XY7PG65c2eW1aFzpCGGCVgjcF/XG9QZ5Yb1b6R0JVNm+taILCwjdmxzUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b="XD5/bFsc";
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A9606A33D;
	Fri,  6 Nov 2026 21:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809A9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=XD5/bFsc
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794000303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNw98TulTGI8RlWvt5yNDg9lFfwWrwXKijxuB0xHpIc=;
	b=XD5/bFscPAHJASvpPL3CHultPB/QfZPTx3vINDcf49knjZ7CHShkHQJ1UXCQwcjVA0RjCB
	pUXTcLAZHsJP1euJ1jKoRxIJZLJhaEB+kkKhVu5D5pn0Jfdb2vKpFY44p9tOz8tXk199ZT
	iCUmO0bWSLWpF3BhGEa6+HyAyifp8XU=
Date: Fri, 06 Nov 2026 22:24:53 +0100
Subject: [PATCH v3 4/9] dt-bindings: arm: apple: apple,pmgr: Add t8142
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
Message-Id: <20261106-apple-m5-initial-devicetrees-v3-4-cee55de54b2f@cyberchaos.dev>
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
In-Reply-To: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
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

