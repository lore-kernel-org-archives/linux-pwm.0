From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm-backlight: add pwm-delay-us property
Date: Thu, 13 Jul 2017 09:49:16 +0200
Message-ID: <CAFqH_5101OQWGyeHtUB-2mUwnbpnPq7FWWnYfjKAgyC9BVMmag@mail.gmail.com>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
 <CAL_Jsq+xpdsqbreQpN6oTdr+X2cHNnJr8tVEzG+tgTvhZUka6g@mail.gmail.com>
 <CAFqH_53tNo1G-ctbmux6AEWWFPXbuiFqTuZ94Gj_mDjFk_MksQ@mail.gmail.com>
 <CAFqH_538k_eZ4vtzJJCOmDwFnjEM0B4grgfq0uiDkE3n13Sguw@mail.gmail.com> <20170713073954.GA1363@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35589 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdGMHtS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jul 2017 03:49:18 -0400
In-Reply-To: <20170713073954.GA1363@amd>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, huang lin <hl@rock-chips.com>

2017-07-13 9:39 GMT+02:00 Pavel Machek <pavel@ucw.cz>:
> On Thu 2017-07-13 09:22:15, Enric Balletbo Serra wrote:
>> Rob,
>>
>> 2017-07-06 20:23 GMT+02:00 Enric Balletbo Serra <eballetbo@gmail.com>:
>> > Hi Rob,
>> >
>> > 2017-07-06 19:07 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
>> >> On Fri, Jun 30, 2017 at 6:21 AM, Enric Balletbo i Serra
>> >> <enric.balletbo@collabora.com> wrote:
>> >>> From: huang lin <hl@rock-chips.com>
>> >>>
>> >>> Add a pwm-delay-us property to specify the delay between setting an
>> >>> initial (non-zero) PWM value and enabling the backlight, and also the
>> >>> delay between disabling the backlight and setting PWM value to 0.
>> >>>
>> >>> Signed-off-by: huang lin <hl@rock-chips.com>
>> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> >>> ---
>> >>> Changes since v1:
>> >>>  - As suggested by Daniel Thompson
>> >>>    - Do not assume power-on delay and power-off delay will be the same
>> >>>
>> >>> v1: https://lkml.org/lkml/2017/6/28/219
>> >>>
>> >>>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>> >>>  1 file changed, 6 insertions(+)
>> >>>
>> >>> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> >>> index 764db86..49b037e 100644
>> >>> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> >>> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>> >>> @@ -17,6 +17,11 @@ Optional properties:
>> >>>                 "pwms" property (see PWM binding[0])
>> >>>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>> >>>                    and disables the backlight (see GPIO binding[1])
>> >>> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
>> >>> +                  enabling the backlight, and also the delay between disabling
>> >>> +                  the backlight and setting PWM value to 0.
>> >>> +                  The 1st cell is the pre-delay in micro seconds.
>> >>> +                  The 2nd cell is the post-delay in micro seconds.
>> >>
>> >> pre and post imply a time before and after a certain event, but these
>> >> are for 2 different events. These are more like an enable/on delay and
>> >> disable/off delay which probably should be separate properties. What
>> >> happens when we need the opposite sequence or a different sequence?
>> >> Maybe some panel requires the PWM to be 0 until some time after
>> >> enabling.
>> >>
>>
>> A second proposal, what do you think?
>>
>>   - post-pwm-on-delay-us: Delay in us after setting an initial (non-zero) PWM
>>                           and enabling the backlight using GPIO.
>
> This says "PWM on", "enable GPIO", "delay". Which is not what you
> want.
>

Ok, seems I need to improve a bit more my English skills. :)

after -> between ?

Then, if I understand correctly, this (found in another binding that I
used as reference)

- post-power-on-delay-ms : Delay in ms after powering the card and
        de-asserting the reset-gpios (if any)

means,

Power the card, de-asserting reset, delay ?

Regards,
 Enric.

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
