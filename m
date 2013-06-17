Return-Path: <horms@verge.net.au>
Date: Mon, 17 Jun 2013 13:25:49 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Message-ID: <20130617042441.GA3725@verge.net.au>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2268799.XyU3XHOFNL@avalon>
 <20130614010118.GC7284@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130614010118.GC7284@verge.net.au>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>

Hi Laurent,

I am having a little trouble testing this.
I am wondering if you could guide me as to
what .config options I should have enabled and
what values I should be looking for in /sys ?

On Fri, Jun 14, 2013 at 10:01:19AM +0900, Simon Horman wrote:
> Hi Laurent,
> 
> yes, I can test it. However, I have to travel to Tokyo for meetings
> today and thus won't be able to do any testing until Monday.
> 
> On Thu, Jun 13, 2013 at 11:36:34PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > Would you be able to test this patch series on kota2 ? If all goes well I'd 
> > like this to go to v3.11.
> > 
> > On Thursday 13 June 2013 18:54:43 Laurent Pinchart wrote:
> > > This is the fourth version of the Renesas TPU PWM unit support patches. The
> > > patch series deprecates and removes the leds-renesas-tpu driver in favor of
> > > a combination of leds-pwm and pwm-renesas-tpu. As an added bonus patch 4/5
> > > removes function GPIOs support from the sh73a0 platform. mach-shmobile is
> > > now free of function GPIOs. We still need volunteer(s) to migrate arch/sh.
> > > 
> > > I believe I've addressed all comments received in response to v3. I've
> > > tested the code on Armadillo only as I don't have access to a kota2 board.
> > > This is why I've added backlight support to Armadillo as part of this set.
> > > 
> > > The patches are based on Simon's renesas-next-20130613 tag. I've pushed them
> > > to
> > > 
> > >         git://linuxtv.org/pinchartl/fbdev.git pinmux/3.10/tpu
> > > 
> > > Given the risk of conflicts on arch/arm/mach-shmobile it would probably be
> > > easier to merge the set through Simon's tree. Thierry, would you be fine
> > > with that ?
> > > 
> > > Changes since v3:
> > > 
> > > - Set the driver name to renesas-tpu-pwm instead of renesas_tpu_pwm
> > > - Allocate the PWM device in the request handler
> > > - Fixed device name in sh73a0 clocks lookup array
> > > - Added support for TPU0 on sh73a0
> > > 
> > > Changes since v2:
> > > 
> > > - Dropped SH Mobile arch patches that have already been merged
> > > - Replaced active_low pdata field with pwm_polarity
> > > - Replaced TPU_PWM_ID with pwm_lookup's
> > > - Set the platform_driver .owner field
> > > - Replaced devm_ioremap_nocache() with devm_ioremap_resource()
> > > - Added a .set_polarity() implementation
> > > - Use kernel block comment style
> > > - Don't enable/disable the clock around clk_get_rate()
> > > - Removed duplicate sanity checks in the .config() operation
> > > 
> > > Changes since v1:
> > > 
> > > - Renamed the pwm-rmob driver to pwm-renesas-tpu, as TPU units are found in
> > >   Renesas SH-Mobile, R-Mobile and R-Car SoCs.
> > > - Added TPU clock and pin groups for r8a7790.
> > > 
> > > Laurent Pinchart (5):
> > >   pwm: Add Renesas TPU PWM driver
> > >   ARM: mach-shmobile: armadillo800eva: Add backlight support
> > >   ARM: mach-shmobile: kota2: Use leds-pwm + pwm-rmob
> > >   ARM: shmobile: sh73a0: Remove all GPIOs
> > >   leds: Remove leds-renesas-tpu driver
> > > 
> > >  arch/arm/mach-shmobile/board-armadillo800eva.c |  54 ++-
> > >  arch/arm/mach-shmobile/board-kota2.c           | 169 +++++----
> > >  arch/arm/mach-shmobile/clock-r8a7740.c         |   2 +-
> > >  arch/arm/mach-shmobile/clock-sh73a0.c          |  12 +-
> > >  arch/arm/mach-shmobile/include/mach/sh73a0.h   | 373 +------------------
> > >  drivers/leds/Kconfig                           |  12 -
> > >  drivers/leds/Makefile                          |   1 -
> > >  drivers/leds/leds-renesas-tpu.c                | 337 ------------------
> > >  drivers/pwm/Kconfig                            |  10 +
> > >  drivers/pwm/Makefile                           |   1 +
> > >  drivers/pwm/pwm-renesas-tpu.c                  | 475 ++++++++++++++++++++++
> > >  include/linux/platform_data/leds-renesas-tpu.h |  14 -
> > >  include/linux/platform_data/pwm-renesas-tpu.h  |  16 +
> > >  13 files changed, 646 insertions(+), 830 deletions(-)
> > >  delete mode 100644 drivers/leds/leds-renesas-tpu.c
> > >  create mode 100644 drivers/pwm/pwm-renesas-tpu.c
> > >  delete mode 100644 include/linux/platform_data/leds-renesas-tpu.h
> > >  create mode 100644 include/linux/platform_data/pwm-renesas-tpu.h
> > 
> > -- 
> > Regards,
> > 
> > Laurent Pinchart
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
