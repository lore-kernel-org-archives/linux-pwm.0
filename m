From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Date: Tue, 10 Mar 2020 12:34:26 +0530
Message-ID: <666dbb7a-db98-d16a-ee73-27d353d2a317@ti.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
 <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
 <20200309180123.GP37466@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59288 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJHFe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 03:05:34 -0400
In-Reply-To: <20200309180123.GP37466@atomide.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Sebastian Reichel <sre@kernel.org>

Hi Tony,

[...snip...]

>>>>  
>>>> +	/*
>>>> +	 * Disable auto reload so that the current cycle gets completed and
>>>> +	 * then the counter stops.
>>>> +	 */
>>>>  	mutex_lock(&omap->mutex);
>>>> -	omap->pdata->stop(omap->dm_timer);
>>>> +	omap->pdata->set_pwm(omap->dm_timer,
>>>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>>>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
>>>> +			     false);
>>>> +
>>>>  	mutex_unlock(&omap->mutex);
>>>>  }
>>>
>>> I'm seeing an issue with this patch where after use something is
>>> left on and power consumption stays higher by about 30 mW after
>>> use.
>>
>> Interesting...What is the PWM period and duty cycle in the test case?
>> Can you dump the following registers before and after disabling:
>> - TLDR
>> - TMAR
>> - TCLR
> 
> Here's the state dumped before and after in omap_dm_timer_set_pwm():
> 
> omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
> omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
> omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
> omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
> omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
> omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
> omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
> omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
> 

Looking at the registers:
period = 327 *(1000/clk_freq in MHz) ns
duty_cycle =  perioid.

I did simulate this behavior on BeagleBoneBlack on timer7. PWM is going down
after disabling.

> So looks like the start bit is still enabled after use?

Right, that is expected. The start bit gets disabled automatically once the pwm
period completes. This is because auto reload bit is off. That's the main idea
of this patch so that PWM period is completed after disabling, else PWM is
stopped abruptly.

Not sure why it is not happening in your case. If you think it is not needed, I
can drop this patch and add a limitation saying that PWM gets disabled
immediately without completing the current cycle.

Thanks and regards,
Lokesh
