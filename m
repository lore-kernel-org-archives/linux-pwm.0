From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 15/17] pwm: sti: It's now valid for number of PWM
 channels to be zero
Date: Mon, 5 Sep 2016 13:20:30 +0200
Message-ID: <20160905112030.GO31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-16-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-16-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:06AM +0100, Lee Jones wrote:
> Setting up the STI PWM IP as capture only, with zero PWM-out devices
> is a perfectly valued configuration.  It is no longer okay to assume
> that there must be at least 1 PWM-out devices.  In this patch we make
> the default number of PWM-out devices zero and only configure channels
> explicitly requested.
>=20
> Reported-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/pwm/pwm-sti.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index fcc80eb..a1319c0 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -483,6 +483,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  	if (!ret)
>  		cdata->cpt_num_devs =3D num_devs;
> =20
> +	if (cdata->pwm_num_devs && !cdata->cpt_num_devs) {

Applied, with this corrected to:

	if (!cdata->pwm_num_devs && !cdata->cpu_num_devs)

as discussed on IRC.

Thanks,
Thierry

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzVT9AAoJEN0jrNd/PrOh36EP/jOXpsWH1hXbrqFWfe5xuICA
h3Vp7wU2oqntgTUpBZy8wiBnkLvEtdO5mt8z/nn4a878k6ux1tr1VgAWKeI75rfE
qWXKdvwePNN6vpyv0ISQV/YMNT6niz5Jkb6NR77wVMyYCHpZAfc+RA1bpmGWMmQg
ZcnzljiAuCIX1Z4jI9QyUZR7SCGETNd3Gv3QPiDX7PjY/0GgcOKt43PLJmzCWxkO
tAA9cYQwoxFudESRqnoWqzD1SmGPUaEQGThnICWLaN6ztpddxKhHXxCIptUMrr9p
IYVgEbyfVXRFULu7cT/UPwzH5KAh6bg2Yy2lE3NU+dGBHDHmP23ukb1Ah09zGoMf
4QpxUveDgkSs6d/I4CI/8dRcaMwn0jX5pz+2MjeVcfxHmHCiuZawRFmTxkCLlUVS
gkq//R4E9g9/IrO5SqkQ7NSaxQDrcxY9nrIKQ6rbUSh5IXiY8i7TsYjH3Qc0rEuI
6YiG7NmUN+ilatlZ/8X0/FQSBYBGgQmh0VBWaO6i2H5SZxWUeXs0NNH0PDOPer4C
bAA/hUqeANwSvDEvcjd8F2tFOP2EGdYomWO1h4LdZ8glG/5Pn9pv51Lq7wzzDqPf
efm/wCnhkPikqEjUNqadAgZtr1z56pZh32GUx0lK7Twj3JFQTW6tTyR9SrsEzDm6
64KVWTAdMjBuFz53xbN4
=/ZB5
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
