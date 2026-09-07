Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38673BFAD9;
	Mon,  7 Sep 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772693; cv=none; b=E+aD76nNd0oEbBph9TnWDTS4Udl0Cbn1yyIur2u1gNYmSSH1HvwVJ6h7U7jL/bdKxQDNlT+q5hucV88gCWZ5j2Hh+RulfMWESOhaIAfy9KAW+0PeJiZ3ZmVtfswQHhwnP/8rHH9SSqiKKq2caOrAK2QlbnWxh4AxpidTSD0bPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772693; c=relaxed/simple;
	bh=hQUTdEhPqVVhEcwvcK+xJyXQVUmljL9MFNZ5tY2Q88I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv1MUUKYFzdpKMj52yT7WhVeelHPZztVLrEia7/qLvZG946E4h5F+0jOasv1jSqoLVGg+WS5PIzlqB0eFIJtOpdMOAApiXkyib6p3uqG1polbX7sq4RMNNaHC30IfmG04HVjWErtzaA3jQOF2hc8SixIj6fuwBoFtWJVoiKQwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiPGE7lF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiPGE7lF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DA33B1F00A3D;
	Mon,  7 Sep 2026 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788772691;
	bh=wHyGtpzCA2UeJuKcWokcD3vWTCf9cr25A+AFNW1+xAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NiPGE7lFV/HpXwdfBdTwzMxjWRo95qu+9LXVpniNX6k5Tlt/LUHttZrSFeT+MM9kx
	 xMxjfbUbdxicz/7uy7OYUJ4+w4KhFQ78tSf2ZY0wfmtTyGzeKKBFXoEaioAxlnFt+r
	 iCUv/qNVLLgYE+L0+8zKx/xmWO+teFWzrKyDlT1n0HqOGwGpGIQXFivjtHYgObXbcr
	 VdIki8JQGqNZNmkP5hZ07WBuaGDVQsLe9mmMbZ/ZvvwTY7ctBfn3tzR6LDyZtfWVkh
	 wn9URmXX5IwOxg3u8le+3MbtXUBF5kyVTgDuv9/rPl++O+QlHHLJW0QoKDpFN+fwHc
	 804IdheX9T+7w==
Date: Mon, 7 Sep 2026 11:18:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: keguang.zhang@gmail.com
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] pwm: loongson: Fix low pulse buffer register
 handling
Message-ID: <ap599_CvfJSjk-2l@monoceros>
References: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
 <20260715-pwm-loongson-fix-v3-1-0aab2847eaa7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mgll4jd2v5glfqpy"
Content-Disposition: inline
In-Reply-To: <20260715-pwm-loongson-fix-v3-1-0aab2847eaa7@gmail.com>


--mgll4jd2v5glfqpy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] pwm: loongson: Fix low pulse buffer register
 handling
MIME-Version: 1.0

Hello Keguang,

On Wed, Jul 15, 2026 at 07:05:23PM +0800, Keguang Zhang via B4 Relay wrote:
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
>  drivers/pwm/pwm-loongson.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index f2fb35b7af2b..e703217a6d5e 100644
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

Can you please make this a minimal fix and do the rework in a separate
patch? This way it a backport to stable is easier to motivate.

> +
>  /* Control register bits */
>  #define LOONGSON_PWM_CTRL_REG_EN	BIT(0)  /* Counter Enable Bit */
>  #define LOONGSON_PWM_CTRL_REG_OE	BIT(3)  /* Pulse Output Enable Control =
Bit, Valid Low */
> @@ -118,20 +122,21 @@ static int pwm_loongson_enable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
>  			       u64 duty_ns, u64 period_ns)
>  {
> -	u64 duty, period;
> +	u64 low, duty, period;
>  	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> =20
> -	/* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> -	duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
> -	if (duty > U32_MAX)
> -		duty =3D U32_MAX;
> -
>  	/* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
>  	period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC=
);
> -	if (period > U32_MAX)
> -		period =3D U32_MAX;
> +	if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> +		period =3D LOONGSON_PWM_MAX_PERIOD;
> =20
> -	pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
> +	/* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> +	duty =3D mul_u64_u64_div_u64_roundup(duty_ns, ddata->clk_rate, NSEC_PER=
_SEC);
> +	low =3D period - duty;

This might overflow. I think in that case the right thing happens (at
least I failed to find an example that results in bogous settings), but
that might be worth to be handled (either by a comment explaining it or
explicitly limiting duty to be <=3D period first).

> +	if ((!FIELD_FIT(LOONGSON_PWM_MAX_LOW, low)))
> +		low =3D LOONGSON_PWM_MAX_LOW;
> +
> +	pwm_loongson_writel(ddata, low, LOONGSON_PWM_REG_LOW);
>  	pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
> =20
>  	return 0;
> @@ -166,15 +171,20 @@ static int pwm_loongson_apply(struct pwm_chip *chip=
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

2^32-1 is the maximal value, right? (This was already wrong before.)

> +	if (low > period)
> +		state->duty_cycle =3D 0;
> +	else
> +		state->duty_cycle =3D
> +		    DIV64_U64_ROUND_UP((u64)(period - low) * NSEC_PER_SEC, ddata->clk_=
rate);
> +
>  	state->period =3D DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC, ddata-=
>clk_rate);
>  	state->polarity =3D (ctrl & LOONGSON_PWM_CTRL_REG_INVERT) ? PWM_POLARIT=
Y_INVERSED :
>  			  PWM_POLARITY_NORMAL;

You could do s/>/>=3D/ as a micro optimisation, but I don't care much.
Otherwise the adaption to pwm_loongson_get_state() looks fine.

Best regards
Uwe

--mgll4jd2v5glfqpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqegU4ACgkQj4D7WH0S
/k5AdggAnKEqeY4F+jpjdgYhLaD+THJmkSKcrwCNVIXJrjwt/ultwauiyDO4N4LS
RF0yfMl+eSRP6F+pAudsOwy0taz5UBPo22UKrED1Yc8/oEtnKG9uVmuVl8zNOCp6
pvgbMKNWfUurRVzAfFxSeMjc7qNGX1y4pgVO2K9fL2l5HS4GiZ3tXN1b5ds3khLB
XDUwous8hLgrGdzoqVzVJ+cvAcxET8j2zTyuo9HY1SpmA+kzjIz/MTp6gNp8qwYq
/rL+K4rY9WZpfF0ucSSdOfrqWjdRZkxXhxG85LQc2f1kn1QsSrx8+BMmhs1OBVql
es8II48rQy8daHHWCvdolDwrQ5xhfw==
=ypFN
-----END PGP SIGNATURE-----

--mgll4jd2v5glfqpy--
