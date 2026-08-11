Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DE4779B2;
	Tue, 11 Aug 2026 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477037; cv=none; b=b7IqojRqMcx1CjtDZYG77H84du05aoY5yj4KrOLjBdGri9n2fJU62EPc14PnFNuTWBy9PD0JSvuXQbG66Ze/lPVoptE/VvpB5pYQrLdpQlZmRgl81tpzzD1NprBpe5AyJZSrZ4M7ggKOoIvil7OHOIO2WBu4CzuPA7KQvaKQaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477037; c=relaxed/simple;
	bh=YmFHeIB0o/O6fzGl/vGOKFOVcLF7QUtGIMGp+1SuiKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=do7kVMW/BuDKNNc3RrUz32W3hZfOV0qG6jsUVpMnuQMZTrYmhObQ9Rg1eXeIObM3ZzrJEoVhpRAAjAmwa9SAAuIWCyOx3gLJKCe5kOgcUUijtVYRfZA4nDoZWayByWoJfR+5t/2y5LkBUYMAV/IppLF7YYc+Emkkad+/jwEapMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=pbKuAzqj; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="pbKuAzqj"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786477027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVJSRmVkxCrG8V5mDry6u5L6zCqB/MC8kvPzNOG+CjU=;
	b=pbKuAzqjoBp3xQ+4aVOL/EZUlrOIHFoopo6Ata/T5mivfilqh1z1RsmpjFe9qdf2KOWFSm
	gLSbs69O+mbzVARbMK8zUniUbv15dAY70aB+9kkepyGf9Xs1IfkcatRMYhYLBLYMoO7qMg
	o2iX5UnsBlFq96/Y96PITdvdM/iSUWU=
Date: Tue, 11 Aug 2026 21:36:57 +0200
Subject: [PATCH v3 4/9] dt-bindings: power: apple,pmgr-pwrstate: Add t8132
 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-apple-m4-initial-devicetrees-v3-4-6bf32d45ad0b@cyberchaos.dev>
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
 linux-pwm@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

The device power state management of the PMGR blocks on Apple's t8132
SoC (M4) is compatible with t8103.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index e269f433524e..b24ea8e54e11 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -48,6 +48,7 @@ properties:
               - apple,t6030-pmgr-pwrstate
               - apple,t6031-pmgr-pwrstate
               - apple,t8122-pmgr-pwrstate
+              - apple,t8132-pmgr-pwrstate
           - const: apple,t8103-pmgr-pwrstate
 
   reg:

-- 
2.55.0

