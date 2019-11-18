From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 3/8] pwm: sun4i: Prefer "mod" clock to unnamed
Date: Mon, 18 Nov 2019 10:50:00 +0100
Message-ID: <20191118095000.gmvnmrtsbjf7nbsq@pengutronix.de>
References: <20191118093727.21899-1-peron.clem@gmail.com>
 <20191118093727.21899-4-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191118093727.21899-4-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Nov 18, 2019 at 10:37:22AM +0100, Clément Péron wrote:
> New device tree bindings called the source clock of the module
> "mod" when several clocks are defined.
> 
> Try to get a clock called "mod" if nothing is found try to get
> an unnamed clock.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index c17935805690..bbb1ed194c0e 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -362,9 +362,34 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->base))
>  		return PTR_ERR(pwm->base);
>  
> -	pwm->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pwm->clk))
> +	/*
> +	 * All hardware variants need a source clock that is divided and
> +	 * then feeds the counter that defines the output wave form. In the
> +	 * device tree this clock is either unnamed or called "mod".
> +	 * Some variants (e.g. H6) need another clock to access the
> +	 * hardware registers; this is called "bus".
> +	 * So we request "mod" first (and ignore the corner case that a
> +	 * parent provides a "mod" clock while the right one would be the
> +	 * unnamed one of the PWM device) and if this is not found we fall
> +	 * back to the first clock of the PWM.
> +	 */
> +	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
> +	if (IS_ERR(pwm->clk)) {
> +		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "get clock failed %pe\n",
> +				pwm->clk);

I think the line break isn't needed here. Unless I'm mistaken the final
; will end in column 80 which is fine.

>  		return PTR_ERR(pwm->clk);
> +	}
> +
> +	if (!pwm->clk) {
> +		pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pwm->clk)) {
> +			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "get clock failed %pe\n",
> +					pwm->clk);

A different error message than above would be nice to be able to
distinguish the two cases.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
