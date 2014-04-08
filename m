From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 01:16:54 +0200
Message-ID: <20140408231654.GA13898@piout.net>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408141832.GA8861@piout.net>
 <53442997.70209@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56676 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756739AbaDHXQ5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Apr 2014 19:16:57 -0400
Content-Disposition: inline
In-Reply-To: <53442997.70209@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

Hi,

On 08/04/2014 at 18:53:43 +0200, Stefan Wahren wrote :
> i applied these 5 patches, but it doesn't fix the problem.
> 
> Here are my results for the pwm driver led on i.MX28:
> 
> version                  | trigger: none          | trigger: heartbeat
> -----------------------------------------------------------------------------
> 3.14                     | OK                     | NOT OK (WARNING, LED
> permanent on)
>   + shawn's patch        | OK                     | NOT OK (LED
> permanent on)
>     + russell's patches  | OK                     | NOT OK (LED
> permanent on)
>       + active-low       | NOT OK (inverse logic) | NOT OK (LED
> permanent on)
> 
> Russell's patches work as expected, but have not influence on the heartbeat.
> 

Yeah, I got it wrong or explained badly.

So, if without Russell's patches, your pwm is not inversed, then you would
have to set active_low and inverse the pwm.
If it was inversed, then you'll have to set active_low and let the pwm
with the normal polarity. I know this is a bit contrived but this was
exactly my point why we shouldn't call it active_low.

Can you try to switch the polarity when setting active_low ?

I'm not home, else I'll try on my i.mx28 boards...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
