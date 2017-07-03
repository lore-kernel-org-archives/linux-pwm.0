From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 4/5] pwm: rockchip: Add atomic updated feature for
 rk3328
Date: Mon, 3 Jul 2017 20:39:57 +0200
Message-ID: <20170703203957.03f3d1db@bbrezillon>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
        <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53663 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbdGCSkA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Jul 2017 14:40:00 -0400
In-Reply-To: <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: thierry.reding@gmail.com, heiko@sntech.de, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Jun 2017 20:27:50 +0800
David Wu <david.wu@rock-chips.com> wrote:

> The rk3328 soc supports atomic update, we could lock the configuration
> of period and duty at first, after unlock is configured, the period and
> duty are effective at the same time.
> 
> If the polarity, period and duty need to be configured together,
> the way for atomic update is "configure lock and old polarity" ->
> "configure period and duty" -> "configure unlock and new polarity".
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  1 +
>  drivers/pwm/pwm-rockchip.c                         | 50 +++++++++++++++++++---
>  2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> index 2350ef9..152c736 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> @@ -4,6 +4,7 @@ Required properties:
>   - compatible: should be "rockchip,<name>-pwm"
>     "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
>     "rockchip,rk3288-pwm": found on RK3288 SoC
> +   "rockchip,rk3328-pwm": found on RK3328 SoC
>     "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
>   - reg: physical base address and length of the controller's registers
>   - clocks: See ../clock/clock-bindings.txt
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index eb630ff..d8801ae8 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -29,6 +29,7 @@
>  #define PWM_INACTIVE_POSITIVE	(1 << 4)
>  #define PWM_POLARITY_MASK	(PWM_DUTY_POSITIVE | PWM_INACTIVE_POSITIVE)
>  #define PWM_OUTPUT_LEFT		(0 << 5)
> +#define PWM_LOCK_EN		(1 << 6)
>  #define PWM_LP_DISABLE		(0 << 8)
>  
>  struct rockchip_pwm_chip {
> @@ -50,6 +51,7 @@ struct rockchip_pwm_data {
>  	struct rockchip_pwm_regs regs;
>  	unsigned int prescaler;
>  	bool supports_polarity;
> +	bool supports_atomic_update;

Yet another customization. Don't you think we can extract common parts,
expose them as helpers and then have 3 different pwm_ops (with 3
different ->apply() implementation), one for each IP revision.

>  	const struct pwm_ops *ops;
>  
>  	void (*set_enable)(struct pwm_chip *chip,
> @@ -201,6 +203,14 @@ static void rockchip_pwm_config_v2(struct pwm_chip *chip,
>  	clk_rate = clk_get_rate(pc->clk);
>  
>  	/*
> +	 * Lock the period and duty of previous configuration, then
> +	 * change the duty and period, that would not be effective.
> +	 */
> +	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
> +	ctrl |= PWM_LOCK_EN;
> +	writel_relaxed(ctrl, pc->base + pc->data->regs.ctrl);
> +
> +	/*
>  	 * Since period and duty cycle registers have a width of 32
>  	 * bits, every possible input period can be obtained using the
>  	 * default prescaler value for all practical clock rate values.
> @@ -222,6 +232,12 @@ static void rockchip_pwm_config_v2(struct pwm_chip *chip,
>  	else
>  		ctrl |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
>  
> +	/*
> +	 * Unlock and set polarity at the same time,
> +	 * the configuration of duty, period and polarity
> +	 * would be effective together at next period.
> +	 */
> +	ctrl &= ~PWM_LOCK_EN;
>  	writel(ctrl, pc->base + pc->data->regs.ctrl);
>  }
>  
> @@ -261,11 +277,18 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (ret)
>  		return ret;
>  
> -	if (state->polarity != curstate.polarity && enabled) {
> -		ret = rockchip_pwm_enable(chip, pwm, false);
> -		if (ret)
> -			goto out;
> -		enabled = false;
> +	/*
> +	 * If the atomic update is supported, then go to the pwm config,
> +	 * no need to do this, it could ensure the atomic update for polarity
> +	 * changed.
> +	 */
> +	if (pc->data->supports_atomic_update) {
> +		if (state->polarity != curstate.polarity && enabled) {
> +			ret = rockchip_pwm_enable(chip, pwm, false);
> +			if (ret)
> +				goto out;
> +			enabled = false;
> +		}
>  	}
>  
>  	pc->data->pwm_config(chip, pwm, state->duty_cycle,
> @@ -345,9 +368,26 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	.pwm_config = rockchip_pwm_config_v2,
>  };
>  
> +static const struct rockchip_pwm_data pwm_data_v3 = {
> +	.regs = {
> +		.duty = 0x08,
> +		.period = 0x04,
> +		.cntr = 0x00,
> +		.ctrl = 0x0c,
> +	},
> +	.prescaler = 1,
> +	.supports_polarity = true,
> +	.supports_atomic_update = true,
> +	.ops = &rockchip_pwm_ops_v2,
> +	.set_enable = rockchip_pwm_set_enable_v2,
> +	.get_state = rockchip_pwm_get_state_v2,
> +	.pwm_config = rockchip_pwm_config_v2,
> +};
> +
>  static const struct of_device_id rockchip_pwm_dt_ids[] = {
>  	{ .compatible = "rockchip,rk2928-pwm", .data = &pwm_data_v1},
>  	{ .compatible = "rockchip,rk3288-pwm", .data = &pwm_data_v2},
> +	{ .compatible = "rockchip,rk3328-pwm", .data = &pwm_data_v3},
>  	{ .compatible = "rockchip,vop-pwm", .data = &pwm_data_vop},
>  	{ /* sentinel */ }
>  };
