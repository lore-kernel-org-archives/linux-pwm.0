From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Tue, 28 Feb 2017 22:07:56 +0100
Message-ID: <20170228220756.3e29b62e@bbrezillon>
References: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
        <1488278415-2786-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488278415-2786-2-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Claudiu,

On Tue, 28 Feb 2017 12:40:14 +0200
Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:

> The currently Atmel PWM controllers supported by this driver
> could change period and duty factor without channel disable
> (sama5d3 supports this by using period and duty factor update
> registers, sam9rl support this by writing channel update
> register and select the corresponding update: period or duty
> factor).

Hm, I had a closer a look at the datasheet, and I'm not sure this is
possible in a safe way. AFAICT (I might be wrong), there's no way to
atomically update both the period and duty cycles. So, imagine you're
just at the end of the current period and you update one of the 2 params
(either the period or the duty cycle) before the end of the period, but
the other one is updated just after the beginning of a new period.
During one cycle you'll have a bad config.

While this should be acceptable in most cases, there are a few cases
where glitches are not permitted (when the PWM drives a critical
device). Also, I don't know what happens if we have duty > period.

> The chip doesn't support run time changings of signal
> polarity. This has been adapted by first disabling the channel,
> update registers and the enabling the channel.

Yep. I agree with that one.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
>  drivers/pwm/pwm-atmel.c | 217 ++++++++++++++++++++++++++----------------------
>  1 file changed, 118 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 67a7023..014b86c 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -68,7 +68,7 @@ struct atmel_pwm_chip {
>  	struct mutex isr_lock;
>  
>  	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
> -		       unsigned long dty, unsigned long prd);
> +		       unsigned long dty, unsigned long prd, bool enabled);
>  };
>  
>  static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
> @@ -105,99 +105,120 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
>  	writel_relaxed(val, chip->base + base + offset);
>  }
>  
> -static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			    int duty_ns, int period_ns)
> +static int atmel_pwm_config_prepare(struct pwm_chip *chip,
> +				    struct pwm_state *state, unsigned long *prd,
> +				    unsigned long *dty, unsigned int *pres)

I'd rename the function atmel_pwm_calculate_params(). Also, when the
period does not change we don't have to calculate prd and pres, so
maybe we should have one function to calculate prd+pres and another one
to calculate dty:

static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
					const struct pwm_state *state,
					u32 *cprd, u32 *pres)
{
	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
	unsigned long long cycles = state->period;

        /* Calculate the period cycles and prescale value */
        cycles *= clk_get_rate(atmel_pwm->clk);
        do_div(cycles, NSEC_PER_SEC);

        for (*pres = 0; cycles > PWM_MAX_PRD; cycles >>= 1)
                (*pres)++;

        if (*pres > PRD_MAX_PRES) {
                dev_err(chip->dev, "pres exceeds the maximum value\n");
                return -EINVAL;
        }

        *cprd = cycles;

        return 0;
}

static void atmel_pwm_calculate_cdty(const struct pwm_state *state,
                                     u32 cprd, u32 *cdty)
{
        unsigned long long cycles = state->duty_cycle;

        cycles *= cprd;
        do_div(cycles, state->period);

        *cdty = cycles;
}


