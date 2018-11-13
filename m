From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date: Tue, 13 Nov 2018 10:52:10 +0100
Message-ID: <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, kernel@pengutronix.de, linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> The flag 'has_clks' and related checks are superfluous as the CCF
> subsystem does this for you.

I'd write instead:

	Handle optional clocks by using NULL as clk instead of a
	separate bool field in the device's platform data.

There is a semantic difference this patch introduces (i.e. if on mt2712
there are no provided clocks, the driver now successfully binds while
before it failed with -ENOENT. And for mt7628 it's the other way round). 
IMHO this should be noted in the commit log, too. Otherwise it sounds as
if this patch was just an optimisation without side effects.

> ---
>  drivers/pwm/pwm-mediatek.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index eb6674c..9400c41 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -57,7 +57,6 @@ enum {
>  struct mtk_pwm_platform_data {
>  	unsigned int num_pwms;
>  	bool pwm45_fixup;
> -	bool has_clks;
>  };
>  
>  /**
> @@ -87,9 +86,6 @@ static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
>  	int ret;
>  
> -	if (!pc->soc->has_clks)
> -		return 0;
> -
>  	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
>  	if (ret < 0)
>  		return ret;
> @@ -116,9 +112,6 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
>  
> -	if (!pc->soc->has_clks)
> -		return;
> -
>  	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
>  	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
>  	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> @@ -246,12 +239,13 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->regs))
>  		return PTR_ERR(pc->regs);
>  
> -	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> +	for (i = 0; i < data->num_pwms + 2; i++) {
>  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
>  		if (IS_ERR(pc->clks[i])) {
> -			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> -				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
> -			return PTR_ERR(pc->clks[i]);
> +			if (PTR_ERR(pc->clks[i]) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +
> +			pc->clks[i] = NULL;

I'd prefer the following instead:

	pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
	if (IS_ERR(pc->clks[i])) {
		if (PTR_ERR(pc->clks[i]) == -ENODEV) {
			pc->clks[i] = NULL;
		} else {
			if (PTR_ERR(pc->clks[i]) == -EPROBE_DEFER)
				dev_err(...);
			return PTR_ERR(pc->clks[i]);
		}

This way you only handle "There is no such clock" and are not ignoring
say an IO error.

I wonder if it would make sense to introduce functions like:

	struct clk *clk_get_optional(struct device *dev, const char *id)

that return NULL instead of ERR_PTR(-ENODEV).

Then the above would simplify to:

	pc->clks[i] = devm_clk_get_optional(&pdev->dev, mtk_pwm_clk_name[i]);
	if (IS_ERR(pc->clks[i]) {
		if (PTR_ERR(pc->clks[i]) == -EPROBE_DEFER)
			dev_err(...);
		return PTR_ERR(pc->clks[i]);
	}

(added the clk people to Cc for this question).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
