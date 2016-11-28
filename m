From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 07/11] pwm: imx: Provide atomic PWM support for i.MX
 PWMv2
Date: Mon, 28 Nov 2016 06:50:31 +0100
Message-ID: <20161128065031.712d9e7f@jawa>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
        <1477984230-18071-8-git-send-email-l.majewski@majess.pl>
        <4f514a235a404d0ab9d26f389fc83f51@agner.ch>
        <20161123093848.206ad78f@bbrezillon>
        <a46e6054dd24c44e48b995837d9be205@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Aj6.MwKVbSGyGmyAfGD1QAr"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a46e6054dd24c44e48b995837d9be205@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

--Sig_/Aj6.MwKVbSGyGmyAfGD1QAr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Stefan, Boris,

> On 2016-11-23 00:38, Boris Brezillon wrote:
> > On Tue, 22 Nov 2016 13:55:33 -0800
> > Stefan Agner <stefan@agner.ch> wrote:
> >=20
> >> On 2016-11-01 00:10, Lukasz Majewski wrote:
> >> > This commit provides apply() callback implementation for i.MX's
> >> > PWMv2.
> >> >
> >> > Suggested-by: Stefan Agner <stefan@agner.ch>
> >> > Suggested-by: Boris Brezillon
> >> > <boris.brezillon@free-electrons.com> Signed-off-by: Lukasz
> >> > Majewski <l.majewski@majess.pl> Reviewed-by: Boris Brezillon
> >> > <boris.brezillon@free-electrons.com> ---
> >> > Changes for v3:
> >> > - Remove ipg clock enable/disable functions
> >> >
> >> > Changes for v2:
> >> > - None
> >> > ---
> >> >  drivers/pwm/pwm-imx.c | 70
> >> > +++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file
> >> > changed, 70 insertions(+)
> >> >
> >> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> >> > index ebe9b0c..cd53c05 100644
> >> > --- a/drivers/pwm/pwm-imx.c
> >> > +++ b/drivers/pwm/pwm-imx.c
> >> > @@ -159,6 +159,75 @@ static void imx_pwm_wait_fifo_slot(struct
> >> > pwm_chip *chip, }
> >> >  }
> >> >
> >> > +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct
> >> > pwm_device *pwm,
> >> > +			    struct pwm_state *state)
> >> > +{
> >> > +	unsigned long period_cycles, duty_cycles, prescale;
> >> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> >> > +	struct pwm_state cstate;
> >> > +	unsigned long long c;
> >> > +	u32 cr =3D 0;
> >> > +	int ret;
> >> > +
> >> > +	pwm_get_state(pwm, &cstate);
> >> > +
> >>
> >> Couldn't we do:
> >>
> >> if (cstate.enabled) { ...
> >>
> >> > +	c =3D clk_get_rate(imx->clk_per);
> >> > +	c *=3D state->period;
> >> > +
> >> > +	do_div(c, 1000000000);
> >> > +	period_cycles =3D c;
> >> > +
> >> > +	prescale =3D period_cycles / 0x10000 + 1;
> >> > +
> >> > +	period_cycles /=3D prescale;
> >> > +	c =3D (unsigned long long)period_cycles *
> >> > state->duty_cycle;
> >> > +	do_div(c, state->period);
> >> > +	duty_cycles =3D c;
> >> > +
> >> > +	/*
> >> > +	 * according to imx pwm RM, the real period value
> >> > should be
> >> > +	 * PERIOD value in PWMPR plus 2.
> >> > +	 */
> >> > +	if (period_cycles > 2)
> >> > +		period_cycles -=3D 2;
> >> > +	else
> >> > +		period_cycles =3D 0;
> >> > +
> >> > +	/* Enable the clock if the PWM is being enabled. */
> >> > +	if (state->enabled && !cstate.enabled) {
> >> > +		ret =3D clk_prepare_enable(imx->clk_per);
> >> > +		if (ret)
> >> > +			return ret;
> >> > +	}
> >> > +
> >> > +	/*
> >> > +	 * Wait for a free FIFO slot if the PWM is already
> >> > enabled, and flush
> >> > +	 * the FIFO if the PWM was disabled and is about to be
> >> > enabled.
> >> > +	 */
> >> > +	if (cstate.enabled)
> >> > +		imx_pwm_wait_fifo_slot(chip, pwm);
> >> > +	else if (state->enabled)
> >> > +		imx_pwm_sw_reset(chip);
> >> > +
> >> > +	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> >> > +	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> >> > +
> >> > +	cr |=3D MX3_PWMCR_PRESCALER(prescale) |
> >> > +	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> >> > +	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
> >> > +
> >> > +	if (state->enabled)
> >> > +		cr |=3D MX3_PWMCR_EN;
> >>
> >> } else if (state->enabled) {
> >> 	imx_pwm_sw_reset(chip);
> >> }
> >>
> >> and get rid of the if (state->enabled) in between? This would safe
> >> us useless recalculation when disabling the controller...
> >=20
> > I get your point, but I'm pretty sure your proposal does not do what
> > you want (remember that cstate is the current state, and state is
> > the new state to apply).
> >=20
> > Something like that would work better:
> >=20
> > 	if (state->enabled) {
>=20
> Oops, yes, got that wrong. state->enabled is what I meant.
>=20
> > 		c =3D clk_get_rate(imx->clk_per);
> > 		c *=3D state->period;
> >=20
> > 		do_div(c, 1000000000);
> > 		period_cycles =3D c;
> >=20
> > 		prescale =3D period_cycles / 0x10000 + 1;
> >=20
> > 		period_cycles /=3D prescale;
> > 		c =3D (unsigned long long)period_cycles *
> > 		    state->duty_cycle;
> > 		do_div(c, state->period);
> > 		duty_cycles =3D c;
> >=20
> > 		/*
> > 		 * According to imx pwm RM, the real period value
> > 		 * should be PERIOD value in PWMPR plus 2.
> > 		 */
> > 		if (period_cycles > 2)
> > 			period_cycles -=3D 2;
> > 		else
> > 			period_cycles =3D 0;
> >=20
> > 		/*
> > 		 * Enable the clock if the PWM is not already
> > 		 * enabled.
> > 		 */
> > 		if (!cstate.enabled) {
> > 			ret =3D clk_prepare_enable(imx->clk_per);
> > 			if (ret)
> > 			return ret;
> > 		}
> >=20
> > 		/*
> > 		 * Wait for a free FIFO slot if the PWM is already
> > 		 * enabled, and flush the FIFO if the PWM was
> > disabled
> > 		 * and is about to be enabled.
> > 		 */
> > 		if (cstate.enabled)
> > 			imx_pwm_wait_fifo_slot(chip, pwm);
> > 		else
> > 			imx_pwm_sw_reset(chip);
> >=20
> > 		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > 		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> >=20
> > 		writel(MX3_PWMCR_PRESCALER(prescale) |
> > 		       MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> > 		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
> > 		       MX3_PWMCR_EN,
> > 		       imx->mmio_base + MX3_PWMCR);
> > 	} else {
> >=20
> > 		writel(0, imx->mmio_base + MX3_PWMCR);
> >=20
> > 		/* Disable the clock if the PWM is currently
> > enabled. */ if (cstate.enabled)
> > 			clk_disable_unprepare(imx->clk_per);
> > 	}
> >=20
> >=20
> > This being said, I'm a bit concerned by the way this driver handles
> > PWM config requests.
> > It seems that the new config request is queued, and nothing
> > guarantees
>=20
> Not sure if that is true. The RM says: "A change in the period value
> due to a write in PWM_PWMPR results in the counter being reset to
> zero and the start of a new count period."
>=20
> And for PWMSAR: "When a new value is written, the duty cycle changes
> after the current period is over."
>=20
> So I guess writing the period basically makes sure the next value from
> PWMSAR will be active immediately...
>=20
>=20
> > that it is actually applied when the
> > pwm_apply/config/enable/disable() functions return.
>=20
>=20
> Given that the driver did it like that since quite some time, I am
> assuming it mostly works in practice.=20
>=20
> I would rather prefer to do that conversion to atomic PWM API now, and
> fix that in a second step...

I'm also for fixing one problem in a time. The "PWM ->apply()" set of
patches now tries to fix all problems in IMX PWM driver.

Could we agree on the scope of this work? I mean what should be
included to "->apply()" rework and what will be fixed latter?

Frankly, I think that this patch series comes to the point where it is
not manageable anymore.

Please also keep in mind that I do have iMX6q system, Stefan has imx7
and Sasha has HW with PWMv1 working.

Changing the driver in N different places not related to the
"->apply()" atomicity support (the ipg clock, FIFO) requires far more
work and testing.


Best regards,
=C5=81ukasz Majewski

>=20
> >=20
> > This approach has several flaws IMO:
> >=20
> > 1/ I'm not sure this is what the PWM users expect. Getting your
> > request queued with no guarantees that it is applied can be weird
> > in some cases (especially when the user changes the PWM config
> > several times in a short period of time).
> > 2/ In the disable path, you queue a "stop PWM" request, but you're
> > not sure that it's actually dequeued before the per clk is disabled.
> >    What happens in that case? And more importantly, what happens
> > when the PWM is re-enabled to apply a new config? AFAICS, there
> > might be a short period of time where the re-enabled PWM is
> > actually running with the old config until we flush the command
> > queue and queue a new command.
> > 3/ The queueing approach complicates the whole logic. You have to
> >    flush the FIFO in some cases, or wait for an empty slots if too
> > many commands are queued.
> >    Forcing imx_pwm_apply_v2() to wait for the config request to be
> >    applied should simplify the whole thing, because you will always
> > be guaranteed that the FIFO is empty, and that the current
> >    configuration is the last requested one.
> >=20
>=20
> --
> Stefan


--Sig_/Aj6.MwKVbSGyGmyAfGD1QAr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlg7xbMACgkQf9/hG2YwgjGAIQCgzj4fR+3Je/Uf9Dt7ASFrGabJ
AA0An1HA+yGb47ISqmjarDUnuDKL//m/
=1Zqv
-----END PGP SIGNATURE-----

--Sig_/Aj6.MwKVbSGyGmyAfGD1QAr--
