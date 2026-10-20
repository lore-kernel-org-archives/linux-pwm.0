Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501952;
	b=B2inaqy8S0BuRfdXY9z3aiCyWe1Q8A95t/hEmx7QZRy+w/UIf8uhufJnyjzKnAHRZlfR
	 Y9PLAGZVuB5TP6tl9qko0zdMptbsZNCBrWO03dQ2CCHz1iHaaC1Pde0SJbez4T+q5ttd/
	 xHhvdtXKx5lrzb3ajIZDxOhEsBVJ2YaXbSZDvxulIXHsoITU4JuZJDnnZEdAlqgtKbYmy
	 MHFp75QqFPmoBean6KMVNZE74NAkdd7FVadY+Dgf3t7f2ADzeVtPRN1lbHfpr0mWfZGwP
	 HmLjqGQxhhvz7SrjozaXZSEyra+NADhd5vPnqfxaRFQ/ReDfuNYDVwvhImRHUIoy4FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501952;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mLH7EE0P/cBxzO77Jo/U46xQ+1iDdQqu3DFFcJQaToU=;
	b=pkM6YoQ+l4W/a0KNLvRV6QIqK/xQxuoRFUHTrr8Z8atBcQc/qHb6RrDjOUdp3DoNz/0O
	 uI7KZGcfu8IfApfGTXNzmYcsbxITdKzJJmzlBNL/dX6yPZuna3YamStyEL8z+2mxYxNiX
	 ZsrBKZi39+l8d7NrKM32tNVR1THMEKO7pEx6H0S5WllfRuM9uE4LT5hYYLf7LY6/Vup2c
	 ExpRE3Z7pGBrpZynGKftTKx6/vVaSKBae4CuICrAznpoBxcj+4aZZfJRqQrEk4APnvk0x
	 R2t+6GT7BOOmQ9Y3rg7ZSQCVzJ7YEyFfTPljkLNfHWROei/ShODSARaVG2tvA4WAjUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgWxF8O1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0B1B606A321;
	Tue, 20 Oct 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgWxF8O1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E94661F000C4;
	Tue, 20 Oct 2026 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501951;
	bh=mLH7EE0P/cBxzO77Jo/U46xQ+1iDdQqu3DFFcJQaToU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HgWxF8O19xHIPWPMVKK37t9FMBVs/9GJCs7Wjo2MKp6fjEzwFg5I7Ux/sTbnW69EO
	 RXZbltFL2HmDHfE8chUCJO7AWwtQx5ZE2eRr6BZ+hick3rc3PvDL73j35eHnU4QPXW
	 rxShnICo/DYTEE7SKMsKMRjs+mv5zwO+lpt3UrTdnKJqcfRlFFDJEOlV/Xms2lAayG
	 IGcusHkmPxiNeo+d3v+vbvmwARxH+myoTbbn3E9L6ymgHaVHUlh9tQrD7D0pOhtFVY
	 B6L+g6BN3aa9DiPEOwTiai5rvppCoVbunvL+4ceNBayoLJgBlTJ5pU8shBBJB2nWE5
	 k/caMHeSp6NOA==
Date: Tue, 20 Oct 2026 15:12:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Stephane Lepain <stephanelepain@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-pwm@vger.kernel.org, Kenneth Kasilag <kenneth@kasilag.me>, 
	George Moussalem <george.moussalem@outlook.com>, Devi Priya <quic_devipriy@quicinc.com>, 
	Baruch Siach <baruch.siach@siklu.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: ipq: fix period calculation
Message-ID: <atdmO41XhQhbas5x@monoceros>
References: <20260731070427.155221-1-stephanelepain@gmail.com>
 <20260803044748.27116-1-stephanelepain@gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="beukunx2nwgtu75i"
Content-Disposition: inline
In-Reply-To: <20260803044748.27116-1-stephanelepain@gmail.com>


--beukunx2nwgtu75i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: ipq: fix period calculation
MIME-Version: 1.0

