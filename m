From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/8] dt-bindings: pwm: samsung: Do not require
 interrupts on Exynos SoCs
Date: Mon, 6 Jul 2020 11:41:57 +0200
Message-ID: <20200706094157.kyag7p5df3vo54wx@pengutronix.de>
References: <20200702155149.12854-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lp45qtpd333jetea"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJmD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 05:42:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EAAC061794
        for <linux-pwm@vger.kernel.org>; Mon,  6 Jul 2020 02:42:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>


--lp45qtpd333jetea
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 05:51:42PM +0200, Krzysztof Kozlowski wrote:
> The bindings required interrupts for all SoCs but actually only the PWM
> timer clocksource (for S3C/S5P SoCs) was using them.  This PWM timer
> clocksource driver is not used on Exynos SoCs thus the interrupts can be
> marked as optional.
>=20
> Reported-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

LGTM,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I'd expect it is ok to let this patch go in via whatever way the other
patches go. (But it's Thierry who has the authority here.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lp45qtpd333jetea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8C8eIACgkQwfwUeK3K
7AkYwgf+O/4iyYsFqS4Hic6Gl1rSJwKY5n02UMuYa3t79MwyE4NMWqSYhqRDIMuh
owMQNcF9YpCOJCzV/re9ZQVSo166NP/THzw1E5e1wDG8seysYEY1NLHsWjQ2Xiuq
uxehUvUBcMw9CbsrKYLWV0meSKcfvU8PAGZXZmPOMvtBWBXIILTicj+MZIiThBij
J9sprwxuT9NPwav5WeKZE39PbV3825KPDPoP8x2YXILUDvBVUANqNkIMW8oa7/4v
L+mIYp0FWpRxHcynPeWsQhwYCJs4xLlX1HeZJy+jiJSzah7485+ny0KxxU0kKbzU
w3cdycy8srQPH6mLzkbJcdNn5RfkDQ==
=nn3C
-----END PGP SIGNATURE-----

--lp45qtpd333jetea--
