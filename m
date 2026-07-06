Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9B3E5A0D;
	Mon,  6 Jul 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324818; cv=none; b=bABqvUfGqk9U9f2ZnVWOXTqX3MZR1YOeBFr01L0IVi2QAXtkWUbrYXg0P9FAu88ndbcL+qiyVT5dyBPZvvj++j59uYRY0LB/s8MBsi1AQqx2HKoHs/mxQ/Jhy//xuYe6wgYWE8lOaLM56wiXgf/xnPlWoGZRM38NUKsUOr20hio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324818; c=relaxed/simple;
	bh=J0UXQBVC6slWTu42W04+KBzla1TY0Qdc1nm+GGlNDng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihWAXolbNG+oPBDRd8vdcx+FeMJXQb7OYTluVDjgSyXJO/FI83AXTztRl+6tucLBVW6U2fx/X2Z8pIVsgXo9my4FMP4gRyf/Cg5ScsbHn3VXZHGpHmbC4sY5JtCrSET8e2ZTJdkEI7Z7RDn99Ra9iZhDUjmOsHseoFCeN0wZxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY46IlKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY46IlKn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3BF351F000E9;
	Mon,  6 Jul 2026 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783324810;
	bh=lqU4e5Q1m6/KSdYhQISfuMhNKB61bOzA57gwbwECHLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aY46IlKnMTbFROzRG0hfXJiZIlsBs3hu9b4hws1eEKzrA2xPz6A8z5Pbe7KQZBBB0
	 n3NX2op00V973QC/mRb1zIlHIyYz9cel77f0TuL9S4GY4H4SQG8jmFuglTF2s+peaL
	 WpM4t7mjWshlzg6IpbaSQPBUclHbcvjIfdz6zMro1yJ2lMs6t/CE3Luc9RyvsiP5XH
	 Tmozet/RnpeyPhm1Ef2uP1/CWhsMCznK2RNK9D72h3johhrf2GjBeoNG+ULBWqPJso
	 YK+d1lBoxDcVo+zg+jsWsdQSWFmF/55Xx46XQ9YvatR7DNJ7CYB3iXT4ze4J8fFnvi
	 yVVGGbgxnBbSg==
Date: Mon, 6 Jul 2026 10:00:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: keguang.zhang@gmail.com
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register
 handling
Message-ID: <aktdkn-NcQt7J1YS@monoceros>
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-1-5492db953879@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zgsluocuiejujrs"
Content-Disposition: inline
In-Reply-To: <20260626-pwm-loongson-fix-v2-1-5492db953879@gmail.com>


--6zgsluocuiejujrs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register
 handling
MIME-Version: 1.0

Hello,

On Fri, Jun 26, 2026 at 08:24:22PM +0800, Keguang Zhang via B4 Relay wrote:
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
> Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/pwm/pwm-loongson.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index 31a57edecfd0..69514b5a1324 100644
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
> @@ -33,10 +34,13 @@
>  #include <linux/units.h>
> =20
>  /* Loongson PWM registers */
> -#define LOONGSON_PWM_REG_DUTY		0x4 /* Low Pulse Buffer Register */
> +#define LOONGSON_PWM_REG_LOW		0x4 /* Low Pulse Buffer Register */
>  #define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
>  #define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
> =20
> +#define LOONGSON_PWM_MAX_LOW		GENMASK(31, 0)
> +#define LOONGSON_PWM_MAX_PERIOD		GENMASK(31, 0)
> +
>  /* Control register bits */
>  #define LOONGSON_PWM_CTRL_REG_EN	BIT(0)  /* Counter Enable Bit */
>  #define LOONGSON_PWM_CTRL_REG_OE	BIT(3)  /* Pulse Output Enable Control =
Bit, Valid Low */
> @@ -118,20 +122,20 @@ static int pwm_loongson_enable(struct pwm_chip *chi=
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
> +	/* low =3D (period_ns - duty_ns) * ddata->clk_rate / NSEC_PER_SEC */
> +	low =3D mul_u64_u64_div_u64_roundup(period_ns - duty_ns, ddata->clk_rat=
e, NSEC_PER_SEC);

This is wrong. Consider clk_rate =3D 1234567 and the request duty_ns =3D
1234 [ns] and period_ns =3D 123456 [ns]

Then you get

	low =3D (123456 - 1234) * 1234567 // 1e9 =3D 150
	period =3D 123456 * 1234567 // 1e9 =3D 152

so the actual duty cycle is (152 - 150) * 1e9 / 1234567 =3D
1620.0011826008633 which is bigger than the requested value.

The correct approach is

	duty =3D mul_u64_u64_div_u64_roundup(duty_ns, ddata->clk_rate, NSEC_PER_SE=
C);
	period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);

	low =3D period - duty;

which yields

	duty =3D 1
	period =3D 152 (as before)
	low =3D 151

=2E

> +	if ((!FIELD_FIT(LOONGSON_PWM_MAX_LOW, low)))
> +		low =3D LOONGSON_PWM_MAX_LOW;
> =20
>  	/* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
>  	period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC=
);
> -	if (period > U32_MAX)
> -		period =3D U32_MAX;
> +	if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> +		period =3D LOONGSON_PWM_MAX_PERIOD;
> =20
> -	pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
> +	pwm_loongson_writel(ddata, low, LOONGSON_PWM_REG_LOW);
>  	pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
> =20
>  	return 0;
> @@ -166,15 +170,15 @@ static int pwm_loongson_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
>  				  struct pwm_state *state)
>  {
> -	u32 duty, period, ctrl;
> +	u32 low, period, ctrl;
>  	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> =20
> -	duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> +	low =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_LOW);
>  	period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
>  	ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> =20
> -	/* duty & period have a max of 2^32, so we can't overflow */
> -	state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_SEC, ddat=
a->clk_rate);
> +	/* low & period have a max of 2^32, so we can't overflow */
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)(period - low) * NSEC_PER=
_SEC, ddata->clk_rate);

What happens if low > period?

>  	state->period =3D DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC, ddata-=
>clk_rate);
>  	state->polarity =3D (ctrl & LOONGSON_PWM_CTRL_REG_INVERT) ? PWM_POLARIT=
Y_INVERSED :
>  			  PWM_POLARITY_NORMAL;

Best regards
Uwe

--6zgsluocuiejujrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpLYIYACgkQj4D7WH0S
/k6bkgf9ERhwGW0QWzsNSb0ss/+Xl3W+5NX8HbnEpV6UMzm1g1CWuJjgvwPOqbEY
9Tqcn9T0RTxRUViIAn5ZEdLsuCNRlAxlA/JKnoP4Dxe7pypvFSiA+V48QhHhFtQ2
QjTYmR1i9BXsolJ8BUuAbuOywpxEvIzKvQj9NjIM1me0gwho60FB3RH2Z81Jo9N/
ZR612bIV/6NYrR3P0Sg1vAADyGn2sKZ9Dw6Ln8BLW8aJ+4voZkSnwJGqamnoE469
klzA97feY+yDeGKu3xFRAi/V5paOVn/UoScueLUSNxQ9mxunPl2zLPNnjo+qweYF
sMYApNEZYBD1Mmp7W4SNCFbVVie+pw==
=VOZ2
-----END PGP SIGNATURE-----

--6zgsluocuiejujrs--
