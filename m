From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH 1/2] pwm: pca9685: fix period change with same duty cycle
Date: Fri, 13 Jan 2017 13:43:19 +0100
Message-ID: <20170113124318.GA5723@archie.localdomain>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:21886 "EHLO
        mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdAMMvj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Jan 2017 07:51:39 -0500
Content-Disposition: inline
In-Reply-To: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Tue, Dec 13, 2016 at 04:52:50PM +0100, Clemens Gruber wrote:
> When first implementing support for changing the output frequency, an
> optimization was added to continue the PWM after changing the prescaler
> without having to reprogram the ON and OFF registers for the duty cycle,
> in case the duty cycle stayed the same.
> This was flawed, because we compared the absolute value of the duty
> cycle in nanoseconds instead of the ratio to the period.
> 
> Fix the problem by removing the shortcut.
> 
> Fixes: 01ec8472009c9 ("pwm-pca9685: Support changing the output
> frequency")
> Cc: <stable@vger.kernel.org> # v4.3+
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 117fccf..01a6a83 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -65,7 +65,6 @@
>  #define PCA9685_MAXCHAN		0x10
>  
>  #define LED_FULL		(1 << 4)
> -#define MODE1_RESTART		(1 << 7)
>  #define MODE1_SLEEP		(1 << 4)
>  #define MODE2_INVRT		(1 << 4)
>  #define MODE2_OUTDRV		(1 << 2)
> @@ -117,16 +116,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			udelay(500);
>  
>  			pca->period_ns = period_ns;
> -
> -			/*
> -			 * If the duty cycle did not change, restart PWM with
> -			 * the same duty cycle to period ratio and return.
> -			 */
> -			if (duty_ns == pca->duty_ns) {
> -				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> -						   MODE1_RESTART, 0x1);
> -				return 0;
> -			}
>  		} else {
>  			dev_err(chip->dev,
>  				"prescaler not set: period out of bounds!\n");
> -- 
> 2.10.2
> 

Hi Thierry,

did you have a chance to look at my two bugfix patches for the PCA9685?
They fix two problems, I caused when implementing the prescaler support.

The first one just leads to also configuring the ON and OFF time
registers when changing the prescaler frequency and no longer relying on
a shortcut which did not work correctly:
https://patchwork.ozlabs.org/patch/705438/

The second one just reads in the current value and if it matches the
default, there is no need to change it.
(Changing would mean stopping the chip, sleeping, etc.)
https://patchwork.ozlabs.org/patch/705437/

They should both go in at the same time and are both rather small
changes.

Thanks,
Clemens
