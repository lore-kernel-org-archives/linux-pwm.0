From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Fix module autoload for OF platform
 driver
Date: Mon, 21 Sep 2015 10:07:14 +0200
Message-ID: <20150921080714.GB19865@ulmo.nvidia.com>
References: <20150918165821.GA27689@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150918165821.GA27689@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 06:58:21PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>=20
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
>=20
>=20
> Hello,
>=20
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
>=20
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519

This is useful information and belongs in the commit message, so I moved
it into the commit message before applying.

Thanks,
Thierry

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV/7qvAAoJEN0jrNd/PrOhRdcP/jY0lmGLXKZwqsAH3D9F4E9X
vAZ4rgxlufYXP1bkG/M6THfSI+4KwzRuVEwLOG6gLYX/m+bkJ0xcX4Dl1LDgCFUN
CoXWeZidpSUI51oT7FCwnWSBK3bKmeEL1lxM8Wt9oDHVI3RhYQub3Egg9aMhVrSz
hRKL9RkS4eGK0i+P+YM+a2/xOCTYZv3Aqw4mwJ66n0iC7Jjts8waezCOVqaA1JWF
5VIFTqEoNT/AyaB6WkFZSJM/A7Y29lrSqSmZsnXBFc+GI0RIELmpxGTW1gPaqzGj
QPrymXnlTIYIaaV0UpibyUizkceWdVfr1krvKX/M3xwHXnorqDuPi/8tGDoVfSH4
eOtpnthTKjwEq/IXeIXdULXgrVSMPoCK8eGpdn1zQ34kdjrnfCBxrMwty1i/ebbV
amzs0r4YPkHZ4/GwiyWwadWF4wc4VwIFxlDGCOumSqnm/kGy7vM5xJN9naqUmCmI
rpwtJQ6yEVoZMJ9/3ann/27p7amg17x8H1D00A5GoAftebDwuaFRMB+JVTib3a+r
QVuv2N+sr6iHumIom6MTRqkJO/f/2cpHwYYMqszU4y7KQwmCFjluzDWi1YZs0QLW
0hWZHW4TMJutNM5nJeZzmdRTsrJExs6oyY9giSkbbYahUnEACsjP7L5MsQYrR5OQ
jxfrfMrk5zQuC67wtf8g
=bAOU
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
