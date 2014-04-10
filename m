From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] pwm: atmel: set pwm_chip can_sleep flag
Date: Thu, 10 Apr 2014 15:51:35 +0200
Message-ID: <5346A1E7.4010000@atmel.com>
References: <1397067969-19905-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:37216 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933057AbaDJNvj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Apr 2014 09:51:39 -0400
In-Reply-To: <1397067969-19905-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/04/2014 20:26, Alexandre Belloni :
> atmel_pwm_config() calls clk_get_rate() which might sleep, so we need to set
> pwm_chip can_sleep flag.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/pwm/pwm-atmel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 0e589594b1cb..180e34e46617 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -369,6 +369,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>  
>  	atmel_pwm->chip.base = -1;
>  	atmel_pwm->chip.npwm = 4;
> +	atmel_pwm->chip.can_sleep = true;
>  	atmel_pwm->config = data->config;
>  
>  	ret = pwmchip_add(&atmel_pwm->chip);
> 


-- 
Nicolas Ferre
