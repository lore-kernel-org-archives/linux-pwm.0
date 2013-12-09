From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Mon, 9 Dec 2013 12:55:24 +0100
Message-ID: <20131209115523.GA17693@ulmo.nvidia.com>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl>
 <20131209085225.GA27868@ulmo.nvidia.com>
 <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:63433 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932604Ab3LIL4e (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Dec 2013 06:56:34 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so1333910bkh.9
        for <linux-pwm@vger.kernel.org>; Mon, 09 Dec 2013 03:56:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: randy <lxr1234@hotmail.com>
Cc: linux-pwm@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 07:04:12PM +0800, randy wrote:
[...]
> Actually, I don't know whether the pwm works or not. In dmesg, I saw:
> [  853.690000] samsung-pwm 139d0000.pwm: tried to request PWM channel
> 0 without output
> [  876.930000] samsung-pwm 139d0000.pwm: tried to request PWM channel
> 0 without output
> [  879.615000] samsung-pwm 139d0000.pwm: tried to request PWM channel
> 1 without output
>=20
> in my dts, I only add
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> pwm@139D0000 {
> 	status =3D "okay";
> };
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> is it enough to make pwm work, if the driver in kernel has been correct.

It seems like you're missing the samsung,pwm-outputs property (see
Documentation/devicetree/bindings/pwm/pwm-samsung.txt).

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpa+rAAoJEN0jrNd/PrOhb/4P/jjwTcVXp+rmihZYlctiZgk0
ldhWUzd8r3wcft9jorCsIgoZc4yKehxPtUUzct3yunwM1r4OzngznOgM5yIRgA4v
B7zdi6oNUj12huR5mBix2SEjsEnyppbzHokXF1GWziHyp/B1U9jSNlFOaopeBLR0
AK3Me4Mjl3QeP59Hv4YDfAs8OmvYX41HoUS9W7Y/Rb4YnjSXWF8jQ8hce581GAhH
FeVk1nxR93W7JlLKGc11+GH5FJNc/RLirZFoXRD0NzpD4PCx3mh8NSv3aouLjmW6
bUCz1aobZ5ptZ0SOauN/zoNN39CcYk66ZNMJrfsdb43/pOY7A2PiZzozl507Ba1H
9fmszBflgQdhkarqAews0SgruUAPawxt257zReM0yPYf/4qtrc5KxSDLqpy8v71O
BU1q1iiOUX14YeGLC8CMnvLtz2LC6Q+CYyrbR+qAt8ePOq8C378gCjYIkQdy0xdS
RKPTMEskm7ipT7+fE7YiB8WYxc6Et5YuL4z1mEuILRzGJ+gpGh20cvr+s8ibWssN
ILYRfw+jj0N0z8PrHU2O9EqfPx+GZZyRKwr7ikzqI/gEdkj0YFibptqj6mDNv89N
IlSrVan8qdA9KJRviMowLZLz5lfAw1qZ3wVnYdky9fAvfECraPtRIMEHslsX7aT1
e8W9ypIeZxy/LF/pCqCI
=ZfnZ
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
