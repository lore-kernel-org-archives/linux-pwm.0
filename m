From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3] ARM: at91: Document new TCB bindings
Date: Mon, 4 Jul 2016 12:36:31 +0200
Message-ID: <20160704103631.GE20045@piout.net>
References: <1467409925-17761-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160704122452.69dcddf0@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38303 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753030AbcGDKgn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jul 2016 06:36:43 -0400
Content-Disposition: inline
In-Reply-To: <20160704122452.69dcddf0@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On 04/07/2016 at 12:24:52 +0200, Boris Brezillon wrote :
> On Fri,  1 Jul 2016 23:52:05 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > +One interrupt per TC block:
> > +	tcb0: timer@fff7c000 {
> > +		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		reg = <0xfff7c000 0x100>;
> > +		interrupts = <18 4>;
> > +		clocks = <&tcb0_clk>, <&clk32k>;
> > +		clock-names = "t0_clk", "slow_clk";
> > +
> > +		timer@0 {
> > +			compatible = "atmel,tcb-timer";
> > +			reg = <0>, <1>;
> > +		};
> > +
> > +		timer@2 {
> > +			compatible = "atmel,tcb-timer";
> > +			reg = <2>;
> > +		};
> 
> And how can you differentiate the clocksource from the clkevent?
> 

It doesn't really matter actually, I'll do the selection in the driver,
as suggested by Rob.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
