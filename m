From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] pwm: core: Use devm_kzalloc instead of kzalloc
Date: Mon, 06 Jan 2014 23:14:30 -0800
Message-ID: <1389078870.32137.5.camel@joe-AO722>
References: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 2014-01-07 at 14:05 +0800, Xiubo Li wrote:
> Use devm_kzalloc instead of kzalloc to free automatically and make
> the cleanup paths simpler and the code slightly shorter.
[]
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
[]
> @@ -245,7 +244,9 @@ int pwmchip_add(struct pwm_chip *chip)
>  	if (ret < 0)
>  		goto out;
>  
> -	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
> +	chip->pwms = devm_kzalloc(chip->dev,
> +				  chip->npwm * sizeof(*pwm),
> +				  GFP_KERNEL);

There is a devm_kcalloc and this should likely use it.
