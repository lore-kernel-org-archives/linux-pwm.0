From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 1/2] backlight: pwm_bl: Move the checks for initial
 power state to a separate function
Date: Tue, 21 Mar 2017 19:48:49 +0100
Message-ID: <CAMuHMdXcgWyKqhZFX49Ri1eEgi1_8b_xj6P9vKwEBwpsxMXTuA@mail.gmail.com>
References: <20161122134123.1209-1-peter.ujfalusi@ti.com> <20161122134123.1209-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122134123.1209-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Peter,

On Tue, Nov 22, 2016 at 2:41 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Move the checks to select the initial state for the backlight to a new
> function and document the checks we are doing.

This is far from a simple "move"...

> With the separate function it is going to be easier to fix or improve the
> initial power state configuration later and it is easier to read the code.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

This patch (commit 7613c922315e308a in v4.11-rc1) broke the display on
r8a7740/armadillo.

> @@ -267,20 +292,16 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                 pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>         }
>
> -       if (pb->enable_gpio) {
> -               /*
> -                * If the driver is probed from the device tree and there is a
> -                * phandle link pointing to the backlight node, it is safe to
> -                * assume that another driver will enable the backlight at the
> -                * appropriate time. Therefore, if it is disabled, keep it so.
> -                */
> -               if (node && node->phandle &&
> -                   gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
> -                   gpiod_get_value(pb->enable_gpio) == 0)
> -                       initial_blank = FB_BLANK_POWERDOWN;
> -               else
> -                       gpiod_direction_output(pb->enable_gpio, 1);

In my case, "node" points to the "/backlight" node, but phandle is NULL.
Hence before, gpiod_direction_output() was called to enable the GPIO...

> -       }
> +       /*
> +        * If the GPIO is configured as input, change the direction to output
> +        * and set the GPIO as active.
> +        * Do not force the GPIO to active when it was already output as it
> +        * could cause backlight flickering or we would enable the backlight too
> +        * early. Leave the decision of the initial backlight state for later.
> +        */
> +       if (pb->enable_gpio &&
> +           gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_IN)
> +               gpiod_direction_output(pb->enable_gpio, 1);

... while now it's no longer called, as gpiod_get_direction() returns
-EINVAL.

Indeed, r8a7740_pfc does not implement the .get_direction() callback,
so gpiod_get_direction() always returns -EINVAL, which is never equal
to GPIOF_DIR_IN.

Restoring the old behavior by changing the above test to

        if (pb->enable_gpio &&
            (!node || !node->phandle ||
             gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_IN))

fixes the display for me, but leads to a more complex expression.

However, changing the test to

        if (pb->enable_gpio &&
            gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)

also fixes the display, as an error is always different from GPIOF_DIR_OUT.

Anyone with comments or suggestions to fix this for real?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
