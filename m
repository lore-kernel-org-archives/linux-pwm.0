From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/7] IIO: add bindings for stm32 IIO timer driver
Date: Sun, 27 Nov 2016 15:51:01 +0000
Message-ID: <7ed9fe79-55bf-4085-d416-d793a2692a62@kernel.org>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-6-git-send-email-benjamin.gaignard@st.com>
 <b2002a81-49fe-af2a-f13a-9f09831aa530@kernel.org>
 <CA+M3ks6LC5M3B01nRWh-bO79OOE11QcsypDXGpFAPzZ7Goc=Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+M3ks6LC5M3B01nRWh-bO79OOE11QcsypDXGpFAPzZ7Goc=Fw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On 27/11/16 15:45, Benjamin Gaignard wrote:
> 2016-11-27 15:25 GMT+01:00 Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>> On 24/11/16 15:14, Benjamin Gaignard wrote:
>>> Define bindings for stm32 IIO timer
>>>
>>> version 2:
>>> - only keep one compatible
>>> - add DT parameters to set lists of the triggers:
>>>   one list describe the triggers created by the device
>>>   another one give the triggers accepted by the device
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
>>> ---
>>>  .../bindings/iio/timer/stm32-iio-timer.txt         | 41 ++++++++++++++++++++++
>>>  1 file changed, 41 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>>> new file mode 100644
>>> index 0000000..840b417
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
>>> @@ -0,0 +1,41 @@
>>> +timer IIO trigger bindings for STM32
>>> +
>>> +Must be a sub-node of STM32 general purpose timer driver
>> Add a cross reference...
> 
> I will add it in v3
> 
>>> +
>>> +Required parameters:
>>> +- compatible:                must be "st,stm32-iio-timer"
>> st,stm32-adc-timer or something like that.
> 
> I would prefer use st,stm32-timer-trigger because triggers can be used
> for multiple other devices (dac, adc, timers)
> 
>>> +- interrupts:                Interrupt for this device
>>> +                     See ../interrupt-controller/st,stm32-exti.txt
>>> +
>>> +Optional parameters:
>>> +- st,input-triggers-names:   List of the possible input triggers for
>>> +                             the device
>>> +- st,output-triggers-names:  List of the possible output triggers for
>>> +                             the device
>> What are input / output triggers?
> 
> each hardware block can be the source of triggers (output triggers) or customer
> of some other trigger (input triggers).That what I have tried to
> describe in those two
> parameters
So this is really about using one timer as a prescaler for another?

I'd be tempted in the first instance to drop that functionality and just
describe the ones that drive the device sampling.

It's complex to describe and there is enough complexity in here already
to keep things busy for a while!
> 
>>> +
>>> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-iio-timer.h
>>> +
>>> +Example:
>>> +     gptimer1: gptimer1@40010000 {
>>> +             compatible = "st,stm32-gptimer";
>>> +             reg = <0x40010000 0x400>;
>>> +             clocks = <&rcc 0 160>;
>>> +             clock-names = "clk_int";
>>> +
>>> +             pwm1@0 {
>>> +                     compatible = "st,stm32-pwm";
>>> +                     st,pwm-num-chan = <4>;
>>> +                     st,breakinput;
>>> +                     st,complementary;
>>> +             };
>>> +
>>> +             iiotimer1@0 {
>>> +                     compatible = "st,stm32-iio-timer";
>>> +                     interrupts = <27>;
>>> +                     st,input-triggers-names = TIM5_TRGO,
>>> +                                               TIM2_TRGO,
>>> +                                               TIM4_TRGO,
>>> +                                               TIM3_TRGO;
>>> +                     st,output-triggers-names = TIM1_TRGO;
>>> +             };
>>> +     };
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
