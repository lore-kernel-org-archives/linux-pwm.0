From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v1 2/4] ARM: PWM: add allwinner sun8i R40/V40/T3 pwm
 support.
Date: Thu, 11 Jan 2018 13:45:23 +0100
Message-ID: <20180111124523.pnn4rbczruflzprz@flea.lan>
References: <20180111113241.GA21953@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2st3b4fmtclegoga"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51740 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeAKMp5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jan 2018 07:45:57 -0500
Content-Disposition: inline
In-Reply-To: <20180111113241.GA21953@arx-s1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--2st3b4fmtclegoga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 11, 2018 at 07:32:41PM +0800, hao_zhang wrote:
> This patch add allwinner sun8i R40/V40/T3 pwm support.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

I don't really know the PWM framework, so I'll obviously leave that
part to Thierry, but the DT and probe parts look ok.

You have a number of issues with checkpatch though still, please run
=2E/scripts/checkpatch.pl --strict, and once all the issues have been
fixed:
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2st3b4fmtclegoga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpXXGIACgkQ0rTAlCFN
r3Sa4g//WLC1WSgThhJRTgd53Ncm+34gZaJ3DON1lK5RjECsu4rHW5Orxq8/lrom
tWPjW4ZAOasNTtx6lpUDalO+0x7CewPPyyYgALtEPJdl4hRW4m6iB/o6qsD5QURq
MKJC1upViXO5tYPb4+2ObAOsQ/cFBcjWDt382tnYM/o6+X/1fvg2OmxqW8wkaJ4u
3y4d8g1VzPJCXOKIBYgR5bLtGR3U+Kcm7Cawb9VaV706znuZ+/PnFPWjQwlIV0aQ
pQeC1v3GHPWL7F9KEVKhy8jjanLS/6N9raSazYrtHAEO4iY7PxkGU6gusxZ7UVMf
XYo66pW64gDQSLdWRzY2FuIeor8kEQcUc3LZ9VH3foGXEDqGaC77qh36Iln9acSX
KG9hEt1pKp6pM14O0Zckg1Cp0Fa8lVT7gbz1yfwPZg8mXIxIbzHwUi7OfXpwD63P
qIWsrrsOFWoDaFJKJ3+L/Nr7xLTxZZxSWv9mi6Cllrq28xy+fp0rIysdVFC2BzXY
aTFKuP+xVfccMLHEmWb1Qdv+t2B1/ovdlNX/2mKNWyuOWTuxou9CeR9phWoRm/vD
p82itCr7hSkqODpmbkVRaYOqLaKCHksSftDhBif0bB+tb5HE3+0wVRX/M83GmqsJ
Sw5VwFMuG7mqmDBzE2gwFZWlxSZZdm8tBRIzy/hzAAxRF/9Hnrg=
=vHZZ
-----END PGP SIGNATURE-----

--2st3b4fmtclegoga--
