From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 2/5] backlight: pwm_bl: eliminate a 64/32 division
Date: Mon, 7 Oct 2019 16:13:19 +0100
Message-ID: <20191007151319.de6ko7n5dypqgyce@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-2-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-2-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Sep 19, 2019 at 04:06:17PM +0200, Rasmus Villemoes wrote:
> lightness*1000 is nowhere near overflowing 32 bits, so we can just use
> an ordinary 32/32 division, which is much cheaper than the 64/32 done
> via do_div().
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index be36be1cacb7..9252d51f31b9 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -177,7 +177,7 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
>  	 */
>  	lightness *= 100;
>  	if (lightness <= (8 * scale)) {
> -		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
> +		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
>  	} else {
>  		retval = int_pow((lightness + (16 * scale)) / 116, 3);
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
> -- 
> 2.20.1
