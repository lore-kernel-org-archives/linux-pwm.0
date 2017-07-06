From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
Date: Thu, 6 Jul 2017 09:00:16 +0200
Message-ID: <20170706070016.asujxs3ibkqq6jzj@piout.net>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
 <20170706064922.GI16144@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44318 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbdGFHAS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 03:00:18 -0400
Content-Disposition: inline
In-Reply-To: <20170706064922.GI16144@ulmo.fritz.box>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Olliver Schinagl <o.schinagl@ultimaker.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 06/07/2017 at 08:49:22 +0200, Thierry Reding wrote:
> On Tue, May 30, 2017 at 09:32:06PM +0200, Alexandre Belloni wrote:
> > Switch to atomic PWM. The main goal is to properly wait for a period before
> > disabling a channel to ensure the correct level is set on the output.
> > 
> > Changes in v2:
> >  - fixed remaining checkpatch warnings
> >  - split the series to ease reviews
> >  - changed the delay handling to ensure the proper amount of time has elapsed
> >    before disabling a channel
> >  - dropped RDY bit handling as it doesn't have any real effect.
> > 
> > Alexandre Belloni (3):
> >   pwm: sun4i: improve hardware read out
> >   pwm: sun4i: switch to atomic PWM
> >   pwm: sun4i: drop legacy callbacks
> > 
> >  drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------------
> >  1 file changed, 148 insertions(+), 115 deletions(-)
> 
> Series applied, though you could've just squashed together patches 2 and
> 3 because they don't make sense apart.
> 

Ok, thanks. IIRC, Boris suggested the split ;)

> Thierry



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
