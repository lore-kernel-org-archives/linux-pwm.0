Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7B3D1A8F;
	Mon, 13 Jul 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956338; cv=none; b=FA1AHI4UXri3Aa3ZJJtf3ys2wSxkvVtXmumBdYtDsC8hpSIIWBj32kGibVFteuIijm4t0xDrDtDfEXWS+g7z6M7V1+MsQZEtFJNPdSipXyxQC5kYP+j8F0/oqEYheL7DqNoysqCYP4TJQuD7iJ8BPchv9gpMwXl/yPceb5SIdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956338; c=relaxed/simple;
	bh=Zi/qfWwdQ19G7Vyq0p/X1lZ10s0FMS+KMEXOfsuB8lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeNdPcKNwXvINwzfSXXg7XtzKDvDjyHsmkQuU+KpqbQxxcToLhOI+Z8eLLbXjsB9qetz30Na/J4VcIa0DiI+AuV9Sqe8fcF3aEJHpAt77OYi3+EeSvaWft31szxzzu9YVYWpPqVYm/TIJto38nLDy2yhDr0egw7oPsS+J2+XyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvjiS1yS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvjiS1yS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BA0DC1F000E9;
	Mon, 13 Jul 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956330;
	bh=S43y0m3tyKSbLzLPY8izdYm9kJrJvv8tLOFrmfdNees=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PvjiS1ySjBxGgAFmCGinmhv4SzIJetqPWK2oOsciLLvUzevNxwZzKrnKco5PyQaU6
	 BKsTYAPKR2J6Kh0mjgr/UclLbvazIBakYOB+FcrL5D+5dtZhW3gOkHsROEsZgQZE6D
	 9UBWSqOBS6Wf13NAaVRxumh0TmZ/MB8ICez37rS9TBQGhpjtmgHm9U+g7PMrBhBPjY
	 uy+wc1HWfhUwM6vsLtQ6MtxzDg/5AXZh+rSFcOxkVwqu8HUBUeRFxFftRsTY0k6QQo
	 ctKIosS1KYbxU7YFv8CMc5GjmrYw89ZD9XyUP81gcPo4lHL9ueX8D/Tpd1ngcd09qE
	 kLD7Z/PTiO+mg==
Date: Mon, 13 Jul 2026 17:25:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] clocksource/drivers/samsung_pwm: switch to
 raw_spinlock_t type
Message-ID: <alUC6X7GgvxPUelM@monoceros>
References: <CGME20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9@eucas1p2.samsung.com>
 <20260713085653.1145015-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oqbewf4c2d6juqpk"
Content-Disposition: inline
In-Reply-To: <20260713085653.1145015-1-m.szyprowski@samsung.com>


--oqbewf4c2d6juqpk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clocksource/drivers/samsung_pwm: switch to
 raw_spinlock_t type
MIME-Version: 1.0

Hello,

On Mon, Jul 13, 2026 at 10:56:53AM +0200, Marek Szyprowski wrote:
>  drivers/clocksource/samsung_pwm_timer.c | 22 +++++++++++-----------
>  drivers/pwm/pwm-samsung.c               | 22 +++++++++++-----------
>  include/clocksource/samsung_pwm.h       |  2 +-
>  3 files changed, 23 insertions(+), 23 deletions(-)

Assuming this will be applied via the clocksource tree:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--oqbewf4c2d6juqpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpVA2UACgkQj4D7WH0S
/k5qfQf+O0q9IgJiIhTIoZb+PFNLzFpJUfTgt80QNJfsw0CNjUnDubvaD00Jx6CB
0+3gpys6WaM2CnAeAFNuwdQd5gknOHyywKF6iWw6E9CWCjAK8Y2QfvuCHCkoLdp/
ahqtz6RRZr7wm58CesLNihyINKtzOZirlvtrzk4ES2pLB7okf86yajwDAnV6NsfM
spfGp7exy3/fv4zYkFzYu2mVS7sUDuxI9AwjwAlOpFNKIUg35dFi2SAnWZbmZUPA
/NpyBmClhBY84AJqyX2qce3qGpt8UNgFtwW4RwE+3N+EN0mdj+hnSf7kLdYOyBuN
N6SV9wAHRF2h8eUWrss8woO01oVNDg==
=BfQ7
-----END PGP SIGNATURE-----

--oqbewf4c2d6juqpk--
