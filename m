From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Date: Mon, 29 Jul 2019 08:36:30 +0200
Message-ID: <20190729063630.rn325whatfnc3m7n@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRB6VH7LUQKGQEHFICNPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190726184045.14669-3-jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Cc +=3D reset framework maintainer

Hello Jernej,

On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> H6 PWM core needs deasserted reset line in order to work.
>=20
> Add a quirk for it.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> ---
>  drivers/pwm/pwm-sun4i.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index de78c824bbfd..1b7be8fbde86 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/time.h>
> @@ -72,12 +73,14 @@ static const u32 prescaler_table[] =3D {
> =20
>  struct sun4i_pwm_data {
>  	bool has_prescaler_bypass;
> +	bool has_reset;
>  	unsigned int npwm;
>  };
> =20
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> +	struct reset_control *rst;
>  	void __iomem *base;
>  	spinlock_t ctrl_lock;
>  	const struct sun4i_pwm_data *data;
> @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
> =20
> +	if (pwm->data->has_reset) {
> +		pwm->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->rst))
> +			return PTR_ERR(pwm->rst);
> +
> +		reset_control_deassert(pwm->rst);
> +	}
> +

I wonder why there is a need to track if a given chip needs a reset
line. I'd just use devm_reset_control_get_optional() and drop the
.has_reset member in struct sun4i_pwm_data.

>  	pwm->chip.dev =3D &pdev->dev;
>  	pwm->chip.ops =3D &sun4i_pwm_ops;
>  	pwm->chip.base =3D -1;
> @@ -383,19 +394,31 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
>  	ret =3D pwmchip_add(&pwm->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> -		return ret;
> +		goto err_pwm_add;
>  	}
> =20
>  	platform_set_drvdata(pdev, pwm);
> =20
>  	return 0;
> +
> +err_pwm_add:
> +	reset_control_assert(pwm->rst);
> +
> +	return ret;
>  }
> =20
>  static int sun4i_pwm_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&pwm->chip);
> +	if (ret)
> +		return ret;
> =20
> -	return pwmchip_remove(&pwm->chip);
> +	reset_control_assert(pwm->rst);
> +
> +	return 0;
>  }
> =20
>  static struct platform_driver sun4i_pwm_driver =3D {

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20190729063630.rn325whatfnc3m7n%40pengutronix.de.
