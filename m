Return-Path: <t.figa@samsung.com>
From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Date: Wed, 19 Jun 2013 12:23:52 +0200
Message-id: <1991384.bDpcDUcax8@amdc1227>
In-reply-to: <20130619094355.GB2911@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1433668.INLZy9nfLF@flatron> <20130619094355.GB2911@mithrandir>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On Wednesday 19 of June 2013 11:43:56 Thierry Reding wrote:
> On Wed, Jun 19, 2013 at 12:45:02AM +0200, Tomasz Figa wrote:
> > On Wednesday 19 of June 2013 00:17:06 Thierry Reding wrote:
> > > On Mon, Jun 17, 2013 at 10:50:40PM +0200, Tomasz Figa wrote:
> > > > On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > > > > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
> > > [...]
> > > 
> > > > > > +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> > > > > > +static DEFINE_SPINLOCK(samsung_pwm_lock);
> > > > > > +#endif
> > > > > 
> > > > > Why is this lock global? Shouldn't it more correctly be part of
> > > > > samsung_pwm_chip?
> > > > 
> > > > There are few registers shared with samsung_pwm_timer clocksource
> > > > driver and so normally the spinlock is exported from it. However on
> > > > on some platforms (namely Exynos >=4x12) kernel can be compiled
> > > > without that driver, so the lock must be defined locally, just to
> > > > synchronize multiple PWM channels, as they share registers as well.
> > > 
> > > Okay, I think this needs further explanation. The clocksource driver
> > > is
> > > used for what exactly? From a quick look it seems to be very much
> > > PWM-
> > > specific. According to the device tree binding for the PWM driver,
> > > the
> > > timer blocks can also be used as clock sources and clock event
> > > timers.
> > > So if I understand correctly you have setups where you use one or
> > > more
> > > channels as clock source or clock event timer and one or more
> > > channels
> > > as PWM outputs.
> > > 
> > > In that case it's a very bad idea to use a global lock to synchronize
> > > accesses. You need to do much more than that. To properly split this
> > > across several drivers there needs to be a mechanism to allocate
> > > channels for use either as clock source/event timer or PWM.
> > > Otherwise,
> > > how do you know that drivers aren't stepping on each other's toes?
> > > 
> > > > > > +		ret = pwm_samsung_parse_dt(chip);
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		chip->chip.of_xlate = of_pwm_xlate_with_flags;
> > > > > > +		chip->chip.of_pwm_n_cells = 3;
> > > > > > +	} else {
> > > > > > +		if (!pdev->dev.platform_data) {
> > > > > > +			dev_err(&pdev->dev, "no platform data
> > > > 
> > > > specified\n");
> > > > 
> > > > > > +			return -EINVAL;
> > > > > > +		}
> > > > > > +
> > > > > > +		memcpy(&chip->variant, pdev->dev.platform_data,
> > > > > > +
> > 
> > sizeof(chip-
> > 
> > > > >variant));
> > > > >
> > > > > > +	}
> > > > > 
> > > > > Obviously this needs some modification in order for the variant
> > > > > to
> > > > > become constant. But I think you can easily do so by making the
> > > > > driver
> > > > > match using the platform_driver's id_table field, similar to how
> > > > > the
> > > > > matching is done for OF.
> > > > 
> > > > Generally output_mask is board-dependent and is passed inside a
> > > > variant
> > > > struct using platform_data pointer.
> > > 
> > > That's okay. But output_mask is the only thing that's
> > > board-dependent.
> > > Everything else in the variant is SoC dependent judging by the OF
> > > device
> > > table. So really only the output_mask should be part of the platform
> > > data.
> > > 
> > > > Same platform data is used in samsung_pwm_timer clocksource driver,
> > > > so
> > > > I just reused it here without adding the need to rename platform
> > > > device at runtime (see arch/arm/plat-samsung/devs.c).
> > > 
> > > Looking a bit at git log for the clocksource driver, there's this
> > > 
> > > commit:
> > > 	a3ce54f clocksource: samsung_pwm_timer: Do not request PWM mem
> > 
> > region
> > 
> > > That's an ugly workaround for sharing registers between two drivers.
> > > There's a reason why drivers do request_mem_region(), and it is
> > > precisely to prevent them from accessing the same registers. As I
> > > already said above, I think you need to come up with some sort of API
> > > to
> > > share resources between the drivers.
> > > 
> > > There was a similar issue a few months back with the pwm-tiehrpwm and
> > > pwm-tiecap drivers, which use a shared block of registers. Initially
> > > something similar was done as you do here, but eventually we came up
> > > with a much better solution that involved introducing a new driver
> > > for
> > > the shared functionality and an exported API.
> > > 
> > > The situation seems to be somewhat different here since you actually
> > > share the same resources for different functionality instead of
> > > sharing
> > > one subset of register across multiple drivers, but I think a similar
> > > solution can be applied here.
> > 
> > Well, current design, or rather lack of thereof, has been established
> > after a significant amount of discussion, mostly with ARM SoC and MFD
> > maintainers.
> > 
> > It started from a simple reorganization of the clocksource driver to be
> > multiplatform friendly, without any means of synchronizing both drivers
> > other than local_irq_save() and _restore() that used to be there
> > originally, before I started my work on this. This was enough to work
> > correctly, because both drivers at the same time are used only on
> > uniprocessor systems.
> > 
> > Here's the thread with patches:
> > http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16664/focus=1726
> > 7
> > 
> > Then I opened a Pandora's Box by asking for opinion in this thread:
> > http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16480/focus=1650
> > 0
> > 
> > After that I started working on a complex framework for sharing this IP
> > block that would solve all the problems with synchronization, channel
> > allocation, device tree parsing, variant management, etc.
> > 
> > Here's an initial version, which started as an MFD master driver, which
> > would let 2 client drivers use the hardware (only the clocksource part
> > was implemented in that series):
> > http://thread.gmane.org/gmane.linux.kernel.samsung-soc/17464/focus=2292
> > 50
> > 
> > Still, that version didn't receive too good feedback, with comments
> > pointing me to change the architecture to master-slave, with the
> > clocksource driver being the master and PWM driver being the slave. And
> > so v5 was made:
> > http://thread.gmane.org/gmane.linux.kernel.samsung-soc/17864
> 
> Yeah, this seemed to be going in the right direction.
> 
> > This version was generally accepted, but then we discussed on IRC
> > (mostly me and Arnd) whether such complex infrastructure is really
> > needed and concluded that for this platform a simple shared spinlock
> > would be enough, based on following reasons:
> > - on all SoCs on which the clocksource driver is going to be used there
> > is only one instance of the PWM block, with 5 channels
> 
> You say that now. But then at some point somebody decides that it might
> be useful to have a second instance.

No, he won't.

Simply because no new SoC is going to be made which will use the 
samsung_pwm_timer driver and all existing ones have only a single instance 
of this IP.

> > - on all existing boards there are always at least two channels that
> > don't have outputs
> 
> I don't see how that's relevant here.

This is the information passed through output_mask. Clocksource driver can 
use _only_ channels without output and PWM driver can use _only_ channels 
with output.

Both drivers receive the same output_mask value, either from the same 
variant structure or from device tree.

> > - operations on particular PWM channels must be synchronized anyway,
> > because there are registers shared by all PWM channels (TCON being most
> > important where enable, autoreload and invert bits are located for all
> > channels).
> 
> And that's precisely why there should be a more explicit way of
> synchronizing than just acquiring a lock. Otherwise you have no
> possibility whatsoever to detect when a board tries to use both the
> clocksource and PWM drivers in incompatible ways. The lock may prevent
> concurrent accesses to the shared registers, but that won't help you if
> the PWM driver suddenly decides to use an output that was originally
> meant to be used as clock source.

See above.

> > And so we got to current design which is basically a shared spinlock
> > and
> > per-board output_mask, which specifies which channels have outputs on
> > particular boards. If you look to the clocksource driver, you can see
> > that it tries to allocate two output-less channels for timekeeping
> > purposes and if it fails to do so, it simply panics.
> > 
> > IMHO this solution is fine, because it's simple, has little overhead
> > and
> > it just works in case of platforms for which it is needed.
> 
> Okay, I like simple. But I see too much potential for this to break
> in the future. There are just too many assumptions for my taste. It
> isn't anything that I'm looking forward to have to maintain.

Those are completely safe assumptions for existing platforms. Any new 
platform with the same PWM IP will use this driver exclusively, without the 
clocksource driver and so without the problems you mentioned.

Best regards,
Tomasz
