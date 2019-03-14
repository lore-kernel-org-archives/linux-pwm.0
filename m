From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 14 Mar 2019 11:00:42 +0100
Message-ID: <20190314100042.fl4kdwn7awcw4aov@pengutronix.de>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
 <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
 <20190314091702.sooxvnzd4mqr2ilz@pengutronix.de>
 <DB3PR0402MB3916975BC10346C612135334F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916975BC10346C612135334F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, Robin Gong <yibin.gong@nxp.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>l
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Mar 14, 2019 at 09:49:06AM +0000, Anson Huang wrote:
> > On Wed, Mar 13, 2019 at 07:31:16AM +0000, Anson Huang wrote:
> > > +static void imx_tpm_pwm_config(struct pwm_chip *chip,
> > > +			       struct pwm_device *pwm,
> > > +			       struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	static bool tpm_cnt_initialized;
> > > +	unsigned int duty_cnt;
> > > +	u32 val;
> > > +	u64 tmp;
> > > +
> > > +	/*
> > > +	 * TPM counter is shared by multi channels, let's make it to be
> > > +	 * ONLY first channel can config TPM counter's precale and period
> > > +	 * count.
> > > +	 */
> > > +	if (!tpm_cnt_initialized) {
> > > +		imx_tpm_pwm_config_counter(chip, state->period);
> > > +		tpm_cnt_initialized = true;
> > > +	}
> > 
> > So the period can only be configured once. That is not as good as it could be.
> > You should allow a change whenever there is exactly one PWM in use.
> 
> OK, maybe I can add check for other channels' statue here, and allow the period
> update if ONLY 1 channel is enabled.

See how the SiFive patch that I already pointed out solves this same
problem.

> > > +	/* set duty counter */
> > > +	tmp = readl(tpm->base + TPM_MOD) & TPM_MOD_MOD_MASK;
> > > +	tmp *= state->duty_cycle;
> > > +	duty_cnt = DIV_ROUND_CLOSEST_ULL(tmp, state->period);
> > 
> > Uah, you use state->period here even though for the 2nd PWM the Divider
> > might not be setup appropriately.
> 
> I think that is 1 limitation here, the dts should make sure the period used for
> different channels are same or at least they can share same divider, otherwise,
> what if multiple channels can NOT find a divider good for every channel? How to
> deal with this case?

You should return -ERANGE or -EINVAL for the calls that cannot be
satisfied.

> > > [...]
> > > +static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			  struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct pwm_state curstate;
> > > +	unsigned long flags;
> > > +
> > > +	imx_tpm_pwm_get_state(chip, pwm, &curstate);
> > > +
> > > +	spin_lock_irqsave(&tpm->lock, flags);
> > > +
> > > +	if (state->period != curstate.period ||
> > > +	    state->duty_cycle != curstate.duty_cycle ||
> > > +	    state->polarity != curstate.polarity)
> > > +		imx_tpm_pwm_config(chip, pwm, state);
> > > +
> > > +	if (state->enabled != curstate.enabled)
> > > +		imx_tpm_pwm_enable(chip, pwm, state->enabled);
> > 
> > This is wrong. This sequence:
> > 
> > 	pwm_apply_state(pwm, { .duty_cycle = 0, .period = 10000, .enabled =
> > true });
> > 	pwm_apply_state(pwm, { .duty_cycle = 10000, .period =
> > 10000, .enabled = false });
> > 
> > must keep the output pin low which isn't guaranteed here.
> 
> So you mean for every .apply operation, the channel MUST be disabled first, then config
> it, then enable it?

No. I only say that you should not configure the new period and duty
cycle if in the end the hardware should be disabled. Always disabling is
wrong, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
