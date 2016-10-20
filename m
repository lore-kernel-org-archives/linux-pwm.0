From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 20 Oct 2016 15:56:11 +0300
Message-ID: <1476968171.3693.24.camel@linux.intel.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
         <20161019185638.GP1722@lahna.fi.intel.com>
         <20161020104541.GA25598@ulmo.ba.sec>
         <20161020111844.GB24289@lahna.fi.intel.com>
         <20161020125144.GA24653@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39136 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932261AbcJTM5o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Oct 2016 08:57:44 -0400
In-Reply-To: <20161020125144.GA24653@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org

On Thu, 2016-10-20 at 14:51 +0200, Thierry Reding wrote:
> On Thu, Oct 20, 2016 at 02:18:44PM +0300, Mika Westerberg wrote:
> > On Thu, Oct 20, 2016 at 12:45:41PM +0200, Thierry Reding wrote:
> > > On Wed, Oct 19, 2016 at 09:56:38PM +0300, Mika Westerberg wrote:
> > > > On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:

> I'm reluctant to add this to the PWM core because it's effectively
> duplicating something for which a proper subsystem already exists.
> 
> If adding pinmux is considered overkill, maybe doing so needs to be
> simplified. Surely if this is applicable to more than one PWM
> controller
> some helpers could be extracted to make it easier to add.
> 
> But if it isn't generally useful I don't think it makes sense to add
> it
> to the PWM core either. So I think our choices here are to register
> via
> pinmux and in the process add helpers to make that easier (remove the
> overkill) or to keep this to the driver until we start seeing a
> pattern
> emerge.

I vote for the latter since we have only one user for that and that one
is not so demonstrative (it is clean GPIO/PWM case, when others might
require GPIO emulation).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
