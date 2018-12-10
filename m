Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1400125.outbound.protection.outlook.com ([40.107.140.125]:13080
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbeLJEtW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 9 Dec 2018 23:49:22 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Dec 2018 04:49:17 +0000
Message-ID: <OSBPR01MB229351E3EC1B66339E6C9635D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
In-Reply-To: <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low
 level
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Uwem

Thank you for your review!

> From: Uwe Kleine-Konig, Sent: Friday, December 7, 2018 6:14 PM
>=20
> On Fri, Dec 07, 2018 at 05:29:33PM +0900, Yoshihiro Shimoda wrote:
<snip>
> > +static void rcar_pwm_workaround_output_low(struct rcar_pwm_chip *rp)
> > +{
> > +	/*
> > +	 * This PWM Timer cannot output low because setting 0x000 is
> > +	 * prohibited on PWMCNT.PH0 (High-Level Period) bitfields. So, avoidi=
ng
> > +	 * the prohibited, this function changes the value from 0 to 1 as
> > +	 * pseudo low level.
> > +	 *
> > +	 * TODO: Add GPIO handling to output low level.
> > +	 */
> > +	if ((rp->pwmcnt & RCAR_PWMCNT_PH0_MASK) =3D=3D 0)
> > +		rp->pwmcnt |=3D 1;
>=20
> In my eyes this is too broken to do. Not sure I have the complete
> picture, but given a small period (say 2) this 1 cycle might result in
> 50 % duty cycle. Depending on how the hardware behaves if you disable
> it, better do this instead.

You're right.

> Are you aware of the series adding such gpio support to the imx driver?

I didn't know that.

> @Thierry: So there are three drivers now that could benefit for a
> generic approach.

Should I wait for Thierry's opinion whether PWM subsystem will have
a generic approach or not?

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
