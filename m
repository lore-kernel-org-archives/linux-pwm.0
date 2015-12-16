From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/6] pwm: lpc32xx: fixes in the LPC32xx PWM driver
Date: Wed, 16 Dec 2015 17:02:47 +0100
Message-ID: <20151216160247.GJ28947@ulmo>
References: <1449401522-22590-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35497 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbLPQCv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 11:02:51 -0500
Content-Disposition: inline
In-Reply-To: <1449401522-22590-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2015 at 01:31:56PM +0200, Vladimir Zapolskiy wrote:
> The changeset fixes a number of issues within current implementation
> of LPC32xx PWM controller driver, namely
> - the SoC has two independent PWM controllers with one channel each,
> - runtime warnings from common clock framework,
> - overflow in duty cycle calculation may result in disabled PWM,
> - unsupported period values are not accepted.
>=20
> Correction of PWM channels requires a correspondent change in
> arch/arm/boot/dts/lpc32xx.dtsi, it has been already sent for review.
>=20
> Changes from v1 to v2:
> - corrected style of examples in documentation,
> - improved commit messages
>=20
> Version v1 can be found here:
>   http://comments.gmane.org/gmane.linux.pwm/2828
>   http://www.spinics.net/lists/devicetree/msg105398.html
>=20
> Vladimir Zapolskiy (6):
>   dt: lpc32xx: pwm: correct LPC32xx PWM device node example
>   dt: lpc32xx: pwm: update documentation of LPC32xx PWM device
>   pwm: lpc32xx: correct number of PWM channels from 2 to 1
>   pwm: lpc32xx: fix warnings from common clock framework
>   pwm: lpc32xx: fix and simplify duty cycle and period calculations
>   pwm: lpc32xx: return ERANGE, if requested period is not supported
>=20
>  .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |  9 +++-
>  drivers/pwm/pwm-lpc32xx.c                          | 59 ++++++++--------=
------
>  2 files changed, 29 insertions(+), 39 deletions(-)

All patches applied, thanks.

Thierry

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYsnAAoJEN0jrNd/PrOhccgP/1gVffNe51ZPwfur2DAMkut7
SL/SE2fT3EoWYAldunjOg5WyJ9jkPkzt/RhXn7hIj1h+2sJfv2k/kmr4IZvA5Hvg
1JMzco8Bjk5tw+iFqVyZZe8Ru4K3v5aRCl+W2VcajvPPItPpeygp6bv8UTI/MBW5
PeSBB6E+PzkOVT02o9bvtgLZO+G3NjSRFMAmrK8dW2/Ks+fiK7H9LCdMx+4GfCXY
5HbAHwO2cXDNttgsdvcYD+kr9axExoXCBl6fuaJ9PqeTzB4vjuEplbA/qmHxrVvs
3/AmNQm6XyOhd4Iv2u/+C2WkUJwh/DX1n7qVZxZCFGA/Pzc+vwDYKhhyW7+6DyNH
keWgWnBDmBGcBvKASlECi3FmaVKNW/0QNqhsAmK2vQQ7mbP7o9SLhKeYWBHDss3w
jxxx1Oidog3dS5sBqCFxVWdz7nnNPSgQuG0cfKJKT9EpqPSM/qqTeQK4JjwvWKcw
Ytmg3o8PrKt/r4iwgOuLlrRoZMV1/4704WkkZdQq73+P68kVWPEdTs2YtTgXVak5
eR0X+l6Dnjg4uu8QxiZaL95GH/oiCQkS4xaXwbaIDVG40wMFZe4Hm6bTJZrSZpGO
0RBkBkMSwsHZKat6isvrEJy4B0OJ/erVkqGZvjTT+XBqie6sjfFHu3fLKtIWw5jl
b9LMlIMlPtSS0Cy6Ex+i
=Qjmm
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--
