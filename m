Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794018;
	b=W4OMEOSJe9LHxLc/xrb41Po0Rlj3ESv89jKYq+Pto6nB7PWYw+qqgdwSH67p8oYQy1Jp
	 GC55DqSqtIMCMj7rUN/1gbb+oe5N6N0MMi00jZMTV1+pzbPI0Ey0w3cvjSEjaNmn/gDLY
	 YJEptbT8ikuTens6lCWvlxcz6lPk9jt4/cQyVkbPzDRxIJhMAKHqq7vh/a7mQCs9fFII/
	 dFsg42k87n/HiJfQKgbamikbuOVNNUGv+J3tDUUoWGUAdiXlflNPYD6N5MisKRTDkPYVf
	 GU0GMNOrJsk061bvqNF/VAzZ/tyRlZs43kPBn8MGekzhm0YO8uuKqwQQO4TeO/t6SFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794018;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e5/rGv6kRlTybcojKPwoDm9EwkOD0brZRsjX9dNYirM=;
	b=E0ijfi6/6C3MiiHMLhhLhXpxc1SOZ6LmOlOZ/AdMArmCvsJJQSyl5Knwhba4r4VOBrqE
	 ggp+FJOl+Pm3g0/3zfR2c41oQN4YoFCpykf+RcTBHQh9xBacepWHwPNIVY2zHeefuRjUH
	 yHN2ZN/if5FmqEkLkP4mUmt3lMlvnMRykEsu2piiVrhKXJIYV7zP7B5a4dtptqV7otnrV
	 FIQeH029GBS15jE7DG6AAjRleao3WQ04PLWs5y3mkMSfUsNIvOXqsIYp5CUeDoJj96I3x
	 3RdhblRDUXV6xczVORwX+/v/7/75Ztn1WA8VhVJapc2Jp5AYoa4dfUBMWytNqumhmFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZheMvId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 44FD0606A31E;
	Fri, 27 Nov 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZheMvId
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 02CC71F000C1;
	Fri, 27 Nov 2026 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794017;
	bh=e5/rGv6kRlTybcojKPwoDm9EwkOD0brZRsjX9dNYirM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KZheMvIdeKcFQh1TUVFvP5jn0rlkPW16af+06C+RuvEJXf0q5LddewqgBsQcA0wak
	 N3OQZK67V/uGYDw0xFPMoo2cPExvAK74jyplyP+82orQH3Pfuz6UJ/Y6gHdJIou2Lk
	 ND0Bk7xitB7I/UCVgVttxzCmjYkFqv8gymp2/C36OP0a7qGG0V66aMas5BGmt/2e3Y
	 ol/0lbtIQNSIUnaxBZm1Tim0pem9H1IjhUeNQoK8sMnYK+DamvO7xcTi8ZouFGWNu9
	 rD7ZLuUXoflvUj86fAQ3pCQp+63Ab91F+MiDNEHQU5wqvVEootqyoioWtj3fes/KdO
	 hnoLj9dqBlsCQ==
Date: Fri, 27 Nov 2026 16:40:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tiecap: Implement .get_state() and keep a running
 PWM
Message-ID: <awmjxhnTVT_ZVzPN@monoceros>
References: <20261116142251.1296742-1-maximpedraza@gmail.com>
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
	protocol="application/pgp-signature"; boundary="bdvxcrzwalea6q3h"
Content-Disposition: inline
In-Reply-To: <20261116142251.1296742-1-maximpedraza@gmail.com>


--bdvxcrzwalea6q3h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tiecap: Implement .get_state() and keep a running
 PWM
MIME-Version: 1.0

Hello,

On Mon, Nov 16, 2026 at 03:22:51PM +0100, M=E0xim Pedraza Padilla wrote:
> The driver has no .get_state(), so a PWM left running by the bootloader,
> for instance for a backlight, is seen as disabled and the consumer may
> turn it off before enabling it again, which makes the screen flicker.
>=20
> Read the state from the hardware. While the PWM runs, .apply() writes
> the shadow registers, loaded at the end of the period, so read those to
> stay consistent with it, and copy the active values into them at probe
> in case the bootloader didn't set them.
>=20
> A running PWM also holds the runtime PM reference ecap_pwm_enable()
> takes, so take it at probe. Switch to devm_pm_runtime_enable() so the
> remove callback can go.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: M=E0xim Pedraza Padilla <maximpedraza@gmail.com>

I applied this to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

Thanks!

Best regards
Uwe

--bdvxcrzwalea6q3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJpFsACgkQj4D7WH0S
/k4lgAf+IUruhqIkdBuXZzieTlnu3xUfA3htvqfePjIzp2t52fpxh78TUqFmriSL
mNizpkWDwF5a7YYW/vzHQyQfPg3F4TGRHWy25OgFgI/mhkhVcxTAcLuYxSgP8R63
LHONFotFgdmks5c8JOz2BYmgFV8TW/QWqLwDuherUWKTFPPz3O/UUqtaQ3QwpVhS
57TMdYCpwErNrEpCezOFDJclqc2u/761i+r0FR5NWCvr4xBC2kjkYl8RIgz/mY6E
/95kI8uHZbsnKq1/U/KHq2Huq+z0N1Qd+mpM4y6PNhFdaFc52aYNjziAATh+XIvJ
c2mAVKwFqO+WNeIx5ineesZRgCseug==
=u+AR
-----END PGP SIGNATURE-----

--bdvxcrzwalea6q3h--
