Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:49012
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbeLMKxb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 Dec 2018 05:53:31 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 13 Dec 2018 10:53:27 +0000
Message-ID: <OSAPR01MB2290F7F727328F7758955F76D8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
 <OSAPR01MB22900C9E97E3B5AFACB99068D8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
 <20181213095238.mys7qulfeow4zuu2@pengutronix.de>
In-Reply-To: <20181213095238.mys7qulfeow4zuu2@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low
 level
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello,

> From: Uwe Kleine-Konig, Sent: Thursday, December 13, 2018 6:53 PM
>=20
> Hello,
>=20
> On Thu, Dec 13, 2018 at 09:47:00AM +0000, Yoshihiro Shimoda wrote:
> > > From: Uwe Kleine-Konig, Sent: Friday, December 7, 2018 6:14 PM
> > > On Fri, Dec 07, 2018 at 05:29:33PM +0900, Yoshihiro Shimoda wrote:
> > > > +static void rcar_pwm_workaround_output_low(struct rcar_pwm_chip *r=
p)
> > > > +{
> > > > +	/*
> > > > +	 * This PWM Timer cannot output low because setting 0x000 is
> > > > +	 * prohibited on PWMCNT.PH0 (High-Level Period) bitfields. So, av=
oiding
> > > > +	 * the prohibited, this function changes the value from 0 to 1 as
> > > > +	 * pseudo low level.
> > > > +	 *
> > > > +	 * TODO: Add GPIO handling to output low level.
> > > > +	 */
> > > > +	if ((rp->pwmcnt & RCAR_PWMCNT_PH0_MASK) =3D=3D 0)
> > > > +		rp->pwmcnt |=3D 1;
> > >
> > > In my eyes this is too broken to do. Not sure I have the complete
> > > picture, but given a small period (say 2) this 1 cycle might result i=
n
> > > 50 % duty cycle. Depending on how the hardware behaves if you disable
> > > it, better do this instead.
> >
> > My colleague suggests that this workaround code also changes the period
> > as maximum (1023) to avoid 50 % duty cycle for such a case.
>=20
> A negative side effect of that is that reenabling the pwm then takes
> longer, right? For my mileage even a duty cycle of 1/1023 if 0 is
> requested is rather unfortunate.

You're right.

> > What do you think that this idea is acceptable for upstream? Or, should
> > I add gpio handling that Uwe suggested?
>=20
> Given that it's impossible to implement a gpio handling that results in
> well defined periods only I'm not a big fan of that either.

I got it.

By the way, I checked R-Car Gen3 manual again (which is not public yet and
RZ/G series manual doesn't mention it though), and then changing the pinctr=
l
setting at runtime is not guarantee. So, I have no change to use gpio on
the pwm-rcar.c. So, I only have a workaround about this at the moment...

> I let Thierry the joy of deciding here.

I hope Thierry accepts this workaround.

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
