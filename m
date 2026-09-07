Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1CC4EC65D;
	Mon,  7 Sep 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806716; cv=none; b=LKKJSAQ42ZO+jUoelEqZYkgEINZ9Eo1IK9xyYUzqEOU5qlcuWmXT40otVSCDcQ7nXeW3Phn6icpvM+IxEPllz3/bgwjkXkxKKhVWTjLG4J5nJm+FThf2NdPcIff8zYj/MNw2hVOsIWMX2HXaecQIuuoX1TBq7zehCZSznKDWWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806716; c=relaxed/simple;
	bh=6CwKBS4qBjkQ4IU7RRirgMZ2Hpl2yNN0/SRFA6QTGFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2TDqoX6pB9wtgfu73bf3oG6I+k3NEFNllADRP/DDQ+/gkyMPA9K+7cHLDk2uWBGebhBkbasqu2zJD7OQqrosDI88ESW5qI/Yp49LavOTm5BIF5EVMg7muB7CWiA1ZxZ5xJTqkIoRytivsMG58yCKjj2ARIFDsa4b6wzZIFujm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHiwNtga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHiwNtga"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4F61F1F00A3D;
	Mon,  7 Sep 2026 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788806700;
	bh=4kL4fMGCj3SR3hY6TLqzXN2o5Y2eftf1hKQIXB63uPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EHiwNtgahfVLLxqooLJy9yugeOedCoj0u/L/QLWi7R51lB73ZwzggqX1DEeIFcqSa
	 +StBg2yUEY7/V0YAmw2I92dUjc1TyFKqMPUfFSp9lITzCSBHjFLObwV3M3NSjtCY/Z
	 zFTxTkty8xZEpT57ICoM/7HQI3LX810s8aS3eQjeC503tQn0mdXt9kckxMY+XF3PQ9
	 YrJdA8sr1HAh345kVuRLc7WAS3eT1Q2sRuzjc5cVOMbVs1pb64+txToCR5TjweYVdT
	 Nq4rccYkzphu0psyJKuIOP69hzSnkoZg4LGViZL8iFB/pMyzqNuwox+qMLm2ThDf1g
	 80/xWvfpQtNGg==
Date: Mon, 7 Sep 2026 20:44:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 3/4] pwm: meson: use bulk API for per-channel clocks
Message-ID: <ap8FuWnIRVgcP98G@monoceros>
References: <20260827-s6-s7-pwm-v4-0-d28a2015177d@amlogic.com>
 <20260827-s6-s7-pwm-v4-3-d28a2015177d@amlogic.com>
 <178879456435.2256446.2005394820666057840.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t7gsagdcfeml35k4"
Content-Disposition: inline
In-Reply-To: <178879456435.2256446.2005394820666057840.b4-review@b4>


--t7gsagdcfeml35k4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/4] pwm: meson: use bulk API for per-channel clocks
MIME-Version: 1.0

Hello,

On Mon, Sep 07, 2026 at 05:22:44PM +0200, Alexandre Mergnat wrote:
> > The S4 PWM driver currently gets each channel clock individually with
> > of_clk_get() and uses a custom cleanup action to release the clocks.
> >=20
> > Use devm_clk_bulk_get_all() instead to retrieve all per-channel clocks
> > at once. Verify that the number of clocks matches the number of PWM
> > channels and assign each clock to its corresponding channel.
> >=20
> > This also allows the per-channel clock initialization code to be shared
> > by Meson PWM variants using one clock per channel.
> >=20
> > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> >
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index 22cefc6d5dd0..6f151464d7cc 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -497,33 +497,25 @@ static int meson_pwm_init_channels_meson8b_v2(str=
uct pwm_chip *chip)
> >  	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
> >  }
> > =20
> > -static void meson_pwm_s4_put_clk(void *data)
> > -{
> > -	struct clk *clk =3D data;
> > -
> > -	clk_put(clk);
> > -}
> > -
> > -static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
> > +static int meson_pwm_init_channels_per_channel_clk(struct pwm_chip *ch=
ip)
> >  {
> >  	struct device *dev =3D pwmchip_parent(chip);
> > -	struct device_node *np =3D dev->of_node;
> >  	struct meson_pwm *meson =3D to_meson_pwm(chip);
> > -	int i, ret;
> > +	struct clk_bulk_data *clks;
> > +	unsigned int i;
> > +	int num;
> > =20
> > -	for (i =3D 0; i < chip->npwm; i++) {
> > -		meson->channels[i].clk =3D of_clk_get(np, i);
> > -		if (IS_ERR(meson->channels[i].clk))
> > -			return dev_err_probe(dev,
> > -					     PTR_ERR(meson->channels[i].clk),
> > -					     "Failed to get clk\n");
> > -
> > -		ret =3D devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> > -					       meson->channels[i].clk);
> > -		if (ret)
> > -			return dev_err_probe(dev, ret,
> > -					     "Failed to add clk_put action\n");
> > -	}
> > +	num =3D devm_clk_bulk_get_all(dev, &clks);
> > +	if (num < 0)
> > +		return dev_err_probe(dev, num, "Failed to get clocks\n");
> > +
> > +	if (num !=3D chip->npwm)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				"expected %u clocks, got %d\n",
>=20
> Small style nit: the continuation arguments are not aligned with the open
> parenthesis, whereas the dev_err_probe() just above and the rest of the d=
river
> do align them. Can you fix it please ?

No need to resend for that, I can fix that up while applying (after
checking I don't have further concerns).

Thanks Alex for your review!

Best regards
Uwe

--t7gsagdcfeml35k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqfBhsACgkQj4D7WH0S
/k4H5gf/b2Cwr+NerQlDrFtCUTp4liuubWlge5tlRlMWOcb5v+9nUeJWlgs2tQvu
yWPt8d+Zt+e3Ro1Lltt6/0z/V2EMCeWmtbyUAUgVB509psrAZq+tEvC5dPNMJOBJ
1NdEPZSVCMSlaPKFFd7mmxORfZRVoOq328+Ou9pKtuvxRFAV20KwWw7SpdZnYNRZ
HKdhlu0iIXKVC20ipM5jSoOuCBjbSyxUcFdlnQIR76rsUeFxWUSt98aAzTntv3YE
G6TZefYdA0k3oSnyd0vQ3vc8zomM9PsuRxdGiyCICdF8NasUaM3sqWgH67mote90
ROqVOOH2Xl9Lo70ugL/zbQq89aaHzA==
=DC7A
-----END PGP SIGNATURE-----

--t7gsagdcfeml35k4--
