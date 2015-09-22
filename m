From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 01/12] pwm: introduce default period and polarity
 concepts
Date: Tue, 22 Sep 2015 22:49:25 +0100
Message-ID: <20150922214925.GC3442@x1>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33669 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbbIVVti (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2015 17:49:38 -0400
Received: by pacex6 with SMTP id ex6so20380289pac.0
        for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2015 14:49:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@google.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutron>

On Mon, 21 Sep 2015, Boris Brezillon wrote:

> When requested by a user, the PWM is assigned a default period and po=
larity
> extracted from the DT, the platform data or statically set by the dri=
ver.
> Those default values are currently stored in the period and polarity
> fields of the pwm_device struct, but they will be stored somewhere el=
se
> once we have introduced the architecture allowing for hardware state
> retrieval.
>=20
> The pwm_set_default_polarity and pwm_set_default_period should only b=
e
> used by PWM drivers or the PWM core infrastructure to specify the
> default period and polarity values.
>=20
> PWM users might call the pwm_get_default_period to query the default
> period value. There is currently no helper to query the default
> polarity, but it might be added later on if there is a need for it.
>=20
> This patch also modifies all the places where the default helpers sho=
uld
> be used in place of the standard ones.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/leds/leds-pwm.c              |  2 +-
>  drivers/pwm/core.c                   | 14 +++++++-------
>  drivers/pwm/pwm-pxa.c                |  2 +-
>  drivers/pwm/pwm-sun4i.c              |  3 ++-
>  drivers/regulator/pwm-regulator.c    |  4 ++--
>  drivers/video/backlight/lm3630a_bl.c |  4 ++--
>  drivers/video/backlight/pwm_bl.c     |  2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/video/fbdev/ssd1307fb.c      |  2 +-
>  include/linux/pwm.h                  | 17 +++++++++++++++++
>  9 files changed, 34 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 1d07e3e..2c564d1 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -125,7 +125,7 @@ static int led_pwm_add(struct device *dev, struct=
 led_pwm_priv *priv,
>  	if (led_data->can_sleep)
>  		INIT_WORK(&led_data->work, led_pwm_work);
> =20
> -	led_data->period =3D pwm_get_period(led_data->pwm);
> +	led_data->period =3D pwm_get_default_period(led_data->pwm);
>  	if (!led_data->period && (led->pwm_period_ns > 0))
>  		led_data->period =3D led->pwm_period_ns;
> =20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3f9df3e..732375d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -146,12 +146,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, co=
nst struct of_phandle_args *args)
>  	if (IS_ERR(pwm))
>  		return pwm;
> =20
> -	pwm_set_period(pwm, args->args[1]);
> +	pwm_set_default_period(pwm, args->args[1]);
> =20
>  	if (args->args[2] & PWM_POLARITY_INVERTED)
> -		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
> +		pwm_set_default_polarity(pwm, PWM_POLARITY_INVERSED);
>  	else
> -		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
> +		pwm_set_default_polarity(pwm, PWM_POLARITY_NORMAL);
> =20
>  	return pwm;
>  }
> @@ -172,7 +172,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const st=
ruct of_phandle_args *args)
>  	if (IS_ERR(pwm))
>  		return pwm;
> =20
> -	pwm_set_period(pwm, args->args[1]);
> +	pwm_set_default_period(pwm, args->args[1]);
> =20
>  	return pwm;
>  }
> @@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *ch=
ip,
>  		pwm->chip =3D chip;
>  		pwm->pwm =3D chip->base + i;
>  		pwm->hwpwm =3D i;
> -		pwm->polarity =3D polarity;
> +		pwm_set_default_polarity(pwm, polarity);
> =20
>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>  	}
> @@ -730,8 +730,8 @@ struct pwm_device *pwm_get(struct device *dev, co=
nst char *con_id)
>  	if (IS_ERR(pwm))
>  		goto out;
> =20
> -	pwm_set_period(pwm, chosen->period);
> -	pwm_set_polarity(pwm, chosen->polarity);
> +	pwm_set_default_period(pwm, chosen->period);
> +	pwm_set_default_polarity(pwm, chosen->polarity);
> =20
>  out:
>  	mutex_unlock(&pwm_lookup_lock);
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index cb2f702..65b80aa 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -160,7 +160,7 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struc=
t of_phandle_args *args)
>  	if (IS_ERR(pwm))
>  		return pwm;
> =20
> -	pwm_set_period(pwm, args->args[0]);
> +	pwm_set_default_period(pwm, args->args[0]);
> =20
>  	return pwm;
>  }
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index cd9dde5..a364fb7 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -333,7 +333,8 @@ static int sun4i_pwm_probe(struct platform_device=
 *pdev)
