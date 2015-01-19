From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Mon, 19 Jan 2015 13:59:06 +0100
Message-ID: <20150119125905.GE7312@ulmo.nvidia.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
 <20150113024256.GH19533@lunn.ch>
 <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
 <20150118100438.GC3574@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62353 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbASM7L (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Jan 2015 07:59:11 -0500
Content-Disposition: inline
In-Reply-To: <20150118100438.GC3574@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 10:04:38AM +0000, Lee Jones wrote:
> On Thu, 15 Jan 2015, Linus Walleij wrote:
>=20
> > On Tue, Jan 13, 2015 at 3:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> >=20
> > > So i thought about this some more. What would an MFD based solution
> > > look like?
> > >
> > > First issue is backwards compatibility. There are currently around 90
> > > .dts files using this gpio driver. I could imagine a few of these
> > > being changed to make use of an MFD based driver to make us of the new
> > > features, but the rest expect backwards compatibility.
> >=20
> > Good point.
> >=20
> > > I think the only sensible way to achieve this is that the gpio driver
> > > keeps its existing binding.
> >=20
> > Yup.
> >=20
> > > This does not really describe the hardware. The hardware is more like:
> > >
> > >         gpio: gpio {
> > >                 compatible =3D "marvell,orion-gpio";
> > >                 reg =3D <0xd0018100 0x40>;
> > >                 ngpios =3D <32>;
> > >                 gio-controller;
> > >                 #gpio-cells =3D <2>;
> > >                 interrupt-controller;
> > >                 #interrupt-cells =3D <2>;
> > >                 interrupts =3D <16>, <17>, <18>, <19>;
> > >                 clocks =3D <&coreclk 0>;
> > >
> > >                 pwm: pwm {
> > >                         compatible =3D "marvell,armada-pwm";
> > >                         reg =3D <0xd00181c0 0x08>;
> > >                         #pwm-cells =3D <2>;
> > >                         clocks =3D <&coreclk 0>;
> > >                 };
> > >         };

I think you technically need an (empty) ranges property in the gpio node
so that the address can be properly translated.

> > >
> > > but i don't think MFD supports that sort of structure?
> >=20
> > No it would have to be some custom DT code in the GPIO driver
> > spawning the PWM platform device.
>=20
> of_platform_populate()?

Huh? I was under the impression that mfd_add_devices() would already
deal with this situation? Isn't that what's parsed based on the cells
parameter?

Thierry

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvP+ZAAoJEN0jrNd/PrOhAxoP/iR/ISvOr3AlZkAdb8TbJTNP
Ifta2m3K56uIODJ5FM4avhH9sJKiuRKHc5cO55ZzqbJgXWX0nxDuxQKOgVz+Ew7g
nsDa4QnehPT7ySluO92nGpMPvlkvN/ZafE8QuGvPvKxX7WVLmHb9kiLnZbQDnbIJ
Qi8rLwir4Uahh2jjK1OrnlgN41nhYTC8fVmEOQDSWmubHRrXi3M6aiaOxLVO4+rx
t5YF1gDXDEwFvurkLBVOfLEPb9Aqyz4pu7KEQJIkU2iYRXsQShJixJcZlmrDZoq3
YYbUexNbZxg7yTg3d+dz4dQyIhLi+okd97e26H8g7mq7dgD9Xh7Gh9LGYTQ8Zx+D
N/bvCEbzBDH2bebnN2hl63WCgI5WAqZysmi75dLyS/KR0mj04pc5MYyRIHUdOWU+
BqKzKl1P9TStesHAk4d3Aa2ngKKcKxLoNnzAUnkdxeykFtTAXn+oG62vgCtbZBZN
Itn6r1Pek4KpcbS7nrbCvlRt3BOrX3Pm8NmIi8Bf+oF1O8BaNi/EwC9vjJenqA+O
NvA4COCumWE1OKNSRYrzryUhDp/V9kK0a1DLijsR5ORYmwg/22jBlx5Rfk2ww7TH
w6oeRbOnhNb+AJBETy64KxHXV8a7/e+HYamUw8Ey5W6DFukjTr/XIAbZJoKNStXb
8I300R9/dDHPBEZnZYHd
=7HmQ
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
