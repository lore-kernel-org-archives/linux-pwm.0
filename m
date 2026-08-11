Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93D47885C;
	Tue, 11 Aug 2026 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477038; cv=none; b=QkAX/YXpIZPM796PbK9C7nxE0z+79HtTSsKgOoczDXLx9lriWIttXiTmIZLRFdoDH7VNiCnn3pvfWJyS2hHNWpFLnoeT0nnhkIiV7dpG2LvgyfUswZ+q2p8ZtFC8XNaYXc0bHKxXBPPaKoiuztKa9kTLtD9jymtIzS04ZxbncDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477038; c=relaxed/simple;
	bh=Ouo5h3JyIMugimYHRSJnAM3nW3ibP5N13SZiBVHC8w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2klP6IjhUQo1IFr9WZjgxc5kRbKmLbfkOnbytKoKYI9MYczwAn/OXFI3FfDryZvZ3fftScOb1IkXl4BYXtOCWN7N8jemku06W8JQG9Bgrv8eJfZV9WpraVx9fjhErv3LeiZcm1pHU6yVzRzCHX6X1RRxXbvpnxtd9Pdccj59SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=ecj9ROfK; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="ecj9ROfK"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786477031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKTfGsjHkFFOVCUzNK0jmRHph7SLAQ5ADYfLPSTB23Q=;
	b=ecj9ROfK+Ctm1O9qUN9c28I3MTDSiT95TJjniGfhw1E4T3edF4OXfxkldFTamFxKps9Fwy
	+qTSbDmLMRd7TzDtDooOgD+qgjY/BLZZdJ5Lg4AHK9vDCPlrv0pBmHVuCDZU0QoFzMNaqD
	kye8Fdy7aM3oPb2B3e0ONW8kzBJw8LA=
Date: Tue, 11 Aug 2026 21:37:01 +0200
Subject: [PATCH v3 8/9] dt-bindings: arm: apple: Add M4 based devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-m4-initial-devicetrees-v3-8-6bf32d45ad0b@cyberchaos.dev>
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

The Apple devices with the t8132 SoC (M4) are very similar to their M3
predecessors.

In addition to the MacBook Pro and the various MacBook Air and iMac
variants, a Mac mini is offered again with the M4.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index fb277c96f341..5d87a4fef193 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -103,6 +103,15 @@ description: |
   - MacBook Pro (14-inch, M3, 2023)
   - iMac (24-inch, M3, 2023)
 
+  Devices based on the "M4" SoC:
+
+  - MacBook Pro (14-inch, M4, 2024)
+  - iMac (24-inch, 2x USB-C, M4, 2024)
+  - iMac (24-inch, 4x USB-C, M4, 2024)
+  - MacBook Air (13-inch, M4, 2025)
+  - MacBook Air (15-inch, M4, 2025)
+  - Mac mini (M4, 2024)
+
   Devices based on the "M1 Pro", "M1 Max" and "M1 Ultra" SoCs:
 
   - MacBook Pro (14-inch, M1 Pro, 2021)
@@ -323,6 +332,18 @@ properties:
           - const: apple,t8122
           - const: apple,arm-platform
 
+      - description: Apple M4 SoC based platforms
+        items:
+          - enum:
+              - apple,j604  # MacBook Pro (14-inch, M4, 2024)
+              - apple,j623  # iMac (24-inch, 2x USB-C, M4, 2024)
+              - apple,j624  # iMac (24-inch, 4x USB-C, M4, 2024)
+              - apple,j713  # MacBook Air (13-inch, M4, 2025)
+              - apple,j715  # MacBook Air (15-inch, M4, 2025)
+              - apple,j773g # Mac mini (M4, 2024)
+          - const: apple,t8132
+          - const: apple,arm-platform
+
       - description: Apple M1 Pro SoC based platforms
         items:
           - enum:

-- 
2.55.0

