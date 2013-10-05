Return-Path: <shawn.guo@linaro.org>
Date: Sat, 5 Oct 2013 10:15:30 +0800
From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] pwm: mxs: Remove redundant of_match_ptr
Message-ID: <20131005021528.GD2734@S2101-09.ap.freescale.net>
References: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
Return-Path: shawn.guo@linaro.org
List-ID: <linux-pwm.vger.kernel.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com

On Mon, Sep 30, 2013 at 08:56:39AM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/pwm/pwm-mxs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index c2c5a4f..9475bc7 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -189,7 +189,7 @@ static struct platform_driver mxs_pwm_driver = {
>  	.driver = {
>  		.name = "mxs-pwm",
>  		.owner = THIS_MODULE,
> -		.of_match_table = of_match_ptr(mxs_pwm_dt_ids),
> +		.of_match_table = mxs_pwm_dt_ids,
>  	},
>  	.probe = mxs_pwm_probe,
>  	.remove = mxs_pwm_remove,
> -- 
> 1.7.9.5
> 
