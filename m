From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 04/14] pwm: rockchip: Add support for hardware readout
Date: Fri, 3 Jun 2016 13:20:06 -0700
Message-ID: <20160603202006.GC124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-5-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35858 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbcFCUUK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 16:20:10 -0400
Received: by mail-pa0-f45.google.com with SMTP id te7so13859754pab.3
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jun 2016 13:20:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464942192-25967-5-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com

On Fri, Jun 03, 2016 at 10:23:02AM +0200, Boris Brezillon wrote:
> Implement the ->get_state() function to expose initial state.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 68d72ce..dfacf7d 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -51,6 +51,8 @@ struct rockchip_pwm_data {
>  
>  	void (*set_enable)(struct pwm_chip *chip,
>  			   struct pwm_device *pwm, bool enable);
> +	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  struct pwm_state *state);
>  };
>  
>  static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
> @@ -75,6 +77,19 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
>  	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>  }
>  
> +static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      struct pwm_state *state)
> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
> +	u32 val;
> +
> +	val = readl(pc->base + pc->data->regs.ctrl);

Nit: I just noticed you've been starting to use readl()/writel() in this
series, where previously {readl,writel}_relaxed() were being used. Any
reason?

Anyway, LGTM:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

> +	if ((val & enable_conf) == enable_conf)
> +		state->enabled = true;
> +}
> +
>  static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
>  				       struct pwm_device *pwm, bool enable)
>  {
> @@ -98,6 +113,53 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip,
>  	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>  }
>  
> +static void rockchip_pwm_get_state_v2(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      struct pwm_state *state)
> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +	u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
> +			  PWM_CONTINUOUS;
> +	u32 val;
> +
> +	val = readl(pc->base + pc->data->regs.ctrl);
> +	if ((val & enable_conf) != enable_conf)
> +		return;
> +
> +	state->enabled = true;
> +
> +	if (!(val & PWM_DUTY_POSITIVE))
> +		state->polarity = PWM_POLARITY_INVERSED;
> +}
> +
> +static void rockchip_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +	unsigned long clk_rate;
> +	u64 tmp;
> +	int ret;
> +
> +	ret = clk_enable(pc->clk);
> +	if (ret)
> +		return;
> +
> +	clk_rate = clk_get_rate(pc->clk);
> +
> +	tmp = readl(pc->base + pc->data->regs.period);
> +	tmp *= pc->data->prescaler * NSEC_PER_SEC;
> +	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> +
> +	tmp = readl(pc->base + pc->data->regs.duty);
> +	tmp *= pc->data->prescaler * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> +
> +	pc->data->get_state(chip, pwm, state);
> +
> +	clk_disable(pc->clk);
> +}
> +
>  static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			       int duty_ns, int period_ns)
>  {
> @@ -170,6 +232,7 @@ static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  }
>  
>  static const struct pwm_ops rockchip_pwm_ops_v1 = {
> +	.get_state = rockchip_pwm_get_state,
>  	.config = rockchip_pwm_config,
>  	.enable = rockchip_pwm_enable,
>  	.disable = rockchip_pwm_disable,
> @@ -177,6 +240,7 @@ static const struct pwm_ops rockchip_pwm_ops_v1 = {
>  };
>  
>  static const struct pwm_ops rockchip_pwm_ops_v2 = {
> +	.get_state = rockchip_pwm_get_state,
>  	.config = rockchip_pwm_config,
>  	.set_polarity = rockchip_pwm_set_polarity,
>  	.enable = rockchip_pwm_enable,
> @@ -194,6 +258,7 @@ static const struct rockchip_pwm_data pwm_data_v1 = {
>  	.prescaler = 2,
>  	.ops = &rockchip_pwm_ops_v1,
>  	.set_enable = rockchip_pwm_set_enable_v1,
> +	.get_state = rockchip_pwm_get_state_v1,
>  };
>  
>  static const struct rockchip_pwm_data pwm_data_v2 = {
> @@ -206,6 +271,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
>  	.prescaler = 1,
>  	.ops = &rockchip_pwm_ops_v2,
>  	.set_enable = rockchip_pwm_set_enable_v2,
> +	.get_state = rockchip_pwm_get_state_v2,
>  };
>  
>  static const struct rockchip_pwm_data pwm_data_vop = {
> @@ -218,6 +284,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
>  	.prescaler = 1,
>  	.ops = &rockchip_pwm_ops_v2,
>  	.set_enable = rockchip_pwm_set_enable_v2,
> +	.get_state = rockchip_pwm_get_state_v2,
>  };
>  
>  static const struct of_device_id rockchip_pwm_dt_ids[] = {
> -- 
> 2.7.4
> 
