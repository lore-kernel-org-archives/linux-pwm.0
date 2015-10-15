From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [RESEND PATCH v2] pwm-backlight: Avoid backlight flicker when
 probed from DT
Date: Thu, 15 Oct 2015 13:51:35 +0200
Message-ID: <CAH9NwWcthPzs4YHzQrFNhWcFst7k4_YRD1o_0GYWMrAc9DTEDA@mail.gmail.com>
References: <1444829119-4266-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444829119-4266-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

2015-10-14 15:25 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
> If the driver is probed from the device tree, and there is a phandle
> property set on it, and the enable GPIO is already configured as output,
> and the backlight is currently disabled, keep it disabled.
> If all these conditions are met, assume there will be some other driver
> that can enable the backlight at the appropriate time.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v1:
>  - Also check if the regulator is enabled. If the power supply is disabled,
>    and a phandle points to it, the backlight should stay powered down.
> ---
>  drivers/video/backlight/pwm_bl.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index eff379b..31afd6d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -199,6 +199,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>         struct backlight_properties props;
>         struct backlight_device *bl;
>         struct pwm_bl_data *pb;
> +       int initial_blank = FB_BLANK_UNBLANK;
> +       bool phandle;
>         int ret;
>
>         if (!data) {
> @@ -264,12 +266,32 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                 pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>         }
>
> +       phandle = of_find_property(pdev->dev.of_node, "phandle", NULL) != NULL;
> +
> +       if (pb->enable_gpio) {
> +               /*
> +                * If the driver is probed from the device tree and there is a
> +                * phandle link pointing to the backlight node, it is safe to
> +                * assume that another driver will enable the backlight at the
> +                * appropriate time. Therefore, if it is disabled, keep it so.
> +                */
> +               if (phandle &&
> +                   gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
> +                   gpiod_get_value(pb->enable_gpio) == 0)
> +                       initial_blank = FB_BLANK_POWERDOWN;
> +               else
> +                       gpiod_direction_output(pb->enable_gpio, 1);
> +       }
> +
>         pb->power_supply = devm_regulator_get(&pdev->dev, "power");
>         if (IS_ERR(pb->power_supply)) {
>                 ret = PTR_ERR(pb->power_supply);
>                 goto err_alloc;
>         }
>
> +       if (phandle && !regulator_is_enabled(pb->power_supply))
> +               initial_blank = FB_BLANK_POWERDOWN;
> +
>         pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>         if (IS_ERR(pb->pwm)) {
>                 ret = PTR_ERR(pb->pwm);
> @@ -321,6 +343,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>         }
>
>         bl->props.brightness = data->dft_brightness;
> +       bl->props.power = initial_blank;
>         backlight_update_status(bl);
>
>         platform_set_drvdata(pdev, bl);
> --
> 2.6.1
>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