>  	val =3D sun4i_pwm_readl(pwm, PWM_CTRL_REG);
>  	for (i =3D 0; i < pwm->chip.npwm; i++)
>  		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
> -			pwm->chip.pwms[i].polarity =3D PWM_POLARITY_INVERSED;
> +			pwm_set_default_polarity(&pwm->chip.pwms[i],
> +						 PWM_POLARITY_INVERSED);
>  	clk_disable_unprepare(pwm->clk);
> =20
>  	return 0;
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pw=
m-regulator.c
> index fc3166d..cc549b7 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -56,7 +56,7 @@ static int pwm_regulator_set_voltage_sel(struct reg=
ulator_dev *rdev,
>  	int dutycycle;
>  	int ret;
> =20
> -	pwm_reg_period =3D pwm_get_period(drvdata->pwm);
> +	pwm_reg_period =3D pwm_get_default_period(drvdata->pwm);
> =20
>  	dutycycle =3D (pwm_reg_period *
>  		    drvdata->duty_cycle_table[selector].dutycycle) / 100;
> @@ -114,7 +114,7 @@ static int pwm_regulator_set_voltage(struct regul=
ator_dev *rdev,
>  {
>  	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(rdev);
>  	unsigned int ramp_delay =3D rdev->constraints->ramp_delay;
> -	unsigned int period =3D pwm_get_period(drvdata->pwm);
> +	unsigned int period =3D pwm_get_default_period(drvdata->pwm);
>  	int duty_cycle;
>  	int ret;
> =20
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/bac=
klight/lm3630a_bl.c
> index 35fe482..449ebc3 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -162,7 +162,7 @@ static int lm3630a_intr_config(struct lm3630a_chi=
p *pchip)
> =20
>  static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int=
 br_max)
>  {
> -	unsigned int period =3D pwm_get_period(pchip->pwmd);
> +	unsigned int period =3D pwm_get_default_period(pchip->pwmd);
>  	unsigned int duty =3D br * period / br_max;
> =20
>  	pwm_config(pchip->pwmd, duty, period);
> @@ -425,7 +425,7 @@ static int lm3630a_probe(struct i2c_client *clien=
t,
>  			return PTR_ERR(pchip->pwmd);
>  		}
>  	}
> -	pchip->pwmd->period =3D pdata->pwm_period;
> +	pwm_set_default_period(pchip->pwmd, pdata->pwm_period);
> =20
>  	/* interrupt enable  : irq 0 is not allowed */
>  	pchip->irq =3D client->irq;
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index eff379b..ae498c1 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -294,7 +294,7 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	 * set the period from platform data if it has not already been set
>  	 * via the PWM lookup table.
>  	 */
> -	pb->period =3D pwm_get_period(pb->pwm);
> +	pb->period =3D pwm_get_default_period(pb->pwm);
>  	if (!pb->period && (data->pwm_period_ns > 0)) {
>  		pb->period =3D data->pwm_period_ns;
>  		pwm_set_period(pb->pwm, data->pwm_period_ns);
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ss=
d1307fb.c
> index 93f4c90..ab3daf0 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -294,7 +294,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *p=
ar)
>  			return PTR_ERR(par->pwm);
>  		}
> =20
> -		par->pwm_period =3D pwm_get_period(par->pwm);
> +		par->pwm_period =3D pwm_get_default_period(par->pwm);
>  		/* Enable the PWM */
>  		pwm_config(par->pwm, par->pwm_period / 2, par->pwm_period);
>  		pwm_enable(par->pwm);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d681f68..31239a9 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -115,11 +115,22 @@ static inline void pwm_set_period(struct pwm_de=
vice *pwm, unsigned int period)
>  		pwm->period =3D period;
>  }
> =20
> +static inline void pwm_set_default_period(struct pwm_device *pwm,
> +					  unsigned int period)
> +{
> +	pwm_set_period(pwm, period);
> +}
> +
>  static inline unsigned int pwm_get_period(const struct pwm_device *p=
wm)
>  {
>  	return pwm ? pwm->period : 0;
>  }
> =20
> +static inline unsigned int pwm_get_default_period(const struct pwm_d=
evice *pwm)
> +{
> +	return pwm_get_period(pwm);
> +}
> +
>  static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsign=
ed int duty)
>  {
>  	if (pwm)
> @@ -136,6 +147,12 @@ static inline unsigned int pwm_get_duty_cycle(co=
nst struct pwm_device *pwm)
>   */
>  int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polar=
ity);
> =20
> +static inline void pwm_set_default_polarity(struct pwm_device *pwm,
> +					    enum pwm_polarity polarity)
> +{
> +	pwm_set_polarity(pwm, polarity);
> +}
> +
>  static inline enum pwm_polarity pwm_get_polarity(const struct pwm_de=
vice *pwm)
>  {
>  	return pwm ? pwm->polarity : PWM_POLARITY_NORMAL;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
