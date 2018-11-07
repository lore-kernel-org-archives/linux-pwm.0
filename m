Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:49247 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbeKGTEk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Nov 2018 14:04:40 -0500
Date: Wed, 7 Nov 2018 10:34:56 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <20181107093456.GV24212@piout.net>
References: <52F917CEA1B9C64C94833D53889D478C01AA4F33@dor-sms-xch01.digi.com>
 <20181107092521.a27npxabb5hmzunj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181107092521.a27npxabb5hmzunj@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: MFD with multiple PWM chips
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Palacios, Hector" <Hector.Palacios@digi.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "Perez, Pedro" <Pedro.Perez@digi.com>, "broonie@kernel.org" <broonie@kernel.org>

On 07/11/2018 10:25:21+0100, Uwe Kleine-K=F6nig wrote:
> Hello Hector,
>=20
> On Mon, Nov 05, 2018 at 11:50:12AM +0000, Palacios, Hector wrote:
> > I have an MFD device connected via I2C. This chip has several PWM contr=
ollers, each one containing a number of PWM channels.
> >=20
> > The device tree looks like this:
> >=20
> > &i2c0 {
> > 	mca@63 {
> > 		...
> > 		mca_pwm {
> > 			compatible =3D "digi,mca-pwm";
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <0>;
> >=20
> > 			mca_pwm0: pwm@0 {
> > 				reg =3D <0>;
> > 				pwm-channels =3D <6>;
> > 				#pwm-cells =3D <2>;
> > 			};
> >=20
> > 			mca_pwm1: pwm@1 {
> > 				reg =3D <1>;
> > 				pwm-channels =3D <2>;
> > 				#pwm-cells =3D <2>;
> > 			};
> >=20
> > 			mca_pwm2: pwm@2 {
> > 				reg =3D <2>;
> > 				pwm-channels =3D <2>;
> > 				#pwm-cells =3D <2>;
> > 			};
> > 		};
> >=20
> > Being an MFD driver, the PWM driver is only probed once for the node "p=
wms".
>=20
> not sure how this relates to being an MFD driver, but you can also do
> the following:
>=20
> 	mca_pwm {

I guess you'd need compatible =3D "simple-mfd" here.

> 		#address-cells =3D <2>;
> 		#size-cells =3D <0>;
>=20
> 		mca_pwm00: pwm@00 {
> 			compatible =3D "...";
> 			reg =3D <0 0>;
> 			#pwm-cells =3D <...>;
> 		}
>=20
> 		mca_pwm01: pwm@01 {
> 			compatible =3D "...";
> 			reg =3D <0 1>;
> 			#pwm-cells =3D <...>;
> 		}
>=20
> 		...
>=20
> 		mca_pwm05: pwm@05 {
> 			compatible =3D "...";
> 			reg =3D <0 5>;
> 			#pwm-cells =3D <...>;
> 		}
>=20
> 		mca_pwm05: pwm@10 {
> 			compatible =3D "...";
> 			reg =3D <1 0>;
> 			#pwm-cells =3D <...>;
> 		}
>=20
> 		...
> 	}
>=20
> Best regards and greetings to Spain,
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--=20
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
