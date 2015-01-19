From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Mon, 19 Jan 2015 14:01:30 +0100
Message-ID: <20150119130128.GF7312@ulmo.nvidia.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
 <20150113024256.GH19533@lunn.ch>
 <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 10:52:51AM +0100, Linus Walleij wrote:
> On Tue, Jan 13, 2015 at 3:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > So i thought about this some more. What would an MFD based solution
> > look like?
> >
> > First issue is backwards compatibility. There are currently around 90
> > .dts files using this gpio driver. I could imagine a few of these
> > being changed to make use of an MFD based driver to make us of the new
> > features, but the rest expect backwards compatibility.
>=20
> Good point.
>=20
> > I think the only sensible way to achieve this is that the gpio driver
> > keeps its existing binding.
>=20
> Yup.
>=20
> > This does not really describe the hardware. The hardware is more like:
> >
> >         gpio: gpio {
> >                 compatible =3D "marvell,orion-gpio";
> >                 reg =3D <0xd0018100 0x40>;
> >                 ngpios =3D <32>;
> >                 gio-controller;
> >                 #gpio-cells =3D <2>;
> >                 interrupt-controller;
> >                 #interrupt-cells =3D <2>;
> >                 interrupts =3D <16>, <17>, <18>, <19>;
> >                 clocks =3D <&coreclk 0>;
> >
> >                 pwm: pwm {
> >                         compatible =3D "marvell,armada-pwm";
> >                         reg =3D <0xd00181c0 0x08>;
> >                         #pwm-cells =3D <2>;
> >                         clocks =3D <&coreclk 0>;
> >                 };
> >         };
> >
> > but i don't think MFD supports that sort of structure?
>=20
> No it would have to be some custom DT code in the GPIO driver
> spawning the PWM platform device.
>=20
> I think it's better if we either go with the first solution of a combined
> GPIO+PWM node (it's also elegant in a way, and perfectly
> OK with device tree I think) but I want the PWM maintainer to
> say if it's OK to have a PWM driver inside a GPIO driver.

I'm fine with that, too. I'd request an update to MAINTAINERS so that at
least linux-pwm@vger.kernel.org gets included on patches against the
driver.

That said, the above DT description would lend itself nicely to MFD in
my opinion.

Thierry

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvQAoAAoJEN0jrNd/PrOhdoMP/3VPkZu9ke/osb8roz/GfPLv
qHy4tXVTbhUJRUexs9TUADGaSc/V+reQABwnktmk8YyueCxvt6QSLbHzGRSyhd9N
j9CkoMBrhwWrp55aa00qToTwxOPN3wbkPGx0ZM2YdK1Bttxo+euwud7a+RyNI6GK
dqg6TL7QwYx7S0LSVXWmOOqUcWFUIuvacpHo2V8CeB9rIoS8wYoPp6cSOL/UnCPg
VoUT1S7DPMwnC4R6OFblgW19KkDqloczJB6ifHW9k+2Z1bUos6M1F8FO93fxZkNG
noRR04fAVBXt6mV9sfk1gHijBbEFCcH3VkbFhMbp6R2Q6bWSzanBRSIxfva3Gr8a
cZarlLdzG8re87ckR0Fudav9tGEv+5K9wSV8Zqp93dLcb4brBPwHaueycZoGKYpe
Hk4aKLNU/Eh1ToHoEr/IKES6oOC0/uiYMUlUYgJMhjPqxgay1eAEuFSYIoCyoJ+R
T1mMBrDexrFSn9hoMogeToofch8jRYCfZo9Ko2btsVoZr4qa6Es2B6xszQJGMC7g
7u+Qcnz4SLaPZsi0+3ALpNToge39U6TTd63gCbdd1itrl4DJ48A8LTKQsaBakQy2
2xk9VIK3E1W5zQGfppA0JPA7IqTTiqYzfvLsWTHFI+zn55/vvEXLbFabPyWWwnz7
gr3ShNRXmpT0Ck6yDxA0
=XTN2
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
