From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 15:08:53 +0200
Message-ID: <20161020130853.GA1785@archie.localdomain>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
 <20161020125144.GA24653@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:57495 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936542AbcJTNI6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2016 09:08:58 -0400
Content-Disposition: inline
In-Reply-To: <20161020125144.GA24653@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Thu, Oct 20, 2016 at 02:51:44PM +0200, Thierry Reding wrote:
> I'm reluctant to add this to the PWM core because it's effectively
> duplicating something for which a proper subsystem already exists.
> 
> If adding pinmux is considered overkill, maybe doing so needs to be
> simplified. Surely if this is applicable to more than one PWM controller
> some helpers could be extracted to make it easier to add.
> 
> But if it isn't generally useful I don't think it makes sense to add it
> to the PWM core either. So I think our choices here are to register via
> pinmux and in the process add helpers to make that easier (remove the
> overkill) or to keep this to the driver until we start seeing a pattern
> emerge.

But the fact that this one pwm chip bypasses PWM control and acts as a
GPO is an implementation detail of the chip, this feature is helpful for
other PWM chips too, as long as they don't toggle.
Would this really be a good fit in the pinmux subsystem?

I really like the idea of Mika to add a gpio_set callback in pwm_ops and
let the pwm core export a GPIO chip. For now we could add this callback
only to the pwm-pca9685 driver but others could opt-in if needed.

But the initial patch from Mika is fine too, in my opinion.

Regards,
Clemens
