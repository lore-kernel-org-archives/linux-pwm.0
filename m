From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
Date: Mon, 30 Mar 2020 13:21:50 +0200
Message-ID: <CAMpxmJUj7wBvO=Y-u5CXazHhjsPHXcq=5iST4KuLrfakW_a9Mg@mail.gmail.com>
References: <20200317205017.28280-1-michael@walle.cc> <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
 <9c310f2a11913d4d089ef1b07671be00@walle.cc> <CAMpxmJXmD-M+Wbj6=wgFgP2aDxbqDN=ceHi1XDun4iwdLm55Zg@mail.gmail.com>
 <22944c9b62aa69da418de7766b7741bd@walle.cc> <CACRpkdbJ3DBO+W4P0n-CfZ1T3L8d_L0Nizra8frkv92XPXR4WA@mail.gmail.com>
 <4d8d3bc26bdf73eb5c0e5851589fe085@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4d8d3bc26bdf73eb5c0e5851589fe085-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-gpio <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arm-soc <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

pt., 27 mar 2020 o 16:28 Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> napisa=C5=82(a):
>
> Am 2020-03-27 11:20, schrieb Linus Walleij:
> > On Thu, Mar 26, 2020 at 9:06 PM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
> >> Am 2020-03-25 12:50, schrieb Bartosz Golaszewski:
> >
> >> > In that case maybe you should use the disable_locking option in
> >> > regmap_config and provide your own callbacks that you can use in the
> >> > irqchip code too?
> >>
> >> But how would that solve problem (1). And keep in mind, that the
> >> reqmap_irqchip is actually used for the interrupt controller, which
> >> is not this gpio controller.
> >>
> >> Ie. the interrupt controller of the sl28cpld uses the regmap_irqchip
> >> and all interrupt phandles pointing to the interrupt controller will
> >> reference the toplevel node. Any phandles pointing to the gpio
> >> controller will reference the GPIO subnode.
> >
> > Ideally we would create something generic that has been on my
> > mind for some time, like a generic GPIO regmap irqchip now that
> > there are a few controllers like that.
> >
> > I don't know how feasible it is or how much work it would be. But
> > as with GPIO_GENERIC (for MMIO) it would be helpful since we
> > can then implement things like .set_multiple() and .get_multiple()
> > for everyone.
>
> For starters, would that be a drivers/gpio/gpio-regmap.c or a
> drivers/base/regmap/regmap-gpio.c? I would assume the first,
> because the stuff in drivers/base/regmap operates on a given
> regmap and we'd just be using one, correct? On the other hand
> there is also the reqmap-irq.c. But as pointed out before, it
> will add an interrupt controller to the regmap, not a device
> so to speak.
>
> -michael

This has been on my TODO list for so long, but I've never been able to
find the time... I'd really appreciate any effort in that direction as
I believe it would allow us to slowly port a big part of the GPIO
expander drivers over to it and make large portions of our codebase
generic.

Best regards,
Bartosz Golaszewski
