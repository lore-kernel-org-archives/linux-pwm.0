From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: MX28: leds/pwm: Using pwm driven led as heartbeat leads to
 kernel warning
Date: Fri, 4 Apr 2014 18:44:47 +0200
Message-ID: <20140404164446.GI4883@piout.net>
References: <53345C93.9040005@i2se.com>
 <533EB9AC.6040708@i2se.com>
 <20140404142656.GA16383@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39913 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753049AbaDDQot (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Apr 2014 12:44:49 -0400
Content-Disposition: inline
In-Reply-To: <20140404142656.GA16383@dragon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@freescale.com>, Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-leds@vger.kernel.org

On 04/04/2014 at 22:26:58 +0800, Shawn Guo wrote :
> On Fri, Apr 04, 2014 at 03:54:52PM +0200, Stefan Wahren wrote:
> > the problem is still reproducable in Mainline 3.14.0 and gives the same
> > warning message.
> > Also i add linux-leds in CC.
> > 
> > Are there any advices to narrow down the problem?
> > 
> > Is this problem specific to i.MX28 PWM (i don't have other kind of
> > hardware)?
> 
> I don't think it's specific to i.MX28 PWM.  Since the .config hook of
> pwm_ops will be called from interrupt context in this case, any pwm
> drivers that do sleeping calls in the hook will have this problem, e.g.
> the clk APIs that hold mutex like clk_prepare() and clk_get_rate() etc.
> 

Yeah, I'm wondering whether we should set pwm->chip->can_sleep then.

Thierry, do you have an opinion ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
