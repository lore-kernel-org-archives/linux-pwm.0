Return-Path: <sha@pengutronix.de>
Date: Mon, 30 Sep 2013 10:14:15 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] pwm: imx: Remove redundant of_match_ptr
Message-ID: <20130930081415.GZ30088@pengutronix.de>
References: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
 <1380511601-20977-3-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380511601-20977-3-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-pwm.vger.kernel.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com

On Mon, Sep 30, 2013 at 08:56:41AM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/pwm/pwm-imx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index aa6e5c6..cc47733 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -297,7 +297,7 @@ static struct platform_driver imx_pwm_driver = {
>  	.driver		= {
>  		.name	= "imx-pwm",
>  		.owner = THIS_MODULE,
> -		.of_match_table = of_match_ptr(imx_pwm_dt_ids),
> +		.of_match_table = imx_pwm_dt_ids,
>  	},
>  	.probe		= imx_pwm_probe,
>  	.remove		= imx_pwm_remove,
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
