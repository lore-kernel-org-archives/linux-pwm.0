Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821348;
	b=I3B7hgI0h8JZ12HgjYW5fJDiN/t07oOvwid/PjJwh6cll+EcSS1XOGLq6l1RAAW/t+Ep
	 +k56OeXcWHXpgyKjFj420FjgVcMGXh6wlUPE9HFsB4/I7pYRfsk84Abd/dSX0k9oDy5D3
	 yGTlO27SsYq3WUJdWPYUa64e2DG6fViWvEmVtFOSTo1+9gh/2cLk1oT223/xAa77Uxz7N
	 Q2womhkyNMddi/A2L3I6MBCi5SJep0Ciiu3831o+r4z8EmZtqRDS1g6YobtK8ZqRotfua
	 uTa3BMw3anMVWfWEKwpK4B5JJX4G7LhzvlyCF1iIRiDB0oCn5XPrJRxuDcXNR+c68DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821348;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9qlmeEjjN/Hi5B1yhZatHZmrPx94agQrfT4eJRLAUHQ=;
	b=GwLoJoTWh4xZl/kkoeDQ7YLnIAwdYc4O2EGVBTcDofWgy6Hj/1Ol+hKNQUERjTr+LvqE
	 0ATivv8gl4jFc1l8awac00KxaLR5gpE34qfdrDhZXBL8x16IB6Tjz/uxdL56NNxyfjc0J
	 mfhLGcBsnjpk+xUlzhOHoGP7j6oNuFzloXvEcrJj5Lg/+xuCRZeSYtNG+Bs6qV0bajihq
	 sjF7CMi1vLDcQuBjU/vQEgOnpUeLBPcCLRQ15gs1UlkX6c42b/qz2nN9ybFnMzcECaUan
	 rx+3vRqY8MxrS0eKHGs/wG9u35NUCZqKwOYWd+4VuNkra55lL+CzTnutyT1qQW8ygIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WryHB1Y5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 88187606A330;
	Mon, 16 Nov 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WryHB1Y5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 91AE21F000C4;
	Mon, 16 Nov 2026 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821348;
	bh=9qlmeEjjN/Hi5B1yhZatHZmrPx94agQrfT4eJRLAUHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WryHB1Y5S8dXg39aRX1rQ50qwjg8X6zBrNMJ+ABoR3hHhY+4yElAJwg8iwYY7Kkf1
	 FfPPVktWVzNRS6EEjk6BK8MBcvzabmWwtTgTAF1aRdBqZBDlCZfUufQpEbcQ0rHuK2
	 zOyzkWwv5eHoc8mhrIMolgkw21AiIWOPi9nM94kfZZET/4TtTllsTOpSU8huyPDHZS
	 oGtxKBVY//l4D8cGoQaEUJesYrkV+KnfgWKPI/C19I1W56JBwdWeH08YZkA4Ne/YI2
	 u8giuvqKE4kCzZGbe3v8E6DJyScj2Ojun43MuWYdgjGPQFdK6THB6PHPGdfa6opebd
	 OQTvAKnGB8Vjg==
Date: Mon, 16 Nov 2026 10:29:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] pwm: mxs: Disable clock on invalid period error path
Message-ID: <avrMdLAPp2oOtdQA@monoceros>
References: <20261102105005.1007-1-laixiangwu@cmss.chinamobile.com>
 <20261116031043.508-1-laixiangwu@cmss.chinamobile.com>
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
	protocol="application/pgp-signature"; boundary="2qdyaspsc4lt35jv"
Content-Disposition: inline
In-Reply-To: <20261116031043.508-1-laixiangwu@cmss.chinamobile.com>


--2qdyaspsc4lt35jv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mxs: Disable clock on invalid period error path
MIME-Version: 1.0

[Cc: +=3D Lee]

Hello,

On Mon, Nov 16, 2026 at 11:10:43AM +0800, Xiangwu Lai wrote:
> I've noticed that Lee Jones' series "pwm: Fix various bugs
> reported by Sashiko" also fixes the clock leak addressed by my
> patch below, with a broader scope:
>=20
>   [PATCH 2/8] pwm: mxs: Return early when disabling and fix error-path cl=
ock leak
>   https://lore.kernel.org/all/20261105143847.2559586-3-lee@kernel.org/
>=20
> Besides balancing clk_prepare_enable() on the same -EINVAL error
> path, that patch also handles the !state->enabled case upfront,
> avoiding a division by zero when state->period is zero, and it
> already carries a Reviewed-by from Frank Li.
>=20
> My patch for reference:
>=20
>   pwm: mxs: Disable clock on invalid period error path
>   https://lore.kernel.org/all/20261102105005.1007-1-laixiangwu@cmss.china=
mobile.com/
>=20
> Please feel free to drop my patch in favour of Lee's more complete
> fix; there is no need to keep both.

Thanks for this follow-up, very appreciated. I marked your patch as
Superseded in patchwork in favour of Lee's patch.

Best regards
Uwe

--2qdyaspsc4lt35jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr6zN8ACgkQj4D7WH0S
/k7o7Qf/UjQPeXOgoT/+hklwnuPwbNMvmFIoh2yJPPQxNX68YtUWalecVUW/TmP+
/ZSd6ajIFk0peHc7RIh2WFNEehinYm9NtMF18bmVq1NX4SqsyLwsml249xLW8WoA
WaKvrw5E2R68hfsgFf0UyL0XosMR83mQr0cYXnaPGOjqMxjR03euzOF0vU5+bLR6
asiWvLn0dquA7ZbR59dOrWYC+w/2IY9qBpQxZEWYh6IdNzVwMw/9hKoA8SOW7l0C
6836BOJF8XGxdkZ/ceXALJtxeVgmwxhry3xYika7u+OKSdMhdYxX0idkNfpUGNtv
S5quDF/FV+xyi93Z+bqj9pyFQmZG5A==
=KPRv
-----END PGP SIGNATURE-----

--2qdyaspsc4lt35jv--
