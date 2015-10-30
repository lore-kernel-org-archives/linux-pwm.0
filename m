From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm-backlight: Avoid backlight flicker when probed from
 DT
Date: Fri, 30 Oct 2015 18:21:13 +0000
Message-ID: <20151030182113.GH4058@x1>
References: <1446133906-3076-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446133906-3076-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, 29 Oct 2015, Philipp Zabel wrote:

> If the driver is probed from the device tree, and there is a phandle
> property set on it, and the enable GPIO is already configured as outp=
ut,
> and the backlight is currently disabled, keep it disabled.
> If all these conditions are met, assume there will be some other driv=
er
> that can enable the backlight at the appropriate time.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
> Changes since v2:
>  - Leave GPIO configuration as is (GPIOD_ASIS) when requesting,
>    so we can actually check the initial state.
> ---
>  drivers/video/backlight/pwm_bl.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index ae3c6b6..8e9c261 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -199,6 +199,8 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct pwm_bl_data *pb;
> +	int initial_blank =3D FB_BLANK_UNBLANK;
> +	bool phandle;
>  	int ret;
> =20
>  	if (!data) {
> @@ -242,7 +244,7 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	pb->enabled =3D false;
> =20
>  	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);
> +						  GPIOD_ASIS);
>  	if (IS_ERR(pb->enable_gpio)) {
>  		ret =3D PTR_ERR(pb->enable_gpio);
>  		goto err_alloc;
> @@ -264,12 +266,32 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
>  	}
> =20
> +	phandle =3D of_find_property(pdev->dev.of_node, "phandle", NULL) !=3D=
 NULL;

This is a little ugly.

If this is the only way to identify the probedness of a device then
you probably want to neaten it up a little.  I suggest something along
the lines of:

if (of_find_property(pdev->dev.of_node, "phandle", NULL))
	already_probed =3D true;

Also, do you also want to check for "linux,phandle", as this is always
catered for in drivers/of/*

> +	if (pb->enable_gpio) {
> +		/*
> +		 * If the driver is probed from the device tree and there is a
> +		 * phandle link pointing to the backlight node, it is safe to
> +		 * assume that another driver will enable the backlight at the
> +		 * appropriate time. Therefore, if it is disabled, keep it so.
> +		 */
> +		if (phandle &&
> +		    gpiod_get_direction(pb->enable_gpio) =3D=3D GPIOF_DIR_OUT &&
> +		    gpiod_get_value(pb->enable_gpio) =3D=3D 0)
> +			initial_blank =3D FB_BLANK_POWERDOWN;
> +		else
> +			gpiod_direction_output(pb->enable_gpio, 1);
> +	}
> +
>  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
>  	if (IS_ERR(pb->power_supply)) {
>  		ret =3D PTR_ERR(pb->power_supply);
>  		goto err_alloc;
>  	}
> =20
> +	if (phandle && !regulator_is_enabled(pb->power_supply))
> +		initial_blank =3D FB_BLANK_POWERDOWN;
> +
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER
>  	    && !pdev->dev.of_node) {
> @@ -320,6 +342,7 @@ static int pwm_backlight_probe(struct platform_de=
vice *pdev)
>  	}
> =20
>  	bl->props.brightness =3D data->dft_brightness;
> +	bl->props.power =3D initial_blank;
>  	backlight_update_status(bl);
> =20
>  	platform_set_drvdata(pdev, bl);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
