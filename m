From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] pwm: rockchip: State of pwm clock should synchronize
 with pwm enabled state
Date: Wed, 1 Mar 2017 11:19:15 +0100
Message-ID: <20170301111915.445925ad@bbrezillon>
References: <1488363362-26624-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37591 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdCAKTj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Mar 2017 05:19:39 -0500
In-Reply-To: <1488363362-26624-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: briannorris@chromium.org, heiko@sntech.de, thierry.reding@gmail.com, dianders@chromium.org, b.galvani@gmail.com, caesar.wang@rock-chips.com, huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed,  1 Mar 2017 18:16:02 +0800
David Wu <david.wu@rock-chips.com> wrote:

> From: "david.wu" <david.wu@rock-chips.com>
> 
> If the pwm was not enabled at uboot loader, pwm could not work for clock
> always disabled at pwm driver. The pwm clock is enabled at beginning of
> pwm_apply(), but disabled at end of pwm_apply().
> 
> If the pwm was enabled at uboot loader, pwm clock is always enabled unless
> closed by ATF. The pwm-backlight might turn off the power at early suspend,
> should disable pwm clock for saving power consume.
> 
> It is important to provide opportunity to enable/disable clock at pwm driver,
> the pwm consumer should ensure correct order to call pwm enable/disable, and
> pwm driver ensure state of pwm clock synchronized with pwm enabled state.
> 
> Fixes: 2bf1c98aa5a4 ("pwm: rockchip: Add support for atomic update")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index ef89df1..dbee3c3 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -191,6 +191,28 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return 0;
>  }
>  
> +static int rk_pwm_enable(struct pwm_chip *chip,
> +			 struct pwm_device *pwm,
> +			 bool enable,
> +			 enum pwm_polarity polarity)

You didn't change the function name:

s/rk_pwm_enable/rockchip_pwm_enable/

> +{
> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> +	int ret;
> +
> +	if (enable) {
> +		ret = clk_enable(pc->clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pc->data->set_enable(chip, pwm, enable, polarity);
> +
> +	if (!enable)
> +		clk_disable(pc->clk);
> +
> +	return 0;
> +}
> +
>  static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			      struct pwm_state *state)
>  {
> @@ -207,22 +229,26 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return ret;
>  
>  	if (state->polarity != curstate.polarity && enabled) {
> -		pc->data->set_enable(chip, pwm, false, state->polarity);
> +		ret = rk_pwm_enable(chip, pwm, false, state->polarity);
> +		if (ret)
> +			goto out;
>  		enabled = false;
>  	}
>  
>  	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
>  	if (ret) {
>  		if (enabled != curstate.enabled)
> -			pc->data->set_enable(chip, pwm, !enabled,
> -					     state->polarity);
> -
> +			rk_pwm_enable(chip, pwm, !enabled,
> +				      state->polarity);
>  		goto out;
>  	}
>  
> -	if (state->enabled != enabled)
> -		pc->data->set_enable(chip, pwm, state->enabled,
> -				     state->polarity);
> +	if (state->enabled != enabled) {
> +		ret = rk_pwm_enable(chip, pwm, state->enabled,
> +				    state->polarity);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	/*
>  	 * Update the state with the real hardware, which can differ a bit
