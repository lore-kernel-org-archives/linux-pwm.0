Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeKHBaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Nov 2018 20:30:30 -0500
Date: Wed, 7 Nov 2018 16:59:30 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20181107155930.yvutgfgzbu2ugn3j@pengutronix.de>
References: <52F917CEA1B9C64C94833D53889D478C01AA4F33@dor-sms-xch01.digi.com>
 <20181107092521.a27npxabb5hmzunj@pengutronix.de>
 <6d5cd8a8-07cb-2d6e-16c9-40b4765129de@digi.com>
 <20181107094818.GW24212@piout.net>
 <d9f995da-0db2-7640-9a9c-6494db23d0a8@digi.com>
 <20181107154930.GB7155@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181107154930.GB7155@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: MFD with multiple PWM chips
To: Thierry Reding <thierry.reding@gmail.com>, "Palacios, Hector" <Hector.Palacios@digi.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "Perez, Pedro" <Pedro.Perez@digi.com>, "broonie@kernel.org" <broonie@kernel.org>

Hello,

On Wed, Nov 07, 2018 at 04:49:30PM +0100, Thierry Reding wrote:
> On Wed, Nov 07, 2018 at 11:41:42AM +0000, Palacios, Hector wrote:
> > The trick is, in the regulators framework, there is a 'regulator_config=
'=20
> > struct that has an of_node field which the driver sets to each regulato=
r=20
> > node in the DT. That doesn't exist on the PWM framework.
>=20
> It should be fairly easy to implement that manually, though. All of the
> necessary helpers exist (da9063 uses them, though perhaps hidden in the
> regulator helpers).
>=20
> With the PWM framework you can't attach a PWM chip to just a struct
> device_node, so you'll have to have a full struct device for it. The
> easiest way to make this work would probably be to have an MFD driver
> that dynamically registers subdevices based on the nodes it finds in
> device tree. Then a PWM driver could bind against each of these devices
> and set pwm_chip.dev to point to the platform device's ->dev field. You
> can probably automate most of that using of_platform_populate(), which
> may already work automatically if you set the compatible string of the
> top-level node to "simple-bus".

I think technically there is no difference between "simple-bus" and
"simple-mfd" (that Alexandre already suggested). Semantically the latter
is probably the better.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
