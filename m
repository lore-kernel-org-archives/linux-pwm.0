From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCHv2] pwm: avoid holding mutex in interrupt context
Date: Tue, 19 Jan 2016 20:34:14 +0530
Message-ID: <CANAwSgSMRL2Us6kCHih5c-s6bFdQfEg=xAcdC2v67PjZAHNOTg@mail.gmail.com>
References: <1453064517-12315-1-git-send-email-linux.amoon@gmail.com>
 <569C2AE8.6070100@samsung.com> <CANAwSgT3rXRBVFUQmogkPQwRY93CO0FRFwx_NGjWTHrD5LGbVg@mail.gmail.com>
 <569C69F4.7000906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37990 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbcASPEf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2016 10:04:35 -0500
In-Reply-To: <569C69F4.7000906@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Hi Krzysztof,

On 18 January 2016 at 09:58, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 18.01.2016 13:23, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> On 18 January 2016 at 05:29, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> On 18.01.2016 06:01, Anand Moon wrote:
>>>> The introduction of the mutex in commit d1cd21427747 ("pwm: Set enable
>>>> state properly on failed call to enable") effectively makes all PWM drivers
>>>> potentially sleeping. That in turn makes the .can_sleep field obsolete
>>>> since all drivers can now sleep.
>>>>
>>>> Changes fix the below bug by using spinlocks instead of mutex
>>>>
>>>> [   22.300239] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>>>> [   22.307212] in_atomic(): 1, irqs_disabled(): 0, pid: 2257, name: sh
>>>> [   22.313454] Preemption disabled at:[<  (null)>]   (null)
>>>> [   23.655232] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>>>> [   23.662174] in_atomic(): 1, irqs_disabled(): 0, pid: 2404, name: upowerd
>>>> [   23.668932] Preemption disabled at:[<  (null)>]   (null)
>>>> [   25.010207] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>>>> [   25.017125] in_atomic(): 1, irqs_disabled(): 0, pid: 2262, name: indicator-keybo
>>>> [   25.024491] Preemption disabled at:[<  (null)>]   (null)
>>>> [   26.355237] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>>>> [   26.362141] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0
>>>> [   26.368728] Preemption disabled at:[<  (null)>]   (null)
>>>> [   27.680220] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>>>> [   27.687119] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0
>>>> [   27.693698] Preemption disabled at:[<  (null)>]   (null)
>>>> [   29.005199] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97
>>>> [   29.012124] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/0
>>>>
>>>> [thierry.reding@gmail.com: Fixed the commit message]
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>> Changes logs: droped my prevoius approch.
>>>> ---
>>>>  drivers/pwm/core.c  | 10 +++++-----
>>>>  include/linux/pwm.h |  4 ++--
>>>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>>> index d24ca5f..58e7091 100644
>>>> --- a/drivers/pwm/core.c
>>>> +++ b/drivers/pwm/core.c
>>>> @@ -269,7 +269,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>>>>               pwm->pwm = chip->base + i;
>>>>               pwm->hwpwm = i;
>>>>               pwm->polarity = polarity;
>>>> -             mutex_init(&pwm->lock);
>>>> +             spin_lock_init(&pwm->lock);
>>>>
>>>>               radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>>>>       }
>>>> @@ -474,7 +474,7 @@ int pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
>>>>       if (!pwm->chip->ops->set_polarity)
>>>>               return -ENOSYS;
>>>>
>>>> -     mutex_lock(&pwm->lock);
>>>> +     spin_lock_irq(&pwm->lock);
>>>
>>> Anand,
>>>
>>> Thank you for the effort put into digging into this issue. Unfortunately
>>> this approach is bad. You cannot fix one issue without looking at the
>>> big picture of the given subsystem. This patch does exactly this - fixes
>>> your warning but probably introduces bugs all over the place.
>>>
>>> Although the set_polarity callback (called under the lock) is not
>>> described as sleeping-allowed but some implementations do it in a
>>> sleeping way. This is really easy to find, e.g.:
>>> pwm_omap_dmtimer_set_polarity.
>>>
>>> This means: no.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Already within function pwm_samsung_set_invert is protected by
>> spin_lock_irqsave(&samsung_pwm_lock, flags);
>>
>> So no need to introduce another lock to control pwm_samsung_set_polarity.
>>
>> Best Regards.
>> -Anand Moon
>
> I don't have any clue what is your point here. I don't get what
> pwm_samsung_set_polarity has to do with main pwm core...
>
> Sorry, you need to be more specific.
>
> Best regards,
> Krzysztof
>
>

Below is the mapping of calls from pwm driver.
I have tried to map the functionality and I am trying to understand
the flow of the driver.

Also looking in document

https://www.kernel.org/doc/Documentation/pwm.txt

pwm-samsung driver controls the LEDS, fans...etc

Form the dts modes pwmleds

        pwmleds {
                compatible = "pwm-leds";

                blueled {
                        label = "blue:heartbeat";
                        pwms = <&pwm 2 2000000 0>;
                        pwm-names = "pwm2";
                        max_brightness = <255>;
                        linux,default-trigger = "heartbeat";
                };
        };

Following is the map out from the device tree.

pwms = <&pwm 2 2000000 0>;

&pwm       ->  pwm: pwm@12dd0000 --->samsung,exynos4210-pwm
2              ->  period
2000000    ->  duty_cycle
0              ->  polarity

And here is the mapping of the call of function
Note: This function call are as per my understanding of the flow in
the driver. I might be wrong.

pwm_samsung_set_polarity(struct pwm_chip *chip, struct pwm_device
*pwm, enum pwm_polarity polarity)
\
 pwm_samsung_set_invert(our_chip, pwm->hwpwm, invert);
 \
  pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
  \
   pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
    \
     pwm_enable(struct pwm_device *pwm) or pwm_disable(struct pwm_device *pwm)

pwm_enable or pwm_disable will be triggered on change in pwm->flags by
the pwm core.
before pwm_set_polarity is called form the Samsung driver it hold with
following locks

Here is the locking

pwm_samsung_set_polarity(struct pwm_chip *chip, struct pwm_device
*pwm, enum pwm_polarity polarity)
 \
  pwm_samsung_set_invert(struct samsung_pwm_chip *chip, unsigned int
channel, bool invert)
    \
     spin_lock_irqsave(&samsung_pwm_lock, flags);
      \
       pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
       \
        mutex_lock(&pwm->lock)

          pwm_enable(struct pwm_device *pwm) or pwm_disable(struct
pwm_device *pwm)
          \
           mutex_lock(&pwm->lock);

Problem I see that we are holding the lock in interrupt context.
I don't know how the this triggers this bug.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:97

Please let me know if I am wrong.

-Anand Moon
