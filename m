From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v6 1/4] gpio: mvebu: Add limited PWM support
Date: Wed, 31 May 2017 14:36:21 +0200
Message-ID: <87bmq9td8a.fsf@free-electrons.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
        <20170414154056.32055-2-ralph.sennhauser@gmail.com>
        <CACRpkdYPp6pBemTT_a4V6a-Qbk2475qOOxWJOhfVaEz=cojOvA@mail.gmail.com>
        <87tw42tqdr.fsf@free-electrons.com>
        <20170530165101.73ae0bf6@gmail.com>
        <CACQ1gAhhVEem9=We3mTJwhDbLDNw+_uyr2LpAyjQSk0iJ4O6Ew@mail.gmail.com>
        <20170531142614.5f32fca6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38944 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdEaMgX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 May 2017 08:36:23 -0400
In-Reply-To: <20170531142614.5f32fca6@gmail.com> (Ralph Sennhauser's message
        of "Wed, 31 May 2017 14:26:14 +0200")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ralph,
 
 On mer., mai 31 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

> On Tue, 30 May 2017 17:35:33 +0200
> Richard Genoud <richard.genoud@gmail.com> wrote:
>   
>> Hi Ralph,
>> 
>> I have the functional spec (no NDA needed, but it's not the full
>> one) : A38x-Functional-Spec-PU0A.pdf
>> https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
>> (just an email needed, no blood signing nor chicken slaughtering)
>> There are the GPIO Blink Counter A/B is ON/OFF Duration Registers as
>> well as the Blink Enable Registers.
>> 
>
> Hi Richard,
>
> Thanks for the link, as the terms only talk about materials obtained
> from www.marvell.com this one from wufoo.com should be exempt ;)
> Also at a glance looks like the complete one. Also says "Functional
> Specifications – Unrestricted". Maybe you want to re-download it.
>
> Regardless, as you said the blinking registers are all described. So
> it's probably safe to assume 39x will have them as well.

I guess you meant 38x. (But I suppose it is also true for 39x)


>
>> I've done a pwm with different periods (8ms, 4ms, 100ns).
>> Looking at the scope, it seems to work pretty well :)
>> 
>> >>
>> >> And it makes me realized that I missed the bad naming of the
>> >> compatible string. We don't use family name for the compatible
>> >> string, but the name of the first SoC compatible with. So in this
>> >> case we should use "marvell,armada-370", as it is still in rc and
>> >> not yet deployed. What about fixing the name now?  
>
> Gregory,
>
> Knowing it's not limited to 370/XP makes "marvell,armada-370-gpio" an
> obviously better choice for the compatible string. Guess you didn't
> mean to drop the "-gpio" suffix.

You're right I meant "marvell,armada-370-gpio".

>
> Will work on a patch changing the compatible string / documentation for
> 4.12 and an updated patch for armada 370/XP dtsi as well as a patch
> adding the properties to 38x for 4.13+. Expect them tomorrow, probably
> won't get around to it today anymore.

Great!

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
