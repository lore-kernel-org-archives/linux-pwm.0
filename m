From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Fri, 12 Jun 2015 12:38:50 +0200
Message-ID: <20150612103849.GI19400@ulmo.nvidia.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34116 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbFLKj3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 06:39:29 -0400
Content-Disposition: inline
In-Reply-To: <1420846493-31647-4-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linus.walleij@linaro.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2015 at 12:34:49AM +0100, Andrew Lunn wrote:
> Armada 370/XP devices can 'blink' gpio lines with a configurable on
> and off period. This can be modelled as a PWM.
>=20
> However, there are only two sets of PWM configuration registers for
> all the gpio lines. This driver simply allows a single gpio line per
> gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>=20
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the gpio driver. Thus the gpio driver has been
> extended with a PWM driver.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/gpio/Kconfig          |   5 ++
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpio-mvebu-pwm.c | 202 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/gpio/gpio-mvebu.c     |  37 +++-----
>  drivers/gpio/gpio-mvebu.h     |  79 +++++++++++++++++
>  5 files changed, 299 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/gpio/gpio-mvebu-pwm.c
>  create mode 100644 drivers/gpio/gpio-mvebu.h

FWIW, I think this could easily just be all in the gpio-mvebu.c driver,
no need to split it up.

Thierry

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVera2AAoJEN0jrNd/PrOhI08P/At/CW6g2GEXjcAIBg/pYMCw
hG4UgdoWJkPg4uPPFtzbPlAuICPXRqGu7duQUMEQvI/glENJptqGHhVpWhPgIMVf
QhYgq0lM6e6oQMYRJiLtI0et3EZjzeOmd91NJWvUSK5b7q+PeptJADmM2VLn8plC
9zgHIE1ZCbNp0cx38Mhgy5t66F/COJ2qgdkCP4GAZquT6gpIrkhDzBSrAaKuQDtD
L09IfEQkbhM4gtgYABOyOqbGt9oFLtphFTMz9iDlTYlEIa6fJoGIBq+o8lsXhRQQ
Du4AZ000XwwChBF51RfHIn67bzhJNjmUGM5bAqdbgGvouaUYwYUfBiTutlToKYe6
KaLILxEQcF3mQbs+sxQcoIJV2Pba++ZqKpRDE1dTV1j3dOsykmEX7mYC5Oe8+4Uv
rk7qM5ZK+rTLu9+mCDUYMHRLnIGP07H++xSHBSj8nDeV9J8qDpnWDNnQY65sCWSc
Q/rAKLBD+H5rrF/NT2yT2C7hkoZUenQTRLqBHdmHNJXn8d6m1NaNWgobcK7yi9Yj
hMCJ6MJdM+aPjs+dl6tkx5rv6FZxfmKR7pHo1FZSwb91OmPEHvAyV0uVnYlbkMOU
mDi3hfRgnl5ZbCQNC/cCZuJ16lEjx1INh4992cB7VLednNfAc/bqCtq0S4cMESW/
TQMB8A8z4TqyiHhGpjoN
=jJR3
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--
