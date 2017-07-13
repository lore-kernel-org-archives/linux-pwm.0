From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm-backlight: add pwm-delay-us property
Date: Thu, 13 Jul 2017 09:22:15 +0200
Message-ID: <CAFqH_538k_eZ4vtzJJCOmDwFnjEM0B4grgfq0uiDkE3n13Sguw@mail.gmail.com>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <CAL_Jsq+xpdsqbreQpN6oTdr+X2cHNnJr8tVEzG+tgTvhZUka6g@mail.gmail.com> <CAFqH_53tNo1G-ctbmux6AEWWFPXbuiFqTuZ94Gj_mDjFk_MksQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFqH_53tNo1G-ctbmux6AEWWFPXbuiFqTuZ94Gj_mDjFk_MksQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, huang lin <hl@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

Rob,

2017-07-06 20:23 GMT+02:00 Enric Balletbo Serra <eballetbo@gmail.com>:
> Hi Rob,
>
> 2017-07-06 19:07 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
>> On Fri, Jun 30, 2017 at 6:21 AM, Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>> From: huang lin <hl@rock-chips.com>
>>>
>>> Add a pwm-delay-us property to specify the delay between setting an
>>> initial (non-zero) PWM value and enabling the backlight, and also the
>>> delay between disabling the backlight and setting PWM value to 0.
>>>
>>> Signed-off-by: huang lin <hl@rock-chips.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>> Changes since v1:
>>>  - As suggested by Daniel Thompson
>>>    - Do not assume power-on delay and power-off delay will be the same
>>>
>>> v1: https://lkml.org/lkml/2017/6/28/219
>>>
>>>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>> index 764db86..49b037e 100644
>>> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>> @@ -17,6 +17,11 @@ Optional properties:
>>>                 "pwms" property (see PWM binding[0])
>>>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>>>                    and disables the backlight (see GPIO binding[1])
>>> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
>>> +                  enabling the backlight, and also the delay between disabling
>>> +                  the backlight and setting PWM value to 0.
>>> +                  The 1st cell is the pre-delay in micro seconds.
>>> +                  The 2nd cell is the post-delay in micro seconds.
>>
>> pre and post imply a time before and after a certain event, but these
>> are for 2 different events. These are more like an enable/on delay and
>> disable/off delay which probably should be separate properties. What
>> happens when we need the opposite sequence or a different sequence?
>> Maybe some panel requires the PWM to be 0 until some time after
>> enabling.
>>

A second proposal, what do you think?

  - post-pwm-on-delay-us: Delay in us after setting an initial (non-zero) PWM
                          and enabling the backlight using GPIO.
  - pwm-off-delay-us: Delay in us after disabling the backlight using a GPIO
                      and setting PWM value to 0.

Thanks,
Enric

>
> Maybe, Only I can say that the panels I checked always first enable
> the PWM and then set the ENABLE signal, but of course I didn't check
> all the panels.
>
> Would be more acceptable have enable-delay-us and disable-delay-us proprieties?
>
>> I don't understand why you even need a post delay. The PWM can be set
>> to 0 while enabled, right? So if the PWM is set to 0 while enabled and
>> then disable the backlight, then there's no delay. Plus this doesn't
>> make much sense to me electrically either. The PWM duty cycle is going
>> to be completely async to the enable line change. The PWM state could
>> go from 1 to 0 at any point in time relative to the enable line
>> change.
>>
>
> To be honest I'm also not sure why is required the post delay, some
> panels specify a 0 but others specifies a minimum value between you
> off the panel and disable the PWM. The only reason I added the post
> delay is because the different datasheets specifies it, I don't have a
> use case that the post delay is used to fix something.
>
> Thanks,
>  Enric
>
>> These issues are the problem with generic bindings. Adding 1 property
>> is no big deal, but then what happens with the next variation. These
>> timing constraints need to be able to be implied by the panel's
>> compatible.
>>
>> Rob
