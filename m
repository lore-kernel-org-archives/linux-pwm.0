From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is
 zero
Date: Fri, 10 Jun 2016 07:23:46 +0200
Message-ID: <20160610072346.51b0a5d5@ipc1.ka-ro>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
	<20160609135125.GA2385@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:58866 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcFJFX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 01:23:59 -0400
In-Reply-To: <20160609135125.GA2385@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

Hi,

On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
> On Tue, 07 Jun 2016, Lothar Wa=C3=9Fmann wrote:
>=20
> > 'brightness' is usually an index into a table of duty_cycle values,
> > where the value at index 0 may well be non-zero
> > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-l=
ife
> > examples).
> > Thus brightness =3D=3D 0 does not necessarily mean that the PWM out=
put
> > will be inactive.
> > Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D 0' t=
o decide
> > whether to disable the PWM.
> >=20
> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > ---
> > Changes wrt. v1:
> >   - update binding docs to reflect the change
> >=20
> >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt         |=
 9 ++++++---
> >  drivers/video/backlight/pwm_bl.c                                 |=
 4 ++--
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-b=
acklight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-bac=
klight.txt
> > index 764db86..95fa8a9 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backligh=
t.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backligh=
t.txt
> > @@ -4,10 +4,13 @@ Required properties:
> >    - compatible: "pwm-backlight"
> >    - pwms: OF device-tree PWM specification (see PWM binding[0])
> >    - brightness-levels: Array of distinct brightness levels. Typica=
lly these
> > -      are in the range from 0 to 255, but any range starting at 0 =
will do.
> > +      are in the range from 0 to 255, but any range will do.
> >        The actual brightness level (PWM duty cycle) will be interpo=
lated
> > -      from these values. 0 means a 0% duty cycle (darkest/off), wh=
ile the
> > -      last value in the array represents a 100% duty cycle (bright=
est).
> > +      from these values. 0 means a 0% duty cycle, while the highes=
t value in
> > +      the array represents a 100% duty cycle.
> > +      The range may be in reverse order (starting with the maximum=
 duty cycle
> > +      value) to create a PWM signal with the 100% duty cycle repre=
senting
> > +      minimum and 0% duty cycle maximum brigthness.
> >    - default-brightness-level: the default brightness level (index =
into the
> >        array defined by the "brightness-levels" property)
> >    - power-supply: regulator for supply voltage
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > index b2b366b..80b2b52 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(struct b=
acklight_device *bl)
> >  	if (pb->notify)
> >  		brightness =3D pb->notify(pb->dev, brightness);
> > =20
> > -	if (brightness > 0) {
> > -		duty_cycle =3D compute_duty_cycle(pb, brightness);
> > +	duty_cycle =3D compute_duty_cycle(pb, brightness);
> > +	if (duty_cycle > 0) {
>=20
> How does this work in the aforementioned:
>=20
>   "The range may be in reverse order"
>=20
> ... case?  Surely when duty_cycle is when the screen should be at it'=
s
> brightest?  Wouldn't it confuse the user if they turn their brightnes=
s
> *up* and the screen goes *off*?
>=20
Assuming that the PWM output is inactive (LOW) when the duty_cycle is
set to zero, there will be no difference between operating the PWM at
duty_cycle 0 or disabling it.

Currently, the screen will go bright when it should be off in this
case.


Lothar Wa=C3=9Fmann
