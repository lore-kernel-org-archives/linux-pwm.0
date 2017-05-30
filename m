From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v6 1/4] gpio: mvebu: Add limited PWM support
Date: Tue, 30 May 2017 17:35:33 +0200
Message-ID: <CACQ1gAhhVEem9=We3mTJwhDbLDNw+_uyr2LpAyjQSk0iJ4O6Ew@mail.gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
 <20170414154056.32055-2-ralph.sennhauser@gmail.com> <CACRpkdYPp6pBemTT_a4V6a-Qbk2475qOOxWJOhfVaEz=cojOvA@mail.gmail.com>
 <87tw42tqdr.fsf@free-electrons.com> <20170530165101.73ae0bf6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34236 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdE3Pfz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 May 2017 11:35:55 -0400
In-Reply-To: <20170530165101.73ae0bf6@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2017-05-30 16:51 GMT+02:00 Ralph Sennhauser <ralph.sennhauser@gmail.com>:
> On Tue, 30 May 2017 15:40:00 +0200
> Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>
>> Hi Ralph and Linus,
>>
>> I resurrect this thread following the series post by Richard Genoud:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/509461.html
>>
>>  On lun., avril 24 2017, Linus Walleij <linus.walleij@linaro.org>
>> wrote:
>>
>> > On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
>> > <ralph.sennhauser@gmail.com> wrote:
>> >
>> >> From: Andrew Lunn <andrew@lunn.ch>
>> >>
>> >> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
>> >> and off period. This can be modelled as a PWM.
>> >>
>> >> However, there are only two sets of PWM configuration registers for
>> >> all the GPIO lines. This driver simply allows a single GPIO line
>> >> per GPIO chip of 32 lines to be used as a PWM. Attempts to use
>> >> more return EBUSY.
>> >>
>> >> Due to the interleaving of registers it is not simple to separate
>> >> the PWM driver from the GPIO driver. Thus the GPIO driver has been
>> >> extended with a PWM driver.
>> >>
>> >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> >> URL: https://patchwork.ozlabs.org/patch/427287/
>> >> URL: https://patchwork.ozlabs.org/patch/427295/
>> >> [Ralph Sennhauser:
>> >>   * Port forward
>> >>   * Merge PWM portion into gpio-mvebu.c
>> >>   * Switch to atomic PWM API
>> >>   * Add new compatible string marvell,armada-370-xp-gpio
>>
>> The fact that Richard managed to run the code on Armada 38x draw my
>> attention on the documentation that need to be amend.
>
> Hi Gregory
>
> But does it behave as a pwm-fan? I don't have access to the 38x
> functional spec (no NDA with Marvell), the one for XP is public.
> According to Andrew the 38x doesn't have the blinking hardware and so I
> expect the pwm-fan is just an overblown gpio-fan there, additionally
> writing some random values to random registers where luck has it nothing
> goes wrong.
>
> Kirkwood apparently has blinking support but only at fixed frequency of
> 10Hz, so not usable for this purpose either.
>
> So to my knowledge it really is just 370 and XP.
Hi Ralph,

I have the functional spec (no NDA needed, but it's not the full one) :
A38x-Functional-Spec-PU0A.pdf
https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
(just an email needed, no blood signing nor chicken slaughtering)
There are the GPIO Blink Counter A/B is ON/OFF Duration Registers as well as the
Blink Enable Registers.

I've done a pwm with different periods (8ms, 4ms, 100ns).
Looking at the scope, it seems to work pretty well :)

>>
>> And it makes me realized that I missed the bad naming of the
>> compatible string. We don't use family name for the compatible
>> string, but the name of the first SoC compatible with. So in this
>> case we should use "marvell,armada-370", as it is still in rc and not
>> yet deployed. What about fixing the name now?
>
> I don't mind but certainly not for me to decide at this point.
>
>>
>> I can send a patch for it if you want and fix the dts that are still
>> in my mvebu branch.
>
> Sure, or if you prefer I can do it as well if we decide for the change.
> No preference.
>
> Ralph
