From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
Date: Mon, 4 Nov 2019 09:24:10 +0100
Message-ID: <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-4-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191103203334.10539-4-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello,

On Sun, Nov 03, 2019 at 09:33:30PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM core needs bus clock to be enabled in order to work.
> 
> Add an optional probe for it and a fallback for previous
> bindings without name on module clock.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index d194b8ebdb00..b5e7ac364f59 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
>  
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
> +	struct clk *bus_clk;
>  	struct clk *clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> @@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)

Adding more context here:

|       pwm->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> +	/* Get all clocks and reset line */
> +	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
> +	if (IS_ERR(pwm->clk)) {
> +		dev_err(&pdev->dev, "get clock failed %ld\n",
> +			PTR_ERR(pwm->clk));
> +		return PTR_ERR(pwm->clk);
> +	}

I guess you want to drop the first assignment to pwm->clk.

> +	/* Fallback for old dtbs with a single clock and no name */
> +	if (!pwm->clk) {
> +		pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->clk)) {
> +			dev_err(&pdev->dev, "get clock failed %ld\n",
> +				PTR_ERR(pwm->clk));
> +			return PTR_ERR(pwm->clk);
> +		}
> +	}

There is a slight change of behaviour if I'm not mistaken. If you have
this:

	clocks = <&clk1>;
	clock-names = "mod";

	pwm {
		compatible = "allwinner,sun4i-a10-pwm"
		clocks = <&clk2>;
	}

you now use clk1 instead of clk2 before.

Assuming this is only a theoretical problem, at least pointing this out
in the commit log would be good I think.

> +	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
> +	if (IS_ERR(pwm->bus_clk)) {
> +		dev_err(&pdev->dev, "get bus_clock failed %ld\n",
> +			PTR_ERR(pwm->bus_clk));
> +		return PTR_ERR(pwm->bus_clk);
> +	}
> +
>  	pwm->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
>  	if (IS_ERR(pwm->rst)) {
>  		if (PTR_ERR(pwm->rst) == -EPROBE_DEFER)
> @@ -381,6 +407,13 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Enable bus clock */
> +	ret = clk_prepare_enable(pwm->bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot prepare_enable bus_clk\n");

I'd do s/prepare_enable/prepare and enable/ here.

> +		goto err_bus;
> +	}
> +
>  	pwm->chip.dev = &pdev->dev;
>  	pwm->chip.ops = &sun4i_pwm_ops;
>  	pwm->chip.base = -1;
> @@ -401,6 +434,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_pwm_add:
> +	clk_disable_unprepare(pwm->bus_clk);
> +err_bus:
>  	reset_control_assert(pwm->rst);
>  
>  	return ret;

What is that clock used for? Is it required to access the hardware
registers? Or is it only required while the PWM is enabled? If so you
could enable the clock more finegrainded.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
