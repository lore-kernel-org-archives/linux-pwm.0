From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ARM: at91: Document new TCB bindings
Date: Fri, 7 Apr 2017 14:15:36 +0200
Message-ID: <a8d541f0-e70a-a12d-5a7e-b1b72eddbe65@linaro.org>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160701012743.GA16698@rob-hp-laptop> <20160704151058.44b679bf@bbrezillon>
 <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
 <20170125161129.41acaa9a@bbrezillon>
 <fd4a2797-d8eb-ac80-36fc-01240fb0e944@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fd4a2797-d8eb-ac80-36fc-01240fb0e944-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On 13/03/2017 16:18, Nicolas Ferre wrote:
> Le 25/01/2017 à 16:11, Boris Brezillon a écrit :
>> Hi Rob,
>>
>> Sorry to revive this old discussion, but there's still one aspect I'm
>> not sure about.
>>
>> On Tue, 5 Jul 2016 10:40:22 -0500
>> Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>>>>>> +   - compatible: Should be "atmel,tcb-free-running-timer"
>>>>>> +   - reg: Should contain the TCB channels to be used. If the
>>>>>> +     counter width is 16 bits (at91rm9200-tcb), two consecutive
>>>>>> +     channels are needed. Else, only one channel will be used.
>>>>>> +
>>>>>> + * a clockevent device
>>>>>> +   - compatible: Should be "atmel,tcb-programmable-timer"  
>>>>>
>>>>> This still looks like assigning usage in DT. As I'm willing to accept
>>>>> that for PWM, either timer channels should be whatever channels are not
>>>>> assigned to PWM (i.e. not in DT) or they should just be "timer" and let
>>>>> the kernel decide their usage.  
>>>>
>>>> I just reviewed Alexandre's new binding, and it makes the whole thing
>>>> a lot more obscure: on older SoCs, we have to chain 2 channels to
>>>> create an acceptable wraparound time (16 bits at 5MHz is generating too
>>>> much interrupts to be acceptable).
>>>>
>>>> If we don't assign the mode from the DT, how should we know which
>>>> channels should be chained to create the free-running timer? Note that
>>>> not all channels can be chained together: they have to be part of the
>>>> same timer counter block and have to be consecutive (0+1, 1+2 or 3+0).  
>>>
>>> The driver can have this knowledge if it is just picking 2 consecutive
>>> timers. It should already know it has 16-bit timers based on the
>>> compatible string. If it gets more complicated then the features or
>>> limitations of the channels should be listed so the driver can make a
>>> choice. OMAP is a good example of lots of timers with differing
>>> features.
>>
>> Yes it's possible to do that, but what about DT overlays then? Say you
>> have some TCB channels you'd like to reserve because they are connected
>> to pins that are exposed on your board. Those pins are not connected to
>> any device yet, but extension boards can be added, and in this case you
>> might want to expose new PWM devices by dynamically loading DT overlays.
>>
>> If your clksource/clkevent driver parsed the initial DT and picked X
>> free channels randomly, it may conflicts with the one requested by the
>> DT overlay.
>>
>> What's your solution for this case?
> 
> It seems that we don't have any progress on this topic for more than 6
> months which is a pity as we now experience an issue that would have
> been addressed completely by the TC rework [1].
> 
> aka "ping"... ;-)


Hi Nicolas, Boris,

is there any news from your side ?

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
