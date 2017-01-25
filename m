From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] ARM: at91: Document new TCB bindings
Date: Wed, 25 Jan 2017 16:11:29 +0100
Message-ID: <20170125161129.41acaa9a@bbrezillon>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
        <20160701012743.GA16698@rob-hp-laptop>
        <20160704151058.44b679bf@bbrezillon>
        <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Rob,

Sorry to revive this old discussion, but there's still one aspect I'm
not sure about.

On Tue, 5 Jul 2016 10:40:22 -0500
Rob Herring <robh@kernel.org> wrote:

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

Yes it's possible to do that, but what about DT overlays then? Say you
have some TCB channels you'd like to reserve because they are connected
to pins that are exposed on your board. Those pins are not connected to
any device yet, but extension boards can be added, and in this case you
might want to expose new PWM devices by dynamically loading DT overlays.

If your clksource/clkevent driver parsed the initial DT and picked X
free channels randomly, it may conflicts with the one requested by the
DT overlay.

What's your solution for this case?

Thanks,

Boris
