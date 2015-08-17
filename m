From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Mon, 17 Aug 2015 16:37:43 +0200
Message-ID: <20150817143742.GF6891@ulmo.nvidia.com>
References: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34287 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbHQOiw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 10:38:52 -0400
Content-Disposition: inline
In-Reply-To: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2015 at 05:19:00PM +0200, Clemens Gruber wrote:
> Hi,
>=20
> the first patch from this series contains bugfixes and the second patch
> adds support for changing the PWM output frequency of the PCA9685.
>=20
> Regards,
> Clemens
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>=20
> Changes in v2:
> - Only put chip into sleep mode if the bounds checking succeeds
>=20
> Changes in v3:
> - Fix checkpatch style warnings introduced in v2
>=20
> Changes in v4:
> - Set RESTART bit. Now the duty cycle to period ratio stays the same
>   after only changing the period.
> - Added a comment at the start of the file pointing out that the chip
>   has only one prescaler and changing the period affects all outputs.
>=20
> Clemens Gruber (2):
>   pwm-pca9685: Fix several driver bugs
>   pwm-pca9685: Support changing the output frequency
>=20
>  drivers/pwm/pwm-pca9685.c | 89 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0fG2AAoJEN0jrNd/PrOhWWgP/RVEp7IVsJCayaxjn8jRXBqb
tdYfOVl/qkM7tFGIgIOqekCSx9ZqVqS9YGSftAur7hTvwkQAVF6DLvOSZhoICXfW
p59fBf+WdGk9+EVeog8/dWs/gqVn521NabT9PxfF5Say/Z0rFCJOSPhQPE3yZmih
lmlUg0Iy9CMI3lHJq27TUxvQsv05hj9cg+wJ0B2h/X/DdDydY3TLFmQCcGBZTNFi
S/2Fb3kG2frSXo+cTW54dJS2jJypD61HHDtSOYfLPLhot0Ac0FhOtoAYG6Axma5R
8sPfnhqFIlIMebUFIPdAfBi9AseyxlFIOqLXsz27xx33eHEVfTpKzTGq7Xm/gh09
IprEMMrkqZ+9Wy7z8qqb+Brdrvomh/9YqZoeYXm/0ia+NsfgB7O0Zmee+e8Stw9a
YOKVGGNKDjvfUSBSUS9fZUd0LKuuVHKA0yqa+GJ5aKdCx2ioad+qWwHm1jG9LCv8
5dZ10dG9jpu9nG91car6gVDYC0u86zBtoyRmiQIs4gFpwQxD/R+II0EMfuqAmAcR
Chh62f8DMKEvzSltz9+sGmllRXzq/4tRcqmWUZ8369IN2lFRqu5ZWh/5QXqZIeSz
7OpohKITapC8gf4/hNHitNO0l+EhfO8MNZy7gfSfN8/+YCPdO85cDGsPz21/SQTA
PJ4/3jbW24Pxo4/5/RO4
=MNlh
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
