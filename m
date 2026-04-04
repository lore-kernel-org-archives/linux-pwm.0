Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A520DD51;
	Sat,  4 Apr 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336969; cv=none; b=OXsMQFcJW5Ho4GWW6wL49IWN2jL/K/HSREjVTkV97zkqjxMAeabdhDtTFTadqqsCGGKQi2I+1R7ieXvZGsyTXkLmssNtNGqhPdQTt9H319f4VrMrNag7mGt3fG9Zvm5Wcia9nq7Y5f9WMfvcpUxJ8lc2FM48x4zbj51WkCDQElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336969; c=relaxed/simple;
	bh=t2sS87uV/Ct+6BFFdkWC+6JsSxBg35n2WXGBKRM+8V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq6Q3aIrLzCAzhOull7UVtqq1vZcPyfJ9IZZoUXjhpMnLWVfWqtFRYjVGvkpzc54McEY4iI76UwuioFsEJMVO26WBrXUEUCQ+AP5i/OKqsI1kBopYbKB7YUJcf3r7mhKz4VFcrNp5bNrfzmJkTxhlqYigHRu6j4uPzzEV7AboFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugzIEbWX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugzIEbWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E95C19421;
	Sat,  4 Apr 2026 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775336969;
	bh=t2sS87uV/Ct+6BFFdkWC+6JsSxBg35n2WXGBKRM+8V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugzIEbWXjf3ckaBdN4j7BdHbeRhuvvL/DRNRPfPRxRelAkMgOkBalYa0vTgEbW3Pg
	 0sdN4E10fiPYBR4X8yAVxMe2THtUQ4WMEOq3C93iGk4h/bhXQ/ZHK1F0PNlqJE92gL
	 xVR/uU8iJhryPG5kZvkMl4R/KbM3p4XwWKLKhOyvcvLGu/v+2a6zAdcfaPylr+sDtr
	 dkO14J4DPpiT329INimOCRqo7Fpmwwj9+x5BDUEsVwyaivavnEW8JAifwaphgL5guy
	 X1h9SkvIPZbNex8IK4FmKqkQw9/LFA2M1VQxRwFK7Fmv3rV/5AbA/9uSLu7D2qlu6e
	 ou6MjOIGSbGyw==
Date: Sat, 4 Apr 2026 23:09:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v20 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <adF9VdZYEGQfRqyl@monoceros>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-2-91733011a3d1@outlook.com>
 <ac6MP-O2MNDkleZB@monoceros>
 <DS7PR19MB8883555F6B620250D1CB55689D5EA@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5ep32xwbqh5jbjs"
Content-Disposition: inline
In-Reply-To: <DS7PR19MB8883555F6B620250D1CB55689D5EA@DS7PR19MB8883.namprd19.prod.outlook.com>


--m5ep32xwbqh5jbjs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v20 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello George,

On Fri, Apr 03, 2026 at 12:40:32PM +0200, George Moussalem wrote:
> On 4/2/2026 5:35 PM, Uwe Kleine-K=F6nig wrote:
> > diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> > index b944ecb456d5..4818d0170d53 100644
> > --- a/drivers/pwm/pwm-ipq.c
> > +++ b/drivers/pwm/pwm-ipq.c
> > @@ -97,9 +97,10 @@ static int ipq_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
> >  	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >  		return -EINVAL;
> > =20
> > -	if (!ipq_chip->clk_rate)
> > -		return -EINVAL;
> > -
> > +	/*
> > +	 * XXX Why? A comment please. (Is this already covered by the checks
> > +	 * below?)
> > +	 */
>=20
> This check can be safely removed as it is indeed covered by the check
> where the period_ns is limited to IPQ_PWM_MAX_PERIOD_NS which equals to
> NSEC_PER_SEC as per macro definition above.
>=20
> >  	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC,
> >  					       ipq_chip->clk_rate))
> >  		return -ERANGE;
> > @@ -107,18 +108,29 @@ static int ipq_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> >  	duty_ns =3D min(state->duty_cycle, period_ns);
> > =20
> > +	/*
> > +	 * Pick the maximal value for PWM_DIV that still allows a
> > +	 * 100% relative duty cycle. This allows a fine grained
> > +	 * selection of duty cycles.
> > +	 */
> >  	pwm_div =3D IPQ_PWM_MAX_DIV - 1;
> > +
> > +	/*
> > +	 * XXX mul_u64_u64_div_u64 returns an u64, this might overflow the
> > +	 * unsigned int pre_div.
> > +	 */
>=20
> Theoretically, yes, but in practice it won't due to above constraints.
> Take the max period of 10^9 (NSEC_PER_SEC) * max clock rate of 10^9 (1
> GHz), then the numerator becomes 10^18. Divide that by 10^9
> (NSEC_PER_SEC) * 65,535 (IPQ_PWM_MAX_DIV) and that fits well into a
> 32-bit integer.

OK, please put that in a comment.

> Do you want me to send a v21 or can you apply the diff in your tree with
> above deletion and comment?

Yes, please send a v21.

Best regards
Uwe

--m5ep32xwbqh5jbjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnRfgMACgkQj4D7WH0S
/k60CQgAleM9kn1zkU4aKSpNcL0L7hkA9F0nzJC6LTP3hb2B8AdC7QrYsj+37Wa+
dQ9tdSIJiBGCnsR63+6H8sN454PcemE6uyC8wkzDJCsFf68T8c5MT77akeYT/ywP
O7uChpFuRpd878MG8PRqfhUX31KqvwbPEJ3XBY8ox7E4LW8+YYNsh9QEY1Xph8n9
RmEJh5+oZD+swa/J0Nioj7VvR/ddv8VMyERPwiHakZjZ4chX5glIaiaRFPDl/V9D
fedZufz1PRL5+2gEhFR41i471BgogGunrwfCsumnzmm9pE/CBkY/vIsRPvCugjSU
a2bygjFMRtZKhh0k+2i7W1+dGiqECQ==
=6gIC
-----END PGP SIGNATURE-----

--m5ep32xwbqh5jbjs--
