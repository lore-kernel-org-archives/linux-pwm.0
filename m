From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/4] bus: ts-nbus: convert to atomic PWM API
Date: Wed, 14 Nov 2018 13:15:04 +0100
Message-ID: <20181114121504.GE2620@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-3-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4318206638181949343=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-3-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--===============4318206638181949343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:41:57PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The legacy PWM API should be removed in the long run, so convert a user
> to the atomic PWM API.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/bus/ts-nbus.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
> index 073fd9011154..51f5ed870ad1 100644
> --- a/drivers/bus/ts-nbus.c
> +++ b/drivers/bus/ts-nbus.c
> @@ -282,7 +282,7 @@ EXPORT_SYMBOL_GPL(ts_nbus_write);
>  static int ts_nbus_probe(struct platform_device *pdev)
>  {
>  	struct pwm_device *pwm;
> -	struct pwm_args pargs;
> +	struct pwm_state pstate;
>  	struct device *dev =3D &pdev->dev;
>  	struct ts_nbus *ts_nbus;
>  	int ret;
> @@ -305,25 +305,19 @@ static int ts_nbus_probe(struct platform_device *pd=
ev)
>  		return ret;
>  	}
> =20
> -	pwm_get_args(pwm, &pargs);
> -	if (!pargs.period) {
> +	pwm_get_state_default(pwm, &pstate);
> +	if (!pstate.period) {
>  		dev_err(&pdev->dev, "invalid PWM period\n");
>  		return -EINVAL;
>  	}
> =20
> -	/*
> -	 * FIXME: pwm_apply_args() should be removed when switching to
> -	 * the atomic PWM API.
> -	 */
> -	pwm_apply_args(pwm);
> -	ret =3D pwm_config(pwm, pargs.period, pargs.period);
> +	/* We can start the FPGA and populate the peripherals now. */
> +	pstate.enabled =3D true;
> +	pstate.duty_cycle =3D pstate.period;
> +	ret =3D pwm_apply_state(pwm, &pstate);
>  	if (ret < 0)
>  		return ret;
> =20
> -	/*
> -	 * we can now start the FPGA and populate the peripherals.
> -	 */
> -	pwm_enable(pwm);
>  	ts_nbus->pwm =3D pwm;
> =20
>  	/*

This looks suspiciously like the PWM is actually powering this bus. It
would've been better to model that as a PWM driven regulator rather than
an PWM consumer.

Either way I don't see why pwm_get_state_default() would be useful here.

Thierry

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsEcgACgkQ3SOs138+
s6GRBg/+MdbzygIFga/02x6DINTEl7aLbclwVTmYLAYouj9BUQxr9n6WykVdbp2R
jlRrpDZJHQjh6ERX4py7kVkSpFRnO+6TIvP40RuJy6PsPMVp7Dm8yYaws22L+r/G
6p71eXhFqDYZuD7tCT8MMdEZaqAtMFMlfGssyGS7bLKJ8Q1MLgJ3qKo2A+S3U5cU
f2xdZb0WLo/lNz70ytvkVDUJgzi1KU954y31oTCQNj4yEVvFv0BV2VKNE/wxfqB+
WBcjFJntsEjtW3hkVyhaMx/KkQP+Q8HGcpU0vxi0ErKlyc7epYMBR1MsfWHW2aX4
jMOMK9Tk/sqMYsVAQOthKGhO2XmTmD/XLfCisTBSwcw0Ge2ws48cbSCDtjzW6+td
H5e/VZBd6aG1HcdEbyqqwYtRT5CE8Q7EzKAcPzW8bobMnUPElSy1FgPy2GD93tOp
jMewIUpGylJKFcauu3LJk7clq1c0vx9SZxLrYAAui+/NYjWmf53vfjh3FTEB4gO3
kvgHuYvkEsU7yUnKBjyuULnATXNseH+mYRisww66hhHEeXFnM8borTstr6mHfDuY
eWtPeOyspM2RJs42FXRgIMEX3T6xfGzs8GI1wwQrxUSmamuQAfY+CSXkhJ9RXniz
nAZNFbGNLHRqFqrw528hUhoBLRPQJ7USCk85FB3HQCDMrgZ6RJc=
=4MbC
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--


--===============4318206638181949343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4318206638181949343==--