>  {
>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> -	unsigned long prd, dty;
>  	unsigned long long div;
> -	unsigned int pres = 0;
> -	u32 val;
> -	int ret;
> -
> -	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
> -		dev_err(chip->dev, "cannot change PWM period while enabled\n");
> -		return -EBUSY;
> -	}
>  
>  	/* Calculate the period cycles and prescale value */
> -	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * period_ns;
> +	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * state->period;
>  	do_div(div, NSEC_PER_SEC);
>  
> +	*pres = 0;
>  	while (div > PWM_MAX_PRD) {
>  		div >>= 1;
> -		pres++;
> +		(*pres)++;
>  	}
>  
> -	if (pres > PRD_MAX_PRES) {
> +	if (*pres > PRD_MAX_PRES) {
>  		dev_err(chip->dev, "pres exceeds the maximum value\n");
>  		return -EINVAL;
>  	}
>  
>  	/* Calculate the duty cycles */
> -	prd = div;
> -	div *= duty_ns;
> -	do_div(div, period_ns);
> -	dty = prd - div;
> +	*prd = div;
> +	div *= state->duty_cycle;
> +	do_div(div, state->period);
> +	*dty = *prd - div;

Not sure this subtraction is needed, you just need to revert the
polarity selection (if polarity == NORMAL => set CPOL, otherwise, clear
it).

>  
> -	ret = clk_enable(atmel_pwm->clk);
> -	if (ret) {
> -		dev_err(chip->dev, "failed to enable PWM clock\n");
> -		return ret;
> -	}
> +	return 0;
> +}
> +
> +static void atmel_pwm_config_set(struct pwm_chip *chip, struct pwm_device *pwm,
> +				 unsigned long dty, unsigned long prd,
> +				 unsigned long pres, enum pwm_polarity polarity,
> +				 bool enabled)
> +{
> +	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> +	u32 val;
>  
>  	/* It is necessary to preserve CPOL, inside CMR */
>  	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
>  	val = (val & ~PWM_CMR_CPRE_MSK) | (pres & PWM_CMR_CPRE_MSK);
> +	if (polarity == PWM_POLARITY_NORMAL)
> +		val &= ~PWM_CMR_CPOL;
> +	else
> +		val |= PWM_CMR_CPOL;
>  	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> -	atmel_pwm->config(chip, pwm, dty, prd);
> +	atmel_pwm->config(chip, pwm, dty, prd, enabled);
>  	mutex_lock(&atmel_pwm->isr_lock);
>  	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
>  	atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
>  	mutex_unlock(&atmel_pwm->isr_lock);
> -
> -	clk_disable(atmel_pwm->clk);
> -	return ret;
>  }
>  

You can move the code in atmel_pwm_config_set() directly in
atmel_pwm_apply().

>  static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
> -				unsigned long dty, unsigned long prd)
> +				unsigned long dty, unsigned long prd,
> +				bool enabled)
>  {
>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>  	unsigned int val;
> +	unsigned long timeout;
>  
> +	if (pwm_is_enabled(pwm) && enabled) {
> +		/* Update duty factor. */
> +		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> +		val &= ~PWM_CMR_UPD_CDTY;
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
>  
> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
> -
> -	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> -	val &= ~PWM_CMR_UPD_CDTY;
> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> -
> -	/*
> -	 * If the PWM channel is enabled, only update CDTY by using the update
> -	 * register, it needs to set bit 10 of CMR to 0
> -	 */
> -	if (pwm_is_enabled(pwm))
> -		return;
> -	/*
> -	 * If the PWM channel is disabled, write value to duty and period
> -	 * registers directly.
> -	 */
> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
> +		/*
> +		 * Wait for the duty factor update.
> +		 */
> +		mutex_lock(&atmel_pwm->isr_lock);
> +		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR) &
> +				~(1 << pwm->hwpwm);
> +
> +		timeout = jiffies + 2 * HZ;
> +		while (!(atmel_pwm->updated_pwms & (1 << pwm->hwpwm)) &&
> +		       time_before(jiffies, timeout)) {
> +			usleep_range(10, 100);
> +			atmel_pwm->updated_pwms |=
> +					atmel_pwm_readl(atmel_pwm, PWM_ISR);
> +		}
> +
> +		mutex_unlock(&atmel_pwm->isr_lock);
> +
> +		/* Update period. */
> +		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> +		val |= PWM_CMR_UPD_CDTY;
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, prd);

As I said above, I'm almost sure it's not 100% safe to update both
parameters. We'd better stick to the existing implementation and see if
new IPs provide an atomic period+duty update feature.

> +	} else {
> +		/*
> +		 * If the PWM channel is disabled, write value to duty and
> +		 * period registers directly.
> +		 */
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
> +	}
>  }

There are 2 different cases in this _config() function, and
atmel_pwm_apply() is already doing different things when the PWM is
enabled than when it's disabled, so maybe it's worth creating 2
different hooks, one for the update-while-running case, and another for
for the initialization case.

How about having the following hooks in atmel_pwm_data?

	void (*update_cdty)(struct pwm_chip *chip,
                            struct pwm_device *pwm,
                            u32 cdty);
        void (*set_cprd_cdty)(struct pwm_chip *chip,
                              struct pwm_device *pwm,
                              u32 cprd, u32 cdty);