Hello,

On Mon, Aug 03, 2026 at 06:47:48AM +0200, Stephane Lepain wrote:
> From: Kenneth Kasilag <kenneth@kasilag.me>
>=20
> ipq_pwm_apply() fixes pwm_div at its maximum and derives only pre_div
> from the requested period. Since the period spans
> (pre_div + 1) * (pwm_div + 1) input clocks, pinning pwm_div near its
> maximum forces pre_div towards zero for short periods: once pre_div
> rounds to 0 the shortest representable period is (pwm_div + 1) / clk_rate,
> and any shorter request is rejected outright:
>=20
> 	pre_div =3D mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
> 				      (u64)NSEC_PER_SEC * (pwm_div + 1));
> 	if (!pre_div)
> 		return -ERANGE;
>=20
> Four-wire fans commonly expect a ~25 kHz PWM, which is therefore
> unusable. On an IPQ6018 with the PWM block clocked at 100 MHz, a
> 40,000 ns (25 kHz) request computes floor(0.061) =3D=3D 0 and returns
> -ERANGE deterministically. Where a request is not rejected outright, the
> high duration truncates to 0 and the output collapses to ~0% duty.
>=20
> Search for the (pre_div, pwm_div) pair whose period best approximates

"best" is very subjective. The original author valued fine grained duty
selection over the higher period range.

> the request instead of fixing pwm_div. Starting pre_div at the smallest
> value that keeps pwm_div within its field and stopping once pre_div
> exceeds pwm_div bounds the loop and keeps pwm_div as large as possible
> for fine duty resolution. For a 25 kHz request at 100 MHz this selects
> pre_div =3D 0, pwm_div =3D 3999, i.e. exactly 4000 clocks, with full 0..4=
000
> duty resolution.
>=20
> While reworking the high-duration computation, round it to nearest
> rather than truncating,

round to nearest is wrong. The official promise of the core to its
consumers is that all values are round down. There are offenders, but
I'm not willing to increase their number.

> so mid-range duty cycles are not biased low, and
> clamp it to pwm_div + 1. Rounding, or a 100% duty request, could
> otherwise push hi_dur past the period length and overflow the 16-bit
> HI_DURATION field.

That's something that the driver has to catch if this is an issue for
the hardware.

> This was first fixed downstream in OpenWrt for the qualcommbe target
> after testing on the Askey SBE1V1K, and has since been applied to
> OpenWrt's qualcommax target as well.
>=20
> Tested on a GL.iNet GL-AXT1800 (IPQ6018, 100 MHz PWM clock) whose DTS
> requests a 25 kHz period for its four-wire fan:
>=20
>   pwms =3D <&pwm 1 40000 0>;
>=20
> Before, pwm-fan failed to probe on every boot:
>=20
>   pwm-fan pwm-fan: failed to enable PWM
>   pwm-fan pwm-fan: Failed to configure PWM: -34
>   pwm-fan pwm-fan: probe with driver pwm-fan failed with error -34
>=20
> The same failure is reproducible without pwm-fan, straight from sysfs:
>=20
>   # echo 40000   > period; echo 1 > enable   -> write error (-ERANGE)
>   # echo 2700000 > period; echo 1 > enable   -> succeeds
>=20
> Because probe returns before the tachometer IRQ is requested and before
> fan-supply is claimed, the board also lost fan RPM reporting and its
> vcc_fan regulator stayed disabled, leaving the DTS cooling-maps with no
> cooling device to bind to.

The waveform API is more flexible, so the right way forward includes
converting the ipq driver to that.

> After, pwm-fan probes cleanly and the fan is confirmed spinning by its
> own tachometer:
>=20
>   /sys/class/hwmon/hwmon7/name                          =3D pwmfan
>   /sys/devices/platform/pwm-fan/hwmon/hwmon7/fan1_input =3D 3548
>   /sys/class/regulator/regulator.3 (vcc_fan)            =3D enabled
>   /sys/class/thermal/cooling_device1                    =3D pwm-fan
>=20
> with idle SoC temperature dropping from ~76 =B0C to ~51 =B0C.
>=20
> Fixes: c436e3e9c265 ("pwm: Driver for qualcomm ipq6018 pwm block")

