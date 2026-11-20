Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191827;
	b=L00fIRrceNg7A3exYrgTjOwbdQt8XAgLpeIu9Qcws7/4NmXfRt2NFijlIsYbqYwUgxcU
	 A5r75rGJ6BLOxKJM81E4yD//JYxFYEJFXY+bQhVxkIGV3L1+2jmG1krqw9qLHumBqM8is
	 JWi7rCGyVxJYBiBv3KzLF1vbwLPw38ifd/5RxO5wooiPE1RrI4xNpmDWogf0WG1v0PxxG
	 ewLW31fdUJ8QqkAfbznwEjmYFEk/Wub/QQ45nXaKyMAUMilHjibgOZfHjQp146pfejgHA
	 rCaC1dL7Z2UanBYDsfYThNlzEgm4eDdAVw3Di6WNtq3AyehXv2BBH9/L+5+NdhkKVcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d3QBEP8dRM7vxwDgY9cDJ9vgtjYUzyf7+KDqMUm8lZE=;
	b=mlGL9klgApJsv2G0aE3U6bc7WP1BSeKVw0mtW1oJD82SeB1sNv5hIzee9ttudFuFK6Ec
	 E83kfL9insJTAET23N52LDjLfi+c1UQ3GFMkMlg2wRHUzWgzwdarTVpIJAczpSXN1q7E7
	 UHWJomthZ/sL2RWE+b1lI5PUwQXFeUbyyk3CF/7NyH7RQJ3+coj6aoiLvav6LLn5MtE/r
	 Hdei/oFUtNmZh7IRUKehdIi7mOq9pQdp1buTzqWIolre5P4yIMUE9cktNVNvZ19QhgVEz
	 H6sii0XmKIyiRPX4jeanxYOJvPhdxH2f+JgJzsUs7/AovCIN1SSvoooouEHzySXh0VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSRXDky8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8C45A606A325;
	Fri, 20 Nov 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSRXDky8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1134F1F000CA;
	Fri, 20 Nov 2026 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795191826;
	bh=d3QBEP8dRM7vxwDgY9cDJ9vgtjYUzyf7+KDqMUm8lZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JSRXDky8awBoFyMHc2ZYa/qstsTfmMod7yUu3hMwHzq+8DKmkTeiCyZEcZ2j8whmN
	 hyM0IVbMfSGnvfxxYmC76qRFIYVtAtiENd9M1Y65PPno2ppTtiPinrnAGC/r4yQHel
	 XIIsnEP3XhLf1OoF6YOqX+xvU9JDF7ybMY7ZRmFJP5mLtmsT2NT5XygkNQznbJXwLk
	 mwG7JM3V2OlHRFpzFWalUd/ZQq5j5XS0HwDo9keZXUjGkpPhksWaCuNmIALDzCYpEt
	 H3tI2DOXwDzcPXA6UYHPpq4ukXbZlLmbky6KCTSGD+fiU0TWmlzvzC8gIWGOZ+gh1P
	 Gq3cytlfMhlzw==
Date: Fri, 20 Nov 2026 17:23:43 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 0/2] driver: core: Allow drivers to opt out of
 driver_override
Message-ID: <awByB3M1qPiye8JL@monoceros>
References: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>
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
	protocol="application/pgp-signature"; boundary="tc46iwcpupwpxjlw"
Content-Disposition: inline
In-Reply-To: <20260922-driver-override-opt-out-v1-0-58c35ded3b83@nvidia.com>


--tc46iwcpupwpxjlw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] driver: core: Allow drivers to opt out of
 driver_override
MIME-Version: 1.0

Hello Thierry,

On Tue, Sep 22, 2026 at 01:38:27PM +0200, Thierry Reding wrote:
> Overriding the driver to bind to may not make sense for some drivers.
> One example of this is platform drivers that use device data obtained
> through device ID matching (such as OF or ACPI) and they cannot work
> without that device data.
>=20
> Usually the device ID matching is the only way that such drivers can
> match against a device, so drivers shouldn't need to check that their
> device data is valid. For such drivers, driver_override is the only
> corner case that can lead to a case where no device data is found.
> Instead of requiring each and every driver to handle this case, move
> handling into the core and let drivers opt out of this override
> mechanism if it doesn't make any sense for them.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

https://lore.kernel.org/all/cover.1795171088.git.u.kleine-koenig@baylibre.c=
om/
is the more promising approach that doesn't require each driver to
opt-out of force-binding, so I'm discarding this series from my patch
queue.

Thanks
Uwe

--tc46iwcpupwpxjlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAdAsACgkQj4D7WH0S
/k5q8Af9E9OuIg4RQEWxGrl1pehojKPkNhbBi8UGoCLQMXxGjsSvtcgWWUo+BI4d
v74CAyb8WsBYczaaPkLSzdh5E7iRRhOsAa2hmTc/Ck5QL6uTnuti1gmDEr1+zaht
BsqkGSM3SQ4tsXEmpAoX19LHNupGCVhb9kDCIFrOeqpgDmTCdM4qbD5hELo4OQyv
acs+1UmnlaCJFe6WywMiNA2nq08jhd90FnVuKAVb3bleyoRx+fh40lSWmc0Kuhxp
M5/w288ljlxEFphCHgycl8JKGg7Mj4u7DXRzh93GMJxHhpDeAILJLvsRn73FPWDd
92wzxVeeR+jUBALI2fFoh64AI1IJfg==
=9Efd
-----END PGP SIGNATURE-----

--tc46iwcpupwpxjlw--
