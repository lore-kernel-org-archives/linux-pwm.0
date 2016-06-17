From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Fri, 17 Jun 2016 15:17:19 +0100
Message-ID: <20160617141719.GH21702@dell>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
 <20160609135125.GA2385@dell>
 <20160610072346.51b0a5d5@ipc1.ka-ro>
 <20160610074449.GB1537@dell>
 <20160610123453.3a8ee14e@ipc1.ka-ro>
 <20160610145449.GA7351@dell>
 <20160611090803.42aeaf5f@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37161 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbcFQOQo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jun 2016 10:16:44 -0400
Received: by mail-wm0-f45.google.com with SMTP id a66so1679865wme.0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jun 2016 07:16:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160611090803.42aeaf5f@ipc1.ka-ro>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

On Sat, 11 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> On Fri, 10 Jun 2016 15:54:49 +0100 Lee Jones wrote:
> > On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > On Fri, 10 Jun 2016 08:44:49 +0100 Lee Jones wrote:
> > > > On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > >=20
> > > > > Hi,
> > > > >=20
> > > > > On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
> > > > > > On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > > > >=20
> > > > > > > 'brightness' is usually an index into a table of duty_cyc=
le values,
> > > > > > > where the value at index 0 may well be non-zero
> > > > > > > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts =
are real-life
> > > > > > > examples).
> > > > > > > Thus brightness =3D=3D 0 does not necessarily mean that t=
he PWM output
> > > > > > > will be inactive.
> > > > > > > Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=
=3D 0' to decide
> > > > > > > whether to disable the PWM.
> > > > > > >=20
> > > > > > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.d=
e>
> > > > > > > ---
> > > > > > > Changes wrt. v1:
> > > > > > >   - update binding docs to reflect the change
> > > > > > >=20
> > > > > > >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt=
         | 9 ++++++---
> > > > > > >  drivers/video/backlight/pwm_bl.c                        =
         | 4 ++--
> > > > > > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/leds/backl=
ight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlig=
ht/pwm-backlight.txt
> > > > > > > index 764db86..95fa8a9 100644
> > > > > > > --- a/Documentation/devicetree/bindings/leds/backlight/pw=
m-backlight.txt
> > > > > > > +++ b/Documentation/devicetree/bindings/leds/backlight/pw=
m-backlight.txt
> > > > > > > @@ -4,10 +4,13 @@ Required properties:
> > > > > > >    - compatible: "pwm-backlight"
> > > > > > >    - pwms: OF device-tree PWM specification (see PWM bind=
ing[0])
> > > > > > >    - brightness-levels: Array of distinct brightness leve=
ls. Typically these
> > > > > > > -      are in the range from 0 to 255, but any range star=
ting at 0 will do.
> > > > > > > +      are in the range from 0 to 255, but any range will=
 do.
> > > > > > >        The actual brightness level (PWM duty cycle) will =
be interpolated
> > > > > > > -      from these values. 0 means a 0% duty cycle (darkes=
t/off), while the
> > > > > > > -      last value in the array represents a 100% duty cyc=
le (brightest).
> > > > > > > +      from these values. 0 means a 0% duty cycle, while =
the highest value in
> > > > > > > +      the array represents a 100% duty cycle.
> > > > > > > +      The range may be in reverse order (starting with t=
he maximum duty cycle
> > > > > > > +      value) to create a PWM signal with the 100% duty c=
ycle representing
> > > > > > > +      minimum and 0% duty cycle maximum brigthness.
> > > > > > >    - default-brightness-level: the default brightness lev=
el (index into the
> > > > > > >        array defined by the "brightness-levels" property)
> > > > > > >    - power-supply: regulator for supply voltage
> > > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/v=
ideo/backlight/pwm_bl.c
> > > > > > > index b2b366b..80b2b52 100644
> > > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > > @@ -103,8 +103,8 @@ static int pwm_backlight_update_statu=
s(struct backlight_device *bl)
> > > > > > >  	if (pb->notify)
> > > > > > >  		brightness =3D pb->notify(pb->dev, brightness);
> > > > > > > =20
> > > > > > > -	if (brightness > 0) {
> > > > > > > -		duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > > > > > +	duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > > > > > +	if (duty_cycle > 0) {
> > > > > >=20
> > > > > > How does this work in the aforementioned:
> > > > > >=20
> > > > > >   "The range may be in reverse order"
> > > > > >=20
> > > > > > ... case?  Surely when duty_cycle is when the screen should=
 be at it's
> > > > > > brightest?  Wouldn't it confuse the user if they turn their=
 brightness
> > > > > > *up* and the screen goes *off*?
> > > > > >=20
> > > > > Assuming that the PWM output is inactive (LOW) when the duty_=
cycle is
> > > > > set to zero, there will be no difference between operating th=
e PWM at
> > > > > duty_cycle 0 or disabling it.
> > > > >=20
> > > > > Currently, the screen will go bright when it should be off in=
 this
> > > > > case.
> > > >=20
> > > > It sounds like we need something that lets the framework know i=
f
> > > > duty_cycle =3D MAX is the brightest or if duty_cycle =3D 0 is. =
 Either way
> > > > someone is going to get screwed by this logic.
> > > >=20
> > > The backlight framework does not (and does not need to) know anyt=
hing
> > > about PWM duty cycles. Its 'brightness' values are consistently 0=
 =3D=3D
> > > dark, max =3D=3D brightest in either case.
> >=20
> > What I'm getting at is; by the look of the documentation, the
> > brightest setting can either be a duty cycle of 0 or 255.  So what
> > happens with your new semantics when the duty cycle of 0 represents
> > the brightest setting and you reach 0?  Didn't you just turn the
> > backlight off?
> >=20
> As mentioned earlier, disabling the PWM has generally the same result=
 as
> setting the duty cycle to 0. The current behaviour is broken in this
> case, since setting brightness to 0 with a non-zero duty_cycle as the
> first element of brightness-levels, the PWM will be disabled rather t=
han
> switched to the given duty cycle.
> Disabling the PWM should have the same effect as setting the duty cyc=
le
> to 0, so it is safe to check for duty_cycle =3D=3D 0 to decide whethe=
r to
> disable the PWM.

I agree with this. BUT, that's not what you're doing is it?

Look at the code you're trying to write:

duty_cycle =3D compute_duty_cycle(pb, brightness);
if (duty_cycle > 0) {
        pwm_config(pb->pwm, duty_cycle, pb->period);
        pwm_backlight_power_on(pb, brightness);
} else
        pwm_backlight_power_off(pb);

Let's say duty_cycle =3D=3D 0.  In some cases this can mean "turn
brightness up to the *maximum*", but with your new logic you just
turned the backlight *off*.

Conversely, let's say duty_cycle =3D=3D 255.  In some cases this can me=
an
"turn the brightness to the *lowest* setting" i.e. *off*. Well your
logic just turned the backlight *on*.

If there is something I'm missing, you're going to have to find a
better way to explain it to me.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
