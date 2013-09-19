Return-Path: <Nicolas.FERRE@atmel.com>
Message-ID: <523AA6C4.6000305@atmel.com>
Date: Thu, 19 Sep 2013 09:24:52 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] pwm: atmel-tcb: fix max time computation for slow
 clk source
References: <1379516720-23289-1-git-send-email-b.brezillon@overkiz.com> <1379516781-23379-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1379516781-23379-1-git-send-email-b.brezillon@overkiz.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: nicolas.ferre@atmel.com
List-ID: <linux-pwm.vger.kernel.org>
To: Boris BREZILLON <b.brezillon@overkiz.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18/09/2013 17:06, Boris BREZILLON :
> Use the the tcb counter width to compute the maximum time that can be
> represented using the slow clock source instead of the static 16 bit width.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   drivers/pwm/pwm-atmel-tcb.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 0266969..f3dcd02 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -307,7 +307,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   		i = slowclk;
>   		rate = 32768;
>   		min = div_u64(NSEC_PER_SEC, rate);
> -		max = min << 16;
> +		max = min << tc->tcb_config->counter_width;
>
>   		/* If period is too big return ERANGE error */
>   		if (max < period_ns)
>


-- 
Nicolas Ferre
