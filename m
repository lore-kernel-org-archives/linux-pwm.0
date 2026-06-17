Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357B466B5D;
	Wed, 17 Jun 2026 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712253; cv=none; b=kYBLjgPs4PqJLhy4WtMm1LtQn0ttHIo3OAZYoR3pTKrV+jtuelBut7e19AyC9TnRdQGoxO15tT8YH1W5/91kjjGqEXjKQB/xzuF9P/eIz84IgSgK4SkJhkrcribeSszi+XL27AKszRBJdJA3/cljwQJCxplVkXKB9wM6fPFHbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712253; c=relaxed/simple;
	bh=xaTbMy8ubL2fG2S4V7Hoy1CdSA8YjOFrSFH1L75WTpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNC01/tZoN7V3G5iM+JLJSwlql4ukxe/QIbV8RHs7IzXU8VAjJcxAZapEQpGuy/x/1V/WvhHGsSoIIHLTic/3YEiohDXeZNAUu1pUXM5mmmMT51nDHGLkGXso4xLmXBsQbVVOEgi8bY1z/ZFRJoUvFPinvZG8awIqXb6SUkyht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaYokiYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaYokiYn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EE7451F000E9;
	Wed, 17 Jun 2026 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712242;
	bh=aosZkFsjb5/qXdpiuGV0O/YbUwJvdVqiCkBohSzGuaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NaYokiYnq5m9EdOQZknchaC6LQma132zQcwalsdR9kt8Z+HvX84B6gNfRmuLS5x4i
	 I3Rbu5AVOaRiL1Uo3zobTHavAledMfWZGH77fq+HkHYvL8VVzleIDftltSbnW+i6O3
	 HX5Yruh1Pxf88V/3eO533+cdMAIJIUMCighRjFqynZhwCqKTC8CSkNp1qmM87E2fQh
	 R5m4j0t4nNSidfz+Gn9i48lCz/4MxfAdEBpdsrRp66U6NuHby4KiOWQridsLmUFR4t
	 LbdizcsfWB/Ocfn0oU1V8YHqdFP+EC2/qDCoOxEUVuBoyn1k1yHhS5TVFojR+dEjLw
	 AF0SSQuGqBhIg==
Date: Wed, 17 Jun 2026 18:03:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: keguang.zhang@gmail.com
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: loongson: Fix low pulse buffer register handling
Message-ID: <ajLDoiFEO_8Y5_1S@monoceros>
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
 <20260616-pwm-loongson-fix-v1-1-491dbf260a7f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="266lxil6oi5bwzgb"
Content-Disposition: inline
In-Reply-To: <20260616-pwm-loongson-fix-v1-1-491dbf260a7f@gmail.com>


--266lxil6oi5bwzgb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] pwm: loongson: Fix low pulse buffer register handling
MIME-Version: 1.0

On Tue, Jun 16, 2026 at 07:13:17PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> The Loongson PWM register at offset 0x4 is documented as the Low
> Pulse Buffer Register, which stores the low pulse width rather than
> the duty cycle.
>=20
> However, this register was incorrectly defined and treated as a
> duty-cycle register. As a result, the duty cycle and low pulse cycle
> are swapped in the generated PWM waveform.
>=20
> Program the low pulse (period - duty) into the register and
> adjust pwm_loongson_get_state() accordingly when reconstructing the
> duty cycle.
>=20
> Also return -ERANGE when the requested period exceeds the hardware
> 32-bit limit instead of silently truncating the value.

This is the intended behaviour.

> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/pwm/pwm-loongson.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index 31a57edecfd0..dc77f82fd888 100644
> --- a/drivers/pwm/pwm-loongson.c
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -22,6 +22,7 @@
>   */
> =20
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -33,10 +34,12 @@
>  #include <linux/units.h>
> =20
>  /* Loongson PWM registers */
> -#define LOONGSON_PWM_REG_DUTY		0x4 /* Low Pulse Buffer Register */
> +#define LOONGSON_PWM_REG_LOW		0x4 /* Low Pulse Buffer Register */
>  #define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
>  #define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
> =20
> +#define LOONGSON_PWM_MAX_PERIOD		GENMASK(31, 0)
> +
>  /* Control register bits */
>  #define LOONGSON_PWM_CTRL_REG_EN	BIT(0)  /* Counter Enable Bit */
>  #define LOONGSON_PWM_CTRL_REG_OE	BIT(3)  /* Pulse Output Enable Control =
Bit, Valid Low */
> @@ -118,20 +121,16 @@ static int pwm_loongson_enable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
>  			       u64 duty_ns, u64 period_ns)
>  {
> -	u64 duty, period;
> +	u64 low, period;
>  	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> =20
> -	/* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> -	duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
> -	if (duty > U32_MAX)
> -		duty =3D U32_MAX;
> -
> -	/* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
>  	period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC=
);
> -	if (period > U32_MAX)
> -		period =3D U32_MAX;
> +	if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> +		return -ERANGE;

As noted above, this is wrong. If period is too big, you're supposed to
pick the biggest possible period and not return an error.

> +
> +	low =3D mul_u64_u64_div_u64(period_ns - duty_ns, ddata->clk_rate, NSEC_=
PER_SEC);

this is also wrong. You're supposed to pick a configuration where the
duty is the biggest not bigger than the requested value. However as
mul_u64_u64_div_u64 rounds down, you're rounding in the wrong direction.

The register layout suggests that the period starts with the inactive
part, did you reverify that?

Best regards
Uwe

--266lxil6oi5bwzgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyxW0ACgkQj4D7WH0S
/k6OXAgAqEf1mW/BxMPm9337Oe10Bu3XNFxrFULDEL+sfezm3424dBfC9LvgvzG3
SvhTr8J3kCU7qsyPiAY0CmZaHqN9bdGN/BdPegOqHmWkDV7AjVLUtbzeo6Kmn5dE
LM9GI5Dny4jY9RY1kGpUweQqseLEVvYV5ooZ10UsJ5PvYDizRuzHjsSK3Jnthj9R
AN84laxR018gs3/jqAk4SPeo3AvxSCAmJWGopLDIEv5k80fdyte5SFPcWtSgcVpn
ikgCUQPUY+8IGKseKq0aKiJICPMopr1w7Nlszp/f21EgEKQVszT6gHKW4oMlpQV0
HKDmblfAKIRoq9bi1KPwqBKqvGn/sA==
=mlzC
-----END PGP SIGNATURE-----

--266lxil6oi5bwzgb--
