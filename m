From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/10] pwm: mediatek: allocate the clks array
 dynamically
Date: Fri, 16 Aug 2019 10:49:18 +0200
Message-ID: <20190816084918.gnpeosid2uqb6cgb@pengutronix.de>
References: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
 <1565940088-845-3-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565940088-845-3-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Fri, Aug 16, 2019 at 03:21:20PM +0800, Sam Shih wrote:
> @@ -119,9 +104,9 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	if (!pc->soc->has_clks)
>  		return;
>  
> -	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> -	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> -	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> +	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
> +	clk_disable_unprepare(pc->clk_main);
> +	clk_disable_unprepare(pc->clk_top);
>  }
>  
>  static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
> @@ -141,7 +126,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  int duty_ns, int period_ns)
>  {
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
> -	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
> +	struct clk *clk = pc->soc->has_clks ? pc->clk_pwms[pwm->hwpwm] : NULL;

iff pc->soc->has_clks is false, pc->clk_pwms is NULL, right? Checking
the latter would be cheaper. (One pointer dereference that you then
reuse compared to two pointer dereferences.)

>  	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
>  	    reg_thres = PWMTHRES;
>  	u64 resolution;
> @@ -229,7 +214,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i, npwms;
> +	unsigned int npwms;
>  	int ret;
>  
>  	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> @@ -255,12 +240,29 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	for (i = 0; i < npwms + 2 && pc->soc->has_clks; i++) {
> -		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> -		if (IS_ERR(pc->clks[i])) {
> -			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> -				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
> -			return PTR_ERR(pc->clks[i]);
> +	if (pc->soc->has_clks) {
> +		int i;
> +
> +		pc->clk_pwms = devm_kcalloc(&pdev->dev, npwms,
> +					    sizeof(*pc->clk_pwms), GFP_KERNEL);
> +		if (!pc->clk_pwms)
> +			return -ENOMEM;
> +
> +		pc->clk_top = devm_clk_get(&pdev->dev, "top");
> +		if (IS_ERR(pc->clk_top))
> +			return PTR_ERR(pc->clk_top);
> +
> +		pc->clk_main = devm_clk_get(&pdev->dev, "main");
> +		if (IS_ERR(pc->clk_main))
> +			return PTR_ERR(pc->clk_main);
> +
> +		for (i = 0; i < npwms; i++) {
> +			char name[8];
> +
> +			snprintf(name, sizeof(name), "pwm%d", i + 1);
> +			pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
> +			if (IS_ERR(pc->clk_pwms[i]))
> +				return PTR_ERR(pc->clk_pwms[i]);

You dropped the error message here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
