From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] pwm: Add support for R-Car PWM Timer
Date: Thu, 14 May 2015 18:06:50 +0200
Message-ID: <CAMuHMdV872yQ7crviCjzn7eEV7FaZPLpA08KnUkaGAUUX-UdCg@mail.gmail.com>
References: <1431509238-7648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1431509238-7648-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1431509238-7648-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Wed, May 13, 2015 at 11:27 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> R-Car SoCs have a seven-channel pulse width modulation (PWM) timer.
> This driver adds support for the PWM Timer as a single PWM chip and
> seven PWM devices.

Thanks for your patch!

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b1541f4..7e98175 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -249,6 +249,17 @@ config PWM_PXA
>           To compile this driver as a module, choose M here: the module
>           will be called pwm-pxa.
>
> +config PWM_RCAR
> +       tristate "Renesas R-Car PWM support"
> +       depends on ARCH_SHMOBILE || COMPILE_TEST

Could be instead

depends on ARCH_RCAR_GEN1 ||  ARCH_RCAR_GEN2 || COMPILE_TEST

> +       depends on HAS_IOMEM
> +       help
> +         This driver exposes the PWM Timer controller found in Renesas
> +         chips through the PWM API.

"Renesas R-Car chips" (e.g. R-Mobile uses pwm-renesas-tpu).

> --- /dev/null
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -0,0 +1,276 @@
> +/*
> + * R-Car PWM Timer driver
> + *
> + * Copyright (C) 2015 Renesas Electronics Corporation
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define NUM_RCAR_PWM_CHANNELS  7

I'm wondering whether this should be a DT property, to prepare for
future expansion.
Alternatively, as these are really 7 individual channels, with 7 individual
register blocks spaced 0x1000 apart, you could have 7 individual device nodes,
each driving one pwm output. That would probably incur more overhead, as
there would be 7 individual pwm controllers. But it does allow for future
expansion, and allows to cope when the individual register blocks are moved
in the SoC address space (I can imagine that on old SoCs e.g. all SCIF
blocks were nicely lay out in the address space, while now they have arbitrary
base addresses).

What do other people think?

> +static int rcar_pwn_get_clock_division(struct rcar_pwm_chip *rp,
> +                                      int period_ns)
> +{
> +       int div;
> +       unsigned long clk_rate = clk_get_rate(rp->clk);
> +       unsigned long long max; /* max cycle / nanoseconds */
> +
> +       for (div = 0; div <= RCAR_PWM_MAX_DIVISION; div++) {
> +               max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
> +               do_div(max, clk_rate / (1 << div));

Dividing clk_rate by "1 << div" reduces accuracy a lot for large values of div.
"NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE * (1 << div)" just fits in 64-bit,
so you can use

        max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
              (1 << div);
        do_div(max, clk_rate);

> +static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int channel,
> +                                int div, int duty_ns, int period_ns)
> +{
> +       unsigned long long one_cycle, tmp;      /* 0.01 nanoseconds */
> +       unsigned long clk_rate = clk_get_rate(rp->clk);
> +       u32 cyc, ph;
> +
> +       one_cycle = (unsigned long long)NSEC_PER_SEC * 100;
> +       do_div(one_cycle, clk_rate / (1 << div));

Same here:

        one_cycle = (unsigned long long)NSEC_PER_SEC * 100 * (1 << div)
        do_div(one_cycle, clk_rate);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
