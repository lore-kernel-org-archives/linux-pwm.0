From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] pwm: mediatek: fix up PWM4 and PWM5 malfunction on MT7623
Date: Tue, 9 Jan 2018 16:32:02 +0100
Message-ID: <0ebe339a-f40e-8567-e475-a0e671409777@gmail.com>
References: <7ddf36f5b9400b29578d4897ddea72c57c1c8d11.1514213639.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:42398 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbeAIPcI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jan 2018 10:32:08 -0500
In-Reply-To: <7ddf36f5b9400b29578d4897ddea72c57c1c8d11.1514213639.git.sean.wang@mediatek.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: sean.wang@mediatek.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>



On 12/25/2017 03:59 PM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> programming on PWM hardware causes waveform cannot be output as expected.
> Thus, the patch adds the extra condition for fixing up the weird case to
> let PWM4 or PWM5 able to work on MT7623.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Zhi Mao <zhi.mao@mediatek.com>
> Cc: John Crispin <john@phrozen.org>
> ---
>  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index f5d97e0..9311574 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -29,7 +29,9 @@
>  #define PWMGDUR			0x0c
>  #define PWMWAVENUM		0x28
>  #define PWMDWIDTH		0x2c
> +#define PWM45DWIDTH_QUIRK	0x30
>  #define PWMTHRES		0x30
> +#define PWM45THRES_QUIRK	0x34
>  
>  #define PWM_CLK_DIV_MAX		7
>  
> @@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
>  
>  struct mtk_pwm_platform_data {
>  	unsigned int num_pwms;
> +	bool pwm45_quirk;
>  };
>  
>  /**
> @@ -66,6 +69,7 @@ struct mtk_pwm_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
>  	struct clk *clks[MTK_CLK_MAX];
> +	const struct mtk_pwm_platform_data *soc;
>  };
>  
>  static const unsigned int mtk_pwm_reg_offset[] = {
> @@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
>  	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
> -	u32 resolution, clkdiv = 0;
> +	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
> +	    reg_thres = PWMTHRES;
>  	int ret;
>  
>  	ret = mtk_pwm_clk_enable(chip, pwm);
> @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return -EINVAL;
>  	}
>  
> +	if (pc->soc->pwm45_quirk && pwm->hwpwm > 2) {
> +		/*
> +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> +		 * from the other PWMs on MT7623.
> +		 */
> +		reg_width = PWM45DWIDTH_QUIRK;
> +		reg_thres = PWM45THRES_QUIRK;
> +	}
> +
>  	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
> +	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
> +	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
>  
>  	mtk_pwm_clk_disable(chip, pwm);
>  
> @@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	data = of_device_get_match_data(&pdev->dev);
>  	if (data == NULL)
>  		return -EINVAL;
> +	pc->soc = data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
> @@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>  
>  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
>  	.num_pwms = 8,
> +	.pwm45_quirk = false,

Hm for me it doesn't look like a quirk but just the values a different. I wonder
why you decided to add a quirk flag. I'd added the access values to the
mtk_pwm_platform_data struct directly.

Regards,
Matthias
