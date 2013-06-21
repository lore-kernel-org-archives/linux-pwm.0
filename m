Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Date: Fri, 21 Jun 2013 08:43:21 +0200
Message-ID: <13724411.JArtzQ6F7y@avalon>
In-Reply-To: <20130621061528.GA30041@verge.net.au>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2149088.lMDRNEvQpV@avalon> <20130621061528.GA30041@verge.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>

Hi Simon,

On Friday 21 June 2013 15:15:28 Simon Horman wrote:
> On Thu, Jun 20, 2013 at 01:15:11PM +0200, Laurent Pinchart wrote:
> > On Monday 17 June 2013 12:31:39 Laurent Pinchart wrote:
> > > On Monday 17 June 2013 13:25:49 Simon Horman wrote:
> > > > Hi Laurent,
> > > > 
> > > > I am having a little trouble testing this.
> > > > I am wondering if you could guide me as to what .config options I
> > > > should have enabled and what values I should be looking for in /sys ?
> > > 
> > > Sure. You need to enable CONFIG_LEDS_PWM and CONFIG_PWM_RENESAS_TPU).
> > > You should then be able to control the LEDs through /sys/class/leds/*.
> > 
> > Any luck ?
> 
> Hi Laurent,
> 
> I have confirmed that I can toggle the G H and J LEDs.

Thank you.

> Should I queue-up this patchset?

Given that it's too late to push this to v3.11 through the ARM SoC tree 
(please correct me if I'm wrong), what about pushing 1/5 through the PWM tree 
for v3.11 and 2/5 to 5/5 through ARM SoC for v3.12 ? Thierry, would you be 
able to pick patch 1/5 for v3.11 ?

> On the way I noticed the following:
> 
> sh-pfc pfc-sh73a0: pin PORT163 already requested by renesas-tpu-pwm.3;
> cannot claim for sh-sci.8 sh-pfc pfc-sh73a0: pin-163 (sh-sci.8) status -22

Pin 163 was used for both TPU LEDs and SCIFB RTS in the original board code, 
hence the conflict. That's most probably a mistake. Do you have the kota2 
schematics ? If so, could you please confirm that pin 163 is used for the LED 
only, not for SCIFB RTS ? I'll then send a patch to fix this.

> sh-pfc pfc-sh73a0: pin 1195 is not registered so it cannot be requested
> sh-pfc pfc-sh73a0: pin-1195 (sh_keysc.0) status -22
> sh-pfc pfc-sh73a0: could not request pin 1195 on device sh-pfc
> sh_keysc sh_keysc.0: Error applying setting, reverse things back

I'll work on that.

> My personal feeling is that if these are trivial to fix then it would be
> worth doing so. Otherwise a discussion needs to be had about support for the
> kota2.

-- 
Regards,

Laurent Pinchart
