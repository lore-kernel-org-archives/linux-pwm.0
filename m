From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] pwm: mediatek: add longer period support
Date: Sat, 7 Mar 2020 22:28:36 +0100
Message-ID: <1a3a523e-62ff-e380-c67b-12f742d348ea@gmail.com>
References: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
 <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39718 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgCGV2k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 7 Mar 2020 16:28:40 -0500
In-Reply-To: <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org



On 03/03/2020 11:19, Sam Shih wrote:
> The pwm clock source could be divided by 1625 with PWM_CON
> BIT(3) setting in mediatek hardware.
> 
> This patch add support for longer pwm period configuration,
> which allowing blinking LEDs via pwm interface.

Is this a fix? In this case please provide a Fixes tag with the commit ID which
introduced the bug.

Thanks
Matthias

> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index b94e0d09c300..c64ecff6c550 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -121,8 +121,11 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			       int duty_ns, int period_ns)
>  {
>  	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
> -	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
> -	    reg_thres = PWMTHRES;
> +	/* The source clock is divided by 2^clkdiv or iff the clksel bit
> +	 * is set by (2^clkdiv*1625)
> +	 */
> +	u32 clkdiv = 0, clksel = 0, cnt_period, cnt_duty,
> +	    reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
>  	u64 resolution;
>  	int ret;
>  
> @@ -133,12 +136,30 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	/* Using resolution in picosecond gets accuracy higher */
>  	resolution = (u64)NSEC_PER_SEC * 1000;
> +	/* Calculate resolution based on current clock frequency */
>  	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> -
> +	/* Using resolution to calculate cnt_period which represents
> +	 * the effective range of the PWM period counter
> +	 */
>  	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
>  	while (cnt_period > 8191) {
> +		/* Using clkdiv to reduce clock frequency and calculate
> +		 * new resolution based on new clock speed
> +		 */
>  		resolution *= 2;
>  		clkdiv++;
> +		if (clkdiv > PWM_CLK_DIV_MAX && !clksel) {
> +			/* Using clksel to divide the pwm source clock by
> +			 * an additional 1625, and recalculate new clkdiv
> +			 * and resolution
> +			 */
> +			clksel = 1;
> +			clkdiv = 0;
> +			resolution = (u64)NSEC_PER_SEC * 1000 * 1625;
> +			do_div(resolution,
> +				clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> +		}
> +		/* Calculate cnt_period based on resolution */
>  		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
>  						   resolution);
>  	}
> @@ -158,8 +179,13 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		reg_thres = PWM45THRES_FIXUP;
>  	}
>  
> +	/* Calculate cnt_duty based on resolution */
>  	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
> -	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> +	if (clksel)
> +		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) |
> +				    clkdiv);
> +	else
> +		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
>  	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
>  	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
>  
> 
