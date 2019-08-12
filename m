From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
Date: Mon, 12 Aug 2019 07:55:15 +0200
Message-ID: <20190812055515.ne7o4ujchfeubjid@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-7-paul@crapouillou.net>
 <20190809171058.gothydohec6qx7hu@pengutronix.de>
 <1565372004.2091.3@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565372004.2091.3@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Aug 09, 2019 at 07:33:24PM +0200, Paul Cercueil wrote:
> 
> 
> Le ven. 9 août 2019 à 19:10, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Fri, Aug 09, 2019 at 02:30:30PM +0200, Paul Cercueil wrote:
> > >  The PWM will always start with the inactive part. To counter that,
> > >  when PWM is enabled we switch the configured polarity, and use
> > >  'period - duty + 1' as the real duty.
> > 
> > Where does the + 1 come from? This looks wrong. (So if duty=0 is
> > requested you use duty = period + 1?)
> 
> You'd never request duty == 0, would you?
> 
> Your duty must always be in the inclusive range [1, period]
> (hardware values, not ns). A duty of 0 is a hardware fault
> (on the jz4740 it is).

From the PWM framework's POV duty cycle = 0 is perfectly valid. Similar
to duty == period. Not supporting dutz cycle 0 is another limitation of
your PWM that should be documented.

For actual use cases of duty cycle = 0 see drivers/hwmon/pwm-fan.c or
drivers/leds/leds-pwm.c.

> If you request duty == 1 (the minimum), then the new duty is equal
> to (period - 1 + 1) == period, which is the maximum of your range.
> 
> If you request duty == period (the maximum), then the new duty
> calculated is equal to (period - period + 1) == 1, which is the
> minimum of your range.
> 
> 
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > >   drivers/pwm/pwm-jz4740.c | 22 +++++++++++++---------
> > >   1 file changed, 13 insertions(+), 9 deletions(-)
> > > 
> > >  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> > >  index 85e2110aae4f..8df898429d47 100644
> > >  --- a/drivers/pwm/pwm-jz4740.c
> > >  +++ b/drivers/pwm/pwm-jz4740.c
> > >  @@ -121,6 +121,7 @@ static int jz4740_pwm_apply(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > >   		   *parent_clk = clk_get_parent(clk);
> > >   	unsigned long rate, parent_rate, period, duty;
> > >   	unsigned long long tmp;
> > >  +	bool polarity_inversed;
> > >   	int ret;
> > > 
> > >   	parent_rate = clk_get_rate(parent_clk);
> > >  @@ -183,24 +184,27 @@ static int jz4740_pwm_apply(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > >   	/* Reset counter to 0 */
> > >   	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
> > > 
> > >  -	/* Set duty */
> > >  -	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
> > >  -
> > >   	/* Set period */
> > >   	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
> > > 
> > >  +	/*
> > >  +	 * The PWM will always start with the inactive part. To counter that,
> > >  +	 * when PWM is enabled we switch the configured polarity, and use
> > >  +	 * 'period - duty + 1' as the real duty.
> > >  +	 */
> > >  +
> > >  +	/* Set duty */
> > >  +	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), period - duty + 1);
> > >  +
> > 
> > Before you set duty first, then period, now you do it the other way
> > round. Is there a good reason?
> 
> To move it below the comment that explains why we use 'period - duty + 1'.
> 
> We modify that line anyway, so it's not like it makes the patch much more
> verbose.

It doesn't make it more verbose, but that's not the background of my
question. For most(?) PWM implementation the order of hardware accesses
matters and introducing such a difference as an unneeded side effect
isn't optimal.

Why not add the comment above the line that already used to set the duty
in hardware?

> > >   	/* Set polarity */
> > >  -	switch (state->polarity) {
> > >  -	case PWM_POLARITY_NORMAL:
> > >  +	polarity_inversed = state->polarity == PWM_POLARITY_INVERSED;
> > >  +	if (!polarity_inversed ^ state->enabled)
> > 
> > Why does state->enabled suddenly matter here?
> 
> The pin stay inactive when the PWM is disabled, but the level of the
> inactive state depends on the polarity of the pin. So we need to switch
> the polarity only when the PWM is enabled.

After some thought I got that. When knowing this, this is already
mentioned in the comment you introduced as you write about enabled PWMs
only. Maybe it's just me, but mentioning that case more explicit would
have helped me. Something like:

	/*
	 * The hardware always starts a period with the inactive part.
	 * So invert polarity and duty cycle to yield the output that is
	 * expected by the PWM framework and its users. This inversion
	 * must not be done for a disabled PWM however because otherwise
	 * it outputs a constant active level.
	 */

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
