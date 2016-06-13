From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: pwm: atmel: Fix disabling of PWM channels
Date: Mon, 13 Jun 2016 11:50:07 +0200
Message-ID: <20160613095007.GB3240@piout.net>
References: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guillermo Rodriguez <guille.rodriguez@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-pwm@vger.kernel.org

On 13/05/2016 at 13:09:37 +0200, Guillermo Rodriguez wrote :
> When disabling a PWM channel, the PWM clock was being stopped
> immediately after writing to PWM_DIS. As a result, the disabling
> of the PWM channel did not complete properly, and the PWM output
> might be left at the wrong level.
> 
> Fix this by waiting for the channel to be effectively disabled
> (by checking the PWM_SR register) before disabling the clock.
> 
> Signed-off-by: Guillermo Rodriguez <guille.rodriguez@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/pwm/pwm-atmel.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 0e4bd4e..a714434 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -271,6 +271,16 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	mutex_unlock(&atmel_pwm->isr_lock);
>  	atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
>  
> +	/*
> +	 * Wait for the PWM channel disable operation to be effective before
> +	 * stopping the clock.
> +	 */
> +	timeout = jiffies + 2 * HZ;
> +	while ((atmel_pwm_readl(atmel_pwm, PWM_SR)& (1 << pwm->hwpwm)) &&
> +	       time_before(jiffies, timeout)) {
> +		usleep_range(10, 100);
> +	}
> +
>  	clk_disable(atmel_pwm->clk);
>  }
>  

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
