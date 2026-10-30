Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354663;
	b=IEbGeEZVuHiwAogKxMKe6btheJ/PNJJoP2stEflOxfmFr+R1ls/zmsiWrx4lzjeSIUcx
	 QcwN+Ag7kBGJg1lC0fwR5fjsoYERdTrusAaLv+2hr4zQMWKoclCM9zleD77AZ+rzCBaHw
	 ZY433G9oHd+2p9U9UrHNiTTTf3IwuMj/KakV8unNDKFq8q8/SYEL1nUsbSDVx4l7D1enK
	 fbR7dPqWF6/yD5OG5z20VPzf+mJ8TNBH9nKsg/SkQG7F4Ok1HXmWvDAb6A15K947M3ZK4
	 AatEhXABALsLSDLIVp+zVqmU+wziCewFLnezB0G7CHm1CIzl5ud1Q/nPnhmxdOnanTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354663;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=73z0TqG0XlzNUqRUtewQFDGpbVjqIXuOCzQpcnJCTes=;
	b=Sqc/u3Z/sWPliePTfUsa8SxGn7Tob5uaPBSGReUjEZ0DQ7Dxr5YsVTkLwd7n67J9An9e
	 dRjmmFYwGB3kN1OJI4Ys19BldyFmkKyh2/WmsjTOAKeKzR9SkYzKjWLFRL0OWKhgmbt8L
	 1gQbg7GqTYlUYahRpHa1Of+NzFTHIOEfkn5oj6r2pmmzr3Jyu5+PvnCQPAzJtrBOdOPky
	 mX+ADTs/i3MLOGJBM8IQM8cwfnHH6CvqX81oTay5N6ll4c9xGg4KQ1UvHDbLDHPIUcb1n
	 +HRncx02hXAYJuG1t0d3iMFoNUKvSI4MFLRFuPm3jA4/SHWkQipuXQbHAutTUwGhyyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrTjV0E6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5A097606A31A;
	Fri, 30 Oct 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrTjV0E6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 649C11F000C1;
	Fri, 30 Oct 2026 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793354662;
	bh=73z0TqG0XlzNUqRUtewQFDGpbVjqIXuOCzQpcnJCTes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GrTjV0E6kcnNh5t0Ut/eEBg7rdJDhmLizwDyGa0tZuBLhYaW6L0dQszFK5SqujHFL
	 Ey+uxTQ0Y22kJ6tAjnnJEuswolC24nJtH7lZdBADWxneecs9jdgR6TcNniLyEH3lRh
	 9cmxOO5T7Rqsw071MtvprTZYUxbBMfPFAI9BcYk8DoQNmvatzAO05YieTG3OfyVO4j
	 UuFZjjSpcnXhp2Uy5Ys73FYlPV2z6Pf+RtbTrEhnYcpIttq+spvjiY7i8x6kAHaVSn
	 WOO8ux2MlHNAKshhgvoChgzWQv1gV85QX0xgmWkm6/aDPypJ+0h25VXwkckipEPaQz
	 BYuEQT5TSpn0g==
Date: Fri, 30 Oct 2026 11:04:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] pwm: tegra: Fix value discarding for duty and period
Message-ID: <auRrUs-eGyJxrlXd@monoceros>
References: <20261020133938.191013-2-u.kleine-koenig@baylibre.com>
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
	protocol="application/pgp-signature"; boundary="l24jphlyjdu2l7gy"
Content-Disposition: inline
In-Reply-To: <20261020133938.191013-2-u.kleine-koenig@baylibre.com>


--l24jphlyjdu2l7gy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tegra: Fix value discarding for duty and period
MIME-Version: 1.0

Hello,

On Tue, Oct 20, 2026 at 03:39:38PM +0200, Uwe Kleine-K=F6nig wrote:
> tegra_pwm_config() is called with u64 values passed for duty_ns and
> period_ns in tegra_pwm_apply(). Make these parameters u64 instead of int
> to not lose the upper bits for bigger values. If such a discard happens
> the values that are written to hardware become wrong, or (if the
> discarded period value becomes 0) a division by zero happens.
>=20
> Adapt the math functions accordingly to not let the now potentially
> bigger values result in overflows. While touching these, also limit the
> scope of the required_clk_rate variable.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd832
> Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

pushed to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

which I will rebase to v7.4-rc1 once that's available and then put in
my for-next branch as 7.5 material.

Best regards
Uwe

--l24jphlyjdu2l7gy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrka6EACgkQj4D7WH0S
/k7RrAf+NaBPjS9wIMoQ9PKruv78TycZ0u93TnrdtzAl7pce7b/xd/mJjwgjuGAZ
xYO/1ioUiAdeNWw73VrfBMq8TdonGvyL+8jZwO3+KdimN7R3853cYnE0Ti2MUE0Q
penMy6/C0AOe5nCtmHohFx1fidtUNJjOYva2uCllXOVK6cOa6OyrkDPv48eTZ7sB
dviopVffUoov+Bu/3U28muUSg+zmEZxKYuI4R/oAUav9dRyIiugfD1uRP+6Wpxcb
lX/W9B8lMkA1/IOE38Sce/6xHZ5iZMTEadQJZarG4Gt2RMhKJcoUAye/iL5ydyCM
w66vKq04D7RQ8a0bMwFTE8E3O07VuQ==
=QGEi
-----END PGP SIGNATURE-----

--l24jphlyjdu2l7gy--
