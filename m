From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Tue, 20 Jan 2015 10:52:48 +0000
Message-ID: <20150120105248.GB13701@x1>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
 <20150113024256.GH19533@lunn.ch>
 <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
 <20150118100438.GC3574@x1>
 <20150119125905.GE7312@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150119125905.GE7312@ulmo.nvidia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, 19 Jan 2015, Thierry Reding wrote:

> On Sun, Jan 18, 2015 at 10:04:38AM +0000, Lee Jones wrote:
> > On Thu, 15 Jan 2015, Linus Walleij wrote:
> >=20
> > > On Tue, Jan 13, 2015 at 3:42 AM, Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >=20
> > > > So i thought about this some more. What would an MFD based solu=
tion
> > > > look like?
> > > >
> > > > First issue is backwards compatibility. There are currently aro=
und 90
> > > > .dts files using this gpio driver. I could imagine a few of the=
se
> > > > being changed to make use of an MFD based driver to make us of =
the new
> > > > features, but the rest expect backwards compatibility.
> > >=20
> > > Good point.
> > >=20
> > > > I think the only sensible way to achieve this is that the gpio =
driver
> > > > keeps its existing binding.
> > >=20
> > > Yup.
> > >=20
> > > > This does not really describe the hardware. The hardware is mor=
e like:
> > > >
> > > >         gpio: gpio {
> > > >                 compatible =3D "marvell,orion-gpio";
> > > >                 reg =3D <0xd0018100 0x40>;
> > > >                 ngpios =3D <32>;
> > > >                 gio-controller;
> > > >                 #gpio-cells =3D <2>;
> > > >                 interrupt-controller;
> > > >                 #interrupt-cells =3D <2>;
> > > >                 interrupts =3D <16>, <17>, <18>, <19>;
> > > >                 clocks =3D <&coreclk 0>;
> > > >
> > > >                 pwm: pwm {
> > > >                         compatible =3D "marvell,armada-pwm";
> > > >                         reg =3D <0xd00181c0 0x08>;
> > > >                         #pwm-cells =3D <2>;
> > > >                         clocks =3D <&coreclk 0>;
> > > >                 };
> > > >         };
>=20
> I think you technically need an (empty) ranges property in the gpio n=
ode
> so that the address can be properly translated.
>=20
> > > >
> > > > but i don't think MFD supports that sort of structure?
> > >=20
> > > No it would have to be some custom DT code in the GPIO driver
> > > spawning the PWM platform device.
> >=20
> > of_platform_populate()?
>=20
> Huh? I was under the impression that mfd_add_devices() would already
> deal with this situation? Isn't that what's parsed based on the cells
> parameter?

There was talk of this _not_ being an MFD device.  I was providing an
alternative way to get this device registered.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
