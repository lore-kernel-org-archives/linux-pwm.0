From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv6 0/3] pwm: imx: support output polarity inversion
Date: Mon, 12 Sep 2016 22:00:21 +0200
Message-ID: <20160912200021.fsnfdgnng4it354g@pengutronix.de>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
 <20160909091857.7a263220@ipc1.ka-ro>
 <20160912124553.aqgv7b4vsx4urogi@piout.net>
 <20160912140401.qkezay7sqqavsf4i@pengutronix.de>
 <074eed0df23199bc82f8d221690596d3@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41520 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbcILUAY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Sep 2016 16:00:24 -0400
Content-Disposition: inline
In-Reply-To: <074eed0df23199bc82f8d221690596d3@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Hello Stefan,

On Mon, Sep 12, 2016 at 09:51:26AM -0700, Stefan Agner wrote:
> On 2016-09-12 07:04, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Mon, Sep 12, 2016 at 02:45:53PM +0200, Alexandre Belloni wrote:
> >> Isn't a properly designed PWM putting a high level on its pin when
> >> disabled and configured with inversed polarity ?
> > 
> > it's not well defined. When trying several times over the years to
> > properly define and document it, I didn't manage to agree with Thierry
> > what is the right thing to define.
> > 
> > IMHO it would be sensible to make it explicitly undefined what happens
> > when a PMW is disabled. This would simplify drivers from
> > 
> > 	pwm_config(mypwm, value, period);
> > 	if (!value)
> > 		pwm_disable(mypwm)
> > 	else
> > 		pwm_enable(led_dat->pwm);
> > 
> > to
> > 
> > 	pwm_config(mypwm, value, period);
> > 
> > and let the pwm driver disable it's clock (or whatever) when value is 0
> > and there are energy saving benefits that don't hurt the expected
> > behaviour of the pin. So the hardware specific stuff is handled in the
> > hardware specific driver and usage in pwm-consumers is simplified.
> > Moreover this also simplifies some pwm drivers because they don't have
> > to catch in software the cases where the hardware differs from the
> > expectation[1].
> 
> That sounds like a sane definition to me and what I would have expected
> from the PWM framework. That the pin is not defined after pwm_disable is
> totally understandable. It is usually a case which the board designer
> anyway needs to take care of (e.g. what is the state right after power
> on? If the designer cares about, he will put a pull-up/down in place).
> 
> And it seems also Sascha suggested that:
> https://lkml.org/lkml/2013/1/4/139

actually I talked to Sascha in private before ranting :-)

> I did not found where Thierry disagreed to that...?

Hmm, I used gmane links before, most of them are dead today. :-|
http://www.spinics.net/lists/linux-leds/msg03237.html is one example.

> > Today it's a (maybe small) bug, when a pwm consumer calls pwm_config with
> > value=0 and doesn't disable it afterwards. IMHO that's a bug in the pwm
> > API that pwm_config with value=0 doesn't imply (the wanted effects of)
> > pwm_disable.
> 
> I don't quite get what you are saying here. What wanted effects of
> pwm_disable would you like to move into pwm_config with value=0?

I want that the pwm driver disables its clock on pwm_config(mypwm, 0,
someperiod) such that the consumer doesn't need to call
pwm_disable(mypwm) to save power (assuming it's safe to do so, which
only the pwm provider knows).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
