From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 1/2] PWM: atmel-pwm: add PWM controller driver
Date: Wed, 4 Dec 2013 10:59:46 +0800
Message-ID: <529E9AA2.8020400@atmel.com>
References: <1384766002-2852-1-git-send-email-voice.shen@atmel.com> <20131202105957.GD18060@ulmo.nvidia.com> <529D4B58.9020700@atmel.com> <20131203094326.GB21178@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131203094326.GB21178-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 12/03/2013 05:43 PM, Thierry Reding wrote:
> On Tue, Dec 03, 2013 at 11:09:12AM +0800, Bo Shen wrote:
>> On 12/02/2013 06:59 PM, Thierry Reding wrote:
>>> On Mon, Nov 18, 2013 at 05:13:21PM +0800, Bo Shen wrote:
> [...]
>>>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> [...]
>>>> +	/* Calculate the period cycles */
>>>> +	while (div > PWM_MAX_PRD) {
>>>> +		div = clk_rate / (1 << pres);
>>>> +		div = div * period_ns;
>>>> +		/* 1/Hz = 100000000 ns */
>>>
>>> I don't think that comment is needed.
>>
>> This is asked to be added.
>> And, I think keep it and it won't hurt, what do you think?
>
> I think it's obvious that you're converting from nanoseconds because of
> the _ns prefix in period_ns. But if somebody requested this and everyone
> else thinks it's useful, I'm okay with keeping it.
>
>>>> +	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
>>>> +	} else {
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTY, dty);
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRD, prd);
>>>> +	}
>>>> +}
>>>
>>> Neither version 1 nor version 2 seem to be able to change the period
>>> while the channel is enabled. Perhaps that should be checked for in
>>> atmel_pwm_config() and an error (-EBUSY) returned?
>>
>> The period is configured in dt in device tree, or platform data in non
>> device tree. Nowhere will update period. So, not code to update period.
>> Am I right? If not, please figure out.
>
> The .config() operation allows the period to be specified. Just because
> nobody currently changes it at runtime doesn't mean it can't be done.
>
> It is also possible that whoever wrote the device tree or platform data
> didn't know that the period must be the same for all PWM channels and
> therefore might use different values. If you check for this, at least
> they'll notice. If you don't check for it, then they may end up having
> the period reconfigured behind their backs, which may cause parts of
> their setup to behave unexpectedly.

Thanks for this information.
I will add code for changing period.

> Thierry
>

Best Regards,
Bo Shen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
