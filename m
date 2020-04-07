From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused
 duty_cycle struct element
Date: Tue, 07 Apr 2020 15:00:43 +0200
Message-ID: <189a1fb7f7aee153151f46fe3bb0f754160472e7.camel@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
         <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
         <20200330151231.GA1650@workstation.tuxnet>
         <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
         <20200404173546.GA55833@workstation.tuxnet>
         <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
         <20200406095124.GA475759@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406095124.GA475759@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sven Van Asbroeck <thesven73@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 2020-04-06 at 11:51 +0200, Thierry Reding wrote:
> 
> On Sat, Apr 04, 2020 at 04:17:00PM -0400, Sven Van Asbroeck wrote:
> > 
> > It does look like we have a square peg (this chip) in a round hole
> > (the
> > standard assumptions the pwm core makes) ?
> 
> There are other chips where a single period is shared across multiple
> PWM channels. Typically what we do there is once a period is
> configured
> for a given channel, all subsequent PWM channel configurations must
> use
> the same period, or otherwise the driver will return an error code.
> 
> See for example:
> 
>   - stm32_pwm_config() in drivers/pwm/pwm-stm32.c
>   - lpc18xx_pwm_config() in drivers/pwm/pwm-lpc18xx-sct.c
>   - pwm_imx_tpm_apply_hw() in drivers/pwm/pwm-imx-tpm.c
>   - fsl_pwm_apply_config() in drivers/pwm/pwm-fsl-ftm.c
> 
> The rationale behind that is that we must not change a PWM
> configuration
> without a consumer having explicitly requested it.

These implementations don't deal with the issue in a consistent way
either though:

1) stm32_pwm_config() only checks for channels that are actually
enabled, regardless if they're requested

2) lpc18xx_pwm_config() checks requested channels instead

"2)" seems more correct to me, as the parameters of a requested channel
can't be changed by another user, but it seems to prevent certain
sequences. I don't have a good grasp of the the usual PWM request
control flow - is it correct that the PWM state is not updated with the
PWM args from OF when the PWM is requested? I only see
pwm_adjust_config() doing something like that, which is not used in
many places (and nothing preventing races) - but I might be overlooking
something.

Meaning, is it possible that two drivers request PWMs from the same
pwmchip of type "2)" (or even a single driver using two PWMs) without
configuring them right away may get into a situation where neither can
set up a period at all even when all users want to use the same period?

Matthias
