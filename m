From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/6] pwm: mxs: add support for inverse polarity
Date: Fri, 4 Oct 2019 16:20:36 +0200
Message-ID: <20191004142036.apzjf54dlzfah5xl@pengutronix.de>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
 <20191004133207.6663-4-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004133207.6663-4-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Oct 04, 2019 at 03:32:04PM +0200, Rasmus Villemoes wrote:
> If I'm reading of_pwm_xlate_with_flags() right, existing device trees
> that set #pwm-cells = 2 will continue to work.

Yes, that's what I expect, too.

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/pwm/pwm-mxs.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 5a6835e18fc6..57562221c439 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -25,8 +25,11 @@
>  #define  PERIOD_PERIOD(p)	((p) & 0xffff)
>  #define  PERIOD_PERIOD_MAX	0x10000
>  #define  PERIOD_ACTIVE_HIGH	(3 << 16)
> +#define  PERIOD_ACTIVE_LOW	(2 << 16)
> +#define  PERIOD_INACTIVE_HIGH	(3 << 18)
>  #define  PERIOD_INACTIVE_LOW	(2 << 18)
>  #define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
> +#define  PERIOD_POLARITY_INVERSE	(PERIOD_ACTIVE_LOW | PERIOD_INACTIVE_HIGH)
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  
> @@ -50,9 +53,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned int period_cycles, duty_cycles;
>  	unsigned long rate;
>  	unsigned long long c;
> -
> -	if (state->polarity != PWM_POLARITY_NORMAL)
> -		return -ENOTSUPP;
> +	unsigned int pol_bits;
>  
>  	/*
>  	 * If the PWM channel is disabled, make sure to turn on the
> @@ -91,9 +92,12 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * only take effect at the beginning of a new period, avoiding
>  	 * glitches.
>  	 */
> +
> +	pol_bits = state->polarity == PWM_POLARITY_NORMAL ?
> +		PERIOD_POLARITY_NORMAL : PERIOD_POLARITY_INVERSE;
>  	writel(duty_cycles << 16,
>  	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
> -	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
> +	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
>  	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);

Is the avoidance of glitches still true when period changes? I assume
that yes, but I wonder if you tested that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
