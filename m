From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Wed, 18 Jan 2017 15:25:33 +0100
Message-ID: <20170118142533.GA17640@archie.localdomain>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
 <20161213155251.28684-2-clemens.gruber@pqgruber.com>
 <20170118105735.GM18989@ulmo.ba.sec>
 <1484737764.2133.193.camel@linux.intel.com>
 <20170118135325.GA2498@archie.localdomain>
 <1484748118.2133.206.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:35525 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdAROZh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2017 09:25:37 -0500
Content-Disposition: inline
In-Reply-To: <1484748118.2133.206.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Jan 18, 2017 at 04:01:58PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-01-18 at 14:53 +0100, Clemens Gruber wrote:
> > Yes, but the period could be different, maybe modified in the
> > bootloader
> > or at a previous boot without hardware reset in between. (We do not
> > send
> > a SWRST to the chip, so the period register could be different)
> 
> It's fragile to rely on some external settings, right? Wouldn't be
> better to leave device in a known state after ->probe()?

Yes, that's what this patch tries to solve by verifying that the
external setting (the prescale register) is set to its hardware default
value of 0x1E (corresponding to a period of 1/200 Hz).
If it is not 0x1E, the driver will reconfigure the prescaler according
to the desired period at the time of the next configuration.

> 
> > Until now, we assumed it is always 1/200 Hz and skipped the lengthy
> > prescale configuration (put chip into sleep mode, set prescaler, go
> > out
> > of sleep mode, udelay for 0.5ms until the oscillator is back up) if
> > the
> > user wants a period of 1/200 Hz.
> > 
> > With this patch, we check if it is in fact set to the hardware
> > default.
> > If not, we set pca->period_ns to 0 which leads to changing the
> > prescaler
> > in the next call to pca9685_pwm_config.
> 
> And this contradicts, for my opinion, to the logic you referred in the
> first paragraph. If you would like to use preset values, you need to
> read and recalculate period correctly.

I don't want to use preset values. I wanted to be sure that we do not
skip the prescaler configuration if the prescale register was modified.
We should only skip it, if it is already at 0x1E.

Thanks,
Clemens
