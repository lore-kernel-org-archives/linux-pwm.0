From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: PWM...
Date: Mon, 20 Jan 2014 08:21:02 +0100
Message-ID: <20140120072102.GA19940@pengutronix.de>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <20140119190324.GC28056@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46873 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaATHVe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2014 02:21:34 -0500
Content-Disposition: inline
In-Reply-To: <20140119190324.GC28056@quad.lixom.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Sun, Jan 19, 2014 at 11:03:24AM -0800, Olof Johansson wrote:
> [Adding devicetree list since we're talking bindings]
> 
> On Sun, Jan 19, 2014 at 04:49:57PM +0000, Russell King - ARM Linux wrote:
> > So, having looked at what else I can add support for on the cubox-i, I
> > decided it would be nice and simple to add support for the front panel
> > LED.  What could possibly go wrong with this.
> > 
> > Well, the hardware is wired such that the LED is connected between the
> > PWM output and +3.3v.  So, a constant low turns the LED on full, whereas
> > a constant high turns the LED off.
> > 
> > So, the polarity of the LED is inverted - but this _can't_ be specified
> > in the totally and utterly fucked misdesigned crap that DT is:
> > 
> >         pwmleds {
> >                 compatible = "pwm-leds";
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&pinctrl_cubox_i_pwm1>;
> >                   
> >                 front {
> >                         label = "imx6:red:front";
> >                         pwms = <&pwm1 0 50000>;
> >                         max-brightness = <248>;
> >                 };
> >         };
> > 
> >                         pwm1: pwm@02080000 {
> >                                 #pwm-cells = <2>;
> >                                 compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
> >                                 reg = <0x02080000 0x4000>;
> >                                 interrupts = <0 83 0x04>;
> >                                 clocks = <&clks 62>, <&clks 145>;
> >                                 clock-names = "ipg", "per";
> >                         };
> > 
> > Yes, because iMX6 specifies #pwm-cells as 2, there's no flags able to
> > be specified in the pwms declaration in pwmleds.  So that doesn't work.
> > There's no property to tell pwmleds that it should use inverted sense
> > either.
> 
> Adding a property for active-low to the pwm-leds binding would be
> easy, and backwards compatible. I'm surprised the original binding
> didn't specify it. The leds-pwm driver already seems to support it for
> C-configured instances.
> 
> I'm also surprised that the imx pwm driver even has a #pwm-cells of
> two, since the driver only supports one output. It'd be nice if they
> had allocated the extra cell for flags, but it's hard to change now,
> unless you do a new binding/compatible value and deprecate the old one.
> 
> > Moreover, there's no way to specify a default brightness for the LED
> > in the absence of any trigger, so this results in the LED being fully
> > on.
> 
> That seems to be missing from the led-pwm driver altogether, not just the DT
> bindings? Shouldn't be too bad to add a default-brightness property and plumb
> that up through the driver in this case.
> 
> > So, something which _should_ be nice and simple is turned into a major
> > fuckup because of the total and utter crappiness that DT is and the
> > total misdesign that this shite is.
> 
> It's not a major fuckup. None of the above is unfixable.

Indeed, and we already have a patch for this:

http://comments.gmane.org/gmane.linux.ports.arm.kernel/294823

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
