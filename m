From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 03 Nov 2015 16:18:09 -0800
Message-ID: <56394EC1.4020304@gmail.com>
References: <1446545320.6627.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33243 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbbKDAS6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 19:18:58 -0500
Received: by pabfh17 with SMTP id fh17so33300227pab.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2015 16:18:57 -0800 (PST)
In-Reply-To: <1446545320.6627.0.camel@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, linux-pwm@vger.kernel.org

On 03/11/15 02:08, Axel Lin wrote:
> The .can_sleep flag is used for some PWM controllers that can't be used
> in atomic context. Not such case for this driver, so don't set the
> can_sleep flag.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> ---
>  drivers/pwm/pwm-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
> index 423ce08..f58039b 100644
> --- a/drivers/pwm/pwm-brcmstb.c
> +++ b/drivers/pwm/pwm-brcmstb.c
> @@ -270,7 +270,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
>  	p->chip.ops = &brcmstb_pwm_ops;
>  	p->chip.base = -1;
>  	p->chip.npwm = 2;
> -	p->chip.can_sleep = true;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	p->base = devm_ioremap_resource(&pdev->dev, res);
> 


-- 
Florian
