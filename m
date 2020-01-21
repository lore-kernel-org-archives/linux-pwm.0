From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] ARM: s3c24xx/rx1950: switch to atomic pwm API
Date: Mon, 20 Jan 2020 18:01:04 -0800
Message-ID: <CA+E=qVeEscYryOjD4FB+EH=JqFg6bVA3PHbx7sWrR7=9Zn003g@mail.gmail.com>
References: <20200120193328.17007-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35971 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAUCAR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 21:00:17 -0500
In-Reply-To: <20200120193328.17007-1-uwe@kleine-koenig.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, arm-linux <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 20, 2020 at 11:33 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>
> Stop using the legacy PWM API which only still exists because there are
> some users left.
>
> Note this change make use of the fact that the value of struct
> pwm_state::duty_cycle doesn't matter for a disabled PWM and so its value
> can stay constant simplifying the code a bit.
>
> A side effect of the conversion is that the pwm isn't stopped in
> rx1950_backlight_init() by the call to pwm_apply_args() just before
> reenabling it when rx1950_lcd_power(1) is called.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/=
mach-rx1950.c
> index 29f9b345a531..03d8f27cdc32 100644
> --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> @@ -377,6 +377,7 @@ static struct pwm_lookup rx1950_pwm_lookup[] =3D {
>  };
>
>  static struct pwm_device *lcd_pwm;
> +static struct pwm_state lcd_pwm_state;
>
>  static void rx1950_lcd_power(int enable)
>  {
> @@ -429,15 +430,16 @@ static void rx1950_lcd_power(int enable)
>
>                 /* GPB1->OUTPUT, GPB1->0 */
>                 gpio_direction_output(S3C2410_GPB(1), 0);
> -               pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> -               pwm_disable(lcd_pwm);
> +
> +               lcd_pwm_state.enabled =3D false;
> +               pwm_apply_state(lcd_pwm, &lcd_pwm_state);
>
>                 /* GPC0->0, GPC10->0 */
>                 gpio_direction_output(S3C2410_GPC(0), 0);
>                 gpio_direction_output(S3C2410_GPC(10), 0);
>         } else {
> -               pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
> -               pwm_enable(lcd_pwm);
> +               lcd_pwm_state.enabled =3D true;
> +               pwm_apply_state(lcd_pwm, &lcd_pwm_state);
>
>                 gpio_direction_output(S3C2410_GPC(0), 1);
>                 gpio_direction_output(S3C2410_GPC(5), 1);
> @@ -493,10 +495,13 @@ static int rx1950_backlight_init(struct device *dev=
)
>         }
>
>         /*
> -        * FIXME: pwm_apply_args() should be removed when switching to
> -        * the atomic PWM API.
> +        * This is only required to initialize .polarity; all other value=
s are
> +        * fixed in this driver.
>          */
> -       pwm_apply_args(lcd_pwm);
> +       pwm_init_state(lcd_pwm, &lcd_pwm_state);
> +
> +       lcd_pwm_state.period =3D LCD_PWM_PERIOD;
> +       lcd_pwm_state.duty_cycle =3D LCD_PWM_DUTY;
>
>         rx1950_lcd_power(1);
>         rx1950_bl_power(1);
> --
> 2.24.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
