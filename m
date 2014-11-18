From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: add at91sam9x5 and sama5d3 errata handling
Date: Tue, 18 Nov 2014 15:35:11 +0100
Message-ID: <546B591F.6040108@atmel.com>
References: <1416314453-28597-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:62962 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbaKROfQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 09:35:16 -0500
In-Reply-To: <1416314453-28597-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>

On 18/11/2014 13:40, Boris Brezillon :
> at91sam9x5 has an errata forbidding the use of slow clk as a clk source and
> sama5d3 SoCs has another errata forbidding the use of div1 prescaler.
> 
> Take both of these erratas into account.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks for having dealt with this.

Bye,

> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index eaf8b12..405f8a5 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -36,6 +36,8 @@ struct atmel_hlcdc_pwm {
>  	struct pwm_chip chip;
>  	struct atmel_hlcdc *hlcdc;
>  	struct clk *cur_clk;
> +	bool slow_clk_errata;
> +	bool div1_clk_errata;
>  };
>  
>  static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
> @@ -56,20 +58,28 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
>  	u32 pwmcfg;
>  	int pres;
>  
> -	clk_freq = clk_get_rate(new_clk);
> -	clk_period_ns = (u64)NSEC_PER_SEC * 256;
> -	do_div(clk_period_ns, clk_freq);
> +	if (!chip->slow_clk_errata) {
> +		clk_freq = clk_get_rate(new_clk);
> +		clk_period_ns = (u64)NSEC_PER_SEC * 256;
> +		do_div(clk_period_ns, clk_freq);
> +	}
>  
> -	if (clk_period_ns > period_ns) {
> +	/* Errata: cannot use slow clk on some IP revisions */
> +	if (chip->slow_clk_errata || clk_period_ns > period_ns) {
>  		new_clk = hlcdc->sys_clk;
>  		clk_freq = clk_get_rate(new_clk);
>  		clk_period_ns = (u64)NSEC_PER_SEC * 256;
>  		do_div(clk_period_ns, clk_freq);
>  	}
>  
> -	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++)
> +	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
> +		/* Errata: cannot divide by 1 on some IP revisions */
> +		if (!pres && chip->div1_clk_errata)
> +			continue;
> +
>  		if ((clk_period_ns << pres) >= period_ns)
>  			break;
> +	}
>  
>  	if (pres > ATMEL_HLCDC_PWMPS_MAX)
>  		return -EINVAL;
> @@ -204,6 +214,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (of_device_is_compatible(dev->parent->of_node,
> +				    "atmel,sama5d3-hlcdc"))
> +		chip->div1_clk_errata = true;
> +
> +	if (of_device_is_compatible(dev->parent->of_node,
> +				    "atmel,at91sam9x5-hlcdc"))
> +		chip->slow_clk_errata = true;
> +
>  	chip->hlcdc = hlcdc;
>  	chip->chip.ops = &atmel_hlcdc_pwm_ops;
>  	chip->chip.dev = dev;
> 


-- 
Nicolas Ferre
