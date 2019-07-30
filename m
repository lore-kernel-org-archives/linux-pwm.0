From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date: Tue, 30 Jul 2019 19:06:01 +0200
Message-ID: <20190730170601.a7ei43wku6jsjanu@flea>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <173825848.1FZsmuHfpq@jernej-laptop>
 <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
 <2452836.v7ux4bnEjb@jernej-laptop>
 <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>, Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jul 30, 2019 at 10:09:00AM +0200, Uwe Kleine-König wrote:
> Hello Rob and Frank,
>
> Maxime and Jernej on one side and me on the other cannot agree about a
> detail in the change to the bindings here. I'm trying to objectively
> summarize the situation for you to help deciding what is the right thing
> to do here.
>
> TLDR: The sun4i pwm driver is extended to support a new variant of that
> device on the H6 SoC. Compared to the earlier supported variants
> allwinner,sun50i-h6-pwm on H6 needs to handle a reset controller and an
> additional clock.
>
> The two positions are:
>
>  - We need a new compatible because only then the driver and/or the dt
>    schema checker can check that each "allwinner,sun50i-h6-pwm" device
>    has a reset property and a "bus" clock; and the earlier variants
>    don't.

There is two topics here, really. The binding itself really must have
those properties as required.

You had an analogy before that we shouldn't really do that, since it
would be verification and that it would be similar to checking whether
the register range was right. This analogy isn't correct, a better one
would be checking that the register range exists in the first place.

Indeed, if you don't have a register range, you have no register to
write to, and that's a showstopper for any driver. I'm pretty sure we
all agree on that. But on those SoCs, like Chen-Yu said, having no
resets or clocks properties result in an equally bad result: either
any write to that device is completely ignored (missing reset), or the
system completely (and silently) locks up (missing bus clock).

We *have* to catch that somehow and not let anything like that happen.

That being said, we can't really validate that the clock pointed is
the right one, just like we can't really check that the register range
is the proper one. Or rather, we could, but it's completely
impractical and we do agree on that as well.

Having the bus clock and reset line being required however is only a
few lines in the binding though, and is very practical.

>  - The driver can be simpler and the device specific knowledge is only
>    in a single place (the dt) if the device tree is considered valid and
>    a reset property and "bus" clock is used iff it's provided in the
>    device tree without additional comparison for the compatible.

And now we have the discussion on how it's implemented in a
driver. Since it's pretty cheap to implement (only a couple of lines:
two for the if block, one for the additional field in the structure,
one for each SoC using that) and have huge benefits (not silently
locking up the system at boot), then I'd say we should go for it.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
