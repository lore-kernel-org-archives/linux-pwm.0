From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Fri, 10 Jun 2016 08:44:49 +0100
Message-ID: <20160610074449.GB1537@dell>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
 <20160609135125.GA2385@dell>
 <20160610072346.51b0a5d5@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35902 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcFJHoO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 03:44:14 -0400
Received: by mail-wm0-f50.google.com with SMTP id n184so255023954wmn.1
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jun 2016 00:44:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160610072346.51b0a5d5@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:

> Hi,
>=20
> On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
> > On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> >=20
> > > 'brightness' is usually an index into a table of duty_cycle value=
s,
> > > where the value at index 0 may well be non-zero
> > > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real=
-life
> > > examples).
> > > Thus brightness =3D=3D 0 does not necessarily mean that the PWM o=
utput
> > > will be inactive.
> > > Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D 0'=
 to decide
> > > whether to disable the PWM.
> > >=20
> > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > ---
> > > Changes wrt. v1:
> > >   - update binding docs to reflect the change
> > >=20
> > >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt        =
 | 9 ++++++---
> > >  drivers/video/backlight/pwm_bl.c                                =
 | 4 ++--
> > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm=
-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-b=
acklight.txt
> > > index 764db86..95fa8a9 100644
> > > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backli=
ght.txt
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backli=
ght.txt
> > > @@ -4,10 +4,13 @@ Required properties:
> > >    - compatible: "pwm-backlight"
> > >    - pwms: OF device-tree PWM specification (see PWM binding[0])
> > >    - brightness-levels: Array of distinct brightness levels. Typi=
cally these
> > > -      are in the range from 0 to 255, but any range starting at =
0 will do.
> > > +      are in the range from 0 to 255, but any range will do.
> > >        The actual brightness level (PWM duty cycle) will be inter=
polated
> > > -      from these values. 0 means a 0% duty cycle (darkest/off), =
while the
> > > -      last value in the array represents a 100% duty cycle (brig=
htest).
> > > +      from these values. 0 means a 0% duty cycle, while the high=
est value in
> > > +      the array represents a 100% duty cycle.
> > > +      The range may be in reverse order (starting with the maxim=
um duty cycle
> > > +      value) to create a PWM signal with the 100% duty cycle rep=
resenting
> > > +      minimum and 0% duty cycle maximum brigthness.
> > >    - default-brightness-level: the default brightness level (inde=
x into the
> > >        array defined by the "brightness-levels" property)
> > >    - power-supply: regulator for supply voltage
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
> > > index b2b366b..80b2b52 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(struct=
 backlight_device *bl)
> > >  	if (pb->notify)
> > >  		brightness =3D pb->notify(pb->dev, brightness);
> > > =20
> > > -	if (brightness > 0) {
> > > -		duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > +	duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > +	if (duty_cycle > 0) {
> >=20
> > How does this work in the aforementioned:
> >=20
> >   "The range may be in reverse order"
> >=20
> > ... case?  Surely when duty_cycle is when the screen should be at i=
t's
> > brightest?  Wouldn't it confuse the user if they turn their brightn=
ess
> > *up* and the screen goes *off*?
> >=20
> Assuming that the PWM output is inactive (LOW) when the duty_cycle is
> set to zero, there will be no difference between operating the PWM at
> duty_cycle 0 or disabling it.
>=20
> Currently, the screen will go bright when it should be off in this
> case.

It sounds like we need something that lets the framework know if
duty_cycle =3D MAX is the brightest or if duty_cycle =3D 0 is.  Either =
way
someone is going to get screwed by this logic.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
