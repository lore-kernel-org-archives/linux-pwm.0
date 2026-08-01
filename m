Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A079CD;
	Sat,  1 Aug 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608154; cv=none; b=I6wSaarfEcDt1nksTIOxXEQNffwkX5xsEJXcajswjPjGZAEMSyFXvXgnUlC64QnKANzY669UHqko4ntpYks2RDzEO1Inonjg2qyOIjnWZwkQ73jcEZbDiR2fl7QbnOdqH+SsvlW2wzvbMVeZllrClbRr7RwxYDERgpYoG3hrUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608154; c=relaxed/simple;
	bh=K0AyXNi0Ltn8qj51ctnbmxqvNPYjn0QPOZYZ3i6lJhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swpwUVb+e1UJIJSRBBU6ydX7FldoLBMsA6A77kii3lA7/BL74MxkoWt8BWN/o9E4gSszvcADAxlHqKGchlrrW+DBVbuxKxOpeIx8JvXhwCQCwmTIJHpeNTre2EM+pbJOD/8oIZrCmNP788hsPU954jb9MJ5im1SkQnLmSjVWWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwP0T/OA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwP0T/OA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ADF1F00AC4;
	Sat,  1 Aug 2026 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608153;
	bh=PknnHsN6cYkEV2qshK7jMvnLf1tIvHLs47/Frwf5Bog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QwP0T/OAFIfXj1w2mhnw1eQ1/59mXM1FqKZ9Eo4DkhFUwePJCID6otQ6dvbzbobC8
	 Z/32MFsNQXqFSLM+7EZqPjojs/LzcWZtxouWuqQZvvkoWpcSNextYNinyFSvmYPnZs
	 Jf55wfCKkYia7yHamXBicgJLdPmnEWqdgNc+A3KKgAM63vn/Ee+rcNmVqcPfzf0TzQ
	 9ScoDEGXzSm1rhWCnZfv5n8vFAOVlgaZ6Pg64Zr5SqAm7hQUM+sPoBATTVrINXArxW
	 v2wyzxWWTv4gXJZnPM4/zy56b6OTKbdaLidFh4inlAidn17HfleX0+riILkKy3Mhnr
	 aPtI3ivAXoscw==
From: Sven Peter <sven@kernel.org>
To: Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/9] Initial Apple M3 Pro, Max and Ultra device trees
Date: Sat,  1 Aug 2026 20:14:29 +0200
Message-ID: <178560804761.33352.11895011679898131857.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
References: <20260724-apple-t603x-initial-devices-v3-0-bbeba0420603@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 24 Jul 2026 20:16:40 +0200, Janne Grunau wrote:
> This series adds device trees for Apple silicon devices with M3 Pro, Max
> and Ultra SoCs. The M3 generation has fewer devices than their M1 and M2
> predecessors. The only non-laptop device is the M3 Ultra Mac Studio. The
> Laptops are the known 14 and 16-inch Macbook Pros now with M3 Pro and
> M3 Max SoCs. The M3 Max variant with fewer CPU and GPU cores has
> additionally only a 384-bit wide memory bus instead of 512-bit of the
> full M3 Max. It has a separate identifier (T6034) and so there are six
> laptop device trees.
> Another difference to M1 and M2 Pro/Max/Ultra is that the M3 Pro is
> distinct SoC design and not a smaller M3 Max. For this reason both M3
> Max variants and the M3 Ultra will use "apple,t6030" as compatible
> prefix. In the M1 and M2 generations Pro, Max and Ultra SoCs shared
> "apple,t6000" / "apple,t6020" as common prefix. There is currently no
> known difference but M3 Pro and M3 Max are not as closely related as
> previously.
> 
> [...]

Applied to sven/linux (apple-soc/dt-7.3), thanks!

[1/9] dt-bindings: arm: apple: Add M3 Pro/Max/Ultra devices (T603x)
      https://github.com/AsahiLinux/linux/commit/f3a01f769afd
[2/9] dt-bindings: interrupt-controller: apple,aic2: Invert #interrupt-cells condition
      https://github.com/AsahiLinux/linux/commit/6545de50dc94
[3/9] dt-bindings: interrupt-controller: apple,aic2: Add apple,t6031-aic3 compatible
      https://github.com/AsahiLinux/linux/commit/c3157833d661
[4/9] dt-bindings: arm: apple: apple,pmgr: Add t6030 and t6031 compatibles
      https://github.com/AsahiLinux/linux/commit/6fe9f80cca52
[5/9] dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles
      https://github.com/AsahiLinux/linux/commit/5b4f03afdeaa
[6/9] dt-bindings: i2c: apple,i2c: Add t6030 and t6031 compatibles
      https://github.com/AsahiLinux/linux/commit/225d33916d95
[7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and t6031 compatibles
      https://github.com/AsahiLinux/linux/commit/b7ccb1b0bc73
[8/9] arm64: dts: apple: Initial T603[124] (M3 Max and Ultra) device trees
      https://github.com/AsahiLinux/linux/commit/396331cc6447
[9/9] arm64: dts: apple: Initial T6030 (M3 Pro) device trees
      https://github.com/AsahiLinux/linux/commit/0f259b86d9f8

Best regards,
-- 
Sven Peter <sven@kernel.org>

