From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 3/7] pwm: sun4i: Add an optional probe for bus clock
Date: Tue, 5 Nov 2019 14:57:45 +0100
Message-ID: <20191105135745.mf63pelpbekmitgm@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-4-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191105131456.32400-4-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:52PM +0100, Clément Péron wrote:
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
>  drivers/pwm/pwm-sun4i.c | 45 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 9ba83769a478..54e19fa56a4e 100644
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
> @@ -363,9 +364,35 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->base))
>  		return PTR_ERR(pwm->base);
>  
> -	pwm->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pwm->clk))
> +	/* Get all clocks and reset line */
> +	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
> +	if (IS_ERR(pwm->clk)) {
> +		dev_err(&pdev->dev, "get clock failed %ld\n",
> +			PTR_ERR(pwm->clk));

Please only print this message if PTR_ERR(pwm->clk) != -EPROBE_DEFER.
You might also want to make use of commit 57f5677e535b ("printf: add
support for printing symbolic error names") and use

	dev_err(&pdev->dev, "get clock failed: %pe\n", pwm->clk);

Other than that the patch is fine for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
