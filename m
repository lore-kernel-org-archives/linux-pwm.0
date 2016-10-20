From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 11:07:59 +0300
Message-ID: <20161020080759.GU1722@lahna.fi.intel.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161019200533.GA26969@archie.localdomain>
 <20161019202827.GR1722@lahna.fi.intel.com>
 <20161019225902.GA373@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16805 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756959AbcJTIIK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Oct 2016 04:08:10 -0400
Content-Disposition: inline
In-Reply-To: <20161019225902.GA373@archie.localdomain>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Thu, Oct 20, 2016 at 12:59:02AM +0200, Clemens Gruber wrote:
> It could be useful for boards that have a PWM chip but only need a few
> of its PWM channels for PWM output. Then they could use the others as
> GPOs. This issue has not come up in any of my projects yet, but I just
> found out that this topic did come up once before, about 4 years ago:
> http://www.spinics.net/lists/linux-omap/msg82913.html
> 
> So there are (at least) two problems if we move it to pwm core:
> 
> 1) Which period to use?
> 
> If we can't get a default period from the hardware or the driver, do we
> need something like the following in the devicetree:
> 
> mypwmgpios: pwm-as-gpio {
> 	compatible = "pwm-as-gpio";
> 	pwms = <&pwmchip1 0 PERIOD>, <&pwmchip1 1 PERIOD>;
> };
> 
> And then use it as follows:
> gpio-foo = <&mypwmgpios 0 GPIO_ACTIVE_HIGH>;
> gpio-bar = <&mypwmgpios 1 GPIO_ACTIVE_HIGH>;
> 
> ?

How about adding a callback to struct pwm_ops: gpio_set() and if that is
implemented by the driver, the core will export a GPIO chip and expects
the driver to be able to set the default period (or better override the
whole PWM functionality as PCA9685 can do).

That also is not tied to DT (Galileo is an ACPI system).

> 2) Are there PWM chips that toggle one time before keeping the level?
> 
> This would be pretty bad. One possibility would be a blacklist for the
> known pwm chips with this behavior?

..or do the above and let each driver to implement that hook only if it
is actually capable of doing that.

> The more I think about it, the more I like your pca9685-specific
> solution, where we can use: gpio-foo = <&pwmchip1 0 GPIO_ACTIVE_HIGH>;
> And the period is not even needed for the PCA9685 because the PWM
> control is elegantly bypassed.

Indeed :)

> Maybe there is a way to keep it as simple to use in the devicetree and
> allow other PWM drivers to use it iff they have a known default period
> and do not toggle? So the driver tells the pwm core the default period
> and if he can act as gpio controller, but the pwm core creates it?

Unfortunately we can't use DT in Galileo but that gpio_set() callback, I
suggest above, should work regardless of the underlying firmware
interface.
