From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 00:59:02 +0200
Message-ID: <20161019225902.GA373@archie.localdomain>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161019200533.GA26969@archie.localdomain>
 <20161019202827.GR1722@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:23801 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbcJSW7G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2016 18:59:06 -0400
Content-Disposition: inline
In-Reply-To: <20161019202827.GR1722@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Wed, Oct 19, 2016 at 11:28:27PM +0300, Mika Westerberg wrote:
> On Wed, Oct 19, 2016 at 10:05:33PM +0200, Clemens Gruber wrote:
> > Hi Mika,
> > 
> > what do you think about implementing this on a higher level / in the pwm
> > core instead of adding it to one specific pwm driver?
> 
> I originally thought about it but since there is only one driver I'm
> aware of that actually needs this functionality (because of how Galileo
> uses the PWM outputs), I decided to add it only to this driver.
> 
> > The fact that the PCA9685 bypasses PWM control if the full on/off bits
> > are set is beneficial but not a requirement to work as a GPIO.
> > Every pwm output could act as GPIO if the duty cycle is set to 0%/100%.
> 
> Yes, that's right.
> 
> > The pwm-pca9685 driver does already clear both OFF registers and sets
> > the ON register depending upon the duty cycle being at 0% or 100%.
> > So it might work without making any changes to specific pwm drivers and
> > it would then be available for all pwm chips.
> 
> I'm fine adding it to PWM core instead if Thierry does not have
> objections. However, do you think there is actual use for this outside
> of Galileo?

It could be useful for boards that have a PWM chip but only need a few
of its PWM channels for PWM output. Then they could use the others as
GPOs. This issue has not come up in any of my projects yet, but I just
found out that this topic did come up once before, about 4 years ago:
http://www.spinics.net/lists/linux-omap/msg82913.html

So there are (at least) two problems if we move it to pwm core:

1) Which period to use?

If we can't get a default period from the hardware or the driver, do we
need something like the following in the devicetree:

mypwmgpios: pwm-as-gpio {
	compatible = "pwm-as-gpio";
	pwms = <&pwmchip1 0 PERIOD>, <&pwmchip1 1 PERIOD>;
};

And then use it as follows:
gpio-foo = <&mypwmgpios 0 GPIO_ACTIVE_HIGH>;
gpio-bar = <&mypwmgpios 1 GPIO_ACTIVE_HIGH>;

?


2) Are there PWM chips that toggle one time before keeping the level?

This would be pretty bad. One possibility would be a blacklist for the
known pwm chips with this behavior?


The more I think about it, the more I like your pca9685-specific
solution, where we can use: gpio-foo = <&pwmchip1 0 GPIO_ACTIVE_HIGH>;
And the period is not even needed for the PCA9685 because the PWM
control is elegantly bypassed.

Maybe there is a way to keep it as simple to use in the devicetree and
allow other PWM drivers to use it iff they have a known default period
and do not toggle? So the driver tells the pwm core the default period
and if he can act as gpio controller, but the pwm core creates it?

Regards,
Clemens
