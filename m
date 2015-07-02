From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH v9 1/2] pwm: kona: Modify settings application sequence
Date: Thu, 2 Jul 2015 16:36:38 -0700
Message-ID: <5595CB06.6060005@broadcom.com>
References: <1434403262-24198-1-git-send-email-jonathar@broadcom.com> <1434403262-24198-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:39384 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbGBXgk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2015 19:36:40 -0400
In-Reply-To: <1434403262-24198-2-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hi Theirry,

If there are no more comments can this patch be applied?

Thanks,
Jon

On 15-06-15 02:21 PM, Jonathan Richardson wrote:
> Update the driver so that settings are applied in accordance with the
> most recent version of the hardware spec.  The revised sequence clears
> the trigger bit, waits 400ns, writes settings, sets the trigger bit,
> and waits another 400ns.  This corrects an issue where occasionally a
> requested change was not properly reflected in the PWM output.
> 
> Reviewed-by: Arun Ramamurthy <arunrama@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Scott Branden <sbranden@broadcom.com>
> Reviewed-by: Tim Kryger <tim.kryger@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c |   47 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 7af8fea..9b1d397 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -76,19 +76,36 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
>  	return container_of(_chip, struct kona_pwmc, chip);
>  }
>  
> -static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
> +/*
> + * Clear trigger bit but set smooth bit to maintain old output.
> + */
> +static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
> +	unsigned int chan)
>  {
>  	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
>  
> -	/* Clear trigger bit but set smooth bit to maintain old output */
>  	value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
>  	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
>  
> +	/*
> +	 * There must be a min 400ns delay between clearing trigger and setting
> +	 * it. Failing to do this may result in no PWM signal.
> +	 */
> +	ndelay(400);
> +}
> +
> +static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
> +{
> +	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
> +
>  	/* Set trigger bit and clear smooth bit to apply new settings */
>  	value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
>  	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
>  	writel(value, kp->base + PWM_CONTROL_OFFSET);
> +
> +	/* Trigger bit must be held high for at least 400 ns. */
> +	ndelay(400);
>  }
>  
>  static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -133,8 +150,14 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			return -EINVAL;
>  	}
>  
> -	/* If the PWM channel is enabled, write the settings to the HW */
> +	/*
> +	 * Don't apply settings if disabled. The period and duty cycle are
> +	 * always calculated above to ensure the new values are
> +	 * validated immediately instead of on enable.
> +	 */
>  	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> +		kona_pwmc_prepare_for_settings(kp, chan);
> +
>  		value = readl(kp->base + PRESCALE_OFFSET);
>  		value &= ~PRESCALE_MASK(chan);
>  		value |= prescale << PRESCALE_SHIFT(chan);
> @@ -164,6 +187,8 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return ret;
>  	}
>  
> +	kona_pwmc_prepare_for_settings(kp, chan);
> +
>  	value = readl(kp->base + PWM_CONTROL_OFFSET);
>  
>  	if (polarity == PWM_POLARITY_NORMAL)
> @@ -175,9 +200,6 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	kona_pwmc_apply_settings(kp, chan);
>  
> -	/* Wait for waveform to settle before gating off the clock */
> -	ndelay(400);
> -
>  	clk_disable_unprepare(kp->clk);
>  
>  	return 0;
> @@ -207,13 +229,20 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct kona_pwmc *kp = to_kona_pwmc(chip);
>  	unsigned int chan = pwm->hwpwm;
> +	unsigned int value;
> +
> +	kona_pwmc_prepare_for_settings(kp, chan);
>  
>  	/* Simulate a disable by configuring for zero duty */
>  	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
> -	kona_pwmc_apply_settings(kp, chan);
> +	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
>  
> -	/* Wait for waveform to settle before gating off the clock */
> -	ndelay(400);
> +	/* Set prescale to 0 for this channel */
> +	value = readl(kp->base + PRESCALE_OFFSET);
> +	value &= ~PRESCALE_MASK(chan);
> +	writel(value, kp->base + PRESCALE_OFFSET);
> +
> +	kona_pwmc_apply_settings(kp, chan);
>  
>  	clk_disable_unprepare(kp->clk);
>  }
> 
