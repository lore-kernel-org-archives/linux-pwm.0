From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Implement .apply callback
Date: Tue, 25 Feb 2020 10:31:45 +0530
Message-ID: <cee31e10-17b4-1cfb-5c77-a58a142c338d@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-5-lokeshvutla@ti.com>
 <20200224090706.xsujpc3yiqlmmrmm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58312 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFCo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 00:02:44 -0500
In-Reply-To: <20200224090706.xsujpc3yiqlmmrmm@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

Hi Uwe,

On 24/02/20 2:37 PM, Uwe Kleine-König wrote:
> On Mon, Feb 24, 2020 at 10:51:35AM +0530, Lokesh Vutla wrote:
>> Implement .apply callback and drop the legacy callbacks(enable, disable,
>> config, set_polarity).
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 141 +++++++++++++++++++--------------
>>  1 file changed, 80 insertions(+), 61 deletions(-)
>>

[..snip..]

>> -static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
>> -					 struct pwm_device *pwm,
>> -					 enum pwm_polarity polarity)
>> +/**
>> + * pwm_omap_dmtimer_apply() - Changes the state of the pwm omap dm timer.
>> + * @chip:	Pointer to PWM controller
>> + * @pwm:	Pointer to PWM channel
>> + * @state:	New sate to apply
>> + *
>> + * Return 0 if successfully changed the state else appropriate error.
>> + */
>> +static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
>> +				  struct pwm_device *pwm,
>> +				  const struct pwm_state *state)
>>  {
>>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
>> +	int ret = 0;
>>  
>> -	/*
>> -	 * PWM core will not call set_polarity while PWM is enabled so it's
>> -	 * safe to reconfigure the timer here without stopping it first.
>> -	 */
>>  	mutex_lock(&omap->mutex);
>> -	omap->pdata->set_pwm(omap->dm_timer,
>> -			     polarity == PWM_POLARITY_INVERSED,
>> -			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
>> +
>> +	if (pwm_is_enabled(pwm) && !state->enabled) {
> 
> In my book calling PWM API functions (designed for PWM consumers) is not
> so nice. I would prefer you checking the hardware registers or cache the
> state locally instead of relying on the core here.

.start and .stop apis does read the hardware registers and check the state
before making any changes. Do you want to drop off the pwm_is_enabled(pwm) check
here?

> 
> It would be great to have a general description at the top of the driver
> (like for example drivers/pwm/pwm-sifive.c) that answers things like:
> 
>  - Does calling .stop completes the currently running period (it
>    should)?

Existing driver implementation abruptly stops the cycle. I can make changes such
that it completes the currently running period.

>  - Does changing polarity, duty_cycle and period complete the running
>    period?

- Polarity can be changed only when the pwm is not running. Ill add extra guards
to reflect this behavior.
- Changing duty_cycle and period does complete the running period and new values
gets reflected in next cycle.

>  - How does the hardware behave on disable? (i.e. does it output the
>    state the pin is at in that moment? Does it go High-Z?)

Now that I am making changes to complete the current period on disable, the pin
goes to Low after disabling(completing the cycle).

Ill add all these points as you mentioned in v2.

Thanks and regards,
Lokesh
