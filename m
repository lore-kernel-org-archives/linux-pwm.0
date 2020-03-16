From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/3] pwm: rcar: Fix late Runtime PM enablement
Date: Mon, 16 Mar 2020 18:02:14 +0200
Message-ID: <20200316160214.GN4732@pendragon.ideasonboard.com>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:38196 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbgCPQCY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:02:24 -0400
Content-Disposition: inline
In-Reply-To: <20200316103216.29383-2-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 11:32:14AM +0100, Geert Uytterhoeven wrote:
> Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> can appear immediately after the PWM chip has been added.
> Likewise, Runtime PM should be disabled after the removal of the PWM
> chip.
> 
> Fixes: ed6c1476bf7f16d5 ("pwm: Add support for R-Car PWM Timer")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pwm/pwm-rcar.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 2685577b6dd45be7..7ab9eb6616d950cb 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -229,24 +229,28 @@ static int rcar_pwm_probe(struct platform_device *pdev)
>  	rcar_pwm->chip.base = -1;
>  	rcar_pwm->chip.npwm = 1;
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = pwmchip_add(&rcar_pwm->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
>  	}
>  
> -	pm_runtime_enable(&pdev->dev);
> -
>  	return 0;
>  }
>  
>  static int rcar_pwm_remove(struct platform_device *pdev)
>  {
>  	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = pwmchip_remove(&rcar_pwm->chip);
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> -	return pwmchip_remove(&rcar_pwm->chip);
> +	return ret;
>  }
>  
>  static const struct of_device_id rcar_pwm_of_table[] = {

-- 
Regards,

Laurent Pinchart
