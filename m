Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813075;
	b=P9QUqsxVtgUiF9Ea5LDBAVpAcECSOGb+UEFQKglnPZ8dpyHuZkbMmU+aQTk/ws350mO4
	 tDOV0+hdz+lRA/SZJbxcf+g1Ks7IxEQ6fWztcTXV6e7orbjFlySmQh4KfzQ5vAp1egQs8
	 1yJ4/7VRnUWkJF3qlVCmTxnINdFyp5LzE2+O1VyzK3HR0bM4ImBXiUmSKV4kAV6uIqzNJ
	 QR61OstRQkYWL4aiYsc6zPC6g6zWrp39Lg9fzkmHjuAHWeyXXuf1IJ+pdWLqmv1tvAfCy
	 I4G9JwnUayEooKu+Vz3g1ZMHD+sQFwMwe1w+rV7jA5+REF+CdwAeVmpg1UJviqGCc7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813075;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=FmFhmHqchVrqj+0DB2A1OfSUsKoVGkJJrNsEk9xPgCc=;
	b=n8/yM1ckHf/3a9OoPAS/5ud31bRX/7cMsAS6n6Uu242s5olv7LevnESr8WKYjwEOISHL
	 5oyjvfoJtqMmhFC1NqCf96G4atYuzdrDEXy03XrwvSIu1ZRScvijOFiRe51pU43vzguol
	 0yK8DFU8pb0xQwzjozlu/pDwcBQmZHtOh7iEc51dkbuXbjheYD//XWPtCM2MIdSbi6wWz
	 7EtmB2SLJe88ZBgWZHqrthm3+pd+H+5GK0h3cbyuv9MXCGVSrzs9VuhVoLZXVjwnLq5lL
	 xfTEwos9s+NUBrq1iuHpnIoROBQbcQlimVBA7Wvs7wV3GVKIOVfEKVTbWFu5LwEyetw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=KIFHrY5F;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A3606D81E;
	Wed,  4 Nov 2026 17:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 532A3606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=KIFHrY5F
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793813072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmFhmHqchVrqj+0DB2A1OfSUsKoVGkJJrNsEk9xPgCc=;
	b=KIFHrY5FiYi8bvIaolJ5AS8FMJspLVlXsDCYqmOpfCtNny4JpvVkkuegokYuOuuD+A9e/6
	IbofpO/vCoiSHenbzAhmN6eXbYUEN/ci4lSQ6qD/0nWh8ZvX701rTLtMD19aldWoLrETS8
	4PCE9ZoXc/sPXMvezsYhTIPNdHTNF7Y=
Date: Wed, 04 Nov 2026 18:24:21 +0100
Subject: [PATCH v2 8/9] dt-bindings: arm: apple: Add M5 based devices
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
Message-Id: <20261104-apple-m5-initial-devicetrees-v2-8-fd727a82d380@cyberchaos.dev>
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

Only the MacBook Pro (14-inch) and MacBook Air (13/15-inch) were offered
with the M5 (t8142) SoC. Add the corresponding compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index da6f043ad07a..f78c89780355 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -116,6 +116,12 @@ description: |
   - MacBook Air (15-inch, M4, 2025)
   - Mac mini (M4, 2024)
 
+  Devices based on the "M5" SoC:
+
+  - MacBook Pro (14-inch, M5, 2026)
+  - MacBook Air (13-inch, M5, 2026)
+  - MacBook Air (15-inch, M5, 2026)
+
   Devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
 
   - MacBook Pro (14-inch, M1 Pro, 2021)
@@ -364,6 +370,15 @@ properties:
           - const: apple,t8132
           - const: apple,arm-platform
 
+      - description: Apple M5 SoC based platforms
+        items:
+          - enum:
+              - apple,j704  # MacBook Pro (14-inch, M5, 2025)
+              - apple,j813  # MacBook Air (13-inch, M5, 2026)
+              - apple,j815  # MacBook Air (15-inch, M5, 2026)
+          - const: apple,t8142
+          - const: apple,arm-platform
+
       - description: Apple M1 Pro SoC based platforms
         items:
           - enum:

-- 
2.56.0

