From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Mon, 20 Jun 2016 08:21:18 +0200
Message-ID: <20160620082118.10a639d5@ipc1.ka-ro>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
	<20160609135125.GA2385@dell>
	<20160610072346.51b0a5d5@ipc1.ka-ro>
	<20160610074449.GB1537@dell>
	<20160610123453.3a8ee14e@ipc1.ka-ro>
	<20160610145449.GA7351@dell>
	<20160611090803.42aeaf5f@ipc1.ka-ro>
	<20160617141719.GH21702@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51365 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbcFTGWP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jun 2016 02:22:15 -0400
In-Reply-To: <20160617141719.GH21702@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

Hi,

On Fri, 17 Jun 2016 15:17:19 +0100 Lee Jones wrote:
> On Sat, 11 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > On Fri, 10 Jun 2016 15:54:49 +0100 Lee Jones wrote:
> > > On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > > On Fri, 10 Jun 2016 08:44:49 +0100 Lee Jones wrote:
> > > > > On Fri, 10 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
> > > > > > > On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:
> > > > > > >=20
> > > > > > > > 'brightness' is usually an index into a table of duty_c=
ycle values,
> > > > > > > > where the value at index 0 may well be non-zero
> > > > > > > > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dt=
s are real-life
> > > > > > > > examples).
> > > > > > > > Thus brightness =3D=3D 0 does not necessarily mean that=
 the PWM output
> > > > > > > > will be inactive.
> > > > > > > > Check for 'duty_cycle =3D=3D 0' rather than 'brightness=
 =3D=3D 0' to decide
> > > > > > > > whether to disable the PWM.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics=
=2Ede>
> > > > > > > > ---
> > > > > > > > Changes wrt. v1:
> > > > > > > >   - update binding docs to reflect the change
> > > > > > > >=20
> > > > > > > >  .../devicetree/bindings/leds/backlight/pwm-backlight.t=
xt         | 9 ++++++---
> > > > > > > >  drivers/video/backlight/pwm_bl.c                      =
           | 4 ++--
> > > > > > > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/Documentation/devicetree/bindings/leds/bac=
klight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backl=
ight/pwm-backlight.txt
> > > > > > > > index 764db86..95fa8a9 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/leds/backlight/=
pwm-backlight.txt
> > > > > > > > +++ b/Documentation/devicetree/bindings/leds/backlight/=
pwm-backlight.txt
> > > > > > > > @@ -4,10 +4,13 @@ Required properties:
> > > > > > > >    - compatible: "pwm-backlight"
> > > > > > > >    - pwms: OF device-tree PWM specification (see PWM bi=
nding[0])
> > > > > > > >    - brightness-levels: Array of distinct brightness le=
vels. Typically these
> > > > > > > > -      are in the range from 0 to 255, but any range st=
arting at 0 will do.
> > > > > > > > +      are in the range from 0 to 255, but any range wi=
ll do.
> > > > > > > >        The actual brightness level (PWM duty cycle) wil=
l be interpolated
> > > > > > > > -      from these values. 0 means a 0% duty cycle (dark=
est/off), while the
> > > > > > > > -      last value in the array represents a 100% duty c=
ycle (brightest).
> > > > > > > > +      from these values. 0 means a 0% duty cycle, whil=
e the highest value in
> > > > > > > > +      the array represents a 100% duty cycle.
> > > > > > > > +      The range may be in reverse order (starting with=
 the maximum duty cycle
> > > > > > > > +      value) to create a PWM signal with the 100% duty=
 cycle representing
