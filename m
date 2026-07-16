Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0A3F410E;
	Thu, 16 Jul 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191627; cv=none; b=N5MaRzRbXkwWbDE5EwsG/MY6R4lnkmBUS07AjL+sQFYVpoTd/gvyw1V+rb/FJ/ZIxAzMhE1o4bgN6ras81IsUkt37KGOwdqcXxLp6gxnyhLNO47WpkSEX1ONHE3WzosJF8chd4d2hAZa17RCMFnB2XLe/E5O7L5Ov8kSWy5ee0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191627; c=relaxed/simple;
	bh=V96eveXXw/8w7eMXoIuqEjUFOxnN4jPAoMCDMigAfDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+HDEfPv5AhECUOlSnEUFOYQVFIuaeaOOszEcVXR6VpZkOMbcdm1wFzXyQjuC218z5sT3w2pXdBki64l41gxIqc8pzJFh9a07n/SCWZuqSli5fFQxliMgheU9OQGHMpPzv0Lpm0UNctNg/ohu9f4V6yO5lzP8peq3V/B0JgglV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3DVOSGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3DVOSGj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6111E1F000E9;
	Thu, 16 Jul 2026 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784191623;
	bh=wrVyxsM07pG4Xh/tm9vRspS1NEmiJQzntn8rJKinX3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l3DVOSGjsmFVFIxw+2SpYPYpYqUiWjz5QeCoiMtOX+QiQEI+vEd7olQRF4f9z/dCJ
	 1raVb3uMbuXPr6n24iK7i8SdSULfTCmnZMlz6SQnspSrpKQJ0JFDwImPH1u8WQxsKT
	 ENIEsB2zFeVriRgHGpkdkpBVt7z9Qxf9JmMcwLooEN3njKHZN4IlC9XLgq7G8kaGaO
	 +J/MPvSQRwkAHKeQCKIns0u1C8OCfLEL2hdoGYpsWrbVse1tRYo1+94vKgwEHUeIQO
	 maNB8/GsNHxwRy1lqn+w+8FLRJienVyqmugZqb6KW9WQbGDxRT7SyjXuZRQoGhPRFi
	 NrLxVXddRC9ng==
Date: Thu, 16 Jul 2026 10:47:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 06/11] pwm: rzg2l-gpt: Convert to waveform callbacks
Message-ID: <aliXW2JWc6OoY9FG@monoceros>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfe2gi5zq5zuhfln"
Content-Disposition: inline
In-Reply-To: <20260604095647.108654-7-biju.das.jz@bp.renesas.com>


--cfe2gi5zq5zuhfln
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 06/11] pwm: rzg2l-gpt: Convert to waveform callbacks
MIME-Version: 1.0

Hello Biju,

On Thu, Jun 04, 2026 at 10:56:36AM +0100, Biju wrote:
> @@ -291,29 +285,84 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
>  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> =20
> -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
>  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> -				return -EBUSY;
> +				is_small_second_period =3D true;
> =20
>  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
>  		}
>  	}
> =20
> -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> +	wfhw->gtpr =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescal=
e);
> +	wfhw->gtccr =3D 0;
> +	if (is_small_second_period)

If is_small_second_period =3D=3D true, the prescale doesn't need to be
recalculated as the other twin already has this configured? But not sure
that reading the value (or storing it in drvdata) is better/faster than
recalculating. So judge yourself.
Also moving
`wfhw->gtccr =3D 0` into the if block reduces (my) confusion a bit.

> +		return 1;
> =20
> -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_=
khz, USEC_PER_SEC);

NSEC_PER_MSEC would be more logically sound here. (But this is a
pre-existing mini issue.)

>  	if (duty_ticks > period_ticks)
>  		duty_ticks =3D period_ticks;
> -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> +	wfhw->gtccr =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale=
);
> =20
> -	/*
> -	 * GPT counter is shared by multiple channels, we cache the period ticks
> -	 * from the first enabled channel and use the same value for both
> -	 * channels.
> -	 */
> -	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> +	return 0;
> +}

Remainder looks good.

Best regards
Uwe

--cfe2gi5zq5zuhfln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpYmoIACgkQj4D7WH0S
/k4hGQf/V3x/BZOhbaQzGZFn68WzkULf7IOtq93kKFBNxcEUnaH6T60ZnGbk9J5W
DhGYXA8vnWaVXO9infIeRg70xlsfYL62tyOvY2Ffw/iIfoF0UUOxgtvKNRMVk2u4
0LjoDgGlBk6ZVgrqxR6sU03nmkVlZqft0nBcNi7sRx2Mg3mQnUdlZsWSS+TZJvzm
B3GWb8mkMmShoIUA50/mVZhtT4gfYIVf5kO/H+A8drmw3Q4RsVseYjwef1ALfK0O
kSuSgf6PGGHz2MrUHhTkmGwv+YlI+bOW/xiULZnbggr5ORglsgx2VC+sV8XTqTzx
6hs0RTV4+C6F1TFslJUSNrIZvUPyWA==
=38Bt
-----END PGP SIGNATURE-----

--cfe2gi5zq5zuhfln--
