From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Mon, 12 Jan 2015 16:07:13 +0100
Message-ID: <20150112150713.GB8094@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50268 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbbALPJP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 Jan 2015 10:09:15 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Mon, Jan 12, 2015 at 03:06:14PM +0100, Linus Walleij wrote:
> On Sat, Jan 10, 2015 at 12:34 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Armada 370/XP devices can 'blink' gpio lines with a configurable on
> > and off period. This can be modelled as a PWM.
> >
> > However, there are only two sets of PWM configuration registers for
> > all the gpio lines. This driver simply allows a single gpio line per
> > gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> > EBUSY.
> >
> > Due to the interleaving of registers it is not simple to separate the
> > PWM driver from the gpio driver. Thus the gpio driver has been
> > extended with a PWM driver.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/gpio/Kconfig          |   5 ++
> >  drivers/gpio/Makefile         |   1 +
> >  drivers/gpio/gpio-mvebu-pwm.c | 202 ++++++++++++++++++++++++++++++++++++++++++
> (...)
> > +++ b/drivers/gpio/gpio-mvebu-pwm.c
> (...)
> > +static const struct pwm_ops mvebu_pwm_ops = {
> > +       .request = mvebu_pwm_request,
> > +       .free = mvebu_pwm_free,
> > +       .config = mvebu_pwm_config,
> > +       .enable = mvebu_pwm_enable,
> > +       .disable = mvebu_pwm_disable,
> > +       .owner = THIS_MODULE,
> > +};
> 
> So the first basic notes:
> 
> - PWM maintainer Thierry Reding has to review and ACK this, and the patch needs
>   to be posted to the linux-pwm mailing list too (check To: line)

Yes, Thierry was in To: and linux-pwm in Cc:

> - Should that driver portion really be in drivers/gpio or rather in drivers/pwm

I also had the same thoughts. What decided it for me is the use of
gpiolib.h.  That file would have to move somewhere under
include/linux, or i find a different way of doing what i'm doing
without using it.
 
> - Why is this not modeled as an MFD spawning a GPIO and a PWM cell,
>   as is custom? (Bringing MFD maintainers into the picture.)
>
> So I am aware that this takes the problem from "quick fix extension to the GPIO
> driver" to "really nasty hairy re-engineering of the whole shebang" but there is
> a lot of precedents in the kernel for splitting up this type of hardware in
> separate drivers under an MFD hub.

Yes, one example would be lp3943, an i2c GPIO and PWM driver.

The nasty hairy re-engineering is one thing that is putting me off.

Another is keeping DT compatibility. Here i'm just adding some
additional optional properties. I've not looked in detail, but i think
it is going to be really hard to add an MFD driver without breaking
the existing DT binding. That is not somewhere i want to go, i'd just
drop this altogether.

Do you know of any other driver with a DT binding which has been
refactored into an MFD? An example to look at would be useful.

Thanks
	Andrew
