From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V8 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 21 Mar 2019 14:42:12 +0100
Message-ID: <20190321134212.hypmz4enz7z5wamg@pengutronix.de>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
 <1553128960-17923-3-git-send-email-Anson.Huang@nxp.com>
 <20190321091950.tkzem7cbgvtynr5m@pengutronix.de>
 <DB3PR0402MB3916CE06E6EF103470915905F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190321104112.xits5qgk7tsuhdps@pengutronix.de>
 <DB3PR0402MB3916094B2F7A4D878785C676F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916094B2F7A4D878785C676F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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

Hello,

On Thu, Mar 21, 2019 at 12:47:32PM +0000, Anson Huang wrote:
> > On Thu, Mar 21, 2019 at 09:54:15AM +0000, Anson Huang wrote:
> > > > On Thu, Mar 21, 2019 at 12:47:57AM +0000, Anson Huang wrote:
> > > > > +static void pwm_imx_tpm_setup_period(struct pwm_chip *chip,
> > > > > +				     struct imx_tpm_pwm_param *p) {
> > > > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > > > +	u32 val, saved_cmod, cur_prescale;
> > > > > +
> > > > > +	/* make sure counter is disabled for programming prescale */
> > > >
> > > > @Thierry: What is your thought here? IMHO this should only be
> > > > allowed if all affected PWMs are off.
> > >
> > > As we already make sure that ONLY when there is ONLY 1 user and the
> > > requested period is different from the current period, then this
> > > function will be called, so there is impossible that multiple PWMs ar=
e active
> > and the period is requested to be changed.
> > > Am I right?
> > =

> > This problem is not about two PWMs. If you reconfigure a running PWM the
> > requirement is that the hardware completes a whole period with the old
> > configuration and then immediately starts a new period with the new
> > parameters. If you stop the counter, the last period with the old param=
eters
> > is disturbed.
> =

> So, I think simply return error if the counter is running and there is a =
new PS change
> request, right?

That's the general idea yes. If you cannot fulfil the request without
violating the guarantees you have to adhere, refuse the request with an
error.

> > > > > +		 */
> > > > > +		state->polarity =3D PWM_POLARITY_NORMAL;
> > > > > +
> > > > > +	/* get channel status */
> > > > > +	state->enabled =3D FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true :
> > > > > +false; }
> > > > > +
> > > > > +static void pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> > > > > +				 struct pwm_device *pwm,
> > > > > +				 struct pwm_state *state)
> > > >
> > > > pwm_imx_tpm_apply_hw is called with the mutex hold. Is this necessa=
ry?
> > > > Please either call it without the mutex or annotate the function
> > > > that the caller is supposed to hold it.
> > >
> > > OK, will make sure call it without mutex hold.

Reading through the reference manual I noticed that there might be a
stall: If you write two values to CnV the second write is ignored if the
first wasn't latched yet. That might mean that you cannot release the
mutex before the newly configured state is active. This is related to
the request to not let .apply return before the configured state is
active, but I didn't thought this to an end what the real consequences
have to be.

> > > If counter is enabled, and for edge aligned PWM mode(EPWM), the
> > > register is updated After written and TPM counter changes from MOD to
> > > zero, same as period count update, HW will make sure the period finis=
h..
> > =

> > Looking into my concern again, it is actually the other way around:
> > Assuming a single used PWM channel that runs at duty_cycle=3D500 +
> > period=3D1000. Then pwm_imx_tpm_apply() is called with state-
> > >duty_cycle=3D700 and state->period=3D800. pwm_imx_tpm_apply() calls
> > pwm_imx_tpm_setup_period() to configure for .period=3D1000. Now if the
> > PWM completes a period before pwm_imx_tpm_apply_hw() sets up CnV to
> > the value corresponding to duty_cycle=3D700, it produces a waveform with
> > duty_cycle=3D500 and period=3D800 which is bad. This is another limitat=
ion that
> > can be worked around in software with some effort (which might or might
> > not be worth to spend).
> =

> I am sure that on i.MX7ULP platform we used for backlight ONLY, it should=
 NOT
> that matter if this case happen, unless the counter is disabled, then the=
 effort spend
> on this case will be huge, so I plan to leave it as what it is if you don=
't mind.

That means you have to add this to the list of limitations.

> > > > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip,
> > > > > +			      struct pwm_device *pwm,
> > > > > +			     struct pwm_state *state)
> > > > > +{
> > > > > +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> > > > > +	struct imx_tpm_pwm_param param;
> > > > > +	struct pwm_state real_state;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret =3D pwm_imx_tpm_round_state(chip, &param, state, &real_stat=
e);
> > > > > +	if (ret)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	mutex_lock(&tpm->lock);
> > > > > +
> > > > > +	/*
> > > > > +	 * TPM counter is shared by multiple channels, so
> > > > > +	 * prescale and period can NOT be modified when
> > > > > +	 * there are multiple channels in use with different
> > > > > +	 * period settings.
> > > > > +	 */
> > > > > +	if (real_state.period !=3D tpm->real_period) {
> > > > > +		if (tpm->user_count > 1) {
> > > > > +			ret =3D -EBUSY;
> > > > > +			goto exit;
> > > > > +		}
> > > > > +
> > > > > +		pwm_imx_tpm_setup_period(chip, &param);
> > > > > +		tpm->real_period =3D real_state.period;
> > > > > +	}
> > > > > +
> > > > > +	pwm_imx_tpm_apply_hw(chip, pwm, &real_state);
> > > > > +
> > > > > +exit:
> > > > > +	mutex_unlock(&tpm->lock);
> > > >
> > > > .apply is supposed to sleep until the newly configured state is act=
ive.
> > > > This is missing here, right?
> > >
> > > NOT quite understand, you meant .apply could be sleep if mutex is hold
> > > by other thread?
> > =

> > No. .apply is supposed to only return when the new configuration is act=
ive.
> > So if the PWM is running in its previous configuration, you setup the r=
egisters
> > such that the new configuration gets active in the next period, you mus=
t not
> > yet return to the caller until the new period started.
> =

> That bring me back to previous question, we can add waiting for period fi=
nish
> And then return from .apply, but we also need a timeout for the wait, wha=
t should
> The timeout value be? 100mS? Or even several seconds?

A sane value would be the duration of the previously configured period
length as this is the theoretical upper limit for this delay.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
