From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/5] pwm: rockchip: Move the configuration of polarity
 from rockchip_pwm_set_enable() to rockchip_pwm_config()
Date: Mon, 3 Jul 2017 20:36:40 +0200
Message-ID: <20170703203640.697b8286@bbrezillon>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
        <1498739271-27431-4-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498739271-27431-4-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 29 Jun 2017 20:27:49 +0800
David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:

> It is usually possible to configure the polarity, cycle and duty all at once,
> so that the polarity and cycle and duty should be binding together. Move it
> into rockchip_pwm_config(), as well as prepared for the next atomic update
> commit.
> 
> As the rk2928-pwm is different from rk3288-pwm, the rk2928-pwm doesn't support
> the polarity, use the pwm_config_v1 and pwm_config_v2 to distinguish them.
> 
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/pwm/pwm-rockchip.c | 77 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index cd45f17..eb630ff 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -27,6 +27,7 @@
>  #define PWM_DUTY_NEGATIVE	(0 << 3)
>  #define PWM_INACTIVE_NEGATIVE	(0 << 4)
>  #define PWM_INACTIVE_POSITIVE	(1 << 4)
> +#define PWM_POLARITY_MASK	(PWM_DUTY_POSITIVE | PWM_INACTIVE_POSITIVE)
>  #define PWM_OUTPUT_LEFT		(0 << 5)
>  #define PWM_LP_DISABLE		(0 << 8)
>  
> @@ -52,10 +53,12 @@ struct rockchip_pwm_data {
>  	const struct pwm_ops *ops;
>  
>  	void (*set_enable)(struct pwm_chip *chip,
> -			   struct pwm_device *pwm, bool enable,
> -			   enum pwm_polarity polarity);
> +			   struct pwm_device *pwm, bool enable);
>  	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  struct pwm_state *state);
> +	void (*pwm_config)(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns,
> +			   enum pwm_polarity polarity);
>  };

Hm, maybe it's time to drop these custom hooks and implement
pwm_apply_v1 and pwm_apply_v2 instead.

>  
>  static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
> @@ -64,8 +67,7 @@ static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
>  }
>  
>  static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
> -				       struct pwm_device *pwm, bool enable,
> -				       enum pwm_polarity polarity)
> +				       struct pwm_device *pwm, bool enable)
>  {
>  	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>  	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
> @@ -95,19 +97,13 @@ static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
>  }
>  
>  static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
> -				       struct pwm_device *pwm, bool enable,
> -				       enum pwm_polarity polarity)
> +				       struct pwm_device *pwm, bool enable)
>  {
>  	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>  	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
>  			  PWM_CONTINUOUS;
>  	u32 val;
>  
> -	if (polarity == PWM_POLARITY_INVERSED)
> -		enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> -	else
> -		enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
> -
>  	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
>  
>  	if (enable)
> @@ -165,12 +161,42 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
>  	clk_disable(pc->pclk);
>  }
>  
> -static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			       int duty_ns, int period_ns)
> +static void rockchip_pwm_config_v1(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   int duty_ns, int period_ns,
> +				   enum pwm_polarity polarity)
> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +	unsigned long period, duty;
> +	u64 clk_rate, div;
> +
> +	clk_rate = clk_get_rate(pc->clk);
> +
> +	/*
> +	 * Since period and duty cycle registers have a width of 32
> +	 * bits, every possible input period can be obtained using the
> +	 * default prescaler value for all practical clock rate values.
> +	 */
> +	div = clk_rate * period_ns;
> +	period = DIV_ROUND_CLOSEST_ULL(div,
> +				       pc->data->prescaler * NSEC_PER_SEC);
> +
> +	div = clk_rate * duty_ns;
> +	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
> +
> +	writel(period, pc->base + pc->data->regs.period);
> +	writel(duty, pc->base + pc->data->regs.duty);
> +}
> +
> +static void rockchip_pwm_config_v2(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   int duty_ns, int period_ns,
> +				   enum pwm_polarity polarity)
>  {
>  	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>  	unsigned long period, duty;
>  	u64 clk_rate, div;
> +	u32 ctrl;
>  
>  	clk_rate = clk_get_rate(pc->clk);
>  
> @@ -188,12 +214,20 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	writel(period, pc->base + pc->data->regs.period);
>  	writel(duty, pc->base + pc->data->regs.duty);
> +
> +	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	ctrl &= ~PWM_POLARITY_MASK;
> +	if (polarity == PWM_POLARITY_INVERSED)
> +		ctrl |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> +	else
> +		ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
> +
> +	writel(ctrl, pc->base + pc->data->regs.ctrl);
>  }
>  
>  static int rockchip_pwm_enable(struct pwm_chip *chip,
>  			 struct pwm_device *pwm,
> -			 bool enable,
> -			 enum pwm_polarity polarity)
> +			 bool enable)
>  {
>  	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>  	int ret;
> @@ -204,7 +238,7 @@ static int rockchip_pwm_enable(struct pwm_chip *chip,
>  			return ret;
>  	}
>  
> -	pc->data->set_enable(chip, pwm, enable, polarity);
> +	pc->data->set_enable(chip, pwm, enable);
>  
>  	if (!enable)
>  		clk_disable(pc->clk);
> @@ -228,17 +262,17 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return ret;
>  
>  	if (state->polarity != curstate.polarity && enabled) {
> -		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity);
> +		ret = rockchip_pwm_enable(chip, pwm, false);
>  		if (ret)
>  			goto out;
>  		enabled = false;
>  	}
>  
> -	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
> +	pc->data->pwm_config(chip, pwm, state->duty_cycle,
> +			  state->period, state->polarity);
>  
>  	if (state->enabled != enabled) {
> -		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
> -				    state->polarity);
> +		ret = rockchip_pwm_enable(chip, pwm, state->enabled);
>  		if (ret)
>  			goto out;
>  	}
> @@ -278,6 +312,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	.ops = &rockchip_pwm_ops_v1,
>  	.set_enable = rockchip_pwm_set_enable_v1,
>  	.get_state = rockchip_pwm_get_state_v1,
> +	.pwm_config = rockchip_pwm_config_v1,
>  };
>  
>  static const struct rockchip_pwm_data pwm_data_v2 = {
> @@ -292,6 +327,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	.ops = &rockchip_pwm_ops_v2,
>  	.set_enable = rockchip_pwm_set_enable_v2,
>  	.get_state = rockchip_pwm_get_state_v2,
> +	.pwm_config = rockchip_pwm_config_v2,
>  };
>  
>  static const struct rockchip_pwm_data pwm_data_vop = {
> @@ -306,6 +342,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	.ops = &rockchip_pwm_ops_v2,
>  	.set_enable = rockchip_pwm_set_enable_v2,
>  	.get_state = rockchip_pwm_get_state_v2,
> +	.pwm_config = rockchip_pwm_config_v2,
>  };
>  
>  static const struct of_device_id rockchip_pwm_dt_ids[] = {

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
