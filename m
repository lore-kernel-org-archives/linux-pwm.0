Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916653D1CAA;
	Sat,  1 Aug 2026 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620491; cv=none; b=jxfFtp176LS0Uk+V102UEaVxNkmQ6vHnDeDSAP8UhXaMGLnC9oiav9DCPYJ2URzBsOqexg7YIbSqGXISuVFSmrJ7iv8i7i2DCcEz88/JZzVtNfAkWfV1Zz9naC9QkVR+XTLITKsuQioDW9JTG4HSzzpcEMqtvIRUsLx26CCIu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620491; c=relaxed/simple;
	bh=dP3ZduCMWYgP/bwVMFxsI2J8qyA6oS0rXd1WFEbON0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0h1InrnmoiEvxppAjp+8KLAV55nXtLgsi/OJenyIkTEjTd8lOCNJYrkUUa1lj6FMRLV5c/67Uwkvf9K5zuLSuZ31UOT4VMCozjsXjiNwZrNuISDpM+qzSEzLpcvvvYP6rymSI0byc8sF0YrxrCzwUnwMGAdaqJafJdqr20qcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=mPJBCV9B; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="mPJBCV9B"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1785620488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgeVZmWljHnvNrY9ON+31e506GvxYaKm1tdjs4LqrMk=;
	b=mPJBCV9B7Mwb+09dfaEDcMCXZIxc00VrOnUC5rQpR1E6jIluk8xdwnZfT9zPHnGmSy3Nwk
	nt3CXUd8ndc9ROU/iTeHVrJYLO47WmHSo5vS8QaKeULb32XPet67e5Ba8ZWqEbBAYrqc3V
	g0Z/uz+N5X9Cd9Cc6PDDpdwkJ/qxCGc=
Date: Sat, 01 Aug 2026 23:40:36 +0200
Subject: [PATCH v2 6/9] dt-bindings: i2c: apple,i2c: Add t8132 compatible
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-apple-m4-initial-devicetrees-v2-6-5cb07cc275da@cyberchaos.dev>
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

The i2c block on the Apple silicon t8132 (M4) SoC is compatible with
t8103. Add "apple,t8132-i2c" as SoC specific compatible under
"apple,t8103-i2c".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index d39f5e3f1df4..641f24b0ef4b 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -27,6 +27,7 @@ properties:
               - apple,t6030-i2c
               - apple,t6031-i2c
               - apple,t8122-i2c
+              - apple,t8132-i2c
           - const: apple,t8103-i2c
       - items:
           - enum:

-- 
2.55.0

