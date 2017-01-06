From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Fri, 6 Jan 2017 08:06:22 +0100
Message-ID: <20170106080622.0ded0b6b@bbrezillon>
References: <1483573014-13185-1-git-send-email-lukma@denx.de>
        <1483573014-13185-8-git-send-email-lukma@denx.de>
        <20170105095035.2f1fe6db@bbrezillon>
        <20170105100347.1358df34@jawa>
        <20170105101935.2365d647@bbrezillon>
        <CAHp75VdRvFyspu0tAN4xQ_KjyHMMxz0Sy5a4cbea=HTh2WmgRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47824 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756028AbdAFHGu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Jan 2017 02:06:50 -0500
In-Reply-To: <CAHp75VdRvFyspu0tAN4xQ_KjyHMMxz0Sy5a4cbea=HTh2WmgRQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lothar Wassmann <LW@karo-electronics.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>

On Thu, 5 Jan 2017 23:15:06 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 5, 2017 at 11:19 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Thu, 5 Jan 2017 10:03:47 +0100
> > Lukasz Majewski <lukma@denx.de> wrote:  
> >> >             /*
> >> >              * Wait for a free FIFO slot if the PWM is already
> >> > enabled, and
> >> >              * flush the FIFO if the PWM was disabled and is
> >> > about to be
> >> >              * enabled.
> >> >              */  
> 
> >> >             if (cstate.enabled) {  
> 
> if (pwm_is_enabled()) ?
> 
> I think it's better to do whatever API provides to be less error prone.

Both pwm_is_enabled() and pwm_get_state()+struct pwm_state are part of
the PWM API, and I don't see how 'if (pwm_is_enabled())' is less error
prone than 'if (cstate.enabled)'.

This being said, I don't care much. It's mainly a matter of taste IMO,
so if others agree to switch to pwm_is_enabled() I'm fine with that.

> 
> >> >                     imx_pwm_wait_fifo_slot(chip, pwm);
> >> >             } else {
> >> >                     ret = clk_prepare_enable(imx->clk_per);
> >> >                     if (ret)
> >> >                             return ret;  
> 
> >> if (state.enabled && !cstate.enabled)
> >>       clk_preapre_enable();  
> >
> > Yep, and that's correct.  
> 
> !pwm_is_enabled() ?
> 
