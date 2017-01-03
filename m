From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 RESEND 07/11] pwm: imx: Provide atomic PWM support for
 i.MX PWMv2
Date: Tue, 03 Jan 2017 09:29:40 -0800
Message-ID: <7401088f38dc214449fe541e43185fda@agner.ch>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-8-git-send-email-l.majewski@majess.pl>
 <20161229172117.523a42a4@bbrezillon> <20161229174535.01b87fb7@jawa>
 <20161229180838.66ca218f@bbrezillon> <20170103124314.4c979807@jawa>
 <20170103134645.6496a193@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:46799 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759921AbdACRp6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Jan 2017 12:45:58 -0500
In-Reply-To: <20170103134645.6496a193@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Lukasz Majewski <lukma@denx.de>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de

On 2017-01-03 04:46, Boris Brezillon wrote:
<snip>
>> > Well, regarding the imx_pwm_apply_v2() suggested by Stefan, I think we
>> > both agreed that most of the code was unneeded when all we want to do
>> > is disable the PWM.
>>
>> So for the PATCH 7/11 we fix the issue with recalculating clocks
>> when we want to disable PWM.
>>
>> if (state->enabled) {
>> 		c = clk_get_rate(imx->clk_per);
>> 		c *= state->period;
>>
>> 		do_div(c, 1000000000);
>> 		period_cycles = c;
>>
>> 		prescale = period_cycles / 0x10000 + 1;
>>
>> 		period_cycles /= prescale;
>> 		c = (unsigned long long)period_cycles *
>> 		    state->duty_cycle;
>> 		do_div(c, state->period);
>> 		duty_cycles = c;
>>
>> 		/*
>> 		 * According to imx pwm RM, the real period value
>> 		 * should be PERIOD value in PWMPR plus 2.
>> 		 */
>> 		if (period_cycles > 2)
>> 			period_cycles -= 2;
>> 		else
>> 			period_cycles = 0;
>>
>> 		/*
>> 		 * Enable the clock if the PWM is not already
>> 		 * enabled.
>> 		 */
>> 		if (!cstate.enabled) {
>> 			ret = clk_prepare_enable(imx->clk_per);
>> 			if (ret)
>> 			return ret;
>> 		}
>>
>> 		/*
>> 		 * Wait for a free FIFO slot if the PWM is already
>> 		 * enabled, and flush the FIFO if the PWM was disabled
>> 		 * and is about to be enabled.
>> 		 */
>> 		if (cstate.enabled)
>> 			imx_pwm_wait_fifo_slot(chip, pwm);
>> 		else
>> 			imx_pwm_sw_reset(chip);
>>
>> 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>> 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>>
>> 		writel(MX3_PWMCR_PRESCALER(prescale) |
>> 		       MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
>> 		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
>> 		       MX3_PWMCR_EN,
>> 		       imx->mmio_base + MX3_PWMCR);
>> 	} else {
>>
>> 		writel(0, imx->mmio_base + MX3_PWMCR);
>>
>> 		/* Disable the clock if the PWM is currently enabled. */
>> 		if (cstate.enabled)
>> 			clk_disable_unprepare(imx->clk_per);
>> 	}
>>
>>
> 
> Yep.
> 

This looks like a good transformation of the current Patch 7, but once
you merge my patch, it will look slightly different...

>>
>> >
>> > My concern was more about the way PWM changes are applied (->apply()
>> > returns before the change is actually applied), but I agreed that it
>> > could be fixed later on (if other people think it's really needed),
>> > since the existing code already handles it this way.
>>
>> This is the issue with FIFO setting - but for now we do not deal with
>> it.
> 
> Exactly.
> 
>>
>> >
>> > > No clear decision what to change until today when Stefan prepared
>> > > separate (concise) patch (now I see what is the problem).
>> > >
>> >
>> > The patch proposed by Stefan is addressing a different problem: the
>> > periph clock has to be enabled before accessing registers.
>>
>> So for this reason Stefan's patch [1] always enable the clock no matter
>> if PWM clock is generated or not.
> 
> Yes.
> 
>>
>> >
>> > >
>> > > >
>> > > > Same goes for the regression introduced in patch 2: I think it's
>> > > > better to keep things bisectable on all platforms (even if it
>> > > > appeared to work by chance on imx7, it did work before this
>> > > > change).
>> > >
>> > > Could you be more specific about your idea to solve this problem?
>> >
>> > Stefan already provided a patch, I just think it should be fixed
>> > before patch 2 to avoid breaking bisectibility.
>>
>> My idea is as follows:
>>
>> I will drop patch v2 (prepared by Sasha) and then squash Stefan's patch
>> [1] to patch 7/11. The "old" ipg enable code will be removed with other
>> not needed code during conversion.
> 
> How about keeping patch 2 but enabling/disabling the periph clk
> in imx_pwm_config() instead of completely dropping the enable/disable
> clk sequence.
> 
> In patch 7 you just add the logic we talked about earlier:
> unconditionally enable the periph clk when entering the
> imx_pwm_apply_v2() function and disable it before leaving the function.
> 
> This way you can preserve bisectibility and still get rid of the ipg
> clk.
> 
> Stefan, what's your opinion?

We will get rid of the ipg clocks anyway in patch 8 (which removes those
functions completely).

So I think Lukasz approach should be fine, just drop patch 2 and squash
my patch into patch 7.

--
Stefan
