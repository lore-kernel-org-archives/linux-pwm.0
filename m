From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 3/6] pwm: sun4i: Add an optional probe for bus clock
Date: Thu, 21 Nov 2019 22:05:59 +0100
Message-ID: <20191121210559.pz3nsyomqfrjuoe4@pengutronix.de>
References: <20191121195902.6906-1-peron.clem@gmail.com>
 <20191121195902.6906-4-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191121195902.6906-4-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

On Thu, Nov 21, 2019 at 08:58:59PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM core needs bus clock to be enabled in order to work.
> 
> Add an optional probe for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 369990ae7d09..66befd8d6f9c 100644
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
> @@ -391,6 +392,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
> +	if (IS_ERR(pwm->bus_clk)) {
> +		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "get bus clock failed %pe\n",
> +				pwm->bus_clk);
> +		return PTR_ERR(pwm->bus_clk);
> +	}
> +
>  	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
>  	if (IS_ERR(pwm->rst)) {
>  		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> @@ -407,6 +416,17 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/*
> +	 * We're keeping the bus clock on for the sake of simplicity.
> +	 * Actually it only needs to be on for hardware register accesses.
> +	 */
> +	ret = clk_prepare_enable(pwm->bus_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot prepare and enable bus_clk %d\n",
> +			ret);

nitpick: other error messages in this driver start with a lower case
letter.

Until there is an equivalent for %pe that consumes an int, I suggest to
use

	dev_err(&pdev->dev, "Cannot prepare and enable bus_clk: %pe\n",
	        ERR_PTR(ret));

to benefit from a symbolic error name instead of an error constant.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
