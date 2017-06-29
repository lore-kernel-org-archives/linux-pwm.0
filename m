From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add pwm-delay-us property
Date: Thu, 29 Jun 2017 14:07:48 +0100
Message-ID: <af29d976-408d-c71a-3eda-db0023e6f1c2@linaro.org>
References: <20170628111632.22582-1-enric.balletbo@collabora.com>
 <20170628133004.GA3507@localhost>
 <CAFqH_53pUu7w6NTEFPtcawG0mG__71dJMAO2wKNCOqtQ04WYRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32833 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbdF2NHw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2017 09:07:52 -0400
Received: by mail-wm0-f53.google.com with SMTP id z75so18772548wmc.0
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2017 06:07:51 -0700 (PDT)
In-Reply-To: <CAFqH_53pUu7w6NTEFPtcawG0mG__71dJMAO2wKNCOqtQ04WYRg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, huang lin <hl@rock-chips.com>

On 28/06/17 15:15, Enric Balletbo Serra wrote:
> Hi Daniel, Pavel,
> 
> 2017-06-28 15:30 GMT+02:00 Pavel Machek <pavel@ucw.cz>:
>> On Wed 2017-06-28 13:16:31, Enric Balletbo i Serra wrote:
>>> From: huang lin <hl@rock-chips.com>
>>>
>>> Add a pwm-delay-us property to specify the delay between setting an
>>> initial (non-zero) PWM value and enabling the backlight, and also the
>>> delay between disabling the backlight and setting PWM value to 0.
>>
>>
>>
>>> Signed-off-by: huang lin <hl@rock-chips.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>   Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>> index 764db86..f75b08f 100644
>>> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
>>> @@ -17,6 +17,9 @@ Optional properties:
>>>                  "pwms" property (see PWM binding[0])
>>>     - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>>>                     and disables the backlight (see GPIO binding[1])
>>> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
>>> +                  enabling the backlight, and also the delay between disabling
>>> +                  the backlight and setting PWM value to 0.
>>>
>>
>>> If is safe to assume power-on delay and power-off delay will be the same?
>>>
>>> I've only took a quick look but several backlight controllers support asymetric power-on/off sequences..
> 
> Daniel, right the ones I checked are symmetric but asymmetric timings
> are possible I guess, so I think now that specify the two delays is
> more accurate, maybe the binding should be something like this?
> 
>    pwm-delay-us = <delay_before_on  delay_after_off>;

I think so. Like you I can't actually point at any asymmetric power 
sequence diagrams but there are a controller devices with power 
sequencing registers that support asymmetry. I'm inclined to take that 
as a hint...


>> I understood it as "you set PWM and it takes a while for display to
>> light up"
>> but that's not correct. Changelog from second patch makes it
>> clear. Please
>> clarify it here, too.
> 
> Pavel, oh, your dude is interesting ...
> 
> That's the idea, the sequence is:
>    Power on, you set the PWM signal, wait a bit and set the LED_EN signal.
>    Power off, you clear the LED_EN signal, wait a bit and stop the PWM signal.
> 
> Note that the patch inverts the sequence, before this patch first you
> set LED_EN signal and then the PWM signal
> 
> I assumed that the sequence was wrong but maybe I'm mistaken and there
> are some panels that follow the original sequence. On the few panels I
> checked the power on/off sequence is how I described above, i.e. see
> [1] p. 17, the sequence is first PWM and then LED_EN. I'll take a look
> at other panel datasheets, or if you know one, could you provide me
> the datasheet?
> 
> Thanks,
> 
> [1] http://www.jxlcd.com/Upload/PicFiles/N116BGE-L41.pdf
> 
>>
>>                                                                  Pavel
>> --
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
