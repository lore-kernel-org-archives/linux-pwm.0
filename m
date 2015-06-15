From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH v9 2/2] pwm: core: Set enable state properly on failed
 call to enable
Date: Mon, 15 Jun 2015 16:22:27 -0700
Message-ID: <557F5E33.2050706@broadcom.com>
References: <1434403262-24198-1-git-send-email-jonathar@broadcom.com> <1434403262-24198-3-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:10019 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbFOXWa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2015 19:22:30 -0400
In-Reply-To: <1434403262-24198-3-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On 15-06-15 02:21 PM, Jonathan Richardson wrote:
> The pwm_enable function didn't clear the enabled bit if a call to a
> clients enable function returned an error. The result was that the state
> of the pwm core was wrong. Clearing the bit when enable returns an error
> ensures the state is properly set.
> 
> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/core.c  |   19 ++++++++++++++++---
>  include/linux/pwm.h |    2 ++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 76b0386..c255267 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -263,6 +263,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  		pwm->pwm = chip->base + i;
>  		pwm->hwpwm = i;
>  		pwm->polarity = polarity;
> +		mutex_init(&pwm->lock);
>  
>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>  	}
> @@ -474,10 +475,22 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
> -		return pwm->chip->ops->enable(pwm->chip, pwm);
> +	int err = 0;
>  
> -	return pwm ? 0 : -EINVAL;
> +	if (!pwm)
> +		return -EINVAL;
> +
> +	mutex_lock(&pwm->lock);
> +
> +	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
> +		err = pwm->chip->ops->enable(pwm->chip, pwm);
> +		if (err)
> +			clear_bit(PWMF_ENABLED, &pwm->flags);
> +	}
> +
> +	mutex_unlock(&pwm->lock);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(pwm_enable);

I meant to add the mutex check in disable also, but what about when
PWMF_ENABLED is checked in pwm_set_polarity() and pwm_dbg_show()?

Thanks.
