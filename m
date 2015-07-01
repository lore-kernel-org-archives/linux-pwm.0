From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH 12/15] pwm: rockchip: add initial state retrieval
Date: Wed, 01 Jul 2015 23:44:46 +0200
Message-ID: <3258341.kaLi8uDfLr@diego>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com> <1435738921-25027-13-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:43083 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbbGAVpK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 1 Jul 2015 17:45:10 -0400
In-Reply-To: <1435738921-25027-13-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org

Hi Boris,

Am Mittwoch, 1. Juli 2015, 10:21:58 schrieb Boris Brezillon:
> Implement the ->init_state() function to expose initial state.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---

[...]

> @@ -98,6 +110,36 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip
> *chip, writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>  }
> 
> +static void rockchip_pwm_init_state(struct pwm_chip *chip,
> +				    struct pwm_device *pwm)
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
> +	tmp = do_div(tmp, clk_rate);

I guess you want to have the division result here and not the remainder, so
-       tmp = do_div(tmp, clk_rate);
+       do_div(tmp, clk_rate);


> +	pwm->state.period = tmp;
> +
> +	tmp = readl(pc->base + pc->data->regs.duty);
> +	tmp *= pc->data->prescaler * NSEC_PER_SEC;
> +	tmp = do_div(tmp, clk_rate);

ditto

> +	pwm->state.duty_cycle = tmp;
> +
> +	pc->data->init(chip, chip->pwms);
> +
> +	if (!pwm_is_enabled(pwm))
> +		clk_disable(pc->clk);
> +}
> +
>  static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm, int duty_ns, int period_ns)
>  {
> @@ -171,6 +213,7 @@ static void rockchip_pwm_disable(struct pwm_chip *chip,
> struct pwm_device *pwm) }
> 
>  static const struct pwm_ops rockchip_pwm_ops_v1 = {
> +	.init_state = rockchip_pwm_init_state,
>  	.config = rockchip_pwm_config,
>  	.enable = rockchip_pwm_enable,
>  	.disable = rockchip_pwm_disable,
> @@ -178,6 +221,7 @@ static const struct pwm_ops rockchip_pwm_ops_v1 = {
>  };
> 
>  static const struct pwm_ops rockchip_pwm_ops_v2 = {
> +	.init_state = rockchip_pwm_init_state,
>  	.config = rockchip_pwm_config,
>  	.set_polarity = rockchip_pwm_set_polarity,
>  	.enable = rockchip_pwm_enable,
> @@ -195,6 +239,7 @@ static const struct rockchip_pwm_data pwm_data_v1 = {
>  	.prescaler = 2,
>  	.ops = &rockchip_pwm_ops_v1,
>  	.set_enable = rockchip_pwm_set_enable_v1,
> +	.init = rockchip_pwm_init_v1,
>  };
> 
>  static const struct rockchip_pwm_data pwm_data_v2 = {
> @@ -207,6 +252,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
>  	.prescaler = 1,
>  	.ops = &rockchip_pwm_ops_v2,
>  	.set_enable = rockchip_pwm_set_enable_v2,
> +	.init = rockchip_pwm_init_v2,

you're referencing the v2 init here, but only add it in the next patch?
[pwm: rockchip: add support for atomic update]


>  };
> 
>  static const struct rockchip_pwm_data pwm_data_vop = {
> @@ -219,6 +265,7 @@ static const struct rockchip_pwm_data pwm_data_vop = {
>  	.prescaler = 1,
>  	.ops = &rockchip_pwm_ops_v2,
>  	.set_enable = rockchip_pwm_set_enable_v2,
> +	.init = rockchip_pwm_init_v2,

ditto


Heiko
