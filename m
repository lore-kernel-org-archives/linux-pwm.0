From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] pwm: brcmstb: Don't set can_sleep flag
Date: Tue, 3 Nov 2015 16:31:53 -0800
Message-ID: <20151104003153.GJ7274@google.com>
References: <1446545320.6627.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33341 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbbKDAb4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2015 19:31:56 -0500
Received: by pabfh17 with SMTP id fh17so33631618pab.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Nov 2015 16:31:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446545320.6627.0.camel@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pwm@vger.kernel.org

On Tue, Nov 03, 2015 at 06:08:40PM +0800, Axel Lin wrote:
> The .can_sleep flag is used for some PWM controllers that can't be used
> in atomic context. Not such case for this driver, so don't set the
> can_sleep flag.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks sane to me, though I've never touched this driver.

Reviewed-by: Brian Norris <computersforpeace@gmail.com>

BTW just a comment from an outsider here, the "can sleep" terminology
seems a bit misleading here. Just IMO of course, but saying something
"can sleep" sounds like a permissive statement, when actually it's a
restrictive statement being made by the driver (which is in this case
unnecessarily restrictive). The "might sleep" terminology used in one
other place would (again IMO) better communicate what I think is
intended here.

Though this problem is most likely result of mindless copy-and-paste,
it's possible that the terminology made it easier to gloss over. Or I
could just be blowing smoke.

Regards,
Brian

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
> -- 
> 2.1.4
> 
> 
> 
