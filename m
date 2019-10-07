From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Date: Mon, 7 Oct 2019 16:28:00 +0100
Message-ID: <20191007152800.3nhbf7h7knumriz4@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-3-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
> The scheduler uses a (currently private) fixed_power_int() in its load
> average computation for computing powers of numbers 0 < x < 1
> expressed as fixed-point numbers, which is also what we want here. But
> that requires the scale to be a power-of-2.

It feels like there is some rationale missing in the description here.

What is the benefit of replacing the explicit int_pow() with the
implicit multiplications?


Daniel.


> 
> We could (and a following patch will) change to use a power-of-2 scale,
> but for a fixed small exponent of 3, there's no advantage in using
> repeated squaring.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9252d51f31b9..aee6839e024a 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -179,7 +179,8 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
>  	if (lightness <= (8 * scale)) {
>  		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
>  	} else {
> -		retval = int_pow((lightness + (16 * scale)) / 116, 3);
> +		retval = (lightness + (16 * scale)) / 116;
> +		retval *= retval * retval;
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
>  	}
>  
> -- 
> 2.20.1
