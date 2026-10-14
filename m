Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406794E1C66;
	Wed, 14 Oct 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971127; cv=none; b=ofDAbefwtCoXWwo5Nhq+IKwlIQLpZjadxc26Ur4NJd9e8c36PZH07uFzpUK+yZbjTsnnPWJXjukf1twHhxLZhTCdoVGlgkPNtfn+OpWCXURwG3uLMQUYBBN1Ity8bYR6U1uelntQirKb+Lle5QOVdvZZFn4O/O4B39+k7LNSJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971127; c=relaxed/simple;
	bh=o25ndurGSbIBeL+Pc3I9l5VHIz5sHmwgR3rpEHo0U9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDEZg2W/uHfOs/re39QFwW97LpTTVRZcVhQF0U/uLOXIve/HMb7uz95LwDL4E7o3D/EwzjGkh2J2QUQxVa4bkOmkKi2z5FZRt6bBP5v5u7Cj69n8bSIk7wPOfRfKa+LkaiEOAZ9D4fdE8va0KFIAFY/NvBoL1FNwmp7snwdqvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtOpkpub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtOpkpub"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 435731F008A4;
	Wed, 14 Oct 2026 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791971125;
	bh=o25ndurGSbIBeL+Pc3I9l5VHIz5sHmwgR3rpEHo0U9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtOpkpub0uYuGgM+jv9mQxo0GDRFNl7ErtDjUIOwnAYplkvGYBEZ7euz+IFyJuWFS
	 YJbrJTtVv2csOyZwYwRSaiJ9/CySnHuPit+1GNMLskuMlND29zmL5zZEk2KNGzQAYn
	 G0QSG4X7bbobGwyydRK6aIZC4WO0nR/u2zzMqmGhGkK+NMQNMSoGn2B7qLAazs8vX3
	 oC9z1RZ8xNsPy55DqLm/VC3Nf38vmU0sLQ+MtV9arCjsRgbpaqrHQa1JeuH+65+Ar0
	 B+j4FjiDzR0Hm5feMC/m6RQ7qF9HzkryHzZ+BBE46q2LTyesfwjvMvpmdsMo0c2PAc
	 WNnXpxjTFWmqg==
Date: Wed, 14 Oct 2026 11:45:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: Fix prescaler for periods of 2^32 clock
 cycles or more
Message-ID: <as9NusRrYjMO388-@monoceros>
References: <20261003083036.21584-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qf4c2coehtxmfrl5"
Content-Disposition: inline
In-Reply-To: <20261003083036.21584-1-kmehltretter@gmail.com>


--qf4c2coehtxmfrl5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: atmel: Fix prescaler for periods of 2^32 clock
 cycles or more
MIME-Version: 1.0

hello Karl,

On Sat, Oct 03, 2026 at 10:30:35AM +0200, Karl Mehltretter wrote:
> [...] Some out-of-range requests of 2^32 clock cycles or more were
> accepted and programmed with truncated values. They now fail with
> -EINVAL.

This is wrong, a too big request is supposed to pick the maximal
possible configuration without an error. But that is a preexisting issue
and converting to the waveform API is more sensible than fixing that.
For the scope of this patch, the implemented behaviour is ok.

> The truncation was not reachable when it was introduced. The period
> was an unsigned int in nanoseconds then, which limits it to about
> 4.29 s. Commit a9d887dc1c60 ("pwm: Convert period and duty cycle to
> u64") made longer periods possible.
>=20
> Fixes: 2101c878f767 ("pwm: atmel: Replace loop in prescale calculation by=
 ad-hoc calculation")
> Fixes: a9d887dc1c60 ("pwm: Convert period and duty cycle to u64")

Why are here two fixes lines? Given that 2101c878f767 is an ancestor of
a9d887dc1c60, this cannot be right.

Best regards
Uwe

--qf4c2coehtxmfrl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrPTzAACgkQj4D7WH0S
/k7ljgf/aIZ6f/aMMdY/TL4aaCYVhzSwMf8ksvYW0d8CVu4IQC5GMHG5bvYms8r0
RRd1sftYJSs1SiGt4vbdwnEZ/ZjsA/jiFtG9aoDyyH9ArkrSPtHGdmOTjQS1kXgw
r9VUMtlBMbzohUzrnTHA3aKIAj9T3F6etkz8fbnjrkaOtxxiGqh9BvqW1eNbiB7d
l8eIQRA2NdgFostcUsQlfgd4pYC42p7i4aFtkhsonrt2GiihtsDhDuiDB9lf6myX
/LxOFFGuwo8qxm/CGiHQgFgqEWs5/8La8kwhg659b2kHXioOHo1pvNVm6tZw1bL5
IBdlfGW2ch4FNLD/ceSlsqHFf1IbjQ==
=JxkX
-----END PGP SIGNATURE-----

--qf4c2coehtxmfrl5--
