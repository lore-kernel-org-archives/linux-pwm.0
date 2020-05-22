From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Date: Fri, 22 May 2020 13:28:10 +0100
Message-ID: <ed46ffb7-87ef-8bfb-46f0-005042041658@nvidia.com>
References: <1587398043-18767-1-git-send-email-spatra@nvidia.com>
 <34ae18f5-494c-7bc7-0f30-2d1455bbcb55@nvidia.com>
 <BYAPR12MB3014B051AD088B42001A8132ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
 <21428954-41cc-c01a-bca2-7eb19f444272@nvidia.com>
 <BYAPR12MB30149CEB64B1BC3F9727AA68ADB40@BYAPR12MB3014.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BYAPR12MB30149CEB64B1BC3F9727AA68ADB40-ZGDeBxoHBPnJoSvCh4fbtgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


On 22/05/2020 13:12, Sandipan Patra wrote:

...

>>>>>  	/*
>>>>>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>>>>>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
>>>>>  	 */
>>>>> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
>>>>> +	if (pc->soc->num_channels == 1) {
>>>>
>>>> Are you using num_channels to determine if Tegra uses the BPMP? If so
>>>> then the above is not really correct, because num_channels is not
>>>> really related to what is being done here. So maybe you need a new SoC
>> attribute in the soc data.
>>>
>>> Here, it tries to find if pwm controller uses multiple channels (like
>>> in Tegra210 or older) or single channel for every pwm instance (i.e.
>>> T186, T194). If found multiple channels on a single controller then it
>>> is not correct to configure separate clock rates to each of the channels. So to
>> distinguish the controller and channel type, num_channels is referred.
>>
>> OK, then that makes sense. Maybe add this detail to the comment about why
>> num_channels is used.
> 
> Ok. Will update comment.
>  
>>
>>>>
>>>>> +		/*
>>>>> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it
>>>> matches
>>>>> +		 * with the hieghest applicable rate that the controller can
>>>>
>>>> s/hieghest/highest/
>>>
>>> Got it.
>>>
>>>>
>>>>> +		 * provide. Any further lower value can be derived by setting
>>>>> +		 * PFM bits[0:12].
>>>>> +		 * Higher mark is taken since BPMP has round-up mechanism
>>>>> +		 * implemented.
>>>>> +		 */
>>>>> +		required_clk_rate =
>>>>> +			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
>>>>> +
>>>>
>>>> Should be we checking the rate against the max rate supported?
>>>
>>> If the request rate is beyond max supported rate, then the
>>> clk_set_rate will be failing and can get caught with error check
>>> followed by. Otherwise it will fail through fitting in the register's frequency
>> divider filed. So I think it is not required to check against max rate.
>>> Please advise if I am not able to follow with what you are suggesting.
>>
>> I think that it would be better to update the cached value so that it is not
>> incorrectly used else where by any future change. Furthermore, this simplifies
>> matters a bit because you can do the following for all devices, but only update
>> the clk_rate for those you wish to ...
>>
>>     rate = pc->clk_rate >> PWM_DUTY_WIDTH;
>>
> What I understood from above is, we will always use max rate for any further configurations.
> If this is the suggestion above, then I think its not the right way.

I am not saying that.

> If we consider only max rate then the pwm output can only be ranging from:
> Possible max output rate: rate
> Possible min output rate: rate/2^13 (13 bits frequency divisor)
> 
> But if we consider the min rate supported by the source clock then,
> min output rate can go beyond the current min possible and 
> that should be considered for finding actual limit of min output rate.
> 
> Based on this, in the driver it tries to find a suitable clock rate to achieve
> requested output rate.
> Please suggest if you think we can still improve this further.

What I am suggesting is you ...

 if (pc->soc->num_channels == 1) {
         required_clk_rate = (NSEC_PER_SEC / period_ns) <<
                              PWM_DUTY_WIDTH;

         err = clk_set_rate(pc->clk, required_clk_rate);
         if (err < 0)
                return -EINVAL;

         pc->clk_rate = clk_get_rate(pc->clk);
 }

 rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;

That's all. I think this is simpler.

Jon
-- 
nvpublic
