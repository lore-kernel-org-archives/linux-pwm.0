Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410100.outbound.protection.outlook.com ([40.107.141.100]:48000
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727449AbeLMJrE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 Dec 2018 04:47:04 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 13 Dec 2018 09:47:00 +0000
Message-ID: <OSAPR01MB22900C9E97E3B5AFACB99068D8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
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
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Thierry, Uwe,

> From: Uwe Kleine-Konig, Sent: Friday, December 7, 2018 6:14 PM
>=20
> On Fri, Dec 07, 2018 at 05:29:33PM +0900, Yoshihiro Shimoda wrote:
> > This PWM Timer cannot output low because setting 0x000 is prohibited
> > on PWMCNT.PH0 (High-Level Period) bitfields. So, avoiding
> > the prohibited, this patch adds a workaround function to change
> > the value from 0 to 1 as pseudo low level.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pwm/pwm-rcar.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > index e479b6a..888cb37 100644
> > --- a/drivers/pwm/pwm-rcar.c
> > +++ b/drivers/pwm/pwm-rcar.c
> > @@ -166,6 +166,20 @@ static void rcar_pwm_disable(struct rcar_pwm_chip =
*rp)
> >  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> >  }
> >
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

My colleague suggests that this workaround code also changes the period
as maximum (1023) to avoid 50 % duty cycle for such a case.

What do you think that this idea is acceptable for upstream? Or, should
I add gpio handling that Uwe suggested?

Best regards,
Yoshihiro Shimoda

> Are you aware of the series adding such gpio support to the imx driver?
>=20
> @Thierry: So there are three drivers now that could benefit for a
> generic approach.
