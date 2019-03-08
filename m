From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in
 img_pwm_config
Date: Fri, 8 Mar 2019 09:53:16 +0100
Message-ID: <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
References: <20190307223628.21270-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307223628.21270-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
> 
> The final else if functions as an else; make that explicit so that Clang
> understands that timebase cannot be used uninitialized.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/400
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 815f5333bb8f..1cc5fbe1e1d3 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	} else if (mul <= max_timebase * 512) {
>  		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
>  		timebase = DIV_ROUND_UP(mul, 512);
> -	} else if (mul > max_timebase * 512) {
> +	} else {
>  		dev_err(chip->dev,
>  			"failed to configure timebase steps/divider value\n");
>  		return -EINVAL;

This can even be simplified further.

From the probe function we have:

	pwm_chip->max_period_ns = NSEC_PER_SEC * 512 * max_timebase / input_clk_hz

Then in img_pwm_config there is:

	mul = ⎡ input_clk_hz / ⎡ NSEC_PER_SEC / period_ns⎤⎤

(Not sure this term is the best we can come up with. The rounding
strategy looks strange because the first DIV_ROUND_UP makes mul smaller
while the second makes it bigger. This is similar to

	⎡ input_clk_hz * period_ns / NSEC_PER_SEC ⎤

which is probably more exact and cheaper to calculate.)

If we now had

	mul > max_timebase * 512

this results in (apart from rounding errors):

	input_clk_hz * period_ns / NSEC_PER_SEC > max_timebase * 512
 <=>    period_ns > max_timebase * 512 * NSEC_PER_SEC / input_clk_hz
 <=>    period_ns > pwm_chip->max_period_ns

This however is already ruled out by the first check in
img_pwm_config().

So if the rounding would be fixed, the else is a dead branch and could
be dropped completely.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
