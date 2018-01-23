From: Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 10/16] pwm: Add PWM modes
Date: Tue, 23 Jan 2018 12:40:20 +0200
Message-ID: <759435bf-764f-68ea-de51-c878ceec28e2@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-11-git-send-email-claudiu.beznea@microchip.com>
 <20180119223452.doeqfd4aewkf5fla@rob-hp-laptop>
 <c5aeb8df-6aa8-cde4-9305-08777cac2f45@microchip.com>
 <CAL_JsqJho2OrdnHwRPpYsbNB4RFTq5qSLA=36D2zy=Mi7B8XwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqJho2OrdnHwRPpYsbNB4RFTq5qSLA=36D2zy=Mi7B8XwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel-IAPFreCvJWOunwaRDDq4rA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org



On 22.01.2018 20:12, Rob Herring wrote:
> On Mon, Jan 22, 2018 at 2:54 AM, Claudiu Beznea
> <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:
>>
>>
>> On 20.01.2018 00:34, Rob Herring wrote:
>>> On Fri, Jan 12, 2018 at 04:22:57PM +0200, Claudiu Beznea wrote:
>>>> Define a macros for PWM modes to be used by device tree sources.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>>>> ---
>>>>  include/dt-bindings/pwm/pwm.h | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
>>>> index ab9a077e3c7d..b8617431f8ec 100644
>>>> --- a/include/dt-bindings/pwm/pwm.h
>>>> +++ b/include/dt-bindings/pwm/pwm.h
>>>> @@ -12,4 +12,7 @@
>>>>
>>>>  #define PWM_POLARITY_INVERTED                       (1 << 0)
>>>>
>>>> +#define PWM_DTMODE_NORMAL                   (1 << 0)
>>>
>>> Bit 0 is already taken. I think you mean (0 << 1)?
>> I wanted to have the PWM modes in a new cell, so that the pwms binding to be
>> something like:
>> pwms=<pwm-controller pwm-channel pwm-period pwm-flags pwm-mode>
>>
>> If you think it is mode feasible to also include PWM mode in the cell for
>> PWM flags, please let me know.
> 
> Yes, but you have to make "normal" be no bit set to be compatible with
> everything already out there.
I'm thinking having it separately is more clear and modular.

> 
>>> Personally, I'd just drop this define. A define for a 0 value makes more
>>> sense when each state is equally used (like active high or low), but if
>>> 0 is the more common case, then I don't the need for a define.
>> I want it to have these defines like bit defines:
>> PWM_DTMODE_NORMAL=0x1
>> PWM_DTMODE_COMPLEMENTARY=0x2
>> PWM_DTMODE_PUSH_PULL=0x4
> 
> Thinking about this some more, shouldn't the new modes just be
> implied? A client is going to require one of these modes or it won't
> work right.
The clients could or could not request the mode via DT. Every PWM chip registers
supported modes at driver probe (default, if no PWM mode support is added
to the PWM chip driver the PWM chip will supports only normal mode). If a
PWM channel is requested by a PWM client via DT, and there is no PWM mode setting
in DT bindings, e.g. requested with these bindings:
pwms=<pwm-controller pwm-channel pwm-period> or
pwms=<pwm-controller pwm-channel pwm-period pwm-flags>
the first available mode of PWM chip will be used to instantiate the mode.
If the defined modes are:
PWM_DTMODE_NORMAL=0x1
PWM_DTMODE_COMPLEMENTARY=0x2
PWM_DTMODE_PUSH_PULL=0x4
and the PWM chip driver registers itself, at probe, with (PWM_DTMODE_COMPLEMENTARY | PWM_DTMODE_PUSH_PULL)
then the first available mode will be PWM_DTMODE_COMPLEMENTARY (first LSB bit
of the variable that keeps the available modes).
  
> 
> Also complementary mode could be accomplished with a single pwm output
> and a board level inverter, right?
Yes, I think this could be accomplished. Here I took into account only PWM controller
capabilities. Having this, I think will involve having extra PWM bindings describing
extra capabilities per-channel. And to change a little bit the implementation in order
to have these capabilities per channel nor per PWM controller. What do you think? 

I think push-pull mode could also be accomplished having board inverter and delay
modules. So, in these cases make sense to have per channel capabilities, as per my
understanding. 

Thank you,
Claudiu Beznea

How would that be handled when the
> PWM driver doesn't support that mode?
> 
> Rob
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
