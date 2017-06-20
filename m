From: John Crispin <john@phrozen.org>
Subject: Re: [PATCH 2/4] pwm: mediatek: fix clk issue
Date: Tue, 20 Jun 2017 09:00:41 +0200
Message-ID: <06d16cb2-ba57-f367-9af1-f96148f246f8@phrozen.org>
References: <1497941657-23876-1-git-send-email-zhi.mao@mediatek.com>
 <1497941657-23876-3-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:44635 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbdFTHAs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 20 Jun 2017 03:00:48 -0400
In-Reply-To: <1497941657-23876-3-git-send-email-zhi.mao@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com


On 20/06/17 08:54, Zhi Mao wrote:
> 1.fix clock control
>   - prepare top/main clk in mtk_pwm_probe() function,
>     it will increase power consumption
>     and in original code these clocks is only prepeare but never enabled
>   - pwm clock should be enabled before setting pwm registers
>     in function: mtk_pwm_config()
>
> 2.fix pwm source clock selection
>   - in original code, the pwm output frequency is not correct
>     when set bit<3>=1 to PWMCON register.
>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>

Hi Zhi,

it looks like you sent the series as text/html and also as text/plain 
with lines getting wrapped. You might want to try and use "git send-email"

> ---
>   drivers/pwm/pwm-mediatek.c |   69
>   +++++++++++++++++++++++++++-----------------
>   1 file changed, 43 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 5c11bc7..c803ff6 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
[ ... ]

> @@ -61,6 +62,40 @@ static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct
>   pwm_chip *chip)
>   	return container_of(chip, struct mtk_pwm_chip, chip);
>   }
>   
> +static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device
>   *pwm)
^^ here for example

     John

> +{
> +	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
> +	int ret = 0;
> +
> +	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(pc->clks[MTK_CLK_MAIN]);
> +	if (ret < 0) {
> +		clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> +	if (ret < 0) {
> +		clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> +		clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device
>   *pwm)
> +{
> +	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
> +
> +	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> +	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> +	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> +}
> +
>   static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int
>   num,
>   				unsigned int offset)
>   {
> @@ -81,6 +116,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct
>   pwm_device *pwm,
>   	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
>   	u32 resolution, clkdiv = 0;
>   
> +	mtk_pwm_clk_enable(chip, pwm);
> +
>   	resolution = NSEC_PER_SEC / clk_get_rate(clk);
>   
>   	while (period_ns / resolution > 8191) {
> @@ -91,10 +128,12 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct
>   pwm_device *pwm,
>   	if (clkdiv > 7)
>   		return -EINVAL;
>   
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
> +	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
>   	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
>   	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
>   
> +	mtk_pwm_clk_disable(chip, pwm);
> +
>   	return 0;
>   }
>   
> @@ -102,11 +141,8 @@ static int mtk_pwm_enable(struct pwm_chip *chip, struct
>   pwm_device *pwm)
>   {
>   	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
>   	u32 value;
> -	int ret;
>   
> -	ret = clk_prepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> -	if (ret < 0)
> -		return ret;
> +	mtk_pwm_clk_enable(chip, pwm);
>   
>   	value = readl(pc->regs);
>   	value |= BIT(pwm->hwpwm);
> @@ -124,7 +160,7 @@ static void mtk_pwm_disable(struct pwm_chip *chip,
>   struct pwm_device *pwm)
>   	value &= ~BIT(pwm->hwpwm);
>   	writel(value, pc->regs);
>   
> -	clk_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> +	mtk_pwm_clk_disable(chip, pwm);
>   }
>   
>   static const struct pwm_ops mtk_pwm_ops = {
> @@ -156,14 +192,6 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>   			return PTR_ERR(pc->clks[i]);
>   	}
>   
> -	ret = clk_prepare(pc->clks[MTK_CLK_TOP]);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = clk_prepare(pc->clks[MTK_CLK_MAIN]);
> -	if (ret < 0)
> -		goto disable_clk_top;
> -
>   	platform_set_drvdata(pdev, pc);
>   
>   	pc->chip.dev = &pdev->dev;
> @@ -174,26 +202,15 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>   	ret = pwmchip_add(&pc->chip);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> -		goto disable_clk_main;
> +		return ret;
>   	}
>   
>   	return 0;
> -
> -disable_clk_main:
> -	clk_unprepare(pc->clks[MTK_CLK_MAIN]);
> -disable_clk_top:
> -	clk_unprepare(pc->clks[MTK_CLK_TOP]);
> -
> -	return ret;
>   }
>   
>   static int mtk_pwm_remove(struct platform_device *pdev)
>   {
>   	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
> -	unsigned int i;
> -
> -	for (i = 0; i < pc->chip.npwm; i++)
> -		pwm_disable(&pc->chip.pwms[i]);
>   
>   	return pwmchip_remove(&pc->chip);
>   }
