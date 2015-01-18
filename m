From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Sun, 18 Jan 2015 10:04:38 +0000
Message-ID: <20150118100438.GC3574@x1>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
 <20150113024256.GH19533@lunn.ch>
 <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:55986 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbbARKEp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Jan 2015 05:04:45 -0500
Received: by mail-ig0-f181.google.com with SMTP id r2so9173895igi.2
        for <linux-pwm@vger.kernel.org>; Sun, 18 Jan 2015 02:04:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, 15 Jan 2015, Linus Walleij wrote:

> On Tue, Jan 13, 2015 at 3:42 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > So i thought about this some more. What would an MFD based solution
> > look like?
> >
> > First issue is backwards compatibility. There are currently around =
90
> > .dts files using this gpio driver. I could imagine a few of these
> > being changed to make use of an MFD based driver to make us of the =
new
> > features, but the rest expect backwards compatibility.
>=20
> Good point.
>=20
> > I think the only sensible way to achieve this is that the gpio driv=
er
> > keeps its existing binding.
>=20
> Yup.
>=20
> > This does not really describe the hardware. The hardware is more li=
ke:
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

of_platform_populate()?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
