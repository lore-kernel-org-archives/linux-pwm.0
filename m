From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: berlin: Add PM support
Date: Tue, 24 Nov 2015 17:23:06 +0100
Message-ID: <20151124162306.GC32623@ulmo.nvidia.com>
References: <1448343785-1540-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448343785-1540-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: sebastian.hesselbarth@gmail.com, antoine.tenart@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 01:43:05PM +0800, Jisheng Zhang wrote:
> This patch adds S2R support for berlin pwm driver.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pwm/pwm-berlin.c | 57 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> index 6510812..2afdb40 100644
> --- a/drivers/pwm/pwm-berlin.c
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -27,10 +27,20 @@
>  #define BERLIN_PWM_TCNT			0xc
>  #define  BERLIN_PWM_MAX_TCNT		65535
> =20
> +#define NUM_PWM_CHANNEL			4	/* berlin PWM channels */
> +
> +struct berlin_pwm_context {
> +	u32	enable;
> +	u32	ctrl;
> +	u32	duty;
> +	u32	tcnt;
> +};
> +
>  struct berlin_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	void __iomem *base;
> +	struct berlin_pwm_context ctx[NUM_PWM_CHANNEL];

Please don't do this. You can easily attach per-PWM data using the
pwm_set_chip_data() function and retrieve it using pwm_get_chip_data().

>  };
> =20
>  static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip=
 *chip)
> @@ -176,7 +186,7 @@ static int berlin_pwm_probe(struct platform_device *p=
dev)
>  	pwm->chip.dev =3D &pdev->dev;
>  	pwm->chip.ops =3D &berlin_pwm_ops;
>  	pwm->chip.base =3D -1;
> -	pwm->chip.npwm =3D 4;
> +	pwm->chip.npwm =3D NUM_PWM_CHANNEL;
>  	pwm->chip.can_sleep =3D true;
>  	pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
>  	pwm->chip.of_pwm_n_cells =3D 3;
> @@ -204,12 +214,57 @@ static int berlin_pwm_remove(struct platform_device=
 *pdev)
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int berlin_pwm_suspend(struct device *dev)
> +{
> +	int i;

unsigned int, please.

> +	struct berlin_pwm_chip *pwm =3D dev_get_drvdata(dev);
> +
> +	for (i =3D 0; i < pwm->chip.npwm; i++) {
> +		struct berlin_pwm_context *ctx =3D &pwm->ctx[i];
> +
> +		ctx->enable =3D berlin_pwm_readl(pwm, i, BERLIN_PWM_ENABLE);
> +		ctx->ctrl =3D berlin_pwm_readl(pwm, i, BERLIN_PWM_CONTROL);
> +		ctx->duty =3D berlin_pwm_readl(pwm, i, BERLIN_PWM_DUTY);
> +		ctx->tcnt =3D berlin_pwm_readl(pwm, i, BERLIN_PWM_TCNT);
> +	}
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_resume(struct device *dev)
> +{
> +	int i;

unsigned int, please.

> +	struct berlin_pwm_chip *pwm =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(pwm->clk);

Always check the return value of this function.

> +	for (i =3D 0; i < pwm->chip.npwm; i++) {
> +		struct berlin_pwm_context *ctx =3D &pwm->ctx[i];
> +
> +		berlin_pwm_writel(pwm, i, ctx->ctrl, BERLIN_PWM_CONTROL);
> +		berlin_pwm_writel(pwm, i, ctx->duty, BERLIN_PWM_DUTY);
> +		berlin_pwm_writel(pwm, i, ctx->tcnt, BERLIN_PWM_TCNT);
> +		berlin_pwm_writel(pwm, i, ctx->enable, BERLIN_PWM_ENABLE);
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
> +			 berlin_pwm_resume);
> +#define BERLIN_PWM_PM_OPS	(&berlin_pwm_pm_ops)
> +#else
> +#define BERLIN_PWM_PM_OPS	NULL
> +#endif

This is a weird way of writing this. I think a more typical way would be
to have the #ifdef contain only the implementation and then define the
dev_pm_ops variable unconditonally, so you don't need a separate macro
for it.

Thierry

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWVI7oAAoJEN0jrNd/PrOhGdIQAJDjGAlmrvmTdc64QPPk2WQH
/GFcXEnUyUnIi2nG8MAgF+xntkr3xe89gkfZBTzR9ZrSJYX0nZYtMyNv/IaNnZrN
zlh8SuBYcuMhEFpDNmyYBKPCho9iVY/O/khjZ9XjCuvGXx0766aZ1YJlh2VWbAFY
CPQp5hFm805dQZwpco4RuOCxTxO3EacBIACJNP6dzREx3iXtAkl6Lrf4BK/PL7n8
s957N0td0Yl/YpkKm3roRtEHZmn8g+4Ven1jobkwFikL/hiDMvMROxYsAzMi10Yl
agHV7317CCOpevjGMBgxxKF//gWKxwN5LGsCUgJ22JB7ntEKr4F/0gR/Ai7w1fYb
0KF40zyQp3foFkws7QSQv1GQ3Yr2OaeR0R+k8eN3Qvira4Y5fxhTUNN4PuIpsTZp
tyU36z9zCVxAMhM85RHy/esecE7BUdwk91J+q37VLQ7X9gpOCUtsjfHWK4hLh/FE
V3BESyLWd5k1jdsPvCSkTWSUOLduEt1bRZUlVnsoE8TzOEEy37CiccW4uVEnp67y
m+WB997uGb1Mh1SNf26dkydJzuqh+FlZKpGGDUVgx9eXG+odKsUpOyWv3/nKgYfr
6A/kHhiZQSGHWfkBnq+MrZM2cyqyEY1f0lt+FQtynD0utKMSpyItkLcsGrTp1wHq
fqyyi56A1u6eeUH0+oyR
=R28n
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
