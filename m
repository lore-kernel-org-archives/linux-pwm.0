From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: core: Set enable state properly on failed
 call to enable
Date: Wed, 11 Feb 2015 15:59:42 -0800
Message-ID: <20150211235942.GF29440@dtor-ws>
References: <jonathar@broadcom.com>
 <1420659771-31401-1-git-send-email-jonathar@broadcom.com>
 <1420659771-31401-3-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:34314 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbBKX7u (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Feb 2015 18:59:50 -0500
Content-Disposition: inline
In-Reply-To: <1420659771-31401-3-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Scott Branden <sbranden@broadcom.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Wed, Jan 07, 2015 at 11:42:51AM -0800, Jonathan Richardson wrote:
> The pwm_enable function didn't clear the enabled bit if a call to a
> clients enable function returned an error. The result was that the state
> of the pwm core was wrong. Clearing the bit when enable returns an error
> ensures the state is properly set.
> 
> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/core.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index f28c4ce..c33e24f 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -477,8 +477,14 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
> -		return pwm->chip->ops->enable(pwm->chip, pwm);
> +	int err;
> +
> +	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
> +		err = pwm->chip->ops->enable(pwm->chip, pwm);
> +		if (err)
> +			clear_bit(PWMF_ENABLED, &pwm->flags);
> +		return err;
> +	}
>  
>  	return pwm ? 0 : -EINVAL;

Seems fine in principle, but somewhat messy. Can we do the following:

int pwm_enable(struct pwm_device *pwm)
{
	int err;

	if (!pwm)
		return -EINVAL;

	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
		err = pwm->chip->ops->enable(pwm->chip, pwm);
		if (err) {
			clear_bit(PWMF_ENABLED, &pwm->flags);
			return err;
		}
	}

	return 0;
}

Otherwise:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
