From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 RESEND 07/11] pwm: imx: Provide atomic PWM support
 for i.MX PWMv2
Date: Thu, 29 Dec 2016 17:45:35 +0100
Message-ID: <20161229174535.01b87fb7@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-8-git-send-email-l.majewski@majess.pl>
        <20161229172117.523a42a4@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/T+mwhdB6v+6gjts_J_5fWyA"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161229172117.523a42a4@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

--Sig_/T+mwhdB6v+6gjts_J_5fWyA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> Hi Lukasz,
>=20
> On Mon, 26 Dec 2016 23:55:57 +0100
> Lukasz Majewski <l.majewski@majess.pl> wrote:
>=20
> > This commit provides apply() callback implementation for i.MX's
> > PWMv2.
> >=20
> > Suggested-by: Stefan Agner <stefan@agner.ch>
> > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Changes for v3:
> > - Remove ipg clock enable/disable functions
> >=20
> > Changes for v2:
> > - None
> > ---
> >  drivers/pwm/pwm-imx.c | 70
> > +++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed,
> > 70 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index ebe9b0c..cd53c05 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -159,6 +159,75 @@ static void imx_pwm_wait_fifo_slot(struct
> > pwm_chip *chip, }
> >  }
> > =20
> > +static int imx_pwm_apply_v2(struct pwm_chip *chip, struct
> > pwm_device *pwm,
> > +			    struct pwm_state *state)
> > +{
> > +	unsigned long period_cycles, duty_cycles, prescale;
> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > +	struct pwm_state cstate;
> > +	unsigned long long c;
> > +	u32 cr =3D 0;
> > +	int ret;
> > +
> > +	pwm_get_state(pwm, &cstate);
> > +
> > +	c =3D clk_get_rate(imx->clk_per);
> > +	c *=3D state->period;
> > +
> > +	do_div(c, 1000000000);
> > +	period_cycles =3D c;
> > +
> > +	prescale =3D period_cycles / 0x10000 + 1;
> > +
> > +	period_cycles /=3D prescale;
> > +	c =3D (unsigned long long)period_cycles * state->duty_cycle;
> > +	do_div(c, state->period);
> > +	duty_cycles =3D c;
> > +
> > +	/*
> > +	 * according to imx pwm RM, the real period value should be
> > +	 * PERIOD value in PWMPR plus 2.
> > +	 */
> > +	if (period_cycles > 2)
> > +		period_cycles -=3D 2;
> > +	else
> > +		period_cycles =3D 0;
> > +
> > +	/* Enable the clock if the PWM is being enabled. */
> > +	if (state->enabled && !cstate.enabled) {
> > +		ret =3D clk_prepare_enable(imx->clk_per);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/*
> > +	 * Wait for a free FIFO slot if the PWM is already
> > enabled, and flush
> > +	 * the FIFO if the PWM was disabled and is about to be
> > enabled.
> > +	 */
> > +	if (cstate.enabled)
> > +		imx_pwm_wait_fifo_slot(chip, pwm);
> > +	else if (state->enabled)
> > +		imx_pwm_sw_reset(chip);
> > +
> > +	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > +
> > +	cr |=3D MX3_PWMCR_PRESCALER(prescale) |
> > +	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> > +	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
> > +
> > +	if (state->enabled)
> > +		cr |=3D MX3_PWMCR_EN;
> > +
> > +	writel(cr, imx->mmio_base + MX3_PWMCR);
> > +
> > +	/* Disable the clock if the PWM is being disabled. */
> > +	if (!state->enabled && cstate.enabled)
> > +		clk_disable_unprepare(imx->clk_per);
> > +
> > +	return 0;
> > +}
> > +
>=20
> Stefan suggested to rework this function to avoid unneeded
> duty/period calculation and reg write when disabling the PWM. Why
> didn't you send a v4 addressing that instead of resending the exact
> same v3?

The discussion between you and Stefan was in this thread:
http://patchwork.ozlabs.org/patch/689790/

Stefan proposed change, you replied with your concerns and that is all.
No clear decision what to change until today when Stefan prepared
separate (concise) patch (now I see what is the problem).


>=20
> Same goes for the regression introduced in patch 2: I think it's
> better to keep things bisectable on all platforms (even if it
> appeared to work by chance on imx7, it did work before this change).

Could you be more specific about your idea to solve this problem?

>=20
> That's just my opinion, but when you get reviews on a patch series,
> it's better to address them directly (especially when issues can be
> easily fixed) than provide follow-up patches.

I do not have iMX7 for testing/development, so I could not reproduce
the error and address the issue directly.

I can at best integrate Stefan's patch and hope to not introduce
regression.



Best regards,
=C5=81ukasz Majewski

>=20
> Regards,
>=20
> Boris


--Sig_/T+mwhdB6v+6gjts_J_5fWyA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhlPbQACgkQf9/hG2YwgjGCjwCdG2ipY4gm4WKfcsBuk2eGsnOi
3MIAoKhhBeOEcZfUdw+ac8qKwY7c2mW/
=wbTz
-----END PGP SIGNATURE-----

--Sig_/T+mwhdB6v+6gjts_J_5fWyA--
