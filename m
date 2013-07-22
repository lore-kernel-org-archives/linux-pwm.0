Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: RE: [PATCH 1/3] mfd: add LP3943 MFD driver
Date: Mon, 22 Jul 2013 01:19:18 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E8317C@DQHE06.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E815C3@DQHE06.ent.ti.com>
 <CACRpkdYF=ZDqqoU6Kq4cwgaufUjpQmX+dxUexqcvb=KiqDdBoQ@mail.gmail.com>
In-Reply-To: <CACRpkdYF=ZDqqoU6Kq4cwgaufUjpQmX+dxUexqcvb=KiqDdBoQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

> This needs to be reviewed by the devicetree people.
> Please break out the bindings separately and include
> devicetree@vger.kernel.org on that review.

OK, thanks.
=20
> > +++ b/Documentation/devicetree/bindings/mfd/lp3943.txt
> > @@ -0,0 +1,23 @@
> > +Bindings for TI/National Semiconductor LP3943 Driver
> > +
> > +Required properties:
> > +  - compatible: "ti,lp3943"
> > +  - reg: 7bit I2C slave address. 0x60 ~ 0x67
> > +
> > +Optional properties:
> > +  - ti,pwm0, ti,pwm1: Output channel definition for PWM port 0 and 1
> > +                      0 =3D invalid, 1 =3D LED0, 2 =3D LED 1, ... 16 =
=3D
> > +LED15
> > +
> > +Datasheet
> > +  http://www.ti.com/lit/ds/snvs256b/snvs256b.pdf
> > +
> > +Application note: How to use LP3943 as a GPIO expander and PWM
> > +generator
> > +  http://www.ti.com/lit/an/snva287a/snva287a.pdf
>=20
> Do we usually put these things into bindings?

Actually I want to put this information in the driver document, but
I've not found which part is the best place for the MFD documentation.

> > +Example:
> > +
> > +       lp3943@60 {
> > +               compatible =3D "ti,lp3943";
> > +               reg =3D <0x60>;
> > +               pwm1 =3D /bits/ 8 <2>;    /* use LED1 output as PWM #1 =
*/
> > +       };
>=20
> OK so there is a way to state which lines are used for PWM.
>=20
> I think you should also specify which lines are used for GPIO, and which
> lines are used for LEDs.
>
> And I'd like the masks to be passed to each subdriver, so we can avoid th=
e
> scenario where one and the same line gets used for GPIO, LED and PWM at t=
he
> same time.

Good idea. This is my missing point - I was writing the LP3943 DT is only u=
sed for the definition of the platform data.
Thanks.

Regards,
Milo
