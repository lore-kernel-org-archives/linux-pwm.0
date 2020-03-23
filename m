From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
Date: Mon, 23 Mar 2020 09:28:23 +0100
Message-ID: <20200323082823.twvpagq7tvrt76ws@pengutronix.de>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-3-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48599 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCWI20 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 04:28:26 -0400
Content-Disposition: inline
In-Reply-To: <20200323065318.16533-3-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:23:18PM +0530, Rayagonda Kokatanur wrote:
> Variable 'duty' is u32. Hence the less-than zero
> comparison is never true, remove the check.

How did you find that one? I assume it was a compiler warning you fixed
here? In this case quoting the warning improves the commit log.

Also the commit log suggests that IPROC_PWM_DUTY_CYCLE_MIN is zero.
Maybe mentioning that explicitly is a nice addition, too.

> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 8bbd2a04fead..1bb66721f985 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -149,8 +149,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		value = rate * state->duty_cycle;
>  		duty = div64_u64(value, div);
>  
> -		if (period < IPROC_PWM_PERIOD_MIN ||
> -		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
> +		if (period < IPROC_PWM_PERIOD_MIN)
>  			return -EINVAL;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
