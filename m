From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pwm: core: Use devm_kzalloc instead of kzalloc
Date: Tue, 7 Jan 2014 00:01:27 -0800
Message-ID: <20140107080127.GD20074@core.coreip.homeip.net>
References: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Xiubo,

On Tue, Jan 07, 2014 at 02:05:00PM +0800, Xiubo Li wrote:
> Use devm_kzalloc instead of kzalloc to free automatically and make
> the cleanup paths simpler and the code slightly shorter.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  drivers/pwm/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 2ca9504..74c9f9a 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -80,7 +80,6 @@ static void free_pwms(struct pwm_chip *chip)
>  
>  	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
>  
> -	kfree(chip->pwms);
>  	chip->pwms = NULL;
>  }
>  
> @@ -245,7 +244,9 @@ int pwmchip_add(struct pwm_chip *chip)
>  	if (ret < 0)
>  		goto out;
>  
> -	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
> +	chip->pwms = devm_kzalloc(chip->dev,
> +				  chip->npwm * sizeof(*pwm),
> +				  GFP_KERNEL);
>  	if (!chip->pwms) {
>  		ret = -ENOMEM;
>  		goto out;

Is it guaranteed that pwmchip_add()/free_pwms() will only be called in
probe() and remove() paths? It is probably safe assumption, but maybe it
should be mentioned in comments now that we definitely have this
restricion.

Thanks.

-- 
Dmitry
