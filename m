Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79945D1A7;
	Mon, 21 Sep 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986168; cv=none; b=I2uLK7EeHKWicoJ+GPDb5b0RSlsSHk1td2odk6xY8pqF7ERZolkteehPcPr3WpDfPTjv3HJv2MY3tjsDEJ6DWaFaRuoSzMyAThDOAXBwdCL7uUokync0duXZsoskN/puP3wFF6oQDseZLuOMfvSR0BPWkNiXr1e0CbSC6cFuoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986168; c=relaxed/simple;
	bh=Uh+eBoF2LbOMTTtRPwSW82D7Py3kqwSgNPmHTNRRQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDAbOAGiSYfDtbjDb6W1fdTMN+BeMWZZtxAHyCzwxCG4+QwJpoIKdnEX3heszATris3gRmst3D+vXTKM7337zRWmn0X4WCTN/cYqYVvVnRBe+qAipJ4QyZ+JTi/O4Ru4eFolHojigk1P7SvRrF5Wk5JM0e6GQw1+MK6O5/0xS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSe0ldZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSe0ldZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD691F000FF;
	Mon, 21 Sep 2026 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986167;
	bh=3zOL2syTuL9hJNjoqerr2i9S/E3w2KFI1jC0z/07gGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSe0ldZn2+rbO32W9R198CLJ1CIf4U/OyIngaB15mzUQofzMpqufWwTc/PCkpuUbl
	 6RIbbs+o58sUtmVA1ra9TbLtqCpP4MFFVhXl3BZOLwzqQfrOgReLQwHIZ45mkBJFil
	 4uDfX8k8FKAUx9LkKRfA/E9IsXTlOS4XQJcLtrxQS1kjGPZG2GVXt45alNkBw84OmN
	 LbQzwBVSKSXL2+6Rd9129R6Bb7dpN8D9YxEzprY9TbKuBmbpw6P8b3014e4Tu97tXC
	 boQq3HYug3SV/FlJ4KBePnT8RnI0B2nNofeEbtpQXGk2TLdyihvOXMzxCTMcmraz7J
	 YZHt+apHP+r+g==
Date: Mon, 21 Sep 2026 12:22:44 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pwm: tegra: Cleanups and .get_state()
Message-ID: <arEEwg3ErxY5nNVm@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aephjmvi6osvwcsg"
Content-Disposition: inline
In-Reply-To: <cover.1789741839.git.u.kleine-koenig@baylibre.com>


--aephjmvi6osvwcsg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] pwm: tegra: Cleanups and .get_state()
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 04:33:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> v1 of this series can be found at
> https://lore.kernel.org/cover.1784030076.git.ukleinek@kernel.org.
>=20
> Changes since then:
>=20
>  - Reordered the patches to have dev_err_probe and dev first. Fixes a
>    build failure in the middle of v1. This way patch 2 -- which could be
>    considered a fix -- isn't before the cleanup in patch 1, but doing
>    patch 1 the old way first also feels strange.
>=20
>  - add { } around blocks with a single statement if there is also a
>    comment.
>=20
>  - fixed too many parenthesis in patch #3 (formerly #6).
>=20
>  - dropped other patches as they reorder stuff in unwanted or at least
>    untested ways.
>=20
> There was a concern in reply to patch #1 of the v1 series (now #2) from
> Mikko Perttunen. He wrote:=20
>=20
> > I feel like driver_override falls in the realm of 'root can mess with
> > the system as they feel like but if they don't know what they're doing
> > they get to keep the pieces'. So adding a check in every driver, or
> > in practice having a random mix of drivers with and without the check,
> > doesn't seem necessary to me.
> >=20
> > If we actually want to check for this condition, could it be done
> > centrally instead? I.e. don't call probe if there's no match data and
> > the driver's match table implies it requires it.
>=20
> It cannot be done reliably in the driver core, and IMHO even root
> shouldn't be able to trigger a NULL pointer exception. So I kept the
> check.

As I mentioned in a comment to the patch, I second Mikko's concern.
Adding validity checks for device data seems like one of those
boilerplate things we should be able to avoid. We never match by name in
the drivers and if driver_override is the only reason why the device
data might end up being NULL, then driver_override should be completely
disabled for this driver because it simply isn't going to work without
the match data (as evidenced by your patch returning an error code in
that case).

I'll take a look at adding a way for the core to let drivers opt-out of
driver_override if it doesn't make sense for them.

Thierry

--aephjmvi6osvwcsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqxBXQACgkQ3SOs138+
s6GBtg//Qj8ifR700XgimC7913YinXpaBQV4AuJNkkd45OlWDFgvzrthKfEarBpl
UBFVQEOjXZgQjDOvqlbLmWUw0PffPxOEe+yfvcgaKnj0aSpJ3XfT61rgd6CQATeh
2YLfvw/EuiDiOZBojnfBONWMkGrrSJHhrz8XsnkKURm49ZmpZ3HWzddFbMANGoyd
6g8lKbDgMsZ7sl77mRU/ESTXrM1EwFLVva3dzXCa4pfmYuCAt9nWx7H0RbjFRjHH
6Hy9pFjV5dh1qSIUdq59K2sY/nIdqyGLsyKnhoIhS4YBjzsSlY/RE29WY5ONtM+e
/ABZ5ViQZXO/94K5icjT9Y3vRCrYrrjuUhrmq4N8N8KyyXA1xOq1+pIYhI7/BOxU
YBaX+ZsxpFHPoyxJd6WyfmeigeXEllLCHjelPgvh5QHsRkAL1f9rIjCxwOSPaFuY
WQocd8grlKsYL4jEbRaGZ38lL9BBurPQTWYQMKPECU84K1yvDGmeoDIpWcRsyIQJ
P2orJcgp8ooj3s9PXlQ+HiW4La3iMnpAlIukG7sQgnaREynJkhYXaXCZrUMf0tx1
oZrZpLzYsP/MHY+GzQdHNTuUMK0BCYwRBBvgOOupoAodUPJaj8kmiwBPuzoEvQVd
Gd/+tq4Oh74sfi4vdVwk2EdumJ8zmauGZbdd1n3CI49IKSYDeUE=
=cQWp
-----END PGP SIGNATURE-----

--aephjmvi6osvwcsg--
