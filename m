Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56303 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfHHHb7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 03:31:59 -0400
Date: Thu, 8 Aug 2019 09:31:48 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190808073148.xx2ywr2myntcqry3@pengutronix.de>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
 <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "geert+renesas@glider.be" <geert+renesas@glider.be>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello,

On Thu, Aug 08, 2019 at 03:52:52AM +0000, Yoshihiro Shimoda wrote:
> > From: Uwe Kleine-K=F6nig, Sent: Wednesday, August 7, 2019 4:03 PM
> > On Mon, Jul 08, 2019 at 06:07:47PM +0900, Yoshihiro Shimoda wrote:
> > > @@ -119,8 +121,11 @@ static int rcar_pwm_set_counter(struct rcar_pwm_=
chip *rp, int div, int duty_ns,
> > >  	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> > >
> > >  	/* Avoid prohibited setting */
> > > -	if (cyc =3D=3D 0 || ph =3D=3D 0)
> > > +	if (cyc =3D=3D 0)
> > >  		return -EINVAL;
> > > +	/* Try to use GPIO to output duty zero */
> > > +	if (ph =3D=3D 0)
> > > +		return -EAGAIN;
> >=20
> > If there is no gpio requesting cyc=3D0 should still yield an error.
>=20
> I'm sorry, I cannot understand this.

I meant that if getting the gpio failed but it's needed to yield the
right level this should result in an error. I thought I removed that
comment because this is taken care of further below.

> > >  	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> > >
> > > @@ -157,6 +162,28 @@ static void rcar_pwm_disable(struct rcar_pwm_chi=
p *rp)
> > >  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> > >  }
> > >
> > > +static int rcar_pwm_gpiod_get(struct rcar_pwm_chip *rp)
> > > +{
> > > +	if (rp->gpio)
> > > +		return 0;
> > > +
> > > +	rp->gpio =3D gpiod_get(rp->chip.dev, "renesas,duty-zero", GPIOD_OUT=
_LOW);
> > > +	if (!IS_ERR(rp->gpio))
> > > +		return 0;
> > > +
> > > +	rp->gpio =3D NULL;
> > > +	return -EINVAL;
> >=20
> > Does getting the gpio automatically switch the pinmuxing?
> >=20
> > If yes, this is IMHO a really surprising mis-feature of the gpio
> > subsystem. I'd prefer to "get" the gpio at probe time and only switch
> > the pinmuxing in .apply(). This makes .apply() quicker, ensures that all
> > resources necessary for pwm operation are available, handles
> > -EPROBE_DEFER (and maybe other errors) correctly.
>=20
> The current pinctrl subsystem only has .set_mux(). I checked the pinctrl =
subsystem
> history and the commit 2243a87d90b42eb38bc281957df3e57c712b5e56 removed t=
he ".disable()" ops.
> So, IIUC, we cannot such a handling.

You'd need to reactivate the pwm setting when changing from 0% to
something bigger of course.

But as I understand it "getting" the gpio already implies that it is
muxed which is bad here. So it would be great if we could opt-out.
Linus?

The pwm-imx driver has a similar problem[1] where we already considered
using a gpio. There auto-muxing would be in the way, too. (Maybe it
isn't because it isn't implmented on i.MX?)

> > Note you're introducing a bug here because switching to gpio doesn't
> > ensure that the currently running period is completed.
>=20
> Umm, the hardware doesn't have such a condition so that the driver cannot=
 manage it.
> So, I'll add this into the "Limitations" too.

yes please.

> > > +static void rcar_pwm_gpiod_put(struct rcar_pwm_chip *rp)
> > > +{
> > > +	if (!rp->gpio)
> > > +		return;
> > > +
> > > +	gpiod_put(rp->gpio);
> > > +	rp->gpio =3D NULL;
> > > +}
> > > +
> > >  static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > >  			  struct pwm_state *state)
> > >  {
> > > @@ -171,6 +198,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > >
> > >  	if (!state->enabled) {
> > >  		rcar_pwm_disable(rp);
> > > +		rcar_pwm_gpiod_put(rp);
> >=20
> > From the framework's POV disabling a PWM is quite similar to duty cycle
> > 0. Assuming disabling the PWM completes the currently running period[1]
> > it might be better and easier to disable instead of switching to gpio.
> > (Further assuming that disable really yields the inactive level which is
> > should and is another limitation if not.)
>=20
> If we disable the hardware, the duty cycle is 100% unfortunately. So,
> I think I should describe it as one of "Limitations".

It seems you got the idea .. :-)

Best regards
Uwe

[1] it goes to 0 on disable even if the polarity is inverted

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
