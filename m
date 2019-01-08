Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1320137.outbound.protection.outlook.com ([40.107.132.137]:2990
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbfAHIqe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Jan 2019 03:46:34 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 8 Jan 2019 08:46:30 +0000
Message-ID: <TY2PR01MB481233D0989EEA601A584377D88A0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
In-Reply-To: <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello Uwe,

> From: Uwe Kleine-Konig, Sent: Tuesday, January 8, 2019 4:48 PM
> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > index ba70e83..4987c12 100644
> > --- a/drivers/pwm/pwm-rcar.c
> > +++ b/drivers/pwm/pwm-rcar.c
> > @@ -316,18 +316,16 @@ static int rcar_pwm_suspend(struct device *dev)
> >  static int rcar_pwm_resume(struct device *dev)
> >  {
> >  	struct pwm_device *pwm =3D rcar_pwm_dev_to_pwm_dev(dev);
> > +	struct pwm_state state;
> >
> >  	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
> >  		return 0;
> >
> >  	pm_runtime_get_sync(dev);
> >
> > -	rcar_pwm_config(pwm->chip, pwm, pwm->state.duty_cycle,
> > -			pwm->state.period);
> > -	if (pwm_is_enabled(pwm))
> > -		rcar_pwm_enable(pwm->chip, pwm);
> > +	pwm_get_state(pwm, &state);
> >
> > -	return 0;
> > +	return rcar_pwm_apply(pwm->chip, pwm, &state);
> >  }
>=20
> Orthogonal to this patch I wonder what the intended behaviour for a pwm
> is on suspend. Should it stop oscilating unconditionally? Or should it
> only stop if the consumer stops it as part of its own suspend callback?

I think the second one is better. I checked drivers/video/backlight/pwm_bl.=
c
and it is possible to call pwm_apply_state() by the driver after rcar_pwm_s=
uspend()
was called. So, I'll fix this as other patch.

> As the patch only reworks and improves the code without a change in
> behaviour, it is fine for me.
>=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!

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
