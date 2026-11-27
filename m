Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771867;
	b=hhRIwrSREwXNrC9iIH9ajcgWbUexZxWMbABo7or51Z5yFUknpX73flzT5rW8cnhJPazU
	 SkRKwlq1rT0DrG/q6chqMENRXdXHUoHMg3BjXcK3RY8Dot7ECYKFbxVy+NEuWxTaVEKf9
	 kUpM8TL57xbHGBFvYjEvjwZnDScgGYSHlfRRnJhEI7wjj1GrWnSsdzqI/aMJ8jMTU8qQm
	 Fnkjqaapyvvd41oJf+WE+QXs3DaBneaYv1Eu5+jKA9J2C2QG5P8Tz1veM09sg7lJHkFAO
	 d8CAhQcgTS7PTofzfJ1qKD7mFcfOAoL/uxb6rg5u+LzzEtU8ROUN4y9RWghwfYTulyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771867;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=08zWpTR5K/nQg5mqMzDZkcFR1VCJRK1H9mo7g3CNk0A=;
	b=cqWYk3+9Qi3KPlkPMB2s8X3xMFzq2NGmLer2qX9v2KSwcv6Eayg03by5t3MyWHzMCVr3
	 aP/8xgXfTto/QC2DfeH+3aXbX1DQVzQidDKGRQXcy0o0QhO1217bfZ4GHlnc8hBOu2H9x
	 3Z9yPjW2+O7nv1JoXT4U1cQPPFZqUpBpOjQneXmphrBxo5s3Qv/8AdpHoi4bVNwseLmwf
	 wNx7ufN8LR7WwOUYX7Fc6bP5BApewgIMiJnhT0VrNQl6foBjWjFQQRc8aEuaeAUv3IzAQ
	 Xj+bEn/N9dUmCI59hagkiSlKhrfXQt5Mc/b8Q3m6mNlHxfHzb4E7vFZyQtkW/r+DVJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0iHYzh+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B02E1606A31C;
	Fri, 27 Nov 2026 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0iHYzh+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 67DAD1F000C1;
	Fri, 27 Nov 2026 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771866;
	bh=08zWpTR5K/nQg5mqMzDZkcFR1VCJRK1H9mo7g3CNk0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h0iHYzh+XkIok5LcYYCcxvHaVqXIfJVzUPJRKmPuJydaInJ9t9BKOGQDCwqryqAuz
	 XFJ5yrLpnqMtpjxp34q8shQU9CFJXBpzo2LwqOz480d2tLPd3QJUW52fTYghqIq1mU
	 xszXKrqOCVOsPfddUE1SWf0U1UlxPywqwybHVXYnoEyqL93CbanfdBZfnsRuYzELoC
	 XX0mPV2RpzdlFMumxAwLgF4f9sYLZORI8AmULrwvg99npTNXSA0jI1I7TIsUolHL+l
	 cqbUI+IdwvRIAzEMpnhNZSLbXbaa26pjj1ZOG1PZ1x3+0TCy087kTn6QMbmwxVgcQb
	 25j+SB8Afis/w==
Date: Fri, 27 Nov 2026 10:31:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
	elle@weathered-steel.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ardalan@uci.edu, zhiyunq@cs.ucr.edu, dzueck@uci.edu
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
Message-ID: <awlNXMCAAlf5trfM@monoceros>
References: <cover.1794600927.git.pgovind2@uci.edu>
 <CGME20261113202542eucas1p27ba92593376041c476afa9c5286205cf@eucas1p2.samsung.com>
 <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
 <9ee41556-4a24-47b2-9db3-9665048658eb@samsung.com>
 <CAPPBnEbnBPsYxE5ZXPkhGfueMoYD6DAH7dDrR=wRcq_mD686fg@mail.gmail.com>
 <awlMukHhET0ALF2j@monoceros>
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
	protocol="application/pgp-signature"; boundary="wglca3u23ukaiyuf"
Content-Disposition: inline
In-Reply-To: <awlMukHhET0ALF2j@monoceros>


--wglca3u23ukaiyuf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
MIME-Version: 1.0

On Fri, Nov 27, 2026 at 10:28:09AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Nov 26, 2026 at 09:38:59AM -0800, Priya Bala Govindasamy wrote:
> > On Wed, Nov 25, 2026 at 7:42=E2=80=AFAM Michal Wilczynski
> > <m.wilczynski@samsung.com> wrote:
> > > The C layout uses PWMCHIP_ALIGN, which is private to core.c. If Uwe
> > > agrees it might be a good idea to move it to include/linux/pwm.h and
> > > assert against that, so the two can't drift apart.
> >=20
> > Thanks for your comments. As per Gary and Uwe's feedback, I will
> > shorten the commit message in the v2 patch. Just to confirm, for v2
> > should I only update the commit message, or also move PWMCHIP_ALIGN
> > into include/linux/pwm.h?
>=20
> There is precedent on a symbol that is only in include/linux/pwm.h for
> Rust. So if you group PWMCHIP_ALIGN to pwmchip_release() and extend the
> comment accordingly that would be ok for me.

But having said that, I wonder if PWMCHIP_ALIGN is really needed. Isn't
is possible to just check after pwmchip_alloc() if the alignment for T
is good enough? Hmm, maybe that doesn't work as it's a runtime check and
Rust might want to know during compile time?

Best regards
Uwe

--wglca3u23ukaiyuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJTdYACgkQj4D7WH0S
/k7ChQf/YqKgJhXHQ4C9aDol+iX1MLyYqIkckuoc3nLejbenUb6Sep0OQjBpQb4a
95P1nPDzU1FBYVHZafwvcyFPcTU15qGsEuGAK+8vQiUfFKQuU1NQnsrdidfsQRh6
XyyLnW0FBzAlseTSVZFWsSYgFI7Qw022PqV0yfoXeSI0woFJZNd/q6fyj9x3cZF5
1YCtMYxEa4CZivtsudGr0l6/LB4lfDLuxNxr8SfRMgJoNovfGF+SiUijOhosp16I
gNhSxufUgf4T9GRgpKdEiCGw4eKSB9f/5fcE+/3D1lGg+ilAx8ylnpxO/8YL0fHs
Y7u5eCnAqsKnQ2Uo5Lo3TGCko6zlTQ==
=l0az
-----END PGP SIGNATURE-----

--wglca3u23ukaiyuf--
