From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: Re: [PATCH] pwm: atmel: Fix disabling of PWM channels
Date: Thu, 9 Jun 2016 18:36:31 +0200
Message-ID: <CABDcavbouRueiO+fZECetfrhoNWZHJowptbvtkRNTN6zwGssbA@mail.gmail.com>
References: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35449 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcFIQgd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jun 2016 12:36:33 -0400
In-Reply-To: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Guillermo Rodriguez <guille.rodriguez@gmail.com>

Hello,

Any comments on this patch?

Guillermo

2016-05-13 13:09 GMT+02:00 Guillermo Rodriguez <guille.rodriguez@gmail.com>:
> When disabling a PWM channel, the PWM clock was being stopped
> immediately after writing to PWM_DIS. As a result, the disabling
> of the PWM channel did not complete properly, and the PWM output
> might be left at the wrong level.
>
> Fix this by waiting for the channel to be effectively disabled
> (by checking the PWM_SR register) before disabling the clock.
>
> Signed-off-by: Guillermo Rodriguez <guille.rodriguez@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 0e4bd4e..a714434 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -271,6 +271,16 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>         mutex_unlock(&atmel_pwm->isr_lock);
>         atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
>
> +       /*
> +        * Wait for the PWM channel disable operation to be effective before
> +        * stopping the clock.
> +        */
> +       timeout = jiffies + 2 * HZ;
> +       while ((atmel_pwm_readl(atmel_pwm, PWM_SR)& (1 << pwm->hwpwm)) &&
> +              time_before(jiffies, timeout)) {
> +               usleep_range(10, 100);
> +       }
> +
>         clk_disable(atmel_pwm->clk);
>  }
>
> --
> 1.7.9.5
>



-- 
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
