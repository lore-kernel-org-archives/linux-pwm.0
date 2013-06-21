Return-Path: <horms@verge.net.au>
Date: Fri, 21 Jun 2013 15:15:28 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Message-ID: <20130621061528.GA30041@verge.net.au>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130617042441.GA3725@verge.net.au>
 <1401873.dJyJ3o5vr2@avalon>
 <2149088.lMDRNEvQpV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2149088.lMDRNEvQpV@avalon>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>

On Thu, Jun 20, 2013 at 01:15:11PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 17 June 2013 12:31:39 Laurent Pinchart wrote:
> > On Monday 17 June 2013 13:25:49 Simon Horman wrote:
> > > Hi Laurent,
> > > 
> > > I am having a little trouble testing this.
> > > I am wondering if you could guide me as to
> > > what .config options I should have enabled and
> > > what values I should be looking for in /sys ?
> > 
> > Sure. You need to enable CONFIG_LEDS_PWM and CONFIG_PWM_RENESAS_TPU). You
> > should then be able to control the LEDs through /sys/class/leds/*.
> 
> Any luck ?

Hi Laurent,

I have confirmed that I can toggle the G H and J LEDs.
Should I queue-up this patchset?


On the way I noticed the following:

sh-pfc pfc-sh73a0: pin PORT163 already requested by renesas-tpu-pwm.3; cannot claim for sh-sci.8
sh-pfc pfc-sh73a0: pin-163 (sh-sci.8) status -22

sh-pfc pfc-sh73a0: pin 1195 is not registered so it cannot be requested
sh-pfc pfc-sh73a0: pin-1195 (sh_keysc.0) status -22
sh-pfc pfc-sh73a0: could not request pin 1195 on device sh-pfc
sh_keysc sh_keysc.0: Error applying setting, reverse things back


My personal feeling is that if these are trivial to fix
then it would be worth doing so. Otherwise a discussion
needs to be had about support for the kota2.