>  
>  static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
> -				unsigned long dty, unsigned long prd)
> +				unsigned long dty, unsigned long prd,
> +				bool enabled)
>  {
>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>  
> -	if (pwm_is_enabled(pwm)) {
> +	if (pwm_is_enabled(pwm) && enabled) {
>  		/*
> -		 * If the PWM channel is enabled, using the duty update register
> -		 * to update the value.
> +		 * If the PWM channel is enabled, use update registers
> +		 * to update the duty and period.
>  		 */
>  		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRDUPD, prd);

Same here, I'm not convinced we are guaranteed that both parameters will
be applied atomically. There's a sync mechanism described in the
datasheet, but I'm not sure I understand how it works, and anyway,
you're not using it here, so let's stick to the "update duty only"
approach for now.

>  	} else {
>  		/*
>  		 * If the PWM channel is disabled, write value to duty and
> @@ -208,49 +229,6 @@ static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
>  	}
>  }
>  
> -static int atmel_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> -				  enum pwm_polarity polarity)
> -{
> -	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> -	u32 val;
> -	int ret;
> -
> -	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> -
> -	if (polarity == PWM_POLARITY_NORMAL)
> -		val &= ~PWM_CMR_CPOL;
> -	else
> -		val |= PWM_CMR_CPOL;
> -
> -	ret = clk_enable(atmel_pwm->clk);
> -	if (ret) {
> -		dev_err(chip->dev, "failed to enable PWM clock\n");
> -		return ret;
> -	}
> -
> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> -
> -	clk_disable(atmel_pwm->clk);
> -
> -	return 0;
> -}
> -
> -static int atmel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> -	int ret;
> -
> -	ret = clk_enable(atmel_pwm->clk);
> -	if (ret) {
> -		dev_err(chip->dev, "failed to enable PWM clock\n");
> -		return ret;
> -	}
> -
> -	atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
> -
> -	return 0;
> -}
> -
>  static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> @@ -285,17 +263,58 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clk_disable(atmel_pwm->clk);
>  }
>  
> +static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
> +{
> +	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> +	struct pwm_state cstate;
> +	unsigned long prd, dty;
> +	unsigned int pres;
> +	bool enabled = true;
> +	int ret;
> +
> +	pwm_get_state(pwm, &cstate);
> +
> +	if (state->enabled) {
> +		ret = atmel_pwm_config_prepare(chip, state, &prd, &dty,
> +					       &pres);
> +		if (ret) {
> +			dev_err(chip->dev, "failed to prepare config\n");
> +			return ret;
> +		}
> +
> +		if (cstate.polarity != state->polarity) {

Hm, you seem to unconditionally disable the PWM. What if it was already
disabled? The atmel_pwm->clk refcounting is likely to be wrong after
that.
 
Moreover, if you follow my previous suggestions, you should have

		if (cstate.enabled &&
		    (cstate.polarity != state->polarity ||
		     cstate.period != state->period))

> +			atmel_pwm_disable(chip, pwm);
> +			enabled = false;

Just set cstate.enabled to false here, no need for an extra variable.

> +		}
> +
> +		if (!cstate.enabled || !enabled) {

		if (!cstate.enabled) {

> +			ret = clk_enable(atmel_pwm->clk);
> +			if (ret) {
> +				dev_err(chip->dev, "failed to enable clock\n");
> +				return ret;
> +			}
> +		}
> +
> +		atmel_pwm_config_set(chip, pwm, dty, prd, pres,
> +				     state->polarity, enabled);
> +		if (!cstate.enabled || !enabled)
> +			atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);

I would differentiate the update CDTY only and set CDTY+CPRD+CMR cases
here. Something like:

		if (cstate.enabled) {
			/*
			 * 1/ read CPRD
			 * 2/ call atmel_pwm_calculate_cdty()
			 * 3/ call ->update_cdty() hook
			 */
		} else {
			/*
			 * 1/ enable the clk
			 * 2/ read CPRD
			 * 3/ call atmel_pwm_calculate_cprd_and_pres()
			 * 4/ call atmel_pwm_calculate_cdty()
			 * 3/ call ->set_cprd_cdty() hook
			 * 4/ write CMR (PRES + polarity)
			 * 5/ start the PWM (PWM_ENA)
			 */
		}

> +	} else if (cstate.enabled) {
> +		atmel_pwm_disable(chip, pwm);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct pwm_ops atmel_pwm_ops = {
> -	.config = atmel_pwm_config,
> -	.set_polarity = atmel_pwm_set_polarity,
> -	.enable = atmel_pwm_enable,
> -	.disable = atmel_pwm_disable,
> +	.apply = atmel_pwm_apply,
>  	.owner = THIS_MODULE,
>  };
>  
>  struct atmel_pwm_data {
>  	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
> -		       unsigned long dty, unsigned long prd);
> +		       unsigned long dty, unsigned long prd, bool enabled);
>  };
>  
>  static const struct atmel_pwm_data atmel_pwm_data_v1 = {

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
