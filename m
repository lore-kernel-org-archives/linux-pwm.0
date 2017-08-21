From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/3] pwm: pwm-samsung: fix suspend/resume support
Date: Mon, 21 Aug 2017 10:34:17 +0200
Message-ID: <20170821083417.GT18996@ulmo>
References: <1493028069-32003-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170424100135epcas5p28465e84a8517c219cb8a1b719fb1137d@epcas5p2.samsung.com>
 <1493028069-32003-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VZEZlOQeSr/zV9d3"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37973 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdHUIeU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 04:34:20 -0400
Content-Disposition: inline
In-Reply-To: <1493028069-32003-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org


--VZEZlOQeSr/zV9d3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 12:01:08PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Fix suspend/resume support:
>=20
> - add disabled_mask to struct samsung_pwm_chip to track PWM
>   disabled state information in pwm_samsung_{disable,enable}()
>=20
> - rename pwm_samsung_config() to __pwm_samsung_config() and
>   add extra force_period parameter to be used during resume
>   (to force tin_ns and tcnt recalculation)
>=20
> - add pwm_samsung_config() wrapper for preserving old behavior
>=20
> - properly restore PWM configuration in pwm_samsung_resume()
>=20
> - remove no longer needed pwm_samsung_suspend()
>=20
> - update Copyrights
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 67 +++++++++++++++++++++++++----------------=
------
>  1 file changed, 35 insertions(+), 32 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry

--VZEZlOQeSr/zV9d3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmamwkACgkQ3SOs138+
s6H5qA/6A1300U9jcu4KSTZVzckgU8d9LOF9KqL30xq96hKfggslZIr/sk0g1Ngi
G8Rq0Mxbo0VmdrB+DbvQV99JOZBersHoq9w8IU6Vgws8M9WpLiB3uZvYWGwHRFf8
D7eVHC+PyC61mPvJykVR207rZ4NTrpxWK4s6tiM0wJRRagx5mIh5krUGWW4J5Rpz
TMgkzn79MlKz3F+jTK08gPYt7gQH3EfHrcW2Au9xRsrJ8jV8Qx4SjAB47SGyVsoT
RiqQ9xM8n9YtHsMS132sBCEixENvtVNumTzXQwcvuhRXiMEI7wp4zTPLhIi0fmDR
Uzor0NGAfgbWi6/NfeGFFzXpli8dYyqetdlpgwFuP8aL2XZmYz7S7jg3IhmYF1mb
UtPmaOPr4wZswLAoEQAKfAS0+DBVS4vbQPpAqeN2MqjD4LD26LRpD0XYdm4CLFyM
r6gi0Yo1MqV2HlSCVjLQmQFZKKSmSM1wpC1usulpAXhVLkd26Ckg08Zt6UuudUwL
RibYHkMLc9nidNimthP/qVVbJrBxizkn5jxB6LTMSfzKeBWR0SO7rCX+xLqSqOI9
quxN5jpPDrG4wiW369YYtk2jNbU4/GaiGySi4+QTxdMQ04h6/3UwH8V4yYGgvmqy
sUE30Awdpc+QbgiXW88VMaCTEMK8Nrv6opkkaO/BQEnt10GwL6Y=
=BGzr
-----END PGP SIGNATURE-----

--VZEZlOQeSr/zV9d3--
