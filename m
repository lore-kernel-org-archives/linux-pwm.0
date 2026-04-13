Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEC37FF61;
	Mon, 13 Apr 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095945; cv=none; b=pnkhheTzXXZ+5Iqgiw/HvFydiB5vaU4QzYmp06NQHGMaga6tC4ioUfF9rGGFaqeUT5id6IJrLXlee2zdF9jpSOMSjQVpxbhn9TksXGc2vYhbFvwrx6f6nHIWdfpyOr1mRpNVp/bOb+3ELhhSeI+XwpSG/2Oi6/VmWKOW03sN590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095945; c=relaxed/simple;
	bh=gsQKoPv+EnlfAT48x/Ud8feHlGBSRcnIYmWJ7nihi84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO08oopvUqFswuaURGkLXp240EQKrqyLbqhp52h4XZBXgMArZu9cxDs0HW7hg9zXXWiw6juKNpluCU80iEEAvtV4IQKqwRJ7AkmQTJ4YXGi9QJtFRqQoUW8hYcYQ5FMavsiKAO2sx/tdHSFZiXLzyBdXBvezDBWkbr040JjEpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 7D6011F80061;
	Mon, 13 Apr 2026 15:58:41 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 3959BB4024A; Mon, 13 Apr 2026 15:58:39 +0000 (UTC)
X-Spam-Level: 
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 2C560B4023E;
	Mon, 13 Apr 2026 15:58:36 +0000 (UTC)
Date: Mon, 13 Apr 2026 17:58:33 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: bigunclemax@gmail.com
Cc: richard.genoud@bootlin.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, jernej.skrabec@gmail.com,
	joao@schimsalabim.eu, jstultz@google.com, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-sunxi@lists.linux.dev,
	p.zabel@pengutronix.de, robh@kernel.org, samuel@sholland.org,
	thomas.petazzoni@bootlin.com, u.kleine-koenig@baylibre.com,
	wens@csie.org
Subject: Re: [PATCH v4 2/4] pwm: sun50i: Add H616 PWM support
Message-ID: <ad0SqUpDM8zMohiO@shepard>
References: <20260305091959.2530374-3-richard.genoud@bootlin.com>
 <20260413123920.2459916-1-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KjdOk9ztcaXoT/r5"
Content-Disposition: inline
In-Reply-To: <20260413123920.2459916-1-bigunclemax@gmail.com>


--KjdOk9ztcaXoT/r5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maksim,

On Mon 13 Apr 26, 15:39, bigunclemax@gmail.com wrote:
> > +
> > +/* PWM Capture Fall Lock Register */
> > +#define H616_PWM_CFLR(x)		(0x74 + (x) * 0x20)
> > +
> > +#define H616_PWM_PAIR_IDX(chan)		((chan) >> 2)
> > +
>=20
> It looks like there's a typo or a mistake in the PAIR_IDX calculation.
> It should be like ((chan) >> 1).
> For example, for the 5th channel the result will be 1, but it should be 2.

Had a quick look at it too and I agree with you. A right shift by 2 essenti=
ally
groups pwms by 4, not 2. So pwms 2 and 3 would also be reported as part of
index 0.

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--KjdOk9ztcaXoT/r5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmndEqkACgkQhP3B6o/u
lQwl7Q//c5ZYca06QsQsNVHqbgpCYsqTnwlucLEA4OExFbJt9tywkeVUHdtpA2sH
zv5Z2dAjzcYN4QuivrhALcenlce5kApSmeDDK/xXa7HpUzMWIeig09tFnBJ6HO/P
/dSWijfg7I50NjbKH+3FBaag2W6c8NWI9b7Omtmpu6HjJHBla6uPZXHfys7HDe3v
4Lrf5M9oWQyMJf70ywvN4P0IlQyzWfMvvdQ4Lh0ph1mj5RzoALos8oGMLxTDvLNP
v8pbzKkSsl+GGUMm9zvk1FOjM0Ew30T+1XnKTJe44GI6gY6Z0oVhD3Wjxlto3vip
d2w3BS8ey79VVRR0Dtq1RiGIx+7nBAFEa4FwGYNYJBIHcI3HV3ofQbL3KK28HDSC
QH94CsvX1BA5rvU2ROIhroJmHNmsvRI6sHKYT/Luo5Q+tDillPOHd/5jd1DL5IMO
ye59Vc7lIPoIp/dX1EFFhAyDj3Gb2U/okfmsFyvcLz+WAukrcFK4hKAq9V8cc+8y
qe9YO7KWDfC/9y0v4dJI6elt3uBjexfH7hK6qm9HNkg4h9MaTyT/nimVyn64vr0V
QwFR2bZLVPI3mPQXANdCp3TipXWObPyHwdF1LKUOXL6IXz0w7GFyAuGyma6Pc0FR
IZq9Tu0X0K3ZHHZ6lT6UGcm2ze76psGicFt/ZR48GidaJevu9Mg=
=Ml0a
-----END PGP SIGNATURE-----

--KjdOk9ztcaXoT/r5--
