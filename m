From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 16:01:17 +0300
Message-ID: <20161020130117.GK24289@lahna.fi.intel.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
 <20161020125144.GA24653@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936488AbcJTNFy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Oct 2016 09:05:54 -0400
Content-Disposition: inline
In-Reply-To: <20161020125144.GA24653@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Thu, Oct 20, 2016 at 02:51:44PM +0200, Thierry Reding wrote:
> On Thu, Oct 20, 2016 at 02:18:44PM +0300, Mika Westerberg wrote:
> > On Thu, Oct 20, 2016 at 12:45:41PM +0200, Thierry Reding wrote:
> > > On Wed, Oct 19, 2016 at 09:56:38PM +0300, Mika Westerberg wrote:
> > > > On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> > > > > The PCA9685 controller has full on/off bit for each PWM channel. Setting
> > > > > this bit bypasses the PWM control and the line works just as it would be a
> > > > > GPIO. Furthermore in Intel Galileo it is actually used as GPIO output for
> > > > > discreet muxes on the board.
> > > > > 
> > > > > This patch adds GPIO output only support for the driver so that we can
> > > > > control the muxes on Galileo using standard GPIO interfaces available in
> > > > > the kernel. GPIO and PWM functionality is exclusive so only one can be
> > > > > active at a time on a single PWM channel.
> > > > > 
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > 
> > > > Thierry,
> > > > 
> > > > Any comments on this?
> > > 
> > > It seems to me like maybe pinmux would be a better framework to handle
> > > this kind of use case. The full on/off bit sounds like it's a mux that
> > > selects between GPIO and PWM functionality.
> > > 
> > > Have you thought about supporting pinmux for this?
> > 
> > Adding a full pinmux just for this sounds a bit overkill if you ask me.
> > 
> > How about adding that ->gpio_set() callback in pwm_ops and let the PWM
> > core to export a GPIO chip in that case? That would support also other
> > PWMs having similar full on/off capability without the need to add a new
> > pinmux driver for each.
> 
> I'm reluctant to add this to the PWM core because it's effectively
> duplicating something for which a proper subsystem already exists.

OK, I see.

> If adding pinmux is considered overkill, maybe doing so needs to be
> simplified. Surely if this is applicable to more than one PWM controller
> some helpers could be extracted to make it easier to add.
> 
> But if it isn't generally useful I don't think it makes sense to add it
> to the PWM core either. So I think our choices here are to register via
> pinmux and in the process add helpers to make that easier (remove the
> overkill) or to keep this to the driver until we start seeing a pattern
> emerge.

I would then go for keeping the code in this single driver for now and
re-think this later if other drivers start to develop similar.
