From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/3] pwm: renesas-tpu: Drop confusing registered message
Date: Mon, 16 Mar 2020 18:05:18 +0200
Message-ID: <20200316160518.GP4732@pendragon.ideasonboard.com>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:38250 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgCPQFZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:05:25 -0400
Content-Disposition: inline
In-Reply-To: <20200316103216.29383-4-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 11:32:16AM +0100, Geert Uytterhoeven wrote:
> During device probe, the message
> 
>     TPU PWM -1 registered
> 
> is printed.
> 
> While the "-1" looks suspicious, it is perfectly normal for a device
> instantiated from DT.
> 
> Remove the message, as there are no non-DT users left, and other drivers
> don't print such messages neither.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pwm/pwm-renesas-tpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 8032acc84161a9dd..81ad5a551455e4b8 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -424,8 +424,6 @@ static int tpu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
> -
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
