From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 1/2] PWM: atmel-pwm: add PWM controller driver
Date: Tue, 10 Dec 2013 10:20:33 +0800
Message-ID: <52A67A71.6020404@atmel.com>
References: <1384766002-2852-1-git-send-email-voice.shen@atmel.com> <20131202105957.GD18060@ulmo.nvidia.com> <529D4B58.9020700@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529D4B58.9020700-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 12/03/2013 11:09 AM, Bo Shen wrote:
>>> +        atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
>>> +        atmel_pwm->chip.of_pwm_n_cells = 3;
>>> +        atmel_pwm->chip.base = -1;
>>> +    } else {
>>> +        atmel_pwm->chip.base = pdev->id;
>>
>> That's not correct. The chip cannot be tied to pdev->id, because that ID
>> is the instance number of the device. So typically you would have
>> devices name like this:
>>
>>     atmel-pwm.0
>>     atmel-pwm.1
>>     ...
>>
>> Now, if you have that, then you won't be able to register the second
>> instance because the first instance will already have requested PWMs
>> 0-3, and setting .base to 1 will cause PWMs 1-4 to be requested, which
>> intersects with the range of the first instance.
>>
>> The same applies of course if you have other PWM controllers in the
>> system which have similar instance names.
>>
>> So the right thing to do here is to provide that number via platform
>> data so that platform code can define it, knowing in advance all ranges
>> for all other PWM controllers and thereby make sure there's no
>> intersection.
>
> OK, I will fix this.

After read deeply of PWM framework, for non device tree, I think we'd 
better let the PWM core to choose chip.base as device tree, while not 
pass a number through platform data to it. Or else, it will confuse the 
user to set the chip.base, must set it in correct value to avoid 
intersection. And, actually we won't use chip.base in driver itself.

Hi J,
   what's your opinion?

Best Regards,
Bo Shen

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
