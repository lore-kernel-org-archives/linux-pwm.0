Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38893 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeLMJwk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Dec 2018 04:52:40 -0500
Date: Thu, 13 Dec 2018 10:52:38 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20181213095238.mys7qulfeow4zuu2@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
 <OSAPR01MB22900C9E97E3B5AFACB99068D8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OSAPR01MB22900C9E97E3B5AFACB99068D8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low
 level
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello,

On Thu, Dec 13, 2018 at 09:47:00AM +0000, Yoshihiro Shimoda wrote:
> > From: Uwe Kleine-Konig, Sent: Friday, December 7, 2018 6:14 PM
> > On Fri, Dec 07, 2018 at 05:29:33PM +0900, Yoshihiro Shimoda wrote:
> > > +static void rcar_pwm_workaround_output_low(struct rcar_pwm_chip *rp)
> > > +{
> > > +	/*
> > > +	 * This PWM Timer cannot output low because setting 0x000 is
> > > +	 * prohibited on PWMCNT.PH0 (High-Level Period) bitfields. So, avoi=
ding
> > > +	 * the prohibited, this function changes the value from 0 to 1 as
> > > +	 * pseudo low level.
> > > +	 *
> > > +	 * TODO: Add GPIO handling to output low level.
> > > +	 */
> > > +	if ((rp->pwmcnt & RCAR_PWMCNT_PH0_MASK) =3D=3D 0)
> > > +		rp->pwmcnt |=3D 1;
> >=20
> > In my eyes this is too broken to do. Not sure I have the complete
> > picture, but given a small period (say 2) this 1 cycle might result in
> > 50 % duty cycle. Depending on how the hardware behaves if you disable
> > it, better do this instead.
>=20
> My colleague suggests that this workaround code also changes the period
> as maximum (1023) to avoid 50 % duty cycle for such a case.

A negative side effect of that is that reenabling the pwm then takes
longer, right? For my mileage even a duty cycle of 1/1023 if 0 is
requested is rather unfortunate.

> What do you think that this idea is acceptable for upstream? Or, should
> I add gpio handling that Uwe suggested?

Given that it's impossible to implement a gpio handling that results in
well defined periods only I'm not a big fan of that either.

I let Thierry the joy of deciding here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
