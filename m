From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date: Mon, 23 Mar 2020 09:25:40 +0100
Message-ID: <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33171 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgCWIZp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 04:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:23:17PM +0530, Rayagonda Kokatanur wrote:
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.

Was this noticed during a review and is more theoretic. Or does this
(depending on pre-boot state) result in a kernel crash?

> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..8bbd2a04fead 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	else
>  		state->polarity = PWM_POLARITY_INVERSED;
>  
> -	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> -	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> -	prescale &= IPROC_PWM_PRESCALE_MAX;
> -
> -	multi = NSEC_PER_SEC * (prescale + 1);
> -
> -	value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> -	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> -	state->period = div64_u64(tmp, rate);
> -
> -	value = readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> -	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> -	state->duty_cycle = div64_u64(tmp, rate);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +	} else {
> +		value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> +		prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> +		prescale &= IPROC_PWM_PRESCALE_MAX;
> +
> +		multi = NSEC_PER_SEC * (prescale + 1);
> +
> +		value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> +		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> +		state->period = div64_u64(tmp, rate);
> +
> +		value = readl(ip->base +
> +			      IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> +		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
> +		state->duty_cycle = div64_u64(tmp, rate);
> +	}

The change looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
