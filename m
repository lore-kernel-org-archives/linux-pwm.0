From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] pwm: lpss: Use positive condition in
 pwm_lpss_prepare()
Date: Wed, 15 Jan 2020 16:54:25 +0100
Message-ID: <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
References: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAOPy3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jan 2020 10:54:29 -0500
Content-Disposition: inline
In-Reply-To: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 05:08:49PM +0200, Andy Shevchenko wrote:
> For better readability and maintenance use positive condition
> in pwm_lpss_prepare(). No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 75bbfe5f3bc2..6930a1d99860 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -109,10 +109,11 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>  	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
>  	ctrl |= on_time_div;
>  
> -	if (orig_ctrl != ctrl) {
> -		pwm_lpss_write(pwm, ctrl);
> -		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> -	}
> +	if (orig_ctrl == ctrl)
> +		return;
> +
> +	pwm_lpss_write(pwm, ctrl);
> +	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);

I personally don't think that readability improved much and think that
the old code is more intuitive. ("If the wanted register value doesn't
match the actual value, write the value out.")

But I agree that the patch doesn't introduce a semantic difference.

What made you create that patch? Is it really that you read through the
driver and thought "Huh, this is more complicated than necessary."?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
