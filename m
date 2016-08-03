From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] pwm: samsung: fix to use lowest div for large enough
 modulation bits
Date: Wed, 03 Aug 2016 10:58:40 +0900
Message-ID: <57A14FD0.9030905@samsung.com>
References: <CGME20160802102943epcas1p3d34d2c3536a094e2e8c91568eefd7cf8@epcas1p3.samsung.com>
 <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, k.kozlowski@samsung.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 08/02/2016 07:16 PM, Seung-Woo Kim wrote:
>>From pwm_samsung_calc_tin(), there is routine to find the lowest
> divider possible to generate lower frequency than requested one.
> But it is always possible to generate requested frequency with
> large enough modulation bits, so this patch fixes to use lowest
> div for the case. This patch removes following UBSAN warning:
> 
>    UBSAN: Undefined behaviour in drivers/pwm/pwm-samsung.c:197:13
>    shift exponent 32 is too large for 32-bit type 'long unsigned int'
>    [...]
>    [<c0670248>] (ubsan_epilogue) from [<c06707b4>] (__ubsan_handle_shift_out_of_bounds+0xd8/0x120)
>    [<c06707b4>] (__ubsan_handle_shift_out_of_bounds) from [<c0694b28>] (pwm_samsung_config+0x508/0x6a4)
>    [<c0694b28>] (pwm_samsung_config) from [<c069286c>] (pwm_apply_state+0x174/0x40c)
>    [<c069286c>] (pwm_apply_state) from [<c0b2e070>] (pwm_fan_probe+0xc8/0x488)
>    [<c0b2e070>] (pwm_fan_probe) from [<c07ba8b0>] (platform_drv_probe+0x70/0x150)
>    [...]
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> The UBSAN warning from ARM is reported with the patch in following link:
> https://patchwork.kernel.org/patch/9189575/
> ---
>  drivers/pwm/pwm-samsung.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index ada2d32..ff0def6 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -193,9 +193,13 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *chip,
>  	 * divider settings and choose the lowest divisor that can generate
>  	 * frequencies lower than requested.
>  	 */
> -	for (div = variant->div_base; div < 4; ++div)
> -		if ((rate >> (variant->bits + div)) < freq)
> -			break;
> +	if (fls(rate) <= variant->bits) {
> +		div = variant->div_base;

It's reasonable to me not to check to decide div at above case.

> +	} else {
> +		for (div = variant->div_base; div < 4; ++div)
> +			if ((rate >> (variant->bits + div)) < freq)
> +				break;
> +	}
>  

Reviewed-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.
