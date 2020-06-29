From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when
 validating duty cycle
Date: Mon, 29 Jun 2020 21:45:51 +0200
Message-ID: <20200629194551.nlsgjlc6g35taks6@pengutronix.de>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-2-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfpd2ci3eiscija7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200629124752.1018358-2-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pwm@vger.kernel.org


--nfpd2ci3eiscija7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 01:47:49PM +0100, Lee Jones wrote:
> 'duty' here is an unsigned int, thus checking for <0 will always
> evaluate to false.
>=20
> Fixes the following W=3D1 warning:
>=20
>  drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expr=
ession < 0 is always false [-Wtype-limits]
>=20
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee70..46f0a45e9049c 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -143,8 +143,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		value =3D rate * state->duty_cycle;
>  		duty =3D div64_u64(value, div);
> =20
> -		if (period < IPROC_PWM_PERIOD_MIN ||
> -		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
> +		if (period < IPROC_PWM_PERIOD_MIN)
>  			return -EINVAL;
> =20
>  		if (period <=3D IPROC_PWM_PERIOD_MAX &&

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nfpd2ci3eiscija7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76ROwACgkQwfwUeK3K
7Ambxwf/R6wYgRkhf9eNfmHQhlvmhydLzULYpt4yxZAlGdgVBIv5d0queLbzMC/A
+Rg9YS0L+QlaHXscl/HMURmyNE/ogz70JD/K+RD9gtRABEX1qC6VCXudZ372QVkZ
CnsUQXpva36Q680MkvM7Df3pJmj82YvCRDkpyOfXdb66d28bKKZXfqnACTzESIzp
7eAIMtkdY1sOUA9pFIGrujjVrtpvXjUy7X+eq0lxspMoRxeMb9fqm40kVCbPCdEO
gILougjq73SO3L2Q14oh/3XydBgc87caM1yhihbz3OamZd6m/BEp0pUvHTeNHpdJ
GIXb0dYXi44CkLHakoWrXsYEAoelcA==
=0gnH
-----END PGP SIGNATURE-----

--nfpd2ci3eiscija7--
