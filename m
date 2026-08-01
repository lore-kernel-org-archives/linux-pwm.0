Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538C3CF678;
	Sat,  1 Aug 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620496; cv=none; b=oboJ5MZ3fUhP/TRjlPDYQzJr9eQ6hVgbKnZUWTTsw/06xqdYEZyFFEfUAKs4TBW35YixsuleifiNwTe/i10xXy7y3ZNvUAb4ESPLMYvHzwT5oQI6NukEUdzJ7+CNs35RCPxhgXni2zp7pkAlaFsjUsv1pNZ6nTzfvZJrXuX7A50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620496; c=relaxed/simple;
	bh=0dUO9cRWqmqZYdG/6Vj65qv6cUae0UbLXhnULaVb/oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ecch3cs2aXRQ+D6wfclxpQZO+vFbVjUzUz9ZNMz9dpXFEmrBggGSpeEvceT/SdZtPYsmGaOl7YWgHEuV2YAIfl9kJYvP/qDKCLcTX4qmq4X3GpimJrky0mR2U3u5Y16L7mznM9XEsq+H5k9YACPOtY5kePTZPiohHbmfn8eMXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=DgKZMBJW; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="DgKZMBJW"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1785620492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+tOmBwltvbaApS+3tNMuJI15d9yWVj352U6mU7Zkwaw=;
	b=DgKZMBJWCkMGV1PdjXqMLYQl6z11iJgZOihjCqksc+UMRx3fdRgxXSF2WiUwsuW9ZCxXEO
	8wh01hfNuuU4PRNr0v23c/A7565jl4kPjshtaviQso74c33Nz8z1UEaoonGvSyjH0BWTFN
	HBjls6d9xLDiHjnLYIkTM88Ks/BSvqs=
Date: Sat, 01 Aug 2026 23:40:37 +0200
Subject: [PATCH v2 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260801-apple-m4-initial-devicetrees-v2-7-5cb07cc275da@cyberchaos.dev>
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
 linux-pwm@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The PWM controller on the Apple silicon t8132 (M4) SoC is compatible
with t8103. Add "apple,t8132-fpwm" as SoC specific compatible under
"apple,s5l-fpwm".

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
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

