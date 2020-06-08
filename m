From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Mon, 8 Jun 2020 09:28:27 +0100
Message-ID: <20200608082827.GB3567@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dc052a5c77171014ecc465b1da8b7ef8-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz@kernel.>
List-Id: linux-pwm@vger.kernel.org

Rob, something for you below.

On Sat, 06 Jun 2020, Michael Walle wrote:
> Am 2020-06-06 13:46, schrieb Mark Brown:
> > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > 
> > > > I have no idea what you are thinking of when you say "simple-regmap" so
> > > > it is difficult to comment.
> > 
> > > I guess, Lee is suggesting to be able to create a regmap instance via
> > > device tree (and populate its child nodes?). Like
> > >   compatible = "syscon", "simple-mfd";
> > > but for any regmap, not just MMIO.

Bingo!

> > I don't understand why this would be anything separate to
> > simple-mfd.
> 
> Don't just simple-mfd tells the of core, to probe the children this
> node? Where does the regmap then come from?

Right.  I'm suggesting a means to extrapolate complex shared and
sometimes intertwined batches of register sets to be consumed by
multiple (sub-)devices spanning different subsystems.

Actually scrap that.  The most common case I see is a single Regmap
covering all child-devices.  It would be great if there was a way in
which we could make an assumption that the entire register address
space for a 'tagged' (MFD) device is to be shared (via Regmap) between
each of the devices described by its child-nodes.  Probably by picking
up on the 'simple-mfd' compatible string in the first instance.

Rob, is the above something you would contemplate?

Michael, do your register addresses overlap i.e. are they intermingled
with one another?  Do multiple child devices need access to the same
registers i.e. are they shared?

> > > But, there is more in my driver:
> > >  (1) there is a version check

If we can rid the Regmap dependency, then creating an entire driver to
conduct a version check is unjustifiable.  This could become an inline
function which is called by each of the sub-devices instead, for
example.

> > >  (2) there is another function for which there is no suitable linux
> > >      subsystem I'm aware of and thus which I'd like to us sysfs
> > >      attributes for: This controller supports 16 non-volatile
> > >      configuration bits. (this is still TBD)

There is a place for everything in Linux.

What do these bits configure?

> > TBH I'd also say that the enumeration of the subdevices for this
> > device should be in the device rather than the DT, they don't
> > seem to be things that exist outside of this one device.
> 
> We're going circles here, formerly they were enumerated in the MFD.
> Yes, they are devices which aren't likely be used outside a
> "sl28cpld", but there might there might be other versions of the
> sl28cpld with other components on different base addresses. I
> don't care if they are enumerated in DT or MFD, actually, I'd
> prefer the latter. _But_ I would like to have the device tree
> properties for its subdevices, e.g. the ones for the watchdog or
> whatever components there might be in the future.

[...]

> MFD core can
> match a device tree node today; but only one per unique compatible
> string. So what should I use to differentiate the different
> subdevices?

Right.  I have been aware of this issue.  The only suitable solution
to this would be to match on 'reg'.

FYI: I plan to fix this.

If your register map needs to change, then I suggest that this is
either a new device or at least a different version of the device and
would also have to be represented as different (sub-)mfd_cell.

> Rob suggested the internal offset, which I did here.

FWIW, I don't like this idea.  DTs should not have to be modified
(either in the first instance or subsequently) or specifically
designed to patch inadequacies in any given OS.

> But then, there is less use in duplicating the offsets in the MFD
> just to have the MFD enumerate the subdevices and then match
> the device tree nodes against it. I can just use
> of_platform_populate() to enumerate the children and I won't
> have to duplicate the base addresses.

Which is fine.  However this causes a different issue for you.  By
stripping out the MFD code you render the MFD portion seemingly
superfluous.  Another issue driver authors commonly contend with.

> So here we are, any ideas appreciated.

Working on it!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
