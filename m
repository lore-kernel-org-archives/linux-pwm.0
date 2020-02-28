From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused
 duty_cycle struct element
Date: Fri, 28 Feb 2020 14:26:52 +0100
Message-ID: <23144d65d94460d70fd66d67d1f9875303c7bce8.camel@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
         <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
         <20200226192103.bodplhjson7drvgm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.tq-group.com ([62.157.118.193]:52777 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgB1N05 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 28 Feb 2020 08:26:57 -0500
In-Reply-To: <20200226192103.bodplhjson7drvgm@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 20:21 +0100, Uwe Kleine-König wrote:
> On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> > On Wed, 2020-02-26 at 16:10 +0100, Uwe Kleine-König wrote:
> > > Hello Matthias,
> > > 
> > > as you seem to have this hardware on your desk, it would be great
> > > if
> > > you
> > > could answer the following questions:
> > > 
> > >  - Does the hardware complete the currently running period before
> > >    applying a new setting?
> > 
> > The datasheet claims:
> > 
> > > Because the loading of the LEDn_ON and LEDn_OFF registers is via
> > > the
> > > I 2 C-bus, and
> > > asynchronous to the internal oscillator, we want to ensure that
> > > we do
> > > not see any visual
> > > artifacts of changing the ON and OFF values. This is achieved by
> > > updating the changes at
> > > the end of the LOW cycle.
> > 
> > My interpretation is that the hardware will complete its period
> > before
> > applying the new settings. I might check with a scope tomorrow-ish.
> 
> I agree given that you can update duty_cycle and period in a single
> write as you considered below. Maybe it is worth playing with small
> periods and a slow i2c bus speed (or hijack the bus by simulating a
> clock stretch).
>  
> > >  - Is this racy somehow (i.e. can it happen that when going from
> > >    duty_cycle/period = 1000/5000 to duty_cycle/period =
> > > 4000/10000 the
> > >    output is 1000/10000 (or 4000/5000) for one cycle)?
> > 
> > It currently is racy. It should be possible to fix that either by
> > updating all 4 registers in a single I2C write, or by using the
> > "update
> > on ACK" mode which requires all 4 registers to be updated before
> > the
> > new setting is applied (I'm not sure if this mode would require
> > using a
> > single I2C write as well though).
> 
> I can offer a second pair of eyeballs to interpret the datasheet.
> Will
> take a look tomorrow.
> 
> > >  - Does the hardware complete the currently running period before
> > >    .enabled = false is configured?
> > 
> > As my interpretation is that new settings are applied
> > asynchronously, I
> > assume that the final running period is completed after .enabled is
> > set
> > to false.
> > 
> > >  - How does the output pin behave on a disabled PWM. (Usual
> > > candidates
> > >    are: freeze where is just happens to be, constant inactive and
> > >    High-Z).
> > 
> > Constant inactive. This is also the case when the chip is put into
> > sleep mode. Note that the interpretation of "inactive" depends in
> > the
> > invert flag in the MODE2 register.
> 
> This is optimal.
> 
> > As it turns out, this driver is broken in yet another way I didn't
> > find
> > before: For changing the global prescaler the chip needs to be put
> > into
> > sleep mode, but the driver doesn't follow the restart sequence
> > described in the datasheet when waking it back up. In consequence,
> > changing the period of one PWM does not only modify the period of
> > all
> > PWMs (which is bad enough, but can't be avoided with this
> > hardware),
> > but it also leaves all PWMs disabled...
> > 
> > As this hardware only has a single prescaler for all PWMs, should
> > changing the period for individual PWMs even be allowed at all?
> > Maybe
> > only when all other PWMs are inactive?
> 
> yes, that is the general approach. Please document this in a
> Limitiations: paragraph. See drivers/pwm/pwm-imx-tpm.c which has a
> similar problem.

This raises the question what to do about the GPIO mode supported by
the driver: While the period does not affect GPIO usage of PWMs,
changing the period would put the chip in sleep mode and thus briefly
disable active GPIOs. I assume that this should preclude changing the
period when there are any PWMs requsted as GPIOs, but now the order in
which things are initialized becomes crucial:

- All references to PWMs of the same PCA9685 must specify the same
period
- When requesting a PWM as GPIO, no period can be specified
=> When a PWM referenced as GPIO is requested before the first actual
PWM, setting the correct period becomes impossible.

I can't think of a nice solution that doesn't require serious rework -
maybe we need at least an optional period property in DTS to support
this case? This could either be implemented as a default period or a
fixed period.

A more elaborate solution could be to remove the GPIO code from PCA9685
and implement a generic GPIO-PWM driver instead that could be
configured in DTS (again, I have no idea how to support non-DTS
platforms). Unfortunately, I assume I won't have time to realize such a
solution myself.

Matthias


>  
> > I could imagine setting it in DTS instead (but I'm not sure what to
> > do
> > about non-OF users of this driver, for example when configured via
> > ACPI).
> 
> I don't like fixing the period in the device tree. This isn't a
> hardware
> property and it is less flexible than possible.
> 
> Best regards
> Uwe
> 
