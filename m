From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] ARM: at91: Document new TCB bindings
Date: Tue, 5 Jul 2016 20:33:17 +0200
Message-ID: <20160705183317.GB3623@piout.net>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160701012743.GA16698@rob-hp-laptop>
 <20160704151058.44b679bf@bbrezillon>
 <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On 05/07/2016 at 10:40:22 -0500, Rob Herring wrote :
> >> > +   - compatible: Should be "atmel,tcb-free-running-timer"
> >> > +   - reg: Should contain the TCB channels to be used. If the
> >> > +     counter width is 16 bits (at91rm9200-tcb), two consecutive
> >> > +     channels are needed. Else, only one channel will be used.
> >> > +
> >> > + * a clockevent device
> >> > +   - compatible: Should be "atmel,tcb-programmable-timer"
> >>
> >> This still looks like assigning usage in DT. As I'm willing to accept
> >> that for PWM, either timer channels should be whatever channels are not
> >> assigned to PWM (i.e. not in DT) or they should just be "timer" and let
> >> the kernel decide their usage.
> >
> > I just reviewed Alexandre's new binding, and it makes the whole thing
> > a lot more obscure: on older SoCs, we have to chain 2 channels to
> > create an acceptable wraparound time (16 bits at 5MHz is generating too
> > much interrupts to be acceptable).
> >
> > If we don't assign the mode from the DT, how should we know which
> > channels should be chained to create the free-running timer? Note that
> > not all channels can be chained together: they have to be part of the
> > same timer counter block and have to be consecutive (0+1, 1+2 or 3+0).
> 
> The driver can have this knowledge if it is just picking 2 consecutive
> timers. It should already know it has 16-bit timers based on the
> compatible string. If it gets more complicated then the features or
> limitations of the channels should be listed so the driver can make a
> choice. OMAP is a good example of lots of timers with differing
> features.
> 
> > Honestly, I don't see the difference between assigning the channel to a
> > PWM mode and assigning it to a free-running or oneshot timer mode. Why
> > is it more acceptable?
> 
> The difference is that pwm's have clients (e.g. a backlight) in DT and
> timers do not. We could just make the pwm clients reference the parent
> node, but then it is hard to figure out which channels are in use for
> pwm. That could also be solved with a simple "pwm-channels" property
> listing the channels in use.
> 

Well, at some point, we will probably have the ADC referring to channels
used as timers as they can be used to trigger it periodically.

We'll also get frequency measurement that will go in iio, quadrature
decoders, gray counters and event counters that will probably used by
different subsystems and will certainly have to be referred to in DT.

It will definitively feel a bit weird to have all the channels have
their own nodes but not the timers...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
