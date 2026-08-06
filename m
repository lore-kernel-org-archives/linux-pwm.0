Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5484334C1;
	Thu,  6 Aug 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010678; cv=none; b=WRQRaHhM6+zGr+Dq4jGhd9yXQIS5DkxeDDmw8DFi/MO/Twvx8QwVUU8O/wYr817UH7qFp6LW/0SY0i2PPbg7Hq7TcVio07b0tdRQPX7iO4ez27C74Sl1hAaXSUotn1QJP27m1VlVe2Cg4hhkMxnPS81AM/KNGspTcEsKikZ5Css=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010678; c=relaxed/simple;
	bh=g8N09sQ7+n26z20HOBNc7m22lVupQdaAjZNvoBGpEgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJUl7mzd/hCyX08AoegB1/hLU3C9JTI+9rxYZVSPua62ko3pxhbo/GqI+npBeZULUh89Uh5dkmrq4jqwnMJuiI+vyg8UsjkW7MEdpA+SxpuicY4BCANVyf0dXnAn+9we4V/1rwh0JUQpbUAbX35LMZN8o9ASZpY4HNe7Qo9gXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9wHswZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9wHswZn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D742E1F00A3A;
	Thu,  6 Aug 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786010676;
	bh=EvfjZC9+BJl+tHW2HeH5B1q6/FvCkYz1fIW9Dc4GRXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l9wHswZnH0VZ5WnJ6vBhnNGe69jlToiJUhWX/SkuYWp0Y6UpqTNKsrcHlLkQxf2jO
	 LhCywSbWq8veEc+5eCv4IRTK6zEjheTIclipwzEsawbLel0BJrW0UU4Rqk7AfvFh77
	 euq0TZeZfTwiEX4nT6Z+0UaD1KLcbsN9Grs0br1dTgJIIHuF74VgLmnodD9e/9hD/7
	 buG4fCodh9tcOqM8e5LDOaXmmcyAn4zsdSGioQXMLEs//5X1mn81Mp3rQ7eS6xmtig
	 FhXyWBgdNBhdnOgRkhr46HUox+C5TlnykN9oP1of1z4ZuH4uTZwem3sTBStzx86dw8
	 oGzxNPVbOix6g==
Date: Thu, 6 Aug 2026 12:04:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, Tzu-Hao Wei <twei@axiado.com>, 
	Karthikeyan Mitran <kmitran@axiado.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: add Axiado AX3000 and AX3005 PWM fan
 controller driver
Message-ID: <anRaB--HAHoWFkDo@monoceros>
References: <20260806-axiado-ax3000-pwm-fan-v1-0-f6db4cf2166b@axiado.com>
 <20260806-axiado-ax3000-pwm-fan-v1-2-f6db4cf2166b@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phnqktoz57ccllis"
Content-Disposition: inline
In-Reply-To: <20260806-axiado-ax3000-pwm-fan-v1-2-f6db4cf2166b@axiado.com>


--phnqktoz57ccllis
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] hwmon: add Axiado AX3000 and AX3005 PWM fan
 controller driver
MIME-Version: 1.0

On Thu, Aug 06, 2026 at 02:01:30AM -0700, Petar Stepanovic wrote:
> +#define PWM_MAX	255

That define has a name that looks much more generic than it actually is.
Please call it AX_TACH_PWM_VAL_MAX or something similar.

> [...]
> +static int axiado_pwm_fan_read(struct device *dev, enum hwmon_sensor_types type,
> +			       u32 attr, int channel, long *val)
> +{
> +	struct axiado_pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		if (attr != hwmon_pwm_input)
> +			return -EOPNOTSUPP;
> +
> +		scoped_guard(mutex, &ctx->pwm_lock)
> +			*val = ctx->pwm_value;

If there is a hwmon lock that serializes calls to hwmon_ops::read and
hwmon_ops::write, .pwm_lock isn't needed. (Unless I miss something,
please double check. Also I'm unsure if there is such a hwmon
serialization.)

> [...]
> +static const struct of_device_id axiado_pwm_fan_match[] = {
> +	{ .compatible = "axiado,ax3000-pwm-fan" },
> +	{ },

No trailing , after the list terminator please.

> +};
> +MODULE_DEVICE_TABLE(of, axiado_pwm_fan_match);
> +
> +static struct platform_driver axiado_pwm_fan_driver = {
> +	.probe		= axiado_pwm_fan_probe,
> +	.shutdown	= axiado_pwm_fan_shutdown,
> +	.driver	= {
> +		.name		= "axiado-pwm-fan",
> +		.pm		= pm_sleep_ptr(&axiado_pwm_fan_pm),
> +		.of_match_table	= axiado_pwm_fan_match,
> +	},
> +};
> +
> +module_platform_driver(axiado_pwm_fan_driver);

Typically `module_platform_driver` follows the struct platform_driver
without a newline.

> +MODULE_AUTHOR("Axiado Corporation");
> +MODULE_DESCRIPTION("Axiado PWM fan controller driver");
> +MODULE_LICENSE("GPL");
> +

Trailing newline at end of file.

Best regards
Uwe

--phnqktoz57ccllis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp0XC8ACgkQj4D7WH0S
/k6CtggAqc2SkaT/74paCQn8c06aLqh+ZQkQt9kOhzsh+nqXBbzoUpyzYVbZ1qKf
KljBTvQZl662s+bADLObfOmJraNBFmm4geuKju1SwTtb4306Vq9YyVCz1QNSlcVz
IGmVDdNGZFpIOa9TpCH6yxDwpSZG0NS6s7AphknUn7pROhVDFGgPAKuU99SxGicj
63kSmknKODrbwIQZNPNQcVGHHwMzbHL8s/cY5KOxhHir6ZcjnL8qeuKVMagPeI1b
4o4/N2UiUDomVIp3Uyj3R2sUBzN+TjtbM+KWQKGfPQZEWanKRDdoo06r2w4yJkdd
p3w5vHhYuCUQi44Swaz41xcqITW3sA==
=Mni6
-----END PGP SIGNATURE-----

--phnqktoz57ccllis--
