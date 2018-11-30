From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix brightness levels for non-DT case.
Date: Fri, 30 Nov 2018 23:22:05 +0100
Message-ID: <CAFqH_53NiYULqcc+2fCgbHETJoTc7tWD8BNxOFhPm6kFZ=e6_g@mail.gmail.com>
References: <20181107085507.26126-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107085507.26126-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, robert.jarzmik@free.fr, Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, kernel@collabora.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, stable@vger.kernel.org, u.kleine-koenig@pengutronix.de, Linux PWM List <linux-pwm@vger.kernel.org>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi,
Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
dia dc., 7 de nov. 2018 a les 9:56:
>
> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
>
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, it sets the max_brightness in their platform data and the
> driver calculates the level without a table. The offending patch assumed
> that when there is no brightness levels table we should create one, but this
> is clearly wrong for the non-DT case.
>
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not.
>
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Cc: <stable@vger.kernel.org>
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Changes in v3:
> - Fixed some typos in commit message.
> - Removed ' in Fixes tag.
>
> Changes in v2:
> - Rebase on top of mainline
> - Add Tested-by and Acked-by tags.
>
>  drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 678b27063198..f9ef0673a083 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -562,7 +562,30 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                 goto err_alloc;
>         }
>
> -       if (!data->levels) {
> +       if (data->levels) {
> +               /*
> +                * For the DT case, only when brightness levels is defined
> +                * data->levels is filled. For the non-DT case, data->levels
> +                * can come from platform data, however is not usual.
> +                */
> +               for (i = 0; i <= data->max_brightness; i++) {
> +                       if (data->levels[i] > pb->scale)
> +                               pb->scale = data->levels[i];
> +
> +                       pb->levels = data->levels;
> +               }
> +       } else if (!data->max_brightness) {
> +               /*
> +                * If no brightness levels are provided and max_brightness is
> +                * not set, use the default brightness table. For the DT case,
> +                * max_brightness is set to 0 when brightness levels is not
> +                * specified. For the non-DT case, max_brightness is usually
> +                * set to some value.
> +                */
> +
> +               /* Get the PWM period (in nanoseconds) */
> +               pwm_get_state(pb->pwm, &state);
> +
>                 ret = pwm_backlight_brightness_default(&pdev->dev, data,
>                                                        state.period);
>                 if (ret < 0) {
> @@ -570,13 +593,19 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                                 "failed to setup default brightness table\n");
>                         goto err_alloc;
>                 }
> -       }
>
> -       for (i = 0; i <= data->max_brightness; i++) {
> -               if (data->levels[i] > pb->scale)
> -                       pb->scale = data->levels[i];
> +               for (i = 0; i <= data->max_brightness; i++) {
> +                       if (data->levels[i] > pb->scale)
> +                               pb->scale = data->levels[i];
>
> -               pb->levels = data->levels;
> +                       pb->levels = data->levels;
> +               }
> +       } else {
> +               /*
> +                * That only happens for the non-DT case, where platform data
> +                * sets the max_brightness value.
> +                */
> +               pb->scale = data->max_brightness;
>         }
>
>         pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> --
> 2.19.1
>

A gentle ping on this patch.

Best regards,
 Enric
