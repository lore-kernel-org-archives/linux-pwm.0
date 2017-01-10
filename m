From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Tue, 10 Jan 2017 08:59:09 +0100
Message-ID: <20170110085909.69b80820@bbrezillon>
References: <1483573014-13185-1-git-send-email-lukma@denx.de>
        <1483573014-13185-8-git-send-email-lukma@denx.de>
        <20170105095035.2f1fe6db@bbrezillon>
        <20170105100347.1358df34@jawa>
        <20170105101935.2365d647@bbrezillon>
        <20170105103505.7b9e32ba@jawa>
        <20170105105329.5e75291d@bbrezillon>
        <66893ecf40113ccd55569ca99be093f0@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52511 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbdAJH7L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Jan 2017 02:59:11 -0500
In-Reply-To: <66893ecf40113ccd55569ca99be093f0@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Lukasz Majewski <lukma@denx.de>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>

On Mon, 09 Jan 2017 19:14:43 -0800
Stefan Agner <stefan@agner.ch> wrote:

> >>  
> >> >
> >> > But, while reviewing your patch I realized this was actually unneeded
> >> > (see the explanation in my previous review).
> >> >  
> >> > >
> >> > > Now it depends on cstate.enabled flag.
> >> > >
> >> > > So we end up with
> >> > >
> >> > > if (state.enabled && !cstate.enabled)
> >> > > 	clk_preapre_enable();  
> >> >
> >> > Yep, and that's correct.  
> >>
> >> And following patch:
> >> http://patchwork.ozlabs.org/patch/709510/
> >>
> >> address this issue.  
> > 
> > Yes, that was needed because the enable/disable path were not
> > separated, and we were unconditionally writing to the IP registers
> > even when the PWM was already disabled (which is probably the case
> > generating the fault reported by Stefan). This is not the case anymore,
> > but let's wait for Stefan to confirm this.  
> 
> With v4 as is, the kernel crashes/hangs on i.MX 7.
> 
> The function imx_pwm_apply_v2 gets first called with state->enabled 0,
> cstate->enabled 0. This branches to else and leads to a register access
> with clocks disabled (and if that would succeed, also an unbalanced
> disable?...)
> 
> With the proposed change plus the additional change in the else branch
> it works for me:
> 
> @@ -192,19 +193,20 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip,
> struct pwm_device *pwm,
>                 else
>                         period_cycles = 0;
>  
> -               ret = clk_prepare_enable(imx->clk_per);
> -               if (ret)
> -                       return ret;
> -
>                 /*
>                  * Wait for a free FIFO slot if the PWM is already
> enabled, and
>                  * flush the FIFO if the PWM was disabled and is about
> to be
>                  * enabled.
>                  */
> -               if (cstate.enabled)
> +               if (cstate.enabled) {
>                         imx_pwm_wait_fifo_slot(chip, pwm);
> -               else if (state->enabled)
> +               } else if (state->enabled) {
> +                       ret = clk_prepare_enable(imx->clk_per);
> +                       if (ret)
> +                               return ret;
> +
>                         imx_pwm_sw_reset(chip);
> +               }
>  
>                 writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>                 writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> @@ -218,7 +220,7 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip,
> struct pwm_device *pwm,
>                         cr |= MX3_PWMCR_POUTC;
>  
>                 writel(cr, imx->mmio_base + MX3_PWMCR);
> -       } else {
> +       } else if (cstate.enabled) {
>                 writel(0, imx->mmio_base + MX3_PWMCR);
>  
>                 clk_disable_unprepare(imx->clk_per);
> 
> 
> This would not disable a disabled PWM anymore, I guess at normal use not
> a problem. Only at bootup it could end up left on, but I guess if we
> care about boot time transition we should implement get_state, but
> something which we can do in a follow up patch.

Yep, that's a different problem which could be addressed by
implementing ->get_state(). Note that you don't necessary want to
disable the PWM at boot time, in some situation, when the PWM is
driving a critical device (like the VDDIODDR regulator), you want the
transition between the bootloader/firmware and Linux to be as smooth as
possible. Actually, 'initial state retrieval' and 'atomic changes'
were added to handle this case.

Stefan, one last thing, can you apply patch 2 alone and check if it
doesn't introduce a regression?

Thanks,

Boris
