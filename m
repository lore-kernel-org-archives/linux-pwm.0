Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660951;
	b=dQ40LXTjCUpuTnq676wn9DHzt3Kh1uM0mqm4RS25dhRkV+plIBfc8mg5lBPMmcWtLuGx
	 qhCCm9E9s5vLhsWP4rBhUm3ahKGg2u+D+Mu3aSSKo1LQaVEPmweotR6XR4hcze85R/LLf
	 zVKG+uJ0TkHxh8gl84J0snJLeXHwIcRCjnZQSaBUTeOSY/dOwuxtTZmr7H9vAEoy3yeep
	 gZSaVAxB+G3TOI6vYcVHxtC4x81Xplc776RCxbt+dI6iPceXXctLaMj2lQyXWnysU6Vq4
	 KMTn8Pf8l5H7hMSVB1GaRz7EjLTSKp4CWLaaJaoeIGj03/49foJ+hGBegCHf74+q2Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=smsm9ORhlPLDL5Nh8b0iZrku9Rm60/Khp9VarBhUFVE=;
	b=lmY/VMVa9Emx1zhNMWq79ZDHlH4id32l+2fHI2/qexJh/Tyi+mIPpl0A7tHKuCPLD94J
	 wPrY1Uusr9rwn9hU+AVrxWmNS3h2WMNg3ocZXDXguPsi2KLtv9Gf5MBTo/+9eNSRP+Azd
	 e5PJALN8oODSEn3nxb1l+ht+PJodnQjJEXeXUOhXMI+xkH0ZTTO3n7Yge2tEiEuEo0eTm
	 FOHqCc49KFoVq/iLKZdNFvzVg5H2+wheOEUqvyED0Q9uugSplYhKuadYHvKbjD2C93GZ0
	 35yOg/qk/YAyjrN6qnLiV/mhncQPJP22ZFAPf9ygZVrfwOvO1H/84K1bpE2ifX1HIhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaRvVopr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7F606A339;
	Sat, 14 Nov 2026 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HaRvVopr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999561F000C4;
	Sat, 14 Nov 2026 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794660951;
	bh=smsm9ORhlPLDL5Nh8b0iZrku9Rm60/Khp9VarBhUFVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HaRvVoprCDXokhEvfXZunmRZ57OmBK16G+vrZvsktNqZvW7E/xHKpv36TJTsWKYT5
	 tTMPncTJThx6q/vu9xmS01xlENgIj7cvILxowW59ARBvtu/gjo2TewkJsYVMyTorW8
	 qtJztDUvKjpG8nHDxthKgjsvNqtB/fIUpqhMfY1qN2ViK1Q7vW3fJ4bL8XNtK7wYAY
	 4a/jl1QUtSOCKf2HYMCt80ciwPqM9Di8KqOO88qAvNfB4Vc7Pxj7BbQNU0ujjGe6DP
	 Oxp9cLMtLX6vNE2iQbiEkdJgFHw8+j5znujzqq5L83FIvIRJnGzg+/CQKoomalIMqm
	 X9cCjnXmhtlJw==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/9] Initial Apple Silicon M5 device trees and dt-bindings
Date: Sat, 14 Nov 2026 13:55:34 +0100
Message-ID: <179466091298.20315.10220651986509721816.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
References: <20261106-apple-m5-initial-devicetrees-v3-0-cee55de54b2f@cyberchaos.dev>
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
Content-Transfer-Encoding: 8bit

On Fri, 06 Nov 2026 22:24:49 +0100, Yureka Lilian wrote:
> This series adds initial device trees and dt-bindings for the Apple
> Silicon devices using the M5 (t8142) SoCs.
> 
> This series covers only a minimal amount of hardware, which is useful
> as a basis for future developments. The hardware added here has remained
> largely unchanged from the earlier Apple Silicon generations.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/dt-7.5), thanks!

[1/9] dt-bindings: interrupt-controller: apple,aic2: Add t8142 compatible
      https://github.com/AsahiLinux/linux/commit/d2ece48ec448
[2/9] dt-bindings: arm: cpus: Add Apple M5 CPU core compatibles
      https://github.com/AsahiLinux/linux/commit/29d432305187
[3/9] dt-bindings: arm: power: apple,pmgr-pwrstate: Add t8142 compatible
      https://github.com/AsahiLinux/linux/commit/a61030626ec1
[4/9] dt-bindings: arm: apple: apple,pmgr: Add t8142 compatible
      https://github.com/AsahiLinux/linux/commit/ca25b9f84383
[5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142 compatible
      https://github.com/AsahiLinux/linux/commit/d60bedaceff2
[6/9] dt-bindings: pinctrl: apple,pinctrl: Add t8142 compatible
      https://github.com/AsahiLinux/linux/commit/d39d10bf2b37
[7/9] dt-bindings: i2c: apple,i2c: Add t8142 compatible
      https://github.com/AsahiLinux/linux/commit/b2755abb177e
[8/9] dt-bindings: arm: apple: Add M5 based devices
      https://github.com/AsahiLinux/linux/commit/33cfb254ebb8
[9/9] arm64: dts: apple: Add minimal t8142 (M5) device trees
      https://github.com/AsahiLinux/linux/commit/b9a12ab2c2d5

Best regards,
-- 
Sven Peter <sven@kernel.org>

