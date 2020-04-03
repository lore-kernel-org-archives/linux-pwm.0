From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 REBASED] pwm: pca9685: fix pwm/gpio inter-operation
Date: Fri, 3 Apr 2020 21:44:25 +0200
Message-ID: <20200403194425.GC201060@ulmo>
References: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35597 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgDCTo3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:44:29 -0400
Content-Disposition: inline
In-Reply-To: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>, YueHaibing <yuehaibing@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 07:01:06PM +0200, Clemens Gruber wrote:
> From: Sven Van Asbroeck <TheSven73@gmail.com>
>=20
> This driver allows pwms to be requested as gpios via gpiolib.
> Obviously, it should not be allowed to request a gpio when its
> corresponding pwm is already requested (and vice versa).
> So it requires some exclusion code.
>=20
> Given that the pwm and gpio cores are not synchronized with
> respect to each other, this exclusion code will also require
> proper synchronization.
>=20
> Such a mechanism was in place, but was inadvertently removed
> by Uwe's clean-up patch.
>=20
> Upon revisiting the synchronization mechanism, we found that
> theoretically, it could allow two threads to successfully
> request conflicting pwms / gpios.
>=20
> Replace with a bitmap which tracks pwm in-use, plus a mutex.
> As long as pwm and gpio's respective request/free functions
> modify the in-use bitmap while holding the mutex, proper
> synchronization will be guaranteed.
>=20
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Link: https://lkml.org/lkml/2019/5/31/963
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> [cg: Tested on an i.MX6Q board with two NXP PCA9685 chips]
>=20
> ---
>  drivers/pwm/pwm-pca9685.c | 85 ++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 37 deletions(-)

Applied, thanks.

Thierry

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HkhkACgkQ3SOs138+
s6EpLw/7B2wgmKpQYAy0SEAUiVfRJqbh5qpUT26I6qKNgXMtkhPjhtinfPd7MCta
YYmIWZxEPUZ2iO1pmWKItkQpCsyomanvTLZX7g/4+8zd8I6bVgREdtckx+8gAQ6W
L2IBR0QcPOyRVJYJB09IcCoX0A5EfWp3qL3s8dm66nTnk+WwsrTma6IpaMUkHS3y
ezvztdPJ6l6q6M/ZgiXrRj/+oSrzvj/x0Fa3jqT13i0+DWUldk4SuY2Bt0GmFByu
FaSKeonlma4tCIkczxge2Zg3niVYN5VylsnZoIV2K6l3x3YM4w4nX5Wu6kVDz+bd
caNzwGhJyrlrlWt7vGPph+MAP/wzY+anaO8v5HnN3a0QDq4P39swCgffGQsLGdeE
7f5ivDPUHwhzWoIyNAdWMBekPA2Y0QaFAaC2/WBd3Eoh70YOfgLS4VQRchljE49e
eLt4kZq0jkEdPXtrNTZ4oeF4uY9u2vGkR802+AJ2QCC7PqWQfJTVg7cX28pP5fj0
sPVdNXbxilZ+9lNZq4OAO2BoYFBR/rSIc36xxri/+jIAqA8X044NJqlPcR0T54nV
SFNpRx4EVTGxTi14Cq/zVPuai7OxM/nug5lFx63qYvGp2+a7M3D+lZJ6WSimuoK/
KpRAsgNGeHZCeGllgIh548dbc8VRT2XPrIqGRJBcHzO2rwWt9bY=
=miJb
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
