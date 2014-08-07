From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
Date: Thu, 7 Aug 2014 14:55:51 +0200
Message-ID: <20140807125549.GA32027@ulmo.nvidia.com>
References: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46069 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428AbaHGMz4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Aug 2014 08:55:56 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so5386520pad.37
        for <linux-pwm@vger.kernel.org>; Thu, 07 Aug 2014 05:55:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Liu Ying <Ying.Liu@freescale.com>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> The .config() hook imx_pwm_config() calls clk APIs like clk_prepare()
> and clk_get_rate(), which might sleep, so we need to set can_sleep flag
> on pwm_chip.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes since v1:
>  - Set can_sleep flag for both imx_pwm_v1 and imx_pwm_v2
>=20
>  drivers/pwm/pwm-imx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--huq684BweRXVnRxX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT43dVAAoJEN0jrNd/PrOhdfgQAKHbtQgYYJrzetn/4bY1m1WU
u+6DG9g8x+m8fj55+2zgiipVZrNg7MmWBOsPTLEId3TXkBxe7nXqbhmZzeRMeX4k
IWeNGgzZ4+fFrhw9dytQuoj0J7jzCtVY4ib6GKZXU1YFSmW2Y8NFK5gbx8rlINjP
5X7r3kh7fe/XT7B8qmH7sV3l/e81WzXbk3NBg6tX6D7SrU3BSNkIxO8MQR0NafuU
iVpbgu0SN/CuHSmve9YzgrqbwgT0/T85C3wJIqpx36FfMfxYCzje4U2O1dKpIZf6
uVjJsFCBd7ANGJwWIkSZQTdNcq/Al971BN8zwgpEc58S7KNivSm9iYaix/uHaNnK
44TOMiA6EqfGNp6eV0VKTyuZ1AS1crDyqZTApc+8U9o72klQgMZt2GgAjKD/ndIX
jn0usiZsFwXgUC0uA0J+Asof8nT2IhFdTg5bltsg99UmzzZQ+3ZBr1BLwZai+8fW
9x0+FcqJUPRUvXT/+sAfzpfO1e6V3o35sstWsE70qsPJvlWSF2O43h+ZYpAAutRP
hluDijIk9nCxgY/yXNUhTYhGDiEb4jJILDBLG2MHWpwhDY4YIYpZVemRfR0ztXJU
LxM8Ja2EHcdiEX2QSvgIu0bE9v/G0VQhVV5OJDxK83VlzH/5Et6wzXXF+SOvQgAq
zwJvZYBg7H5a+7gE/Fyi
=+j3/
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
