Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2A453A45;
	Mon, 31 Aug 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187205; cv=none; b=p/h9sa1jw+qiYq0OkhZuZbGhvnY3kagyQs4Uuxgx6UYHB7C2RznvpOKYQx3a/C/l8T8tIZabNeu8RSOU369x7Qm5CIawSl0yTdzSpXe+NUqUR/lNDhXJxnsedQvIJ2mM3CHd3mbjIJV9O5VNqb/HIuG+zrb1DlzTYqYW6rYFPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187205; c=relaxed/simple;
	bh=J/6pTHziJWAL2tsEb6RSS9sOTTk+yYx0QHsCvWJMn80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IU29owuAuVCyhYRCk+NN0UKMLEGenLqLI/HbihtRrenmS51h2eTQq6jDQiB2XcWPLeFIdTD2sXFfZlFFARK9RxCRReHtHfwyNZsHVI1AwuizuanJjHz/URrFreuX9Lz52x+l9M5yGpFbd7oajv2t8dtbqQiPxyappFnzjlhPTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM8DaxTD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM8DaxTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853881F000E9;
	Mon, 31 Aug 2026 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187203;
	bh=yMpGKzLtEyNcCRVx8mHNOB6Q4YD3ZVD6yfJwV9Ggd9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KM8DaxTDZU+seS1CP7yk4Spfvw2SF9Cz52bCXjTTDovAqR/DJUvxLyzM1GeKFe6p0
	 G8iDHxy89iB3DdgJD+QTsLOaFhmLnPClXer0fin6IoF8/PZNWaBprknu/XO3Lx5B+s
	 E+I7WmVpLF1lj71bXdfwvaGsFTW1vxs81AoARn+2IFbH2VeimlxFGixyAwtvzDXm0Q
	 khHHJRt4VFbBHmYUwgeBIyJfjaB+OYmQoFuw+Ul3o2RIbx7u/UB4IKbA+BDe/oHsfW
	 S8sgDBwgy4upUauqZ4Uic8X92EkBRfj4wqqmUBsyIRlAKHG6IUZJFHA/ma86L5X7VI
	 P5/+P1L0CWNyA==
From: Sven Peter <sven@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Hector Martin <marcan@marcan.st>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/9] Initial Apple Silicon M4 device trees and dt-bindings
Date: Mon, 31 Aug 2026 16:39:42 +0200
Message-ID: <178818713424.102394.1070287458177331117.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-apple-m4-initial-devicetrees-v3-0-6bf32d45ad0b@cyberchaos.dev>
References: <20260811-apple-m4-initial-devicetrees-v3-0-6bf32d45ad0b@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 21:36:53 +0200, Yureka Lilian wrote:
> This series adds initial device trees and dt-bindings for the Apple
> Silicon devices using the M4 (t8132) SoC. For the most part it mirrors
> Janne's M3 (t8122) bringup series as it was merged in the 7.2 cycle.
> 
> This series covers only a minimal amount of hardware, which is useful
> as a basis for future developments. The hardware added here has remained
> largely unchanged between the M3 and M4 generations.
> 
> [...]

Applied to local tree (apple-soc/dt-7.4), thanks!

[1/9] dt-bindings: arm: cpus: Add Apple M4 CPU core compatibles
      https://github.com/AsahiLinux/linux/commit/4be8659603b0
[2/9] dt-bindings: interrupt-controller: apple,aic2: Add apple,t8132 compatible
      https://github.com/AsahiLinux/linux/commit/1a8b7a1131af
[3/9] dt-bindings: arm: apple: apple,pmgr: Add t8132 compatible
      https://github.com/AsahiLinux/linux/commit/f8805ac96c9b
[4/9] dt-bindings: power: apple,pmgr-pwrstate: Add t8132 compatible
      https://github.com/AsahiLinux/linux/commit/bda617ad4171
[5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8132 compatible
      https://github.com/AsahiLinux/linux/commit/7d0c3b4c41e2
[6/9] dt-bindings: i2c: apple,i2c: Add t8132 compatible
      https://github.com/AsahiLinux/linux/commit/12672a9c9180
[7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8132 compatible
      https://github.com/AsahiLinux/linux/commit/a581a2343c45
[8/9] dt-bindings: arm: apple: Add M4 based devices
      https://github.com/AsahiLinux/linux/commit/e23d2b23739e
[9/9] arm64: dts: apple: Add minimal t8132 (M4) device trees
      https://github.com/AsahiLinux/linux/commit/23850378ade7

Best regards,
-- 
Sven Peter <sven@kernel.org>

