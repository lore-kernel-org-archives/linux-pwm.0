Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] pwm: pxa: add device tree support to pwm driver
Date: Thu, 5 Sep 2013 17:34:40 +0200
References: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com> <201309050011.01808.marex@denx.de> <5228A238.2090202@newsguy.com>
In-Reply-To: <5228A238.2090202@newsguy.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201309051734.40570.marex@denx.de>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Thierry Reding <thierry.reding@gmail.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Grant Likely <grant.likely@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>

Dear Mike Dunn,

> On 09/04/2013 03:11 PM, Marek Vasut wrote:
> 
> 
> [...]
> 
> >>> What's that "secondary PWM" there? I no longer remember, sorry.
> >> 
> >> If pdev->id_entry->driver_data == HAS_SECONDARY_PWM, then
> >> pwm_chip->npwm=2 when pwmchip_add() is called.  Otherwise
> >> pwm_chip->npwm=1.  The driver knows that the second pwm's registers are
> >> at a fixed offset from the first.  For compatibility, the pxa27x maps
> >> the registers for the third pwm at a distant offset, and makes the
> >> offset between 3 and 4 the same as between 1 and 2.  Yes, the driver
> >> mkes this unnecessarily complicated. There should just be one device
> >> instance per pwm, and dispense with the whole driver_data thing.  I
> >> guess there's some history there.
> > 
> > OK, I checked the datasheet. The register block for PWM<n + 2> is at
> > offset of 0x10 from PWM<n> , for n in {0, 1} .
> > 
> > Why can we not just register four PWM blocks, each with 0x10 register
> > window size then? I know there's history (maybe), but then, with DT,
> > this might go away.
> 
> Indeed.  That is what I am also thinking.
> 
> >>> The question
> >>> remains still, we can have two entries there (pxa25x and pxa27x) ORR
> >>> have one entry (pxa25x) + mrvl,has-secondary-pwm entry.
> >> 
> >> It looks like defining "compatible" properties that mirror the old
> >> platform_device_id names won't fly...
> > 
> > Yes of course, this won't work. I didn't know the layout exactly.
> > 
> >> wildcards are verboten (see Sergei's
> >> comment).  So your inclination to use one value for the "compatible"
> >> property is correct.  I think the way to go is to forget the whole
> >> HAS_SECONDARY_PWM in the DT case, have one device instance per pwm, and
> >> use "compatible=marvell,pwm". Other suggestions welcome.
> > 
> > compatbile=marvell,pxa25x-pwm , no ? The lowest CPU with the block.
> 
> Unless I am missing something, the compatible string does not need to
> replicate any of the existing platform_device_id names, so wouldn't
> "marvell,pxa" be better?  Except for register mapping and the number of
> units present on a particular pxa variant, the peripheral is software
> compatible across all pxa processors.  Plus there is the problem of the
> 'x' wildcard in "pxa25x-pwm".

So use pxa250 ?

My concern is once marvell comes up with PXA1048576 which will have a different 
PWM unit, then what will be the name for this new one?

Best regards,
Marek Vasut
