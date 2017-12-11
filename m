From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 09:36:00 +0000
Message-ID: <20171211093559.GS10595@n2100.armlinux.org.uk>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo>
 <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45260 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdLKJgM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 04:36:12 -0500
Content-Disposition: inline
In-Reply-To: <20171211091625.GA10671@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>

On Mon, Dec 11, 2017 at 10:16:25AM +0100, Thierry Reding wrote:
> On Tue, Dec 05, 2017 at 04:56:00PM -0200, Fabio Estevam wrote:
> > Hi Thierry,
> > 
> > On Tue, Dec 5, 2017 at 6:47 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > It looks like this would also keep other PWMs enabled in suspend. If for
> > > example you hooked up a fan to this PWM this change would make it so
> > > that the fan would remain on during suspend. That doesn't sound
> > > desirable to me.
> > 
> > It is expected that the PWM fan driver would disable the fan upon
> > entering into suspend.
> > 
> > The old vendor driver also sets the STOPEN bit unconditionally:
> > http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/plat-mxc/pwm.c?h=imx_2.6.35_11.09.01#n97
> > 
> > >
> > > On v2, I see this reply from you:
> > >
> > >         Please note that on imx6qdl-cuboxi the pwm is active low.
> > 
> > What I meant to say is that a logic level 0 turns on the LED.
> 
> That's the same thing.
> 
> > > I also see that imx6q-cubox-i uses the "fsl,imx27-pwm" compatible
> > > version of this controller and that supports polarity inversion. I think
> > > the correct thing to do here is to mark the PWM as inverted (according
> > > to the DTS file it is actually the pwmleds node that has an active-low
> > > property). If you invert the PWM you could add extra code to the PWM
> > > driver to deal with this properly and set STOPEN only for inverted PWM
> > > signals.
> > 
> > Polarity is correct:
> > 
> > echo 0 > brightness --> turns off the LED
> > echo 248 > brightness ---> turns on the LED with the maximum brightness
> > 
> > It is only the behaviour during suspend which is not correct (LCD turns on).
> 
> This does indicate all the more that you're trying to invert the
> polarity in the user driver. If you look at the driver code it will
> simply invert the duty cycle for active-low LEDs. That matches the
> symptoms that you describe: when you set zero brightness you will
> in fact get full duty cycle and hence the LED turns off. However,
> this does no longer work if the PWM signal is truly inverted, since
> the "off" state of the PWM signal will actually be "on".

There was discussion back in 2014 about this.  The problem is the
iMX6 PWM implementation is rather fscked.

The pwm specification in DT has support for inverting the PWM output:

"Optionally, the pwm-specifier can encode a number of flags (defined in
<dt-bindings/pwm/pwm.h>) in a third cell:
- PWM_POLARITY_INVERTED: invert the PWM signal polarity"

The problem, though, is that the imx6 PWM driver never took advantage
of that, and set #pwm-cells to 2.  So, for imx6, the PWM specification
is a phandle and a specifier, without the flags.

Adding the flags is not trivial (as was discussed back then) as DT
has no knowledge apart from the #*-cells property about how many
entries there are - the < > is just for our eyeballs and is mostly
otherwise meaningless.

Had this not been the case, then adding support for PWM_POLARITY_INVERTED
in pwm-imx6 would have been trivial, and probably the correct
solution, but alas, the discussion back then pointed to the current
solution being the best given the already broken implementation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
