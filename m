From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: imx27: Fix rounding behavior
Date: Tue, 2 Jun 2020 14:48:35 +0200
Message-ID: <20200602124835.GF3360525@ulmo>
References: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMsi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:48:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D4C061A0E
        for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2020 05:48:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so12633307eju.2
        for <linux-pwm@vger.kernel.org>; Tue, 02 Jun 2020 05:48:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 10:02:45AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To not trigger the warnings provided by CONFIG_PWM_DEBUG
>=20
>  - use up-rounding in .get_state()
>  - don't divide by the result of a division
>  - don't use the rounded counter value for the period length to calculate
>    the counter value for the duty cycle
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSqMACgkQ3SOs138+
s6H0Ew//dg1D7NOYsebYUxn1ebbp1eH/F2Xg1HwYxqcR0QKh+xVcdEHbVEVqPkKL
Fn1HM0l8qe/Und4p8CvS36PyTTGn4X/c3O3+l0wXYvsbTMCwlQctBbcWMvafAgIj
xcjfweYrjXZUwNM9KYiNIZCASt5pI3lfTbnxp+vLQhnGgkL8ZmZUmBmspVTLsSOy
yYn50/FlqSFCFWfiFK/WE8UZWo5rAFO5KubXsJKKMipyJuKTa5tumLj8ic30E9g6
HRHqPuBS/BoIZ4ZzxfgDZo6qyHHvnlFx3ZAXxEFwVGiHj2gy2LH9XpIW/unZLxwq
kW5ydvr+ynOZhKqWNHP3g2080+tM+nm/G6PUeh4tws85qANHcFYge5HhjF+NDunP
oI1ZOgIaqBcRnBRooDJ4Zn/JQHmpQ0X4pwJdNeKAR2pFq0wp5w+UeQbNpRMxJho1
ia+KawFNTWTFCTLFgvzP2GY0yZ+BL5Kx6820khlcQtdq6zqNz0EWS4dJ5pN84VB9
qkpAOpMiP0Mvx8cnaDdLzEFZ0LAE8wIIlUZvS4xo+PzMglH51F3HzHjYMpJ45rEP
dlAXS7W2tswYlUK89IrpEdZv5dcT4t1FeXtLRfZF0bv6RUGW35uTUw8sWgvqk3KT
dkpcXxfpRNkifF63NKULxHq8wrEAbwqZDdYzlVLweJMRpAW+/TI=
=YRtJ
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
