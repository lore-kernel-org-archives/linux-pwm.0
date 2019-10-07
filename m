From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/5] backlight: pwm_bl: fix cie1913 comments and constant
Date: Mon, 7 Oct 2019 16:08:38 +0100
Message-ID: <20191007150838.3qbrten34ln6ufo4@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Sep 19, 2019 at 04:06:16PM +0200, Rasmus Villemoes wrote:
> The "break-even" point for the two formulas is L==8, which is also
> what the code actually implements. [Incidentally, at that point one
> has Y=0.008856, not 0.08856].
> 
> Moreover, all the sources I can find say the linear factor is 903.3
> rather than 902.3, which makes sense since then the formulas agree at
> L==8, both yielding the 0.008856 figure to four significant digits.

Indeed. Interestingly the following doc (with a high search rank in
Google) has exactly this inconsistency and uses different values at
different times:
http://www.photonstophotos.net/GeneralTopics/Exposure/Psychometric_Lightness_and_Gamma.htm

> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 2201b8c78641..be36be1cacb7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -155,8 +155,8 @@ static const struct backlight_ops pwm_backlight_ops = {
>   *
>   * The CIE 1931 lightness formula is what actually describes how we perceive
>   * light:
> - *          Y = (L* / 902.3)           if L* ≤ 0.08856
> - *          Y = ((L* + 16) / 116)^3    if L* > 0.08856
> + *          Y = (L* / 903.3)           if L* ≤ 8
> + *          Y = ((L* + 16) / 116)^3    if L* > 8
>   *
>   * Where Y is the luminance, the amount of light coming out of the screen, and
>   * is a number between 0.0 and 1.0; and L* is the lightness, how bright a human
> @@ -169,9 +169,15 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
>  {
>  	u64 retval;
>  
> +	/*
> +	 * @lightness is given as a number between 0 and 1, expressed
> +	 * as a fixed-point number in scale @scale. Convert to a
> +	 * percentage, still expressed as a fixed-point number, so the
> +	 * above formulas can be applied.
> +	 */
>  	lightness *= 100;
>  	if (lightness <= (8 * scale)) {
> -		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9023);
> +		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
>  	} else {
>  		retval = int_pow((lightness + (16 * scale)) / 116, 3);
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
> -- 
> 2.20.1
