Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1320109.outbound.protection.outlook.com ([40.107.132.109]:4594
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfAHILr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Jan 2019 03:11:47 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 8 Jan 2019 08:11:41 +0000
Message-ID: <TY2PR01MB48122303FCD3B880701F101DD88A0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190108074331.lqwtex2pyumilfyn@pengutronix.de>
In-Reply-To: <20190108074331.lqwtex2pyumilfyn@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH v2 1/4] pwm: rcar: Add support "atomic" API
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello Uwe,

Thank you for the review!

> From: Uwe Kleine-Konig, Sent: Tuesday, January 8, 2019 4:44 PM
<snip>
> > +static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> > +			  struct pwm_state *state)
> > +{
> > +	struct rcar_pwm_chip *rp =3D to_rcar_pwm_chip(chip);
> > +	struct pwm_state cur_state;
> > +	int div, ret;
> > +
> > +	/* This HW doesn't support changing polarity */
> > +	pwm_get_state(pwm, &cur_state);
> > +	if (state->polarity !=3D cur_state.polarity)
> > +		return -ENOTSUPP;
>=20
> Does the driver only support normal polarity or only inversed polarity?
> If so checking against that would be more clear here.

This driver only supports normal polarity. So, I'll change the code as the =
following:

	/* This HW/driver only support normal polarity */
	pwm_get_state(pwm, &cur_state);
	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -ENOTSUPP;

> > +	div =3D rcar_pwm_get_clock_division(rp, state->period);
> > +	if (div < 0)
> > +		return div;
> > +
> > +	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> > +
> > +	ret =3D rcar_pwm_set_counter(rp, div, state->duty_cycle, state->perio=
d);
> > +	if (!ret)
> > +		rcar_pwm_set_clock_control(rp, div);
> > +
> > +	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
> > +	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> > +
> > +	if (!ret && state->enabled)
> > +		ret =3D rcar_pwm_enable(chip, pwm);
> > +
> > +	if (!state->enabled) {
> > +		rcar_pwm_disable(chip, pwm);
> > +		ret =3D 0;
> > +	}
>=20
> Assume the PWM runs with duty cycle 33% when
> pwm_apply_state({ .enabled=3D0, .duty_cycle=3D66, .period=3D100 }) is cal=
led.
>=20
> Does this might result in a 66% wave form being emitted? If yes, this
> needs fixing.

Thank you for the pointing it out. This code is possible to output 66% wave=
 form
between the second rcar_pwm_update() and rcar_pwm_disable(). So, I'll fix t=
his.

Best regards,
Yoshihiro Shimoda

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
