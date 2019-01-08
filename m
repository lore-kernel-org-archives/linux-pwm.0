Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39079 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfAHIWL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 03:22:11 -0500
MIME-Version: 1.0
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1546918094-13960-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jan 2019 09:21:57 +0100
Message-ID: <CAMuHMdVZXjFoY7J-1_WfL3xz1cO5XUEi8YnFK9W8gGfMdLDnhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 4/4] pwm: rcar: improve calculation of divider
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Tue, Jan 8, 2019 at 4:31 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The rcar_pwm_get_clock_division() has a loop to calculate the divider,
> but the value of div should be calculatable without a loop. So,
> this patch improves it.
>
> This algorithm is suggested by Uwe Kleine-König and Laurent Pinchart.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 6dbb70c..0498a93 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -8,6 +8,8 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -68,19 +70,15 @@ static void rcar_pwm_update(struct rcar_pwm_chip *rp, u32 mask, u32 data,
>  static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
>  {
>         unsigned long clk_rate = clk_get_rate(rp->clk);
> -       unsigned long long max; /* max cycle / nanoseconds */
> -       unsigned int div;
> +       u64 div, tmp;
>
>         if (clk_rate == 0)
>                 return -EINVAL;
>
> -       for (div = 0; div <= RCAR_PWM_MAX_DIVISION; div++) {
> -               max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
> -                       (1 << div);
> -               do_div(max, clk_rate);
> -               if (period_ns <= max)
> -                       break;
> -       }
> +       div = NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;

As we have:

    #define NSEC_PER_SEC    1000000000L
    #define RCAR_PWM_MAX_CYCLE      1023

NSEC_PER_SEC is 64-bit on arm64, and 32-bit on arm32.

Hence you should use

    div = (u64)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;

to avoid overflow on arm32.

> +       tmp = (u64)period_ns * clk_rate + div - 1;
> +       tmp = div64_u64(tmp, div);
> +       div = ilog2(tmp - 1) + 1;
>
>         return (div <= RCAR_PWM_MAX_DIVISION) ? div : -ERANGE;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
