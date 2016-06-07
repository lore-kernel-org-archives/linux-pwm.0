From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [[PATCH v2] 09/11] pwm: sti: Add support for
 PWM Capture IRQs
Date: Tue, 7 Jun 2016 09:14:55 +0100
Message-ID: <20160607081455.GB22744@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <1461320295-20414-10-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461320295-20414-10-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, thierry.reding@gmail.com
List-Id: linux-pwm@vger.kernel.org

Hi Lee,

On Fri, 22 Apr 2016, Lee Jones wrote:

> Here we're requesting the PWM Capture IRQ and supplying the
> handler which will be called in the event of an IRQ fire to
> handle it.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 9d597bb..2230afb 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -91,7 +91,9 @@ struct sti_pwm_chip {
>  	struct regmap_field *prescale_low;
>  	struct regmap_field *prescale_high;
>  	struct regmap_field *pwm_out_en;
> +	struct regmap_field *pwm_cpt_en;
>  	struct regmap_field *pwm_cpt_int_en;
> +	struct regmap_field *pwm_cpt_int_stat;
>  	struct pwm_chip chip;
>  	struct pwm_device *cur;
>  	unsigned long configured;
> @@ -311,6 +313,76 @@ static const struct pwm_ops sti_pwm_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static irqreturn_t sti_pwm_interrupt(int irq, void *data)
> +{
> +	struct sti_pwm_chip *pc = data;
> +	struct device *dev = pc->dev;
> +	struct sti_cpt_ddata *ddata;
> +	int devicenum;
> +	unsigned int cpt_int_stat;
> +	unsigned int reg;
> +	int ret = IRQ_NONE;
> +
> +	ret = regmap_field_read(pc->pwm_cpt_int_stat, &cpt_int_stat);
> +	if (ret)
> +		return ret;
> +
> +	while (cpt_int_stat) {
> +		devicenum = ffs(cpt_int_stat) - 1;
> +
> +		ddata = pwm_get_chip_data(&pc->chip.pwms[devicenum]);
> +
> +		/*
> +		 * Capture input:
> +		 *    _______                   _______
> +		 *   |       |                 |       |
> +		 * __|       |_________________|       |________
> +		 *   ^0      ^1                ^2
> +		 *
> +		 * Capture start by the first available rising edge
> +		 * When a capture event occurs, capture value (CPT_VALx)
> +		 * is stored, index incremented, capture edge changed.
> +		 *
> +		 * After the capture, if the index > 1, we have collected
> +		 * the necessary data so we signal the thread waiting for it
> +		 * and disable the capture by setting capture edge to none
> +		 *
> +		 */
> +
> +		regmap_read(pc->regmap,
> +			    PWM_CPT_VAL(devicenum),
> +			    &ddata->snapshot[ddata->index]);
> +
> +		switch (ddata->index) {
> +		case 0:
> +		case 1:
> +			regmap_read(pc->regmap, PWM_CPT_EDGE(devicenum), &reg);
> +			reg ^= PWM_CPT_EDGE_MASK;
> +			regmap_write(pc->regmap, PWM_CPT_EDGE(devicenum), reg);
> +
> +			ddata->index++;
> +			break;
> +		case 2:
> +			regmap_write(pc->regmap,
> +				     PWM_CPT_EDGE(devicenum),
> +				     CPT_EDGE_DISABLED);
> +			wake_up(&ddata->wait);
> +			break;
> +		default:
> +			dev_err(dev, "Internal error\n");
> +		}
> +
> +		cpt_int_stat &= ~BIT_MASK(devicenum);
> +
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	/* Just ACK everything */
> +	regmap_write(pc->regmap, PWM_INT_ACK, PWM_INT_ACK_MASK);
> +
> +	return ret;
> +}
> +
>  static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  {
>  	struct device *dev = pc->dev;
> @@ -351,6 +423,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  	if (IS_ERR(pc->pwm_cpt_int_en))
>  		return PTR_ERR(pc->pwm_cpt_int_en);
>  
> +	pc->pwm_cpt_int_stat = devm_regmap_field_alloc(dev, pc->regmap,
> +						reg_fields[PWM_CPT_INT_STAT]);
> +	if (PTR_ERR_OR_ZERO(pc->pwm_cpt_int_stat))
> +		return PTR_ERR(pc->pwm_cpt_int_stat);
> +
>  	return 0;
>  }
>  
> @@ -367,7 +444,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	struct sti_pwm_chip *pc;
>  	struct resource *res;
>  	unsigned int devnum;
> -	int ret;
> +	int irq, ret;
>  
>  	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>  	if (!pc)
> @@ -388,6 +465,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->regmap))
>  		return PTR_ERR(pc->regmap);
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt,
> +			       0, pdev->name, pc);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to request IRQ\n");
> +		return ret;
> +	}
> +
>  	/*
>  	 * Setup PWM data with default values: some values could be replaced
>  	 * with specific ones provided from Device Tree.

pwm-st.txt dt binding document and pwm example needs updating to document this
irq.

regards,

Peter
