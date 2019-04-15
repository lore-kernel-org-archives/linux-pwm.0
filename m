From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 04/12] clocksource/drivers/tcb_clksrc: stop depending on
 atmel_tclib
Date: Mon, 15 Apr 2019 16:14:28 +0200
Message-ID: <20190415141428.GE3578@piout.net>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-5-alexandre.belloni@bootlin.com>
 <7ce7342d-7fa2-d2b0-621d-2c47a0e5cdba@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7ce7342d-7fa2-d2b0-621d-2c47a0e5cdba@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 11/04/2019 18:19:34+0200, Daniel Lezcano wrote:
> > +	tc.clk[0] = t0_clk;
> > +	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
> > +	if (IS_ERR(tc.clk[1]))
> > +		tc.clk[1] = t0_clk;
> > +	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
> > +	if (IS_ERR(tc.clk[2]))
> > +		tc.clk[2] = t0_clk;
> > +	tc.irq[0] = irq;
> > +	tc.irq[1] = of_irq_get(node->parent, 1);
> > +	if (tc.irq[1] <= 0)
> > +		tc.irq[1] = irq;
> > +	tc.irq[2] = of_irq_get(node->parent, 2);
> > +	if (tc.irq[2] <= 0)
> > +		tc.irq[2] = irq;
> 
> Why are clk[1/2] and irq[1/2] defaulting back to t0 in case of error?
> 

This is how the DT binding is madewhen the same IRQ/clk is used for all
the channels of the TCB, then it is only specified once. Unfortunately,
this has to be kept to keep backward DT compatibility. Still, I'm
reworking the irq paring as the driver only needs the irq for channel 2.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
