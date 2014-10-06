From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv7 1/2] pwm: Add Allwinner SoC support
Date: Mon, 6 Oct 2014 16:43:21 +0200
Message-ID: <20141006144320.GF15599@piout.net>
References: <1410983638-24915-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410983638-24915-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20141006132404.GC26921@ulmo>
 <20141006143008.GC15599@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56338 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751344AbaJFOnY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Oct 2014 10:43:24 -0400
Content-Disposition: inline
In-Reply-To: <20141006143008.GC15599@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, jonsmirl@gmail.com, Simon <longsleep@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Oops, missing line:

On 06/10/2014 at 16:30:08 +0200, Alexandre Belloni wrote :
> > > +static const u32 prescaler_table[] = {
> > > +	120,
> > > +	180,
> > > +	240,
> > > +	360,
> > > +	480,
> > > +	0,
> > > +	0,
> > > +	0,
> > > +	12000,
> > > +	24000,
> > > +	36000,
> > > +	48000,
> > > +	72000,
> > > +	0,
> > > +	0,
> > > +	0, /* Actually 1 but tested separately */
> > > +};
> > 
> > Did I already mention that this was really weird?
> > 
> 
> I'm not sure what you want to do here then. This is simply coming from
> the datasheet. The last one (0xF) being a bypass is actually only existing on 

A20 and later.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