I wouldn't call it a fix. The driver behaves as expected (by the core),
so what you're doing here is not a fix.

> Signed-off-by: Kenneth Kasilag <kenneth@kasilag.me>
> [Stephane: dropped the explanatory comment, the unreachable
>  clk_rate > 16 GHz bound and the unrelated hi_div cast, per review]
> Tested-by: Stephane Lepain <stephanelepain@gmail.com>
> Signed-off-by: Stephane Lepain <stephanelepain@gmail.com>
> ---
> Changes in v3:
> - Resend: v2 accidentally carried a stray copy of the whole driver at
>   t/drivers/pwm/pwm-ipq.c (a leftover verification directory that got
>   swept into the commit). Only drivers/pwm/pwm-ipq.c is touched here.
> - No functional change from v2.
>=20
> Changes in v2 (per Konrad Dybcio's review):
> - Dropped the explanatory comment above the divider search; the rationale
>   lives in the commit message.
> - Dropped the "clk_rate > 16 * GIGA" bound. period_ns is already clamped
>   to IPQ_PWM_MAX_PERIOD_NS (1e9), so period_ns * clk_rate only overflows
>   u64 above ~18.4 GHz, i.e. ~184x the 100 MHz this block runs at; the
>   check was unreachable.
> - Dropped the "(u64)hi_div" cast as unrelated. It is not a live bug
>   either: hi_dur and pre_div both come from 16-bit fields, so the worst
>   case 65535 * 65536 =3D 4294901760 still fits u32 (effective_div on the
>   line above genuinely does need the cast, at 65536 * 65536).
> - Behaviour is unchanged: for 40,000 ns at 100 MHz the search still
>   selects pre_div =3D 0, pwm_div =3D 3999.
>=20
>  drivers/pwm/pwm-ipq.c | 91 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> index c533739..797559d 100644
> --- a/drivers/pwm/pwm-ipq.c
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -89,10 +89,10 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
>  			 const struct pwm_state *state)
>  {
>  	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
> -	unsigned int pre_div, pwm_div;
> -	u64 period_ns, duty_ns;
> +	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
> +	u64 period_ns, duty_ns, period_rate, min_diff;
>  	unsigned long val =3D 0;
> -	unsigned long hi_dur;
> +	u64 hi_dur;
> =20
>  	if (!state->enabled) {
>  		/* clear IPQ_PWM_REG1_ENABLE */
> @@ -112,35 +112,74 @@ static int ipq_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>  	duty_ns =3D min(state->duty_cycle, period_ns);
> =20
> -	/*
> -	 * Pick the maximal value for PWM_DIV that still allows a
> -	 * 100% relative duty cycle. This allows a fine grained
> -	 * selection of duty cycles.
> -	 */
> -	pwm_div =3D IPQ_PWM_MAX_DIV - 1;
> +	period_rate =3D period_ns * ipq_chip->clk_rate;
> +
> +	best_pre_div =3D IPQ_PWM_MAX_DIV;
> +	best_pwm_div =3D IPQ_PWM_MAX_DIV;
> +	min_diff =3D period_rate;
> =20
>  	/*
> -	 * although mul_u64_u64_div_u64 returns a u64, in practice it
> -	 * won't overflow due to above constraints. Take the max period
> -	 * of 10^9 (NSEC_PER_SEC) and the pwm_div + 1 (IPQ_PWM_MAX_DIV)
> -	 *  10^9 * 10^8
> -	 * ------------- =3D> which fits well into a 32-bit unsigned int.
> -	 * 10^9 * 65,535
> +	 * Smaller pre_div than this cannot represent the period (pwm_div would
> +	 * have to exceed its field), so start the search there.
>  	 */
> -	pre_div =3D mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
> -				      (u64)NSEC_PER_SEC * (pwm_div + 1));
> -
> -	if (!pre_div)
> -		return -ERANGE;
> +	pre_div =3D div64_u64(period_rate,
> +			    (u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
> +
> +	for (; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
> +		u64 remainder;
> +
> +		pwm_div =3D div64_u64_rem(period_rate,
> +					(u64)NSEC_PER_SEC * (pre_div + 1),
> +					&remainder);
> +		/* pwm_div is unsigned; the swap check below catches underflow */
> +		pwm_div--;
> +
> +		/*
> +		 * Swapping pre_div and pwm_div yields the same period but a
> +		 * larger pwm_div gives finer duty resolution, so once pre_div
> +		 * exceeds pwm_div every further candidate is strictly worse.
> +		 */
> +		if (pre_div > pwm_div)
> +			break;
> +
> +		/* need room for 100% duty, where hi_dur =3D=3D pwm_div + 1 */
> +		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
> +			continue;
> +
> +		if (remainder < min_diff) {
> +			best_pre_div =3D pre_div;
> +			best_pwm_div =3D pwm_div;
> +			min_diff =3D remainder;
> +
> +			if (min_diff =3D=3D 0)
> +				break;
> +		}
> +	}

I didn't try to do the maths here, but usually you can determine the
needed values without a loop.

> -	pre_div -=3D 1;
> +	pre_div =3D best_pre_div;
> +	pwm_div =3D best_pwm_div;
> =20
> -	if (pre_div > IPQ_PWM_MAX_DIV)
> -		pre_div =3D IPQ_PWM_MAX_DIV;
> +	/*
> +	 * If the search found no usable candidate, best_pwm_div is left at
> +	 * IPQ_PWM_MAX_DIV; cap it so pwm_div + 1 still fits the 16-bit field
> +	 * and 100% duty remains expressible.
> +	 */
> +	if (pwm_div > IPQ_PWM_MAX_DIV - 1)
> +		pwm_div =3D IPQ_PWM_MAX_DIV - 1;
> =20
> -	/* pwm duty =3D HI_DUR * (PRE_DIV + 1) / clk_rate */
> -	hi_dur =3D mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
> -				     (u64)NSEC_PER_SEC * (pre_div + 1));
> +	/*
> +	 * high duration =3D duty_ratio * (pwm_div + 1)
> +	 *              =3D duty_ns * clk_rate / ((pre_div + 1) * NSEC_PER_SEC)
                    ^
missing space here -' to align the =3D.

> +	 *
> +	 * Round to nearest to avoid biasing every duty cycle low, then clamp
> +	 * to (pwm_div + 1): rounding or a 100% request can otherwise push
> +	 * hi_dur past the period, overflowing the 16-bit HI_DURATION field
> +	 * and asking the hardware to stay high beyond one period.
> +	 */

Best regards
Uwe

--beukunx2nwgtu75i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrXaLoACgkQj4D7WH0S
/k5ZRAf/RXPBuszebMCMpicBsyvA1p3x+/5Waw0nllho6GNQNHJo0TZZRsRdmpY2
UCkTPVAVkp19CBXGnoHL5Lu6unWRYJhJgd/cWS84opOhxUp9TDBK5SYzg8gjypqD
aEqKGsro8ae7JBNgPM/7Dg8ffVeuHrNYNpSwt9Q1apeHCRdHdq3gJuq6ldjPCsqF
w74Jz0+/uPH/rnFMLYT2nFqAJRmnLidTA9usGDZ2JqyilHo1780qxrBFw0tOFZVa
2uvPoQjOIUsGnxNTrXMc2yHesq1jHhUb8JuI5IMFoq50f8U/VKw3E3KJkstNzs+n
dArvXSaPGphhYoBkcBJ1pRygP5ZLZw==
=Dv9B
-----END PGP SIGNATURE-----

--beukunx2nwgtu75i--
