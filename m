From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 2/7] pwm: sun4i: Add an optional probe for reset line
Date: Tue, 05 Nov 2019 14:36:23 +0100
Message-ID: <a8908f1157e862164fb1bea07f8d5e1812325858.camel@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
         <20191105131456.32400-3-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105131456.32400-3-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 'Uwe =?ISO-8859-1?Q?Kleine-K=F6nig=27?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

On Tue, 2019-11-05 at 14:14 +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM core needs deasserted reset line in order to work.
> 
> Add an optional probe for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
>  drivers/pwm/pwm-sun4i.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 6f5840a1a82d..9ba83769a478 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
[...]
> @@ -365,6 +367,21 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> +	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->rst)) {
> +		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "get reset failed %ld\n",
> +				PTR_ERR(pwm->rst));
> +		return PTR_ERR(pwm->rst);
> +	}
> +
> +	/* Deassert reset */

Nitpick: isn't the API function name explanatory enough?

regards
Philipp
