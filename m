From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Sat, 11 Jun 2016 09:08:03 +0200
Message-ID: <20160611090803.42aeaf5f@ipc1.ka-ro>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
	<20160609135125.GA2385@dell>
	<20160610072346.51b0a5d5@ipc1.ka-ro>
	<20160610074449.GB1537@dell>
	<20160610123453.3a8ee14e@ipc1.ka-ro>
	<20160610145449.GA7351@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:61114 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcFKHIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Jun 2016 03:08:19 -0400
In-Reply-To: <20160610145449.GA7351@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

Hi,

On Fri, 10 Jun 2016 15:54:49 +0100 Lee Jones wrote:
> On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > On Fri, 10 Jun 2016 08:44:49 +0100 Lee Jones wrote:
> > > On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > >=20
> > > > Hi,
> > > >=20
> > > > On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
> > > > > On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > > >=20
> > > > > > 'brightness' is usually an index into a table of duty_cycle=
 values,
> > > > > > where the value at index 0 may well be non-zero
> > > > > > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts ar=
e real-life
> > > > > > examples).
> > > > > > Thus brightness =3D=3D 0 does not necessarily mean that the=
 PWM output
> > > > > > will be inactive.
> > > > > > Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=
=3D 0' to decide
> > > > > > whether to disable the PWM.
> > > > > >=20
> > > > > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > > > > ---
> > > > > > Changes wrt. v1:
> > > > > >   - update binding docs to reflect the change
> > > > > >=20
> > > > > >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt  =
       | 9 ++++++---
> > > > > >  drivers/video/backlight/pwm_bl.c                          =
       | 4 ++--
> > > > > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/leds/backlig=
ht/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight=
/pwm-backlight.txt
> > > > > > index 764db86..95fa8a9 100644
> > > > > > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-=
backlight.txt
> > > > > > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-=
backlight.txt
> > > > > > @@ -4,10 +4,13 @@ Required properties:
> > > > > >    - compatible: "pwm-backlight"
> > > > > >    - pwms: OF device-tree PWM specification (see PWM bindin=
g[0])
> > > > > >    - brightness-levels: Array of distinct brightness levels=
=2E Typically these
> > > > > > -      are in the range from 0 to 255, but any range starti=
ng at 0 will do.
> > > > > > +      are in the range from 0 to 255, but any range will d=
o.
> > > > > >        The actual brightness level (PWM duty cycle) will be=
 interpolated
> > > > > > -      from these values. 0 means a 0% duty cycle (darkest/=
off), while the
> > > > > > -      last value in the array represents a 100% duty cycle=
 (brightest).
> > > > > > +      from these values. 0 means a 0% duty cycle, while th=
e highest value in
> > > > > > +      the array represents a 100% duty cycle.
> > > > > > +      The range may be in reverse order (starting with the=
 maximum duty cycle
> > > > > > +      value) to create a PWM signal with the 100% duty cyc=
le representing
> > > > > > +      minimum and 0% duty cycle maximum brigthness.
> > > > > >    - default-brightness-level: the default brightness level=
 (index into the
> > > > > >        array defined by the "brightness-levels" property)
> > > > > >    - power-supply: regulator for supply voltage
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/vid=
eo/backlight/pwm_bl.c
> > > > > > index b2b366b..80b2b52 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(=
struct backlight_device *bl)
> > > > > >  	if (pb->notify)
> > > > > >  		brightness =3D pb->notify(pb->dev, brightness);
> > > > > > =20
> > > > > > -	if (brightness > 0) {
> > > > > > -		duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > > > > +	duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > > > > +	if (duty_cycle > 0) {
> > > > >=20
> > > > > How does this work in the aforementioned:
> > > > >=20
> > > > >   "The range may be in reverse order"
> > > > >=20
> > > > > ... case?  Surely when duty_cycle is when the screen should b=
e at it's
> > > > > brightest?  Wouldn't it confuse the user if they turn their b=
rightness
> > > > > *up* and the screen goes *off*?
> > > > >=20
> > > > Assuming that the PWM output is inactive (LOW) when the duty_cy=
cle is
> > > > set to zero, there will be no difference between operating the =
PWM at
> > > > duty_cycle 0 or disabling it.
> > > >=20
> > > > Currently, the screen will go bright when it should be off in t=
his
> > > > case.
> > >=20
> > > It sounds like we need something that lets the framework know if
> > > duty_cycle =3D MAX is the brightest or if duty_cycle =3D 0 is.  E=
ither way
> > > someone is going to get screwed by this logic.
> > >=20
> > The backlight framework does not (and does not need to) know anythi=
ng
> > about PWM duty cycles. Its 'brightness' values are consistently 0 =3D=
=3D
> > dark, max =3D=3D brightest in either case.
>=20
> What I'm getting at is; by the look of the documentation, the
> brightest setting can either be a duty cycle of 0 or 255.  So what
> happens with your new semantics when the duty cycle of 0 represents
> the brightest setting and you reach 0?  Didn't you just turn the
> backlight off?
>=20
As mentioned earlier, disabling the PWM has generally the same result a=
s
setting the duty cycle to 0. The current behaviour is broken in this
case, since setting brightness to 0 with a non-zero duty_cycle as the
first element of brightness-levels, the PWM will be disabled rather tha=
n
switched to the given duty cycle.
Disabling the PWM should have the same effect as setting the duty cycle
to 0, so it is safe to check for duty_cycle =3D=3D 0 to decide whether =
to
disable the PWM.


Lothar Wa=C3=9Fmann
