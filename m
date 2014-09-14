From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] This adds a generic PWM framework driver for the PWM
 controller
Date: Sun, 14 Sep 2014 13:19:01 +0200
Message-ID: <20140914111901.GF26281@piout.net>
References: <20140818180316.31807.3445.stgit@studio>
 <20140818192318.GJ15297@lukather>
 <CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
 <20140818201929.GL15297@lukather>
 <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33633 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752514AbaINLTI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Sep 2014 07:19:08 -0400
Content-Disposition: inline
In-Reply-To: <CAKON4OwDWqnu9Nn6rBFtUJX2f0eFVzBFhRMcvPAp=K6N1KpE0w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pwm@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>, ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>

On 19/08/2014 at 08:11:40 -0400, jonsmirl@gmail.com wrote :
> On Mon, Aug 18, 2014 at 4:19 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Aug 18, 2014 at 03:53:08PM -0400, jonsmirl@gmail.com wrote:
> >> On Mon, Aug 18, 2014 at 3:23 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Aug 18, 2014 at 02:03:16PM -0400, Jon Smirl wrote:
> >> >> found on Allwinner SoCs.x
> >> >>
> >> >> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> >> >
> >> > Is there any notable difference with Alexandre's driver?
> >> > https://lkml.org/lkml/2014/5/19/568
> >> >
> >> > If so, why didn't you posted incremental patches on top of his driver?
> >>
> >> Better A10 support.
> >
> > Better how?
> >
> >> And I wrote this one without know about his.
> >
> > So you're just require us to trash an already extensively reviewed
> > driver and start from scratch again?
> 
> Forget mine then.
> 
> Problems in the other one....
> 1) The math is not right in either patch. Selsinork has been checking
> mine with a scope and just found another math error in mine. The
> internal math needs to be done in picoseconds or round off errors mess
> up the high frequency outputs (24Mhz, 12Mhz, 8Mhz, ...).

I don't have an oscilloscope so I can't check the exact output but I4ll
try to think about it.

> 3) By-pass mode on the A20 is not implemented.

I'm not sure there is a real use case here, using the bypass only allows
for one duty cycle of 50% with a period of 41.6ns so I think it is
preferable to get an error instead of a bogus output.

> 2) A10 is not correctly handled. Specifically the prescaler is
> different on the A10 vs A20.
> 

I'll change that.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
