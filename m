From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
Date: Wed, 17 Jun 2020 09:18:34 +0200
Message-ID: <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
References: <20200615141606.2814208-1-thierry.reding@gmail.com> <20200615141606.2814208-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200615141606.2814208-2-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Guru Das Srinagesh <gurus@codeaurora.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, Jun 15, 2020 at 4:17 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> The PWM core will soon change the duty cycle and period of PWMs to 64
> bits to allow for a broader range of values. Use a 64-bit format
> specifier to avoid a warning when that change is made.
>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>                 /* Enable the PWM */
>                 pwm_enable(par->pwm);
>
> -               dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> +               dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
>                         par->pwm->pwm, pwm_get_period(par->pwm));
>         }

This change must be done together with changing the return type of
pwm_get_period(), else you will get a compiler warning, and will print a
bogus value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
