Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94F313E38;
	Tue, 18 Aug 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088789; cv=none; b=ryTa1MxaossuaM8GFYKE9ncxIq0l3xrGOjxxpiQ5oYlx3EDarZUz3V4koCrxBbXpeiWu6mU39THLJ++tkGaYd2tk87HQlE4rFpbiexFJTAXS2CpOP6W1CzNKzVZgWzAcXYtWOS6ny8rSg02SJb0VHxsxsWZv1uhcZaamP0QJOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088789; c=relaxed/simple;
	bh=zwiUylK4JdCGFFupdl0naa4o14Uw6rKxDwZjvJPCGyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4YjNMqoBE3ArsZBkhCPaZjKZ8cXlbxsf5Hn3ssR21PhQMy6f80WIdseHK1Vjy1lnSQEQVCLLiaMj4532LaY1p+wYyyKTCc/fJaj0+3lb/INM9uuCzVn9RkjfBQqIe2kmZSBPG6BIv2/lZeYSiZBzTLomAUjXsHM0t6WkC1jPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5P7y32p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5P7y32p"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 53EB01F000E9;
	Tue, 18 Aug 2026 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088788;
	bh=Ecv+y4qPf7TDQrrwWvBs02Eh2mi1ptD/0q+SKR2GL/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F5P7y32pDfsu7R8MnWFAm205vDaHTaeXQ/u/lIS77bwrxm38tvuzp6OTJoUR/60dl
	 Cmh+3cxrFIw9H7FryH9QX0VTOpXOW3ZAxPAsy5mMpA5L/dOEOxV/WZjL5tYtRj3zZ6
	 J7+jnZfY8sXR+/iBm1buiqA+XN7HFWKjnIL+JEJJenwMED/w/x9y00tUikBXVX/p9C
	 hRR3ceFFnu8PcBMZSPw4sUT6IFruyFcg/x6jsjVhrf2agf0UTCakg5p4yZ+O8Pspeh
	 qauywjzQn88w8ctx4ve+z/4qYQZma+KMzRoQqvPLn+wPmgxLXQvXiOpuK1JJu7Xi2j
	 nLVD8uECg2XVA==
Date: Tue, 18 Aug 2026 23:33:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 2/2] pwm: meson: Add support for Amlogic S7
Message-ID: <aoTOjGhqfdfk6Ze-@monoceros>
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
 <20260521-s6-s7-pwm-v3-2-57b073fbafef@amlogic.com>
 <178705763029.1733024.16040030322013834677.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifsoxaipndo4pyw3"
Content-Disposition: inline
In-Reply-To: <178705763029.1733024.16040030322013834677.b4-review@b4>


--ifsoxaipndo4pyw3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: meson: Add support for Amlogic S7
MIME-Version: 1.0

Hello Alexandre,

thanks for your review, that's very appreciated.

On Tue, Aug 18, 2026 at 02:53:50PM +0200, Alexandre Mergnat wrote:
> > @@ -642,7 +672,11 @@ static const struct of_device_id meson_pwm_matches=
[] =3D {
> >  		.compatible =3D "amlogic,meson-s4-pwm",
> >  		.data =3D &pwm_s4_data
> >  	},
> > -	{},
> > +	{
> > +		.compatible =3D "amlogic,s7-pwm",
> > +		.data =3D &pwm_s7_data
> > +	},
> > +	{ }
>=20
> Small nit: changing the sentinel from "{}," to "{ }" is unrelated to
> adding S7 support. Patches tend to be easier to review when they carry on=
ly
> the functional change, so would you mind dropping it, or splitting it into
> its own trivial cleanup?

Just skimming your mail, only here I want to express a little
disagreement. While I'm generally a friend of "each patch does exactly
one atomic thing", IMHO such reformatting in an array that is touched
anyhow is fine, and a separate commit that just updates the terminator
in this one array is over-engineered.

Just mention it in the commit log and that's fine for me.

Best regards
Uwe

--ifsoxaipndo4pyw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEz44ACgkQj4D7WH0S
/k4wEAf/U7rMIHl6Kc36+5u7qcO9M8BWtK1nBKev20mftpvCC7drphdIZwcYpNt/
kWSgpXSUz96MkaKh2EwFyzTitngJS6YgbL/qHVoiG8fCgLwxowaPo0EG+GLqPrYh
eDU7LK4YUQLA985s/TYkz2HBSFamjg3004FMXLmCLXT21sZ90k7SBnH8L8D9U9YN
UD3YvDmhQvoXO5fMvLKhWM+Gl1wldo611r7JoB+e/V4RBmBM1Koi6F/cN0Hq/C9d
MYiDdUqONfPc9cgxjwzrsjt5Cj94kfOCrpFT+D5qtHnqn8KL1LuRyqSCkiUdAzjF
/A5Ri4YY99h2CuhttK2J1vNmEew7yg==
=9mnJ
-----END PGP SIGNATURE-----

--ifsoxaipndo4pyw3--
