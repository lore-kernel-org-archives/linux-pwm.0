From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Thu, 4 Feb 2016 15:01:50 +0100
Message-ID: <20160204150150.553d36df@bbrezillon>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<2341981.a79ioYM9Es@diego>
	<20151110173416.GB21727@ulmo>
	<CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
	<20160125170855.GA10182@ulmo>
	<CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
	<20160203145337.GD9650@ulmo>
	<CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
	<20160204110203.GL4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42874 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752587AbcBDOCF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Feb 2016 09:02:05 -0500
In-Reply-To: <20160204110203.GL4455@sirena.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@google.com>, Thierry Reding <thierry.reding@gmail.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>, linux-pwm <linux-pwm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.inf>

Hi Mark, Thierry,

On Thu, 4 Feb 2016 11:02:03 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Feb 03, 2016 at 11:04:20AM -0800, Doug Anderson wrote:
> 
> > Sure.  ...but you agree that somehow you need a new API call for this,
> > right?  Somehow the PWM regulator needs to be able to say that it
> > wants the hardware state, not the initial state as specified in the
> > device tree.
> 
> Wouldn't the most direct way to do that be to just not specify anything
> in the DT?  If there *is* something in DT but we ignore it that's a bit
> weird.

Just adding some inputs on this specific aspect. The reason we have to
specify a period (and, to a lesser extent, the polarity) in the DT or
PWM lookup table is because what most PWM users want is to specify a
dutycycle relatively to a predefined period value.
If we decide to remove those information from the DT, then you'll need
a way to define it somewhere else, and then the is question is 'where?'.

Users that really want to control their period (this could the case for
the clk-pwm driver) could completely ignore DT/lookup-table information
and set the period and absolute dutycycle directly.

Now, from what I seen, what most PWM users want to do is:

	pwm_set_rel_duty_scale(pwm, rel_value, scale);
or 
	rel_duty = pwm_get_rel_duty_cycle(pwm, scale);

where scale depends on the precision you need for your use case (most
of the time it's expressed in percent).

So, how about providing this kind of API (this is what I proposed in
one of my previous email)?

This would not only solve our problem (say you have a period at
boot-time that differs from the one you'll set when first applying a
new relative duty cycle, then the resulting relative value would still
be correct), but it would also remove a lot of boiler plate code from
PWM users code (if you take a look at pwm-regulator, pwm-leds, pwm-fan
and probably others, you'll see that they are all doing this conversion
manually).

Now, the last blocking point is, what if the PWM driver does not
implement HW-readout. In this case, the pwm-regulator will probably
expose a 0V output (IIRC, dutycycle is set to 0 by default) when it's
actually providing something else. But is this really important? I
mean, if the user really wants to have a reliable information, then he
will implement initial-state retrieval in its PWM controller driver.
Alternatively, we could put a flag specifying whether the PWM chip
supports initial state retrieval.

Am I missing something?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
