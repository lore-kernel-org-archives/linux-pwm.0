From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: remove set but not set variable 'pwm'
Date: Mon, 20 Jan 2020 08:34:07 +0100
Message-ID: <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
References: <20200119122202.14502-1-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46859 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATHeJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 02:34:09 -0500
Content-Disposition: inline
In-Reply-To: <20200119122202.14502-1-yukuai3@huawei.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: yu kuai <yukuai3@huawei.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, zhengbin13@huawei.com, yi.zhang@huawei.com

Hello,

$Subject ~= s/not set/not used/

On Sun, Jan 19, 2020 at 08:22:02PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
> drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but
> not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")

> ---
>  drivers/pwm/pwm-pca9685.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 168684b02ebc..b07bdca3d510 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -159,13 +159,9 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
>  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
>  {
>  	struct pca9685 *pca = gpiochip_get_data(gpio);
> -	struct pwm_device *pwm;
>  
>  	pca9685_pwm_gpio_set(gpio, offset, 0);
>  	pm_runtime_put(pca->chip.dev);
> -	mutex_lock(&pca->lock);
> -	pwm = &pca->chip.pwms[offset];
> -	mutex_unlock(&pca->lock);

Did you check that dropping the locking is save? (I didn't)

I'd assume that no harm is introduced, but mentioning that in the commit
log would be good.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
