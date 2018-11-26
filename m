From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Mon, 26 Nov 2018 12:51:23 +0100
Message-ID: <20181126115123.GA15164@ulmo>
References: <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
 <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
 <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 03:15:11PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> On 22.11.2018 20:03, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Nov 22, 2018 at 04:46:39PM +0000, Vok=C3=A1=C4=8D Michal wrote:
> >> On 22.11.2018 17:23, Uwe Kleine-K=C3=B6nig wrote:
> >>> On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> >>>> On 16.11.2018 09:25, Uwe Kleine-K=C3=B6nig wrote:
> >>>>> On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Wa=C3=9Fmann wrote:
> >>>>>> No. You can disable the output driver via pinctrl, so that only the
> >>>>>> selected pull-up/down is relevant. The pin function and GPIO regis=
ter
> >>>>>> settings don't matter at all in this case.
> >>>>
> >>>> Lothar, please can you be more specific how would you do that? IFAIK=
 the
> >>>> pull-up/down internal resistors have effect only if the pin is confi=
gured
> >>>> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Output dr=
iver:
> >>>>
> >>>>     "Internal pull-up, pull-down resistors, and pad keeper are disab=
led in
> >>>>      output mode."
> >=20
> > This would mean you'd have to rely on an external pull up for your use
> > case. I wouldn't be surprised however if DSE=3D0 wouldn't count as "out=
put
> > mode". Given the reliability of NXP documentation I wouldn't bet neither
> > on one nor the other possibility.
>=20
> Yeah, the NXP documentation sometimes does not really match reality.
> My use case is based on the fact that I configure the pin as input in
> the driver. Then it works just fine.
>=20
> >>> So I'd expect this to really work on i.MX6 but not the earlier SoCs
> >>> without a gpio specifier.
> >>
> >> Maybe you would expect it to work but I already tested and measured
> >> that weeks ago ;) It did not work.
> >=20
> > Which pin/gpio do we talk about? Which i.MX6 variant did you test this
> > on? (Assuming i.MX6D or i.MX6Q and PAD_DISP0_DATA09, did you try setting
> >=20
> > 	IOMUXC_SW_MUX_CTL_PAD_DISP0_DATA09 (0x020E0194) =3D 0x00000005
> > 	IOMUXC_SW_PAD_CTL_PAD_DISP0_DATA09 (0x020E04A8) =3D 0x0000b080
> >=20
> > and then play with GPIO 4.30 direction and output value?)
>=20
> My test setup is as follows:
> - SoC is i.MX6DL or i.MX6S - I have three board variants in total.
> - Pin used for PWM/GPIO is PAD_GPIO9.
> - The pin is not connected to any circuit. Just a test point.
> - pinctrl setup in DT:
>    - for "pwm":
>      - fsl,pins =3D <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x8>
>      - IOMUXC_SW_MUX_CTL_PAD_GPIO09 =3D 0x00000004
>      - IOMUXC_SW_PAD_CTL_PAD_GPIO09 =3D 0x00000008
>=20
>    - for "gpio":
>     - fsl,pins =3D <MX6QDL_PAD_GPIO_9__GPIO1_IO09 0xb000>
>     - IOMUXC_SW_MUX_CTL_PAD_GPIO09 =3D 0x00000005
>     - IOMUXC_SW_PAD_CTL_PAD_GPIO09 =3D 0x0000b000

Does it help if you additionally set the ODE bit (bit 11) here?

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv73jgACgkQ3SOs138+
s6Eo/hAAiZDZS/s4dgLSQLvuZolBku1IUFAPtT68E1MuS8GLBsO3HsTImJ3/+v9C
QcohCQ4B1ymoOU8x5WcF5kDy928tpvZ7y+u1YG9QUt+jkmZ1tOIUPuSQbjwZsirU
jDJxmLWMZfOuEydNIRM4CPKSyO6l/XD1QMdtV51LkCJLhvCSUv+bFVDwR+EBpXCw
0kBlLPuyjVFmp7Lg2oBIgIY2a56TwgpXJViAWRWxY1ugQaS9qrMj70gxlAjGkY0T
Dz7ZxPTJU7YpggVHF09eO7ReYOFPikSc8hP/2fNIL0O2DbSc04mmbR6sXLY0al5A
opadlDPtRvMli/5ECp0+jneaQStdThmB3DKfFCxG5rNpwb2dlnm//waFahM6Y9cY
Kw+C9AJly3hiG1a2uQnmL5ijaBqyLXPlUAqMr5vtU2CHRNZRiHSmZzASSGObIkcn
4XHYWEkLkxvkxh0Av1Y3vBOX/6+WeZdKWBxNSISDFjG+G74SCKGQpxIRYrLXj+2S
fAUHHZQSvL1RohhEmm9AICTcaQOuJz4aFV+ew4lo82zKhpbS/J7KvCHredi7tzuf
pZI363JxqpalfLZQl7cfzYckbFHSnOb3LaYWiVnKgURt45y9Gd2giHqbrKqGJEmU
SPWgv4bFPRfhnsOb+soBxbZNsOWCUfYPlStImQC+9toyDaIUkM0=
=ImQK
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
