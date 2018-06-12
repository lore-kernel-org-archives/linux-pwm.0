From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE disabled
Date: Tue, 12 Jun 2018 09:25:05 +0200
Message-ID: <CAMuHMdXJg0mYbs=e0QJMDb=A+bRbPsNF=TJzSumSjjOK3yJw2Q@mail.gmail.com>
References: <20180525210843.1821071-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, fabrice.gasnier@st.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi Arnd,

On Fri, May 25, 2018 at 11:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
>
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but not used [-Werror=unused-function]
>
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
>
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>  static const struct pwm_ops stm32pwm_ops = {
>         .owner = THIS_MODULE,
>         .apply = stm32_pwm_apply_locked,
> -#if IS_ENABLED(CONFIG_DMA_ENGINE)
> -       .capture = stm32_pwm_capture,
> -#endif
> +       .capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,

Cool, I didn't know IS_ENABLED() can be used in static initializers.
I guess it's too late/much work to use this trick in e.g. SET_*_PM_OPS(),
as there are lots of places protecting the functions by #ifdefs?

>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
