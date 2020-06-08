From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
Date: Mon, 8 Jun 2020 13:02:21 +0300
Message-ID: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell> <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc> <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc> <20200608082827.GB3567@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgFHKCe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 06:02:34 -0400
In-Reply-To: <20200608082827.GB3567@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, david.m.ertman@intel.com, shiraz.saleem@intel.com
Cc: Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>

+Cc: some Intel people WRT our internal discussion about similar
problem and solutions.

On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 06 Jun 2020, Michael Walle wrote:
> > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > Am 2020-06-05 12:50, schrieb Mark Brown:

...

> Right.  I'm suggesting a means to extrapolate complex shared and
> sometimes intertwined batches of register sets to be consumed by
> multiple (sub-)devices spanning different subsystems.
>
> Actually scrap that.  The most common case I see is a single Regmap
> covering all child-devices.

Yes, because often we need a synchronization across the entire address
space of the (parent) device in question.

>  It would be great if there was a way in
> which we could make an assumption that the entire register address
> space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> each of the devices described by its child-nodes.  Probably by picking
> up on the 'simple-mfd' compatible string in the first instance.
>
> Rob, is the above something you would contemplate?
>
> Michael, do your register addresses overlap i.e. are they intermingled
> with one another?  Do multiple child devices need access to the same
> registers i.e. are they shared?
>
> > > > But, there is more in my driver:
> > > >  (1) there is a version check
>
> If we can rid the Regmap dependency, then creating an entire driver to
> conduct a version check is unjustifiable.  This could become an inline
> function which is called by each of the sub-devices instead, for
> example.
>
> > > >  (2) there is another function for which there is no suitable linux
> > > >      subsystem I'm aware of and thus which I'd like to us sysfs
> > > >      attributes for: This controller supports 16 non-volatile
> > > >      configuration bits. (this is still TBD)
>
> There is a place for everything in Linux.
>
> What do these bits configure?
>
> > > TBH I'd also say that the enumeration of the subdevices for this
> > > device should be in the device rather than the DT, they don't
> > > seem to be things that exist outside of this one device.
> >
> > We're going circles here, formerly they were enumerated in the MFD.
> > Yes, they are devices which aren't likely be used outside a
> > "sl28cpld", but there might there might be other versions of the
> > sl28cpld with other components on different base addresses. I
> > don't care if they are enumerated in DT or MFD, actually, I'd
> > prefer the latter. _But_ I would like to have the device tree
> > properties for its subdevices, e.g. the ones for the watchdog or
> > whatever components there might be in the future.
>
> [...]
>
> > MFD core can
> > match a device tree node today; but only one per unique compatible
> > string. So what should I use to differentiate the different
> > subdevices?
>
> Right.  I have been aware of this issue.  The only suitable solution
> to this would be to match on 'reg'.
>
> FYI: I plan to fix this.
>
> If your register map needs to change, then I suggest that this is
> either a new device or at least a different version of the device and
> would also have to be represented as different (sub-)mfd_cell.
>
> > Rob suggested the internal offset, which I did here.
>
> FWIW, I don't like this idea.  DTs should not have to be modified
> (either in the first instance or subsequently) or specifically
> designed to patch inadequacies in any given OS.
>
> > But then, there is less use in duplicating the offsets in the MFD
> > just to have the MFD enumerate the subdevices and then match
> > the device tree nodes against it. I can just use
> > of_platform_populate() to enumerate the children and I won't
> > have to duplicate the base addresses.
>
> Which is fine.  However this causes a different issue for you.  By
> stripping out the MFD code you render the MFD portion seemingly
> superfluous.  Another issue driver authors commonly contend with.

-- 
With Best Regards,
Andy Shevchenko
