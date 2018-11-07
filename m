Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32870 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHBU3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Nov 2018 20:20:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so10762415edr.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 Nov 2018 07:49:32 -0800 (PST)
Date: Wed, 7 Nov 2018 16:49:30 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181107154930.GB7155@ulmo>
References: <52F917CEA1B9C64C94833D53889D478C01AA4F33@dor-sms-xch01.digi.com>
 <20181107092521.a27npxabb5hmzunj@pengutronix.de>
 <6d5cd8a8-07cb-2d6e-16c9-40b4765129de@digi.com>
 <20181107094818.GW24212@piout.net>
 <d9f995da-0db2-7640-9a9c-6494db23d0a8@digi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <d9f995da-0db2-7640-9a9c-6494db23d0a8@digi.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: MFD with multiple PWM chips
To: "Palacios, Hector" <Hector.Palacios@digi.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "Perez, Pedro" <Pedro.Perez@digi.com>, "broonie@kernel.org" <broonie@kernel.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 11:41:42AM +0000, Palacios, Hector wrote:
> On 11/7/18 10:48 AM, Alexandre Belloni wrote:
> > On 07/11/2018 09:39:16+0000, Palacios, Hector wrote:
> >> Hi Uwe,
> >>
> >> On 11/7/18 10:25 AM, Uwe Kleine-K=C3=B6nig wrote:
> >>> Hello Hector,
> >>>
> >>> On Mon, Nov 05, 2018 at 11:50:12AM +0000, Palacios, Hector wrote:
> >>>> I have an MFD device connected via I2C. This chip has several PWM co=
ntrollers, each one containing a number of PWM channels.
> >>>>
> >>>> The device tree looks like this:
> >>>>
> >>>> &i2c0 {
> >>>> 	mca@63 {
> >>>> 		...
> >>>> 		mca_pwm {
> >>>> 			compatible =3D "digi,mca-pwm";
> >>>> 			#address-cells =3D <1>;
> >>>> 			#size-cells =3D <0>;
> >>>>
> >>>> 			mca_pwm0: pwm@0 {
> >>>> 				reg =3D <0>;
> >>>> 				pwm-channels =3D <6>;
> >>>> 				#pwm-cells =3D <2>;
> >>>> 			};
> >>>>
> >>>> 			mca_pwm1: pwm@1 {
> >>>> 				reg =3D <1>;
> >>>> 				pwm-channels =3D <2>;
> >>>> 				#pwm-cells =3D <2>;
> >>>> 			};
> >>>>
> >>>> 			mca_pwm2: pwm@2 {
> >>>> 				reg =3D <2>;
> >>>> 				pwm-channels =3D <2>;
> >>>> 				#pwm-cells =3D <2>;
> >>>> 			};
> >>>> 		};
> >>>>
> >>>> Being an MFD driver, the PWM driver is only probed once for the node=
 "pwms".
> >>>
> >>> not sure how this relates to being an MFD driver, but you can also do
> >>> the following:
> >>>
> >>> 	mca_pwm {
> >>> 		#address-cells =3D <2>;
> >>> 		#size-cells =3D <0>;
> >>>
> >>> 		mca_pwm00: pwm@00 {
> >>> 			compatible =3D "...";
> >>> 			reg =3D <0 0>;
> >>> 			#pwm-cells =3D <...>;
> >>> 		}
> >>>
> >>> 		mca_pwm01: pwm@01 {
> >>> 			compatible =3D "...";
> >>> 			reg =3D <0 1>;
> >>> 			#pwm-cells =3D <...>;
> >>> 		}
> >>>
> >>> 		...
> >>>
> >>> 		mca_pwm05: pwm@05 {
> >>> 			compatible =3D "...";
> >>> 			reg =3D <0 5>;
> >>> 			#pwm-cells =3D <...>;
> >>> 		}
> >>>
> >>> 		mca_pwm05: pwm@10 {
> >>> 			compatible =3D "...";
> >>> 			reg =3D <1 0>;
> >>> 			#pwm-cells =3D <...>;
> >>> 		}
> >>>
> >>> 		...
> >>> 	}
> >>
> >> Being an MFD driver, I have an entry for each cell/driver the
> >> micro-controller handles: GPIO, watchdog, RTC, PWM:
> >>
> >> static const struct mfd_cell mca_devs[] =3D {
> >>           {
> >>                   .name           =3D MCA_DRVNAME_RTC,
> >>                   .num_resources  =3D ARRAY_SIZE(mca_rtc_resources),
> >>                   .resources      =3D mca_rtc_resources,
> >>                   .of_compatible  =3D "digi,mca-rtc",
> >>           },
> >>           {
> >>                   .name           =3D MCA_DRVNAME_WATCHDOG,
> >>                   .num_resources  =3D ARRAY_SIZE(mca_watchdog_resource=
s),
> >>                   .resources      =3D mca_watchdog_resources,
> >>                   .of_compatible  =3D "digi,mca-watchdog",
> >>           },
> >>           {
> >>                   .name           =3D MCA_DRVNAME_GPIO,
> >>                   .num_resources  =3D ARRAY_SIZE(mca_gpios_resources),
> >>                   .resources      =3D mca_gpios_resources,
> >>                   .of_compatible =3D "digi,mca-gpio",
> >>           },
> >> =09
> >> 	...
> >>
> >> 	{
> >>                   .name           =3D MCA_DRVNAME_PWM,
> >>                   .num_resources  =3D ARRAY_SIZE(mca_pwm_resources),
> >>                   .resources      =3D mca_pwm_resources,
> >>                   .of_compatible =3D "digi,mca-gpio",
> >>           },
> >> };
> >>
> >> This means there is only *one probe call* for each entry/cell/driver in
> >> the MFD core driver, no matter how many 'compatible' entries I add on
> >> the DT.
> >> Having only one probe call, I also only have one 'device' and one
> >> 'of_node' to refer to (the parent of the PWM controllers).
> >>
> >=20
> > Yes, Uwe's point was to have one compatible/device/probe per PWM subnode
> > instead of one for all the PWMs.
>=20
> Maybe I'm missing something but wouldn't I then need to add mfd_cells=20
> for every PWM device to my MFD core driver?
> I had already tried Uwe's approach before he mentioned it but then=20
> realized that the MFD I2C driver was really only calling probe once per=
=20
> each mfd_cell.
>=20
> I need something like the PMIC DA9063 with its regulators. The MFD core=
=20
> driver only has once cell for the regulators:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/mfd/da9063-core.c#n79
>=20
> but it has multiple regulators defined in the DTS:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/imx6q-ba16.dtsi#n202
> Although none of them has a 'compatible' string, they can all be=20
> referenced by other nodes in the DT and be handled separately.
>=20
> The regulator driver probe is only called once (as per the unique cell=20
> in the MFD driver) and the DT is parsed to get and register each=20
> regulator in a loop:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/regulator/da9063-regulator.c#n853
>=20
> The trick is, in the regulators framework, there is a 'regulator_config'=
=20
> struct that has an of_node field which the driver sets to each regulator=
=20
> node in the DT. That doesn't exist on the PWM framework.

It should be fairly easy to implement that manually, though. All of the
necessary helpers exist (da9063 uses them, though perhaps hidden in the
regulator helpers).

With the PWM framework you can't attach a PWM chip to just a struct
device_node, so you'll have to have a full struct device for it. The
easiest way to make this work would probably be to have an MFD driver
that dynamically registers subdevices based on the nodes it finds in
device tree. Then a PWM driver could bind against each of these devices
and set pwm_chip.dev to point to the platform device's ->dev field. You
can probably automate most of that using of_platform_populate(), which
may already work automatically if you set the compatible string of the
top-level node to "simple-bus".

Thierry

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvjCYcACgkQ3SOs138+
s6FuuA/9Fq7yqg4bixbjKX51H66cLgyEVEhbtlwQaAvw0BtxhuY4GwmmvkzVGDMT
4N6RkT7KtlzZ4m3gz8jDoaB+yf1tuOMPnyK/NDsbAqvAd1qagJ1IGQjeizkpvnnP
bFHOb+lh4KWy+akecGlSRUM3V/uclkUuExTp9BugdCajX8tt3Rn9T5KKGzby5Yho
7GNFgyRnUDms31FbR1EB8yRhXGDoLofcMhdWFoy1KZcQKEtxhsirHX4pQI6CPlrn
STN0q9Y55nQiByTX9OEazlfTT1LNPFjb7O6XBktnOXy4IcgHNcj1+7SylNIG8ZWc
l+U1kkPvH91VOg8fsPZGfb+FFaifrKSkdlytaKglk+8ESEZISfFyYMALq199/HTT
kibVKo3/KNJ9SkCr3jwQMOn2hs3sjkSOxmeDmCNuSQ4Gk2U8FWyH771s5tgfkJPH
jJS9srMHYFdj1GuXq9PIpTLwSEhkb+82XpCEwGEcbRM0eZuQgIQPx2rJg+DQ9fOW
8f3lh8x8ZzzIG5iWK96vhWoFNPaUfRaiCXy360LLkZ/GnWVxKI05EDu7aKIKRYp7
u9FNpR/R+/0Qp7uiftRjOxL7T9PtD1adm0AKU3hCbmCVooyMzed2bHu98oDHWF4/
hz3qU/7CKv3bbdMYXT0m5Rt5u6+Jd/brALSBYDx72qKqYj+Nbpg=
=RaaK
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