> > > > > > > > +      minimum and 0% duty cycle maximum brigthness.
> > > > > > > >    - default-brightness-level: the default brightness l=
evel (index into the
> > > > > > > >        array defined by the "brightness-levels" propert=
y)
> > > > > > > >    - power-supply: regulator for supply voltage
> > > > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers=
/video/backlight/pwm_bl.c
> > > > > > > > index b2b366b..80b2b52 100644
> > > > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > > > @@ -103,8 +103,8 @@ static int pwm_backlight_update_sta=
tus(struct backlight_device *bl)
> > > > > > > >  	if (pb->notify)
> > > > > > > >  		brightness =3D pb->notify(pb->dev, brightness);
> > > > > > > > =20
> > > > > > > > -	if (brightness > 0) {
> > > > > > > > -		duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > > > > > > +	duty_cycle =3D compute_duty_cycle(pb, brightness);
> > > > > > > > +	if (duty_cycle > 0) {
> > > > > > >=20
> > > > > > > How does this work in the aforementioned:
> > > > > > >=20
> > > > > > >   "The range may be in reverse order"
> > > > > > >=20
> > > > > > > ... case?  Surely when duty_cycle is when the screen shou=
ld be at it's
> > > > > > > brightest?  Wouldn't it confuse the user if they turn the=
ir brightness
> > > > > > > *up* and the screen goes *off*?
> > > > > > >=20
> > > > > > Assuming that the PWM output is inactive (LOW) when the dut=
y_cycle is
> > > > > > set to zero, there will be no difference between operating =
the PWM at
> > > > > > duty_cycle 0 or disabling it.
> > > > > >=20
> > > > > > Currently, the screen will go bright when it should be off =
in this
> > > > > > case.
> > > > >=20
> > > > > It sounds like we need something that lets the framework know=
 if
> > > > > duty_cycle =3D MAX is the brightest or if duty_cycle =3D 0 is=
=2E  Either way
> > > > > someone is going to get screwed by this logic.
> > > > >=20
> > > > The backlight framework does not (and does not need to) know an=
ything
> > > > about PWM duty cycles. Its 'brightness' values are consistently=
 0 =3D=3D
> > > > dark, max =3D=3D brightest in either case.
> > >=20
> > > What I'm getting at is; by the look of the documentation, the
> > > brightest setting can either be a duty cycle of 0 or 255.  So wha=
t
> > > happens with your new semantics when the duty cycle of 0 represen=
ts
> > > the brightest setting and you reach 0?  Didn't you just turn the
> > > backlight off?
> > >=20
> > As mentioned earlier, disabling the PWM has generally the same resu=
lt as
> > setting the duty cycle to 0. The current behaviour is broken in thi=
s
> > case, since setting brightness to 0 with a non-zero duty_cycle as t=
he
> > first element of brightness-levels, the PWM will be disabled rather=
 than
> > switched to the given duty cycle.
> > Disabling the PWM should have the same effect as setting the duty c=
ycle
> > to 0, so it is safe to check for duty_cycle =3D=3D 0 to decide whet=
her to
> > disable the PWM.
>=20
> I agree with this. BUT, that's not what you're doing is it?
>=20
> Look at the code you're trying to write:
>=20
> duty_cycle =3D compute_duty_cycle(pb, brightness);
> if (duty_cycle > 0) {
>         pwm_config(pb->pwm, duty_cycle, pb->period);
>         pwm_backlight_power_on(pb, brightness);
> } else
>         pwm_backlight_power_off(pb);
>=20
> Let's say duty_cycle =3D=3D 0.  In some cases this can mean "turn
> brightness up to the *maximum*", but with your new logic you just
> turned the backlight *off*.
>=20
Huh? Please think again!
 - duty_cycle =3D=3D 0 means a CONSTANT LOW level on the PWM output. Ag=
reed?
 - Disabling the PWM usually achieves a CONSTANT LOW level on the PWM
   output. Agreed?
So duty_cycle =3D=3D 0  <=3D> disable the PWM no matter whether the bac=
klight
is darkest or brightest at this duty cycle setting!

The backlight controller does not know anything about the value of the
'brightness' variable in the code but only sees the 'duty_cycle' value.
When brightness =3D=3D 0 translates into max. duty cycle, the original =
code
will switch the PWM OFF (which is equivalent to a ZERO duty cycle), whe=
n
it rather should operate at the max. duty cycle.
When duty_cycle is '0', this is equivalent to the PWM output being at
constant LOW level which is the same as being switched OFF in the usual
cases.

When the brightness is maximum at duty_cycle =3D=3D 0, that means, that=
 the
backlight is brightest when the control pin is constantly LOW, which
is usually the case when the PWM is disabled. This is exactly what the
patch does achieve!
With the current code a backlight that is brightest at a constant '0'
level will turn to max. brightness rather than off when selecting
brightness level 0 (max. PWM duty cycle).

> Conversely, let's say duty_cycle =3D=3D 255.  In some cases this can =
mean
> "turn the brightness to the *lowest* setting" i.e. *off*. Well your
> logic just turned the backlight *on*.
>=20
OK. Let's try a sequence of brightness levels and duty cycles:
=46or simplicity assume a range of brightness levels from 0..100, so
that the 'brightness' value directly represents the duty cycle of the
PWM. So either: brightness =3D=3D 0 =3D> duty cycle =3D=3D 0% =3D> cons=
tant LOW
Or: brightnes =3D=3D 0 =3D> duty cycle =3D=3D 100% =3D> constant HIGH.

Normal range with current and patched code:
 brightness   duty_cycle
    0            0           PWM disabled =3D> constant LOW=20
    1            1           PWM active
  ...
  100          100           PWM active =3D> constant HIGH

Inverted range (backlight brightest at duty cycle 0)
Current code:
 brightness   duty_cycle
    0          100           PWM disabled (OUTPUT CONSTANT LOW!)   =20
    1           99           PWM active with near full duty cycle
  ...
   99            1           PWM active with near ZERO duty cycle
  100            0           PWM active with 0% duty cycle =3D> constan=
t LOW

With my patch:
 brightness   duty_cycle
    0          100           PWM active with 100% duty cycle (constant =
HIGH)   =20
    1           99           PWM active with near full duty cycle
  ...
   99            1           PWM active with near ZERO duty cycle
  100            0           PWM disabled =3D> constant LOW


Lothar Wa=C3=9Fmann
