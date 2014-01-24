From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/2] PWM: let of_xlate handlers check args count
Date: Fri, 24 Jan 2014 06:42:54 +0100
Message-ID: <20140124064254.0369084d@ipc1.ka-ro>
References: <20140123083714.3c6e86ae@ipc1.ka-ro>
	<1390467898-9216-1-git-send-email-s.hauer@pengutronix.de>
	<1390467898-9216-2-git-send-email-s.hauer@pengutronix.de>
	<20140123115632.6d3f1a58@ipc1.ka-ro>
	<20140123110444.GI16215@pengutronix.de>
	<20140123165349.GY15937@n2100.arm.linux.org.uk>
	<20140123173642.GZ15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:58958 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaAXFoY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2014 00:44:24 -0500
In-Reply-To: <20140123173642.GZ15937@n2100.arm.linux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Landley <rob@landley.net>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi,

Russell King - ARM Linux wrote:
> On Thu, Jan 23, 2014 at 04:53:50PM +0000, Russell King - ARM Linux wr=
ote:
> > On Thu, Jan 23, 2014 at 12:04:44PM +0100, Sascha Hauer wrote:
> > > On Thu, Jan 23, 2014 at 11:56:32AM +0100, Lothar Wa=C3=9Fmann wro=
te:
> > > > Hi,
> > > >=20
> > > > Sascha Hauer wrote:
> > > > > of_pwm_n_cells for the of_xlate handler is stored in struct p=
wm_chip,
> > > > > but it is only ever used by the of_xlate handler itsel. Remov=
e
> > > > > of_pwm_n_cells from struct pwm_chip and let the handler do th=
e argument
> > > > > count checking to simplify the code.
> > > > >=20
> > > > This still does not make the PWM_POLARITY flag in the pwms node
> > > > optional as was the goal because of_parse_phandle_with_args() r=
equires
> > > > at least #pwm-cells arguments in the node.
> > > >=20
> > > > So, with a DT configuration like:
> > > > pwm0: pwm@0 {
> > > > 	#pwm-cells =3D <3>;
> > > > };
> > > > backlight {
> > > > 	pwms =3D <&pwm0 0 100000>;
> > > > };
> > >=20
> > > We misunderstood each other. My goal was to allow the driver to a=
lso
> > > work with old devicetrees which specify #pwm-cells =3D <2>, not t=
o allow
> > > inconsistent devicetrees like the snippet above.
> >=20
> > In which case, the patch I've posted seems to do that job too... I'=
m
> > just about to test out the three-cell version.
>=20
> Okay, this works, but there's a problem with pwm-leds.
>=20
> When the duty cycle is set to zero (when you set the brightness to ze=
ro)
> pwm-leds decides to disable the PWM after configuring it.  This cause=
s
> the PWM output to be driven low, causing the LED to go to maximum
> brightness.
>=20
> So, using the inversion at PWM level doesn't work.
>=20
The problem is that the driver calls pwm_disable() when the duty cycle =
is 0.
This sets the PWM output low independent from the output polarity setti=
ng.

> To make this work correctly, we really need pwm-leds to do the invers=
ion
> rather than setting the inversion bit in hardware.
>=20
The same holds for the pwm-backlight driver.

The easiest fix would be not to call pwm_disable() even for a zero duty
cycle.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
