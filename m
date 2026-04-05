Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CF40DFAF;
	Sun,  5 Apr 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775375624; cv=none; b=JJ2XR93KUhWZrEnjBt1IIqICGmXSllH0t81XzvxF6Wj7zqWYCG2rYVZyf5ks/xYRo7EhSIzuvE/30D4wCb3UQ+gZ6jdHvx+ccURgRpqZHClHFydw8FpRj/qsaZuQiUTfV1amUPByYumeij04By+JZREpKsPBbu/ILiCETFVuJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775375624; c=relaxed/simple;
	bh=mmT6pS2qy6cxZpqzi3T3vnIlGk445m471lTjYAty8AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT9k9RgUkQVRe8myiuCWv7oRnk0yI0UbUreuOmbV5WuI3HaQrFf6WAFLDYYv8zV3flRo5kl2n6t1zAtZtW9gnhNRx/wtrL9Hr+SC9pVmypXqb5/MDJHF5/TRF1qDqJDG6/plRnHQRQVITPssaHgxZxTe+wRITXw3wwZnGPOWDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fywhHBR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fywhHBR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE19C116C6;
	Sun,  5 Apr 2026 07:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775375624;
	bh=mmT6pS2qy6cxZpqzi3T3vnIlGk445m471lTjYAty8AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fywhHBR2CBjI23v0w3up56C9cMDZNh/BxiClQFDTaz+8M0J92oOsIo8ehZx8FCrNy
	 GHISB9tq9laaOWb9XCIY1j+OWZPNo1ju2jRKd8KKGnfTcSfEKXN4TEDxgBjZThA04i
	 bAfTyF3G9UanDv/2nN20AA+gawgWl8gOx6KqZasuETWVmxzIJ/GEo+G3OG1P+yX502
	 0Tn4O/6dmTIXbPkGSaMIVXzovM+EJ+jbJLz2QFudu6d6TUJfPhyHrNO2ZeCrgTLlKh
	 R5h4gU2yfNV/AbACVYBHSYvk6wHK3rg9WJy7D06QASRN1nRGwUt9BJYiXjIuiLECwe
	 f5ob7221EliKA==
Date: Sun, 5 Apr 2026 09:53:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 3/3] arm64: dts: broadcom: rp1: Add PWM node
Message-ID: <20260405-tremendous-colorful-spoonbill-88debb@quoll>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <ef79e974c6680202294a4cfde7cc791753bf1b3e.1775223441.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef79e974c6680202294a4cfde7cc791753bf1b3e.1775223441.git.andrea.porta@suse.com>

On Fri, Apr 03, 2026 at 04:31:56PM +0200, Andrea della Porta wrote:
> +
>  &rp1_usb0 {
>  	pinctrl-0 = <&usb_vbus_default_state>;
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> index 5a815c3797945..7e78501e62b0c 100644
> --- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> @@ -56,6 +56,16 @@ rp1_eth: ethernet@40100000 {
>  		#size-cells = <0>;
>  	};
>  
> +	rp1_pwm: pwm@4009c000 {

Don't break the order. Instead please read and follow DTS coding style.

Best regards,
Krzysztof

