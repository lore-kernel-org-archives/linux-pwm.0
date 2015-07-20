From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/2] pwm-pca9685: Fix several driver bugs
Date: Mon, 20 Jul 2015 11:27:24 +0200
Message-ID: <20150720092723.GP29614@ulmo>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-2-git-send-email-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tZCmRiovzb4sxAVa"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36889 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbGTJ1h (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 05:27:37 -0400
Content-Disposition: inline
In-Reply-To: <1437381369-8502-2-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 10:36:08AM +0200, Clemens Gruber wrote:
> Problems:
> - When duty_ns =3D=3D period_ns, the full OFF bit was not cleared and the
>   PWM output of the PCA9685 stayed off.
> - When duty_ns =3D=3D period_ns and the catch-all channel was used, the
>   ALL_LED_OFF_L register was not cleared.
> - The full ON bit was not cleared when setting the OFF time, therefore
>   the exact OFF time was ignored when setting a duty_ns < period_ns
>=20
> Solution: Clear both OFF registers when setting full ON and clear the
> full ON bit when changing the OFF registers.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 34b5c27..f4a9c4a 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -85,6 +85,22 @@ static int pca9685_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	}
> =20
>  	if (duty_ns =3D=3D period_ns) {
> +		/* Clear both OFF registers */
> +		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> +			reg =3D PCA9685_ALL_LED_OFF_L;
> +		else
> +			reg =3D LED_N_OFF_L(pwm->hwpwm);
> +
> +		regmap_write(pca->regmap, reg, 0x0);
> +
> +		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> +			reg =3D PCA9685_ALL_LED_OFF_H;
> +		else
> +			reg =3D LED_N_OFF_H(pwm->hwpwm);
> +
> +		regmap_write(pca->regmap, reg, 0x0);
> +
> +		/* Set the full ON bit */
>  		if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
>  			reg =3D PCA9685_ALL_LED_ON_H;
>  		else
> @@ -112,6 +128,14 @@ static int pca9685_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> =20
>  	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
> =20
> +	/* Clear the full ON bit, otherwise the set OFF time has no effect */
> +	if (pwm->hwpwm >=3D PCA9685_MAXCHAN)
> +		reg =3D PCA9685_ALL_LED_ON_H;
> +	else
> +		reg =3D LED_N_ON_H(pwm->hwpwm);
> +
> +	regmap_write(pca->regmap, reg, 0);

Doesn't this undo the setting of this register back up in the duty_ns =3D=3D
period_ns conditional block?

Thierry

--tZCmRiovzb4sxAVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrL77AAoJEN0jrNd/PrOh6wQQAKE7Gz1Nu7m4mx2fifITnW7i
HHX+aOmfgA9Gvr28VbqkPGE/tawTWcgSsquWGWCOtlifFj1hq8kGIVYxfM34rviE
LRbUf3QKLOryEwli4gVxpS3/MJYV9HOKc2DfrKprbV91uTL8Y3aQZDf/LXRvkgLW
3q4+bRamJXKiQ8KkI6IHI/33hARJa/PeDCaCpVtPSJNiadVElhlBIRL0U+UVFZA7
zriho9VfosLzu/Pu6MehONQubVXcgNmJqjxFW7OwKqcYtePTtuXwHpVZb0D6jqaJ
R8zNMtOKgiWUPg2soUqj55dIhALITqNbp4X9QeoZmzvXHUTaZjNyo+2Pr94LirL7
gQext8RCF324hlS6wGC8jxagiVsq7H/AqtMyW9KSrAV+V5KKXEsnhb5T6Wwssu1N
lzeF++U8ZCVbg4NW5zxoXh1V7wn6eTjh+Gc7QzB52LUqa1mCZEtkJlZeEYr24Z5F
Vrlf8vNu36DP31LVtemy04Qq8VPn0BgIK9MqAmE1LrDH57a8rGbikjBrPWHj9bF+
3NzV6jQNiRrNm4SFxSN7dPwASgN9Gfk9mBVzH9gcscRWEkwN4W2I7juikhou4YaL
50lR1XgIBSfnEHdrk3/C3Dhvwy3kdDyh+l+kk4IATAWxc1XnYGtNc5X2K3+ZG/St
TQBlUyTRLHmdcBVQ9GGi
=3AGM
-----END PGP SIGNATURE-----

--tZCmRiovzb4sxAVa--
