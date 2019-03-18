From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Date: Mon, 18 Mar 2019 09:07:43 +0100
Message-ID: <20190318080743.xumj6e72bzumszvp@pengutronix.de>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
 <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
 <20190315093532.xw5ivfkxrwvrkvix@pengutronix.de>
 <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm->
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 18, 2019 at 07:41:02AM +0000, Anson Huang wrote:
> Hi,Uwe
> > > +	val &=3D ~PWM_IMX_TPM_SC_CMOD;
> > > +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> > =

> > As this interrupts the output, please only do it if necessary.
> =

> OK, will do it ONLY when it is enabled previously.

I think you only need to do that when the value actually changes.

> > > +	/* set duty counter */
> > > +	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD_MA=
SK;
> > =

> > I recommend storing this value in driver data.
> =

> NOT quite understand, as we did NOT use it in other places except the get=
_state,
> just reading the register once should be OK there.

I had the impression it is used more than once. Will look again in the
next iteration. But also note that shadowing the value might already be
beneficial for a single call site as driver data might occupy more RAM
than necessary anyhow and reading from RAM is faster than from the
hardware's register. Probably this is not a fast path, so not worth the
optimisation?!

> > I wonder why MSA and MSB are two bits instead of making this a field of
> > width 2 with 2b10 meaning PWM mode. But maybe it's just me not
> > understanding the independent semantic of these two bits?
> =

> I think making them a field makes more sense, but anyway we just follow
> the RM.

If it makes the driver easier to understand (which I think it does) feel
free to derivate from the RM. Just add a comment to the definition, then
it's fine.

> > Reading the reference manual I'd say in PWM mode the semantic of ELSA
> > and ELSB is:
> > =

> > 	On counter reload set the output to ELSB
> > 	On counter match set the output to ELSA
> > =

> > Noting that in a comment would ease understanding the code here.
> =

> I added below comment for PWM modes:
> =

> 137         /*
> 138          * set polarity (for edge-aligned PWM modes)
> 139          *
> 140          * CPWMS  MSB:MSA  ELSB:ELSA  Mode  Configuration
> 141          * 0      10       10         PWM   High-true pulse
> 142          * 0      10       00         PWM   Reserved
> 143          * 0      10       01         PWM   Low-true pulse
> 144          * 0      10       11         PWM   Reserved
> 145          *
> 146          * High-true pulse: clear output on counter match, set output=
 on
> 147          * counter reload, set output when counter first enabled or p=
aused.
> 148          *
> 149          * Low-true pulse: set output on counter match, clear output =
on
> 150          * counter reload, clear output when counter first enabled or=
 paused.
> 151          */

I stumbled over "high-true" and "low-true" in the RM, too. In my bubble
this is an uncommon wording. I'd write instead:

	/*
	 * set polarity
	 *
	 * ELSB:ELSA =3D 2b10 yields normal polarity behaviour, ELSB:ELSA
	 * =3D 2b01 yields inversed polarity. The other values are
	 * reserved.
	 */

And don't write about CPWM, MSA and MSB which are always used with fixed
values anyhow in the driver. =

 =

> > > +		/* disable channel */
> > > +		writel(PWM_IMX_TPM_CnSC_CHF,
> > > +			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > =

> > Clearing CHF doens't disable the channel as I read the manual.
> =

> This write clears CHF as well as writing other bits 0, to disable the out=
put. Maybe I
> can explicitly clear MSA/MSB/ELSA/ELSB to avoid confusion.

Ah, I misinterpreted the value written.

> > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > > +			     struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > +	struct pwm_state curstate;
> > > +	u32 duty_cycle =3D state->duty_cycle;
> > > +	int ret;
> > > +
> > > +	pwm_imx_tpm_get_state(chip, pwm, &curstate);
> > > +
> > > +	mutex_lock(&tpm->lock);
> > =

> > What should this lock protect? Does it hurt if the state changes between
> > pwm_imx_tpm_get_state releasing the lock and pwm_imx_tpm_apply taking
> > it?
> =

> The idea is to protect the share resourced by multiple channels, but I th=
ink I can make the mutex_lock
> includes get_state and remove the lock in get_state function.

You might need it in .get_state to return a consistent state to the
caller. In this case just introduce an unlocked variant of .get_state to
share code between the two functions.

And BTW the question was honest. I'm not entirely sure that you need to
hold the lock.

> > > +		 */
> > > +		if (tpm->user_count !=3D 1)
> > > +			return -EBUSY;
> > =

> > Ideally if say period =3D 37 is requested but currently we have period =
=3D
> > 36 and configuring 37 would result in 36 anyhow, don't return EBUSY.
> =

> I think here the protection is just for making sure that is there are mul=
tiple
> users, period can NOT be changed, since all channels will be impacted.

I think you misunderstood what I intended to say here.

Consider that in the case that there is only a single PWM in use
configuring for a period of 37 ns actually yields 36 ns because the
hardware cannot provide 37 ns and 36 ns is the best match.

Then if a second user comes and requests 37 ns, the result here is, that
the second user gets the -EBUSY. This is ridiculous however because the
request is denied even though the period is already configured for the
length that would be configured if the second user were the only one.

> > > +	tpm->chip.dev =3D &pdev->dev;
> > > +	tpm->chip.ops =3D &imx_tpm_pwm_ops;
> > > +	tpm->chip.base =3D -1;
> > > +	tpm->chip.npwm =3D PWM_IMX_TPM_MAX_CHANNEL_NUM;
> > =

> > This is wrong, as some only have 2 channels?
> =

> I saw we can get channel number from register, will read register to dete=
rmine
> the channel number, but for the channel config and status saved in struct=
, I will
> still use the MAX channel number to define the array.

Yeah, that is sensible.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
