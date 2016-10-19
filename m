From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Wed, 19 Oct 2016 22:05:33 +0200
Message-ID: <20161019200533.GA26969@archie.localdomain>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:33911 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcJSUNv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2016 16:13:51 -0400
Content-Disposition: inline
In-Reply-To: <20161019185638.GP1722@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

> On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> > The PCA9685 controller has full on/off bit for each PWM channel. Setting
> > this bit bypasses the PWM control and the line works just as it would be a
> > GPIO. Furthermore in Intel Galileo it is actually used as GPIO output for
> > discreet muxes on the board.
> > 
> > This patch adds GPIO output only support for the driver so that we can
> > control the muxes on Galileo using standard GPIO interfaces available in
> > the kernel. GPIO and PWM functionality is exclusive so only one can be
> > active at a time on a single PWM channel.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Mika,

what do you think about implementing this on a higher level / in the pwm
core instead of adding it to one specific pwm driver?

The fact that the PCA9685 bypasses PWM control if the full on/off bits
are set is beneficial but not a requirement to work as a GPIO.
Every pwm output could act as GPIO if the duty cycle is set to 0%/100%.

The pwm-pca9685 driver does already clear both OFF registers and sets
the ON register depending upon the duty cycle being at 0% or 100%.
So it might work without making any changes to specific pwm drivers and
it would then be available for all pwm chips.

Regards,
Clemens
