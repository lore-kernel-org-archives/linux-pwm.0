Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50147 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHJNE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 04:13:04 -0500
Date: Tue, 8 Jan 2019 10:12:59 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190108091259.knpn5mcr3e3m6oht@pengutronix.de>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
 <TY2PR01MB481233D0989EEA601A584377D88A0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <TY2PR01MB481233D0989EEA601A584377D88A0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

On Tue, Jan 08, 2019 at 08:46:30AM +0000, Yoshihiro Shimoda wrote:
> Hello Uwe,
>=20
> > From: Uwe Kleine-Konig, Sent: Tuesday, January 8, 2019 4:48 PM
> > > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > > index ba70e83..4987c12 100644
> > > --- a/drivers/pwm/pwm-rcar.c
> > > +++ b/drivers/pwm/pwm-rcar.c
> > > @@ -316,18 +316,16 @@ static int rcar_pwm_suspend(struct device *dev)
> > >  static int rcar_pwm_resume(struct device *dev)
> > >  {
> > >  	struct pwm_device *pwm =3D rcar_pwm_dev_to_pwm_dev(dev);
> > > +	struct pwm_state state;
> > >
> > >  	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
> > >  		return 0;
> > >
> > >  	pm_runtime_get_sync(dev);
> > >
> > > -	rcar_pwm_config(pwm->chip, pwm, pwm->state.duty_cycle,
> > > -			pwm->state.period);
> > > -	if (pwm_is_enabled(pwm))
> > > -		rcar_pwm_enable(pwm->chip, pwm);
> > > +	pwm_get_state(pwm, &state);
> > >
> > > -	return 0;
> > > +	return rcar_pwm_apply(pwm->chip, pwm, &state);
> > >  }
> >=20
> > Orthogonal to this patch I wonder what the intended behaviour for a pwm
> > is on suspend. Should it stop oscilating unconditionally? Or should it
> > only stop if the consumer stops it as part of its own suspend callback?
>=20
> I think the second one is better.

I agree. @Thierry: Do you agree, too? Then we should document that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
