Return-Path: <horms@verge.net.au>
Date: Thu, 20 Jun 2013 22:21:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Message-ID: <20130620132137.GF24993@verge.net.au>
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

Sorry, I have been slow. I should have some time to try tomorrow.
