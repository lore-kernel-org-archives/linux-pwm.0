Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:49774 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeKGTSG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Nov 2018 14:18:06 -0500
Date: Wed, 7 Nov 2018 10:48:18 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <20181107094818.GW24212@piout.net>
References: <52F917CEA1B9C64C94833D53889D478C01AA4F33@dor-sms-xch01.digi.com>
 <20181107092521.a27npxabb5hmzunj@pengutronix.de>
 <6d5cd8a8-07cb-2d6e-16c9-40b4765129de@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6d5cd8a8-07cb-2d6e-16c9-40b4765129de@digi.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: MFD with multiple PWM chips
To: "Palacios, Hector" <Hector.Palacios@digi.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "Perez, Pedro" <Pedro.Perez@digi.com>, "broonie@kernel.org" <broonie@kernel.org>

On 07/11/2018 09:39:16+0000, Palacios, Hector wrote:
> Hi Uwe,
>=20
> On 11/7/18 10:25 AM, Uwe Kleine-K=F6nig wrote:
> > Hello Hector,
> >=20
> > On Mon, Nov 05, 2018 at 11:50:12AM +0000, Palacios, Hector wrote:
> >> I have an MFD device connected via I2C. This chip has several PWM cont=
rollers, each one containing a number of PWM channels.
> >>
> >> The device tree looks like this:
> >>
> >> &i2c0 {
> >> 	mca@63 {
> >> 		...
> >> 		mca_pwm {
> >> 			compatible =3D "digi,mca-pwm";
> >> 			#address-cells =3D <1>;
> >> 			#size-cells =3D <0>;
> >>
> >> 			mca_pwm0: pwm@0 {
> >> 				reg =3D <0>;
> >> 				pwm-channels =3D <6>;
> >> 				#pwm-cells =3D <2>;
> >> 			};
> >>
> >> 			mca_pwm1: pwm@1 {
> >> 				reg =3D <1>;
> >> 				pwm-channels =3D <2>;
> >> 				#pwm-cells =3D <2>;
> >> 			};
> >>
> >> 			mca_pwm2: pwm@2 {
> >> 				reg =3D <2>;
> >> 				pwm-channels =3D <2>;
> >> 				#pwm-cells =3D <2>;
> >> 			};
> >> 		};
> >>
> >> Being an MFD driver, the PWM driver is only probed once for the node "=
pwms".
> >=20
> > not sure how this relates to being an MFD driver, but you can also do
> > the following:
> >=20
> > 	mca_pwm {
> > 		#address-cells =3D <2>;
> > 		#size-cells =3D <0>;
> >=20
> > 		mca_pwm00: pwm@00 {
> > 			compatible =3D "...";
> > 			reg =3D <0 0>;
> > 			#pwm-cells =3D <...>;
> > 		}
> >=20
> > 		mca_pwm01: pwm@01 {
> > 			compatible =3D "...";
> > 			reg =3D <0 1>;
> > 			#pwm-cells =3D <...>;
> > 		}
> >=20
> > 		...
> >=20
> > 		mca_pwm05: pwm@05 {
> > 			compatible =3D "...";
> > 			reg =3D <0 5>;
> > 			#pwm-cells =3D <...>;
> > 		}
> >=20
> > 		mca_pwm05: pwm@10 {
> > 			compatible =3D "...";
> > 			reg =3D <1 0>;
> > 			#pwm-cells =3D <...>;
> > 		}
> >=20
> > 		...
> > 	}
>=20
> Being an MFD driver, I have an entry for each cell/driver the=20
> micro-controller handles: GPIO, watchdog, RTC, PWM:
>=20
> static const struct mfd_cell mca_devs[] =3D {
>          {
>                  .name           =3D MCA_DRVNAME_RTC,
>                  .num_resources  =3D ARRAY_SIZE(mca_rtc_resources),
>                  .resources      =3D mca_rtc_resources,
>                  .of_compatible  =3D "digi,mca-rtc",
>          },
>          {
>                  .name           =3D MCA_DRVNAME_WATCHDOG,
>                  .num_resources  =3D ARRAY_SIZE(mca_watchdog_resources),
>                  .resources      =3D mca_watchdog_resources,
>                  .of_compatible  =3D "digi,mca-watchdog",
>          },
>          {
>                  .name           =3D MCA_DRVNAME_GPIO,
>                  .num_resources  =3D ARRAY_SIZE(mca_gpios_resources),
>                  .resources      =3D mca_gpios_resources,
>                  .of_compatible =3D "digi,mca-gpio",
>          },
> =09
> 	...
>=20
> 	{
>                  .name           =3D MCA_DRVNAME_PWM,
>                  .num_resources  =3D ARRAY_SIZE(mca_pwm_resources),
>                  .resources      =3D mca_pwm_resources,
>                  .of_compatible =3D "digi,mca-gpio",
>          },
> };
>=20
> This means there is only *one probe call* for each entry/cell/driver in=20
> the MFD core driver, no matter how many 'compatible' entries I add on=20
> the DT.
> Having only one probe call, I also only have one 'device' and one=20
> 'of_node' to refer to (the parent of the PWM controllers).
>=20

Yes, Uwe's point was to have one compatible/device/probe per PWM subnode
instead of one for all the PWMs.

--=20
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
