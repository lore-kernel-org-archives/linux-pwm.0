From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Date: Tue, 26 May 2020 13:44:40 +0100
Message-ID: <c83f7297-f3da-2b49-bc1a-42bffe7faabd@nvidia.com>
References: <1590492335-25857-1-git-send-email-spatra@nvidia.com>
 <81646862-8cbd-95f1-506d-ea375e365d69@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <81646862-8cbd-95f1-506d-ea375e365d69-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kyarlagadda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On 26/05/2020 13:05, Jon Hunter wrote:
> 
> On 26/05/2020 12:25, Sandipan Patra wrote:
>> Added support for dynamic clock freq configuration in pwm kernel driver.
>> Earlier the pwm driver used to cache boot time clock rate by pwm clock
>> parent during probe. Hence dynamically changing pwm frequency was not
>> possible for all the possible ranges. With this change, dynamic calculation
>> is enabled and it is able to set the requested period from sysfs knob
>> provided the value is supported by clock source.
>>
>> Changes mainly have 2 parts:
>>   - T186 and later chips [1]
>>   - T210 and prior chips [2]
>>
>> For [1] - Changes implemented to set pwm period dynamically and
>>           also checks added to allow only if requested period(ns) is
>>           below or equals to higher range.
>>
>> For [2] - Only checks if the requested period(ns) is below or equals
>>           to higher range defined by max clock limit. The limitation
>>           in T210 or prior chips are due to the reason of having only
>>           one pwm-controller supporting multiple channels. But later
>>           chips have multiple pwm controller instances each having
>> 	  single channel support.
>>
>> Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

...

>>  	/*
>> +	 *  Period in nano second has to be <= highest allowed period
>> +	 *  based on max clock rate of the pwm controller.
>> +	 *
>> +	 *  higher limit = max clock limit >> PWM_DUTY_WIDTH
>> +	 *  lower limit = min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH
> 
> Not sure why we mention the lower limit if we are not testing this
> condition. Does not appear to be relevant here. Or should we be checking
> this as well?

The above comment appears to be incorrect. Looking further at the code,
the code seems fine but the comment is confusing. I think you mean to
say that 'the period needs to be greater than the minimum period' and
that ...

 min period = max clock limit >> PWM_DUTY_WIDTH
 max period = min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH

> 
>> +	 */
>> +	if (period_ns < pc->min_period_ns)
>> +		return -EINVAL;
> 
> Something does not seem right here. If this is the highest allowed
> period, shouldn't this variable be called 'max_period_ns'?

Jon

-- 
nvpublic
