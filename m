From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 9 Jun 2020 07:47:35 +0100
Message-ID: <20200609064735.GH4106@dell>
References: <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <32231f26f7028d62aeda8fdb3364faf1-QKn5cuLxLXY@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ranjani Sridharan <ranjani.sridharan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, david.m.ertman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shiraz.saleem-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe
List-Id: linux-pwm@vger.kernel.org

On Mon, 08 Jun 2020, Michael Walle wrote:

> Am 2020-06-08 20:56, schrieb Lee Jones:
> > On Mon, 08 Jun 2020, Michael Walle wrote:
> > 
> > > Am 2020-06-08 12:02, schrieb Andy Shevchenko:
> > > > +Cc: some Intel people WRT our internal discussion about similar
> > > > problem and solutions.
> > > >
> > > > On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > > > > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > > > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > > >
> > > > ...
> > > >
> > > > > Right.  I'm suggesting a means to extrapolate complex shared and
> > > > > sometimes intertwined batches of register sets to be consumed by
> > > > > multiple (sub-)devices spanning different subsystems.
> > > > >
> > > > > Actually scrap that.  The most common case I see is a single Regmap
> > > > > covering all child-devices.
> > > >
> > > > Yes, because often we need a synchronization across the entire address
> > > > space of the (parent) device in question.
> > > >
> > > > >  It would be great if there was a way in
> > > > > which we could make an assumption that the entire register address
> > > > > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > > > > each of the devices described by its child-nodes.  Probably by picking
> > > > > up on the 'simple-mfd' compatible string in the first instance.
> > > > >
> > > > > Rob, is the above something you would contemplate?
> > > > >
> > > > > Michael, do your register addresses overlap i.e. are they intermingled
> > > > > with one another?  Do multiple child devices need access to the same
> > > > > registers i.e. are they shared?
> > > 
> > > No they don't overlap, expect for maybe the version register, which is
> > > just there once and not per function block.
> > 
> > Then what's stopping you having each device Regmap their own space?
> 
> Because its just one I2C device, AFAIK thats not possible, right?

Not sure what (if any) the restrictions are.

I can't think of any reasons why not, off the top of my head.

Does Regmap only deal with shared accesses from multiple devices
accessing a single register map, or can it also handle multiple
devices communicating over a single I2C channel?

One for Mark perhaps.

> > The issues I wish to resolve using 'simple-mfd' are when sub-devices
> > register maps overlap and intertwine.

[...]

> > > > > What do these bits configure?
> > > 
> > > - hardware strappings which have to be there before the board powers
> > > up,
> > >   like clocking mode for different SerDes settings
> > > - "keep-in-reset" bits for onboard peripherals if you want to save
> > > power
> > > - disable watchdog bits (there is a watchdog which is active right
> > > from
> > >   the start and supervises the bootloader start and switches to
> > > failsafe
> > >   mode if it wasn't successfully started)
> > > - special boot modes, like eMMC, etc.
> > > 
> > > Think of it as a 16bit configuration word.
> > 
> > And you wish for users to be able to view these at run-time?
> 
> And esp. change them.
> 
> > Can they adapt any of them on-the-fly or will the be RO?
> 
> They are R/W but only will only affect the board behavior after a reset.

I see.  Makes sense.  This is board controller territory.  Perhaps
suitable for inclusion into drivers/soc or drivers/platform.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
