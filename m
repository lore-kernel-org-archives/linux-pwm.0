From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/2] pwm: Add support for R-Car PWM Timer
Date: Thu, 21 May 2015 10:29:53 +0200
Message-ID: <CAMuHMdXeNaHWbJ1hsVymUAa3gWW3-UkTwqQCpUBSG28UCy9vbw@mail.gmail.com>
References: <1432176653-4452-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1432176653-4452-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35429 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbEUI3y (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 21 May 2015 04:29:54 -0400
In-Reply-To: <1432176653-4452-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Shimoda-san,

On Thu, May 21, 2015 at 4:50 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds support for R-Car SoCs PWM Timer.

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pwm/pwm-rcar.c

> +#define RCAR_PWM_CH_OFFSET     0x1000

This is no longer used, now each pwm instance has its own device node.

> +static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div,
> +                                int duty_ns, int period_ns)
> +{
> +       unsigned long long one_cycle, tmp;      /* 0.01 nanoseconds */
> +       unsigned long clk_rate = clk_get_rate(rp->clk);
> +       u32 cyc, ph;
> +
> +       one_cycle = (unsigned long long)NSEC_PER_SEC * 100 * (1 << div);
> +       do_div(one_cycle, clk_rate);
> +
> +       tmp = period_ns * 100;

period_ns and the constant 100 are both int, hence the multiplication may
still overflow.
Please use e.g. "tmp = period_ns * 100ULL" instead.

> +       do_div(tmp, one_cycle);
> +       cyc = ((u32)tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;

I think the cast is not needed.

> +
> +       tmp = duty_ns * 100;

Same here: "tmp = duty_ns * 100ULL;".

> +       do_div(tmp, one_cycle);
> +       ph = (u32)tmp & RCAR_PWMCNT_PH0_MASK;

I think the cast is not needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
