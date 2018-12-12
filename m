Return-path: <kernel-bounces@pengutronix.de>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 12 Dec 2018 03:19:40 +0000
Message-ID: <OSBPR01MB2293BE0147A4A535136BDF82D8A70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
 <OSBPR01MB229351E3EC1B66339E6C9635D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
 <20181210081103.zxayrzpbxiuvv6hb@pengutronix.de>
In-Reply-To: <20181210081103.zxayrzpbxiuvv6hb@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low level
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

Hi Uwe,

> From: Uwe Kleine-Konig, Sent: Monday, December 10, 2018 5:11 PM
>=20
> Hello,
>=20
> On Mon, Dec 10, 2018 at 04:49:17AM +0000, Yoshihiro Shimoda wrote:
> > > From: Uwe Kleine-Konig, Sent: Friday, December 7, 2018 6:14 PM
> > >
> > > On Fri, Dec 07, 2018 at 05:29:33PM +0900, Yoshihiro Shimoda wrote:
> > <snip>
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
> > You're right.
>=20
> But in the meantime I learned that the pwm gets active on disable, so
> this won't help.
>=20
> > > Are you aware of the series adding such gpio support to the imx drive=
r?
> >
> > I didn't know that.
> >
> > > @Thierry: So there are three drivers now that could benefit for a
> > > generic approach.
> >
> > Should I wait for Thierry's opinion whether PWM subsystem will have
> > a generic approach or not?
>=20
> Not sure how to preceed here. The needed procedure would be:
>=20
> 	set duty_cycle to 0%
> 	delay long enough to be sure the duty cycle is active
> 	switch to gpio
> 	disable the hardware
>=20
> The additional blocker for rcar is that it doesn't support duty_cycle
> 0%.
>=20
> So unless your hardware guys confirm that 0% works even though not
> supported according to the hardware manual I have no good idea.
>=20
> In the past I suggested to weaken the requirements after pwm_disable,
> but Thierry didn't like it.

I read the following discussion once:
https://patchwork.ozlabs.org/patch/959776/

I could not understand all this yet, but I think I should try to add a spec=
ial gpio handling
to the pwm-rcar.c driver instead of a generic approach because as you menti=
oned above,
such special handling needs for the hardware.

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
