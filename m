From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
Date: Thu, 6 Jul 2017 09:02:10 +0200
Message-ID: <20170706090210.3bbfd3e6@bbrezillon>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
        <20170706064922.GI16144@ulmo.fritz.box>
        <20170706070016.asujxs3ibkqq6jzj@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44379 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdGFHCN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 03:02:13 -0400
In-Reply-To: <20170706070016.asujxs3ibkqq6jzj@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <o.schinagl@ultimaker.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 6 Jul 2017 09:00:16 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 06/07/2017 at 08:49:22 +0200, Thierry Reding wrote:
> > On Tue, May 30, 2017 at 09:32:06PM +0200, Alexandre Belloni wrote:  
> > > Switch to atomic PWM. The main goal is to properly wait for a period before
> > > disabling a channel to ensure the correct level is set on the output.
> > > 
> > > Changes in v2:
> > >  - fixed remaining checkpatch warnings
> > >  - split the series to ease reviews
> > >  - changed the delay handling to ensure the proper amount of time has elapsed
> > >    before disabling a channel
> > >  - dropped RDY bit handling as it doesn't have any real effect.
> > > 
> > > Alexandre Belloni (3):
> > >   pwm: sun4i: improve hardware read out
> > >   pwm: sun4i: switch to atomic PWM
> > >   pwm: sun4i: drop legacy callbacks
> > > 
> > >  drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------------
> > >  1 file changed, 148 insertions(+), 115 deletions(-)  
> > 
> > Series applied, though you could've just squashed together patches 2 and
> > 3 because they don't make sense apart.
> >   
> 
> Ok, thanks. IIRC, Boris suggested the split ;)

Yes, I did it because the diff was really hard to review.
