From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 07/13] pwm: add support for sl28cpld PWM controller
Date: Wed, 15 Jul 2020 19:45:10 +0200
Message-ID: <7d8e9f524f0fd81be282be0be50d16ad@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
 <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
 <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
 <20200715163620.xhi24mct5b64qpyp@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgGORpT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jul 2020 13:45:19 -0400
In-Reply-To: <20200715163620.xhi24mct5b64qpyp@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundat>

Hi Uwe,

Am 2020-07-15 18:36, schrieb Uwe Kleine-König:
> On Tue, Jul 14, 2020 at 11:09:28PM +0200, Michael Walle wrote:
>> > My wishlist (just as it comes to my mind, so no guarantee of
>> > completeness):
>> >
>> >  - can do 0% duty cycle for all supported period lengths
>> >  - can do 100% duty cycle for all supported period lengths
>> >  - supports both polarities
>> >  - supports immediate change of configuration and after completion of
>> >    the currently running period
>> >  - atomic update (i.e. if you go from configuration A to configuration B
>> >    the hardware guarantees to only emit periods of type A and then type
>> >    B. (Depending on the item above, the last A period might be cut off.)
>> 
>> We actually discussed this, because the implementation would be 
>> easier. But
>> if the change takes place immediately you might end up with a longer 
>> duty
>> cycle. Assume the PWM runs at 80% duty cycle and starts with the 
>> on-period.
>> If you now change that to 50% you might end up with one successive 
>> duty
>> cycle of "130%". Eg. the 80% of the old and right after that you 
>> switch to
>> the new 50% and then you'd have a high output which corresponds to a 
>> 130%
>> cycle. I don't know if that is acceptable for all applications.
> 
> I thought this is a "change takes place immediately" implementation?! 
> So
> these problems are actually real here. (And this not happening is 
> exactly
> my wish here. Is there a mis-understanding?)

I wasn't talking about the sl28cpld btw. What is the difference between
your proposed "change take place immediately" and "after the cycle".
I understand how the after the cycle should work. But how would the
immediate change work in your ideal PWM?

>> > > > If you change only cycle but not mode, does the hardware complete the
>> > > > currently running period?
>> > >
>> > > No it does not.
>> >
>> > Please document this as a Limitation.
>> 
>> I've discussed this internally, for now its a limitation. In the worst
>> case you'd do one 100% duty cycle. Maybe we can fix the hardware. I
>> acknowledge that this is a severe limitation, esp. if you use the PWM
>> for controlling stuff (for now its only LCD backlight.. so thats ok).
> 
> That happens if you reduce the duty cycle from A to B and the counter 
> is
> already bigger than B but smaller than A, right?
That is correct.

> The fix would be to
> compare for counter >= match instead of counter = match. (Which then
> would result in a period with a duty cycle bigger than B but smaller
> than A. Also not ideal, but probably better.)

This would actually work. I could imagine that comparing "less than" 
will
take up more space again. But it would be worth a try; see also below.

>> > > > What about disable()?
>> > >
>> > > Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there we can
>> > > fix that (in hardware), not much we can do in the driver here. We are
>> > > _very_ constraint in size, therefore all that little edge cases fall
>> > > off
>> > > the table.
>> >
>> > You're saying that on disable the hardware emits a constant high level
>> > for one cycle? I hope not ...
>> 
>> Mh, I was mistaken, disabling the PWM will turn it off immediately, 
>> but
> 
> And does turn off mean, the output gets inactive?
> If so you might also disable the hardware if a 0% duty cycle is
> configured assuming this saves some energy without modifying the
> resulting wave form.

Disabling it has some side effects like switching to another function
for this multi function pin. So I'd rather keep it on ;)

>> one 100% duty cycle may happen if you change from a higher to a lower
>> duty cycle setting. See above.
>> 
>> > I never programmed a CPLD to emulate a hardware PWM, but I wonder if
>> > these are really edge cases that increase the size of the binary?!
>> 
>> At the moment there is only one 8bit register which stores the value
>> which is used for matching. If you want to change that setting after
>> a whole cycle, you'd use another 8bit register to cache the new value.
>> So this would at least needs 8 additional flip-flops. This doesn't
>> sound much, but we are already near 100% usage of the CPLD. So its
>> hard to convince people why this is really necessary.
> 
> OK. (Maybe there is enough space to allow implementing 100% for mode 
> 0?)

Little bit here a little bit there ;) TBH there are some more critical
bugs which would need to be fixed first. So this would need to be a
limitation for now.

-michael
