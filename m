Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9113FBEBC;
	Thu, 16 Jul 2026 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215780; cv=none; b=pEekFjq48+PahOoNpZCYMA9iv/OtYToUDk+01P6UwaIH9OiZ/6Iu2xmJ3Ru1l4kUcpiopU+je3YgBcobLUd41i6BoCRNAsP4CESQlLgE7geV0N62efBjOsnVLSAaAALzBSg2e80ZePhUG9CumabfUleQguPzEnTkj+APlFPO2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215780; c=relaxed/simple;
	bh=Tt7J5EbIB5pJt9YrW20EHTycHCeF5+1iZaVfF3urwRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0YB/PFD2jytbfqN9Sk6nCirj6b4UAZZNegLgYTOXE6XJnWKFWuPaJ2p1r2NdpH39d5a+wzY4mEpY234DZDb0CvKnVlGUQWWSUzkEjEX6NQ7aYGIBSLf8xnvWKOjitwbbV5Qz3ohCHhwXEmxxqyPtz8SvLHRj2WsvtyAnzVj1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzEcp0g4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzEcp0g4"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D48871F000E9;
	Thu, 16 Jul 2026 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215779;
	bh=kyrnJ2HVNlROAH9IfoAcIDk9irdu02X3VrWYVuptvgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzEcp0g4579s4xbXT2Rx/tV0OU5tUuMTvLn/8CYkJtvCTa6RRp5KkMNKul2lX9T6u
	 lKA42fE6/hN7AJ6KxvWcgl7kr0dNbXmIEiZVyp8vr6gKzZwWglICVXvcuZ5q4LdDRt
	 x6dtBYKBQhrqQvqs0CHWyeOqIoH459G3IBFjmmJge5mflzXtT9GKJxJSzbrjpPz3Xz
	 vF00+v3WJNn8E0j72TGIkGxedS8BlXuo9DmGO/RO5Bvhe9J/ZTNvupzN/OvDHBRghx
	 2xnHRtZt4LmeofU8LT1l30VuYy5OMwlIY1uvnjhdhCL3Mxb/8QKRHSTPGxLy/3DOCS
	 JvOWgqpkNzp+g==
Date: Thu, 16 Jul 2026 17:29:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v4 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Message-ID: <alj1UapHAq9f_MiF@monoceros>
References: <20260617025925.2539334-1-cwweng.linux@gmail.com>
 <20260617025925.2539334-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vnwt4hsu7dtmhebl"
Content-Disposition: inline
In-Reply-To: <20260617025925.2539334-3-cwweng.linux@gmail.com>


--vnwt4hsu7dtmhebl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
MIME-Version: 1.0

Hello,

On Wed, Jun 17, 2026 at 10:59:25AM +0800, Chi-Wen Weng wrote:
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>

Please don't include that file, <linux/platform_device.h> should pull in
the things you need from that file.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define MA35D1_REG_PWM_CTL0			0x00
> +#define MA35D1_REG_PWM_CTL1			0x04
> +#define MA35D1_REG_PWM_CNTEN			0x20
> +#define MA35D1_REG_PWM_PERIOD(ch)		(0x30 + 4 * (ch))
> +#define MA35D1_REG_PWM_CMPDAT(ch)		(0x50 + 4 * (ch))
> +#define MA35D1_REG_PWM_WGCTL0			0xb0
> +#define MA35D1_REG_PWM_WGCTL1			0xb4
> +#define MA35D1_REG_PWM_POLCTL			0xd4
> +#define MA35D1_REG_PWM_POEN			0xd8
> +
> +#define MA35D1_PWM_CTL1_CNTMODE_MASK(ch)	BIT(16 + (ch))
> +#define MA35D1_PWM_CTL1_OUTMODE_MASK(ch)	BIT(24 + ((ch) / 2))
> +
> +#define MA35D1_PWM_WGCTL_ACTION_MASK		0x3
> +#define MA35D1_PWM_WGCTL_ACTION_LOW		1
> +#define MA35D1_PWM_WGCTL_ACTION_HIGH		2

If you make this:

	#define MA35D1_PWM_WGCTL_ACTION(ch)		GENMASK(2 * (ch) + 2, 2 * (ch))
	#define MA35D1_PWM_WGCTL_ACTION_LOW		1
	#define MA35D1_PWM_WGCTL_ACTION_HIGH		2

you can drop the static inlines below.

> +
> +#define MA35D1_PWM_WGCTL_ZERO_HIGH(ch)		\
> +	(MA35D1_PWM_WGCTL_ACTION_HIGH << (2 * (ch)))
> +#define MA35D1_PWM_WGCTL_CMP_UP_LOW(ch)		\
> +	(MA35D1_PWM_WGCTL_ACTION_LOW << (2 * (ch)))
> +
> +#define MA35D1_PWM_CNTEN_EN(ch)			BIT(ch)
> +#define MA35D1_PWM_POEN_EN(ch)			BIT(ch)
> +#define MA35D1_PWM_POLCTL_INV(ch)		BIT(ch)
> +
> +#define MA35D1_PWM_MAX_CMPDAT			0xffff
> +#define MA35D1_PWM_MAX_PERIOD			0xfffe
> +#define MA35D1_PWM_MAX_PERIOD_CYCLES		(MA35D1_PWM_MAX_PERIOD + 1)

This is irritating with similar names and different values/semantic.

> +#define MA35D1_PWM_NUM_CHANNELS			6
> +
> [...]
> +static int nuvoton_pwm_probe(struct platform_device *pdev)
> +{
> [...]
> +	nuvoton_pwm_init(nvtpwm);

This clobbers what the hardware is doing. The idea here is to not modify
the hardware settings at probe time to keep e.g. a backlight configured
as it was setup by the bootloader and only modify on explicit calls to
.apply().

> +
> +	chip->ops = &nuvoton_pwm_ops;
> +	chip->atomic = true;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to add PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--vnwt4hsu7dtmhebl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpY+N4ACgkQj4D7WH0S
/k6t2ggAheUc/ihnKZtwZNGhIC3uzj83mpSYNAZepbhHbkXa31Mzdnt+h/tT4sn1
mpELBZ65mL0V6g2fFCU7ADnE4B08y6LY0Joa7gnhwJvomVpCHGaxuUz9xrz2n8Be
77CF/uiA1qFQIJPNOSitR4XR1kUwRTJPdBCQhHbBL36a+RnLlV5+bTTQ5AEYwq5k
ELPBKwALXAnGQE1djJ9B0o/mTAeDHtuBJTN7UTp6bOcw23cq76rjPV/PfwhhTDg8
c63oZ/aobLfuqE/7FuSibebXh/fdI/J+IJVk5YhN7RZlwK0cLlW95CFY5zT7PtT5
QdlmEEpZ3RU6ip0h1KUyJNiu3J4Qjg==
=nrGB
-----END PGP SIGNATURE-----

--vnwt4hsu7dtmhebl--
