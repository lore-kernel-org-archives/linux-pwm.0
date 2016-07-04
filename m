From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3] ARM: at91: Document new TCB bindings
Date: Mon, 4 Jul 2016 14:17:33 +0200
Message-ID: <20160704141733.5d931a7f@bbrezillon>
References: <1467409925-17761-1-git-send-email-alexandre.belloni@free-electrons.com>
	<20160704122452.69dcddf0@bbrezillon>
	<20160704103631.GE20045@piout.net>
	<20160704140358.53ea7ad7@bbrezillon>
	<20160704121127.GG20045@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41224 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753756AbcGDMRg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jul 2016 08:17:36 -0400
In-Reply-To: <20160704121127.GG20045@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On Mon, 4 Jul 2016 14:11:27 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 04/07/2016 at 14:03:58 +0200, Boris Brezillon wrote :
> > On Mon, 4 Jul 2016 12:36:31 +0200
> > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> >   
> > > On 04/07/2016 at 12:24:52 +0200, Boris Brezillon wrote :  
> > > > On Fri,  1 Jul 2016 23:52:05 +0200
> > > > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:    
> > > > > +One interrupt per TC block:
> > > > > +	tcb0: timer@fff7c000 {
> > > > > +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> > > > > +		#address-cells = <1>;
> > > > > +		#size-cells = <0>;
> > > > > +		reg = <0xfff7c000 0x100>;
> > > > > +		interrupts = <18 4>;
> > > > > +		clocks = <&tcb0_clk>, <&clk32k>;
> > > > > +		clock-names = "t0_clk", "slow_clk";
> > > > > +
> > > > > +		timer@0 {
> > > > > +			compatible = "atmel,tcb-timer";
> > > > > +			reg = <0>, <1>;
> > > > > +		};
> > > > > +
> > > > > +		timer@2 {
> > > > > +			compatible = "atmel,tcb-timer";
> > > > > +			reg = <2>;
> > > > > +		};    
> > > > 
> > > > And how can you differentiate the clocksource from the clkevent?
> > > >     
> > > 
> > > It doesn't really matter actually, I'll do the selection in the driver,
> > > as suggested by Rob.
> > >   
> > 
> > Yes, I've read Rob's review, but then what's the point of defining 2
> > timer nodes, just do the detection based on the number of channels
> > you've reserved for the timer and define a single node.  
> 
> I agree this is a really hypothetical use case but one may want to have
> the clocksource on one TCB and the clockevent on another. This would
> allow to have for example a quadrature decoder and the clocksource on
> one TCB and another quadrature decoder and the clockevent device on
> another TCB.
> 
> 

Hm, that sounds like a valid but unlikely use case, but it makes the
DT bindinds even more obscure. When should one define a single timer
node, when to define two, how many channels per timer depending on the
type of timer you want to instantiate, etc. That should probably be
documented.

ITOH, by choosing the single timer-node approach, you hide everything in
the driver, and let the implementation choose the correct channels for
the clkevent and clksource devices.
