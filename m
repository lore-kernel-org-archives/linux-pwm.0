From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCHv2] pwm: avoid holding mutex in interrupt context
Date: Wed, 20 Jan 2016 08:13:50 +0530
Message-ID: <CANAwSgTBDhv2Kn33CBRJrDNFdYL_OQV1bqOmWWpJCx9Jzk1VUA@mail.gmail.com>
References: <1453064517-12315-1-git-send-email-linux.amoon@gmail.com>
 <569C2AE8.6070100@samsung.com> <CANAwSgT3rXRBVFUQmogkPQwRY93CO0FRFwx_NGjWTHrD5LGbVg@mail.gmail.com>
 <569C69F4.7000906@samsung.com> <CANAwSgSMRL2Us6kCHih5c-s6bFdQfEg=xAcdC2v67PjZAHNOTg@mail.gmail.com>
 <569EC6F6.1020505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33453 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbcATCoL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2016 21:44:11 -0500
In-Reply-To: <569EC6F6.1020505@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Hi Krzysztof,

On 20 January 2016 at 04:59, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 20.01.2016 00:04, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> On 18 January 2016 at 09:58, Krzysztof Kozlowski
>>>> Already within function pwm_samsung_set_invert is protected by
>>>> spin_lock_irqsave(&samsung_pwm_lock, flags);
>>>>
>>>> So no need to introduce another lock to control pwm_samsung_set_polarity.
>>>>
>>>> Best Regards.
>>>> -Anand Moon
>>>
>>> I don't have any clue what is your point here. I don't get what
>>> pwm_samsung_set_polarity has to do with main pwm core...
>>>
>>> Sorry, you need to be more specific.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>
>> Below is the mapping of calls from pwm driver.
>> I have tried to map the functionality and I am trying to understand
>> the flow of the driver.
>>
>> Also looking in document
>>
>> https://www.kernel.org/doc/Documentation/pwm.txt
>>
>> pwm-samsung driver controls the LEDS, fans...etc
>>
>> Form the dts modes pwmleds
>>
>>         pwmleds {
>>                 compatible = "pwm-leds";
>>
>>                 blueled {
>>                         label = "blue:heartbeat";
>>                         pwms = <&pwm 2 2000000 0>;
>>                         pwm-names = "pwm2";
>>                         max_brightness = <255>;
>>                         linux,default-trigger = "heartbeat";
>>                 };
>>         };
>>
>> Following is the map out from the device tree.
>>
>> pwms = <&pwm 2 2000000 0>;
>>
>> &pwm       ->  pwm: pwm@12dd0000 --->samsung,exynos4210-pwm
>> 2              ->  period
>> 2000000    ->  duty_cycle
>> 0              ->  polarity
>
> I do not see any relations between DTS and the problem.
>
>>
>> And here is the mapping of the call of function
>> Note: This function call are as per my understanding of the flow in
>> the driver. I might be wrong.
>>
>> pwm_samsung_set_polarity(struct pwm_chip *chip, struct pwm_device
>> *pwm, enum pwm_polarity polarity)
>> \
>>  pwm_samsung_set_invert(our_chip, pwm->hwpwm, invert);
>>  \
>>   pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
>
> No, pwm_samsung_set_invert does not call pwm_set_polarity(). This would
> result in a circular call - back to pwm_samsung_set_polarity().
>
>>   \
>>    pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
>>     \
>>      pwm_enable(struct pwm_device *pwm) or pwm_disable(struct pwm_device *pwm)
>>
>> pwm_enable or pwm_disable will be triggered on change in pwm->flags by
>> the pwm core.
>> before pwm_set_polarity is called form the Samsung driver it hold with
>> following locks
>>
>> Here is the locking
>>
>> pwm_samsung_set_polarity(struct pwm_chip *chip, struct pwm_device
>> *pwm, enum pwm_polarity polarity)
>>  \
>>   pwm_samsung_set_invert(struct samsung_pwm_chip *chip, unsigned int
>> channel, bool invert)
>>     \
>>      spin_lock_irqsave(&samsung_pwm_lock, flags);
>>       \
>>        pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
>>        \
>>         mutex_lock(&pwm->lock)
>>
>>           pwm_enable(struct pwm_device *pwm) or pwm_disable(struct
>> pwm_device *pwm)
>>           \
>>            mutex_lock(&pwm->lock);
>>
>> Problem I see that we are holding the lock in interrupt context.
>> I don't know how the this triggers this bug.
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>
> So leave it. If your flow of calls was correct, you would spot the
> problem. But actually it does not matter - I think the flow is not correct.
>
> Best regards,
> Krzysztof

Yep the flow might be wrong.
Ok thanks for your input.

Best Regards.
-Anand Moon
