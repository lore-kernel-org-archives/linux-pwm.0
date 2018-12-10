Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 10 Dec 2018 09:11:03 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 5/5] pwm: rcar: add workaround to output "pseudo" low level
Message-ID: <20181210081103.zxayrzpbxiuvv6hb@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207091337.mvrzzbgqa77adgbd@pengutronix.de>
 <OSBPR01MB229351E3EC1B66339E6C9635D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OSBPR01MB229351E3EC1B66339E6C9635D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello,

On Mon, Dec 10, 2018 at 04:49:17AM +0000, Yoshihiro Shimoda wrote:
> > From: Uwe Kleine-Konig, Sent: Friday, December 7, 2018 6:14 PM
> >=20
> > On Fri, Dec 07, 2018 at 05:29:33PM +0900, Yoshihiro Shimoda wrote:
> <snip>
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
> You're right.

But in the meantime I learned that the pwm gets active on disable, so
this won't help.
=20
> > Are you aware of the series adding such gpio support to the imx driver?
>=20
> I didn't know that.
>=20
> > @Thierry: So there are three drivers now that could benefit for a
> > generic approach.
>=20
> Should I wait for Thierry's opinion whether PWM subsystem will have
> a generic approach or not?

Not sure how to preceed here. The needed procedure would be:

	set duty_cycle to 0%
	delay long enough to be sure the duty cycle is active
	switch to gpio
	disable the hardware

The additional blocker for rcar is that it doesn't support duty_cycle
0%.

So unless your hardware guys confirm that 0% works even though not
supported according to the hardware manual I have no good idea.

In the past I suggested to weaken the requirements after pwm_disable,
but Thierry didn't like it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
