From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Date: Sat, 5 Jan 2019 20:57:25 +0100
Message-ID: <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-15-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227181319.31095-15-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 27, 2018 at 07:13:06PM +0100, Paul Cercueil wrote:
> The previous algorithm hardcoded details about how the TCU clocks work.
> The new algorithm will use clk_round_rate to find the perfect clock rate
> for the PWM channel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v9: New patch
> 
>  drivers/pwm/pwm-jz4740.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index c6136bd4434b..dd80a2cf6528 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -110,23 +110,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
>  	struct clk *clk = jz4740->clks[pwm->hwpwm],
>  		   *parent_clk = clk_get_parent(clk);
> -	unsigned long rate, period, duty;
> +	unsigned long rate, new_rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned int prescaler = 0;
>  
>  	rate = clk_get_rate(parent_clk);
> -	tmp = (unsigned long long)rate * state->period;
> -	do_div(tmp, 1000000000);
> -	period = tmp;
>  
> -	while (period > 0xffff && prescaler < 6) {
> -		period >>= 2;
> -		rate >>= 2;
> -		++prescaler;
> +	for (;;) {
> +		tmp = (unsigned long long)rate * state->period;
> +		do_div(tmp, 1000000000);

NSEC_PER_SEC?

> +
> +		if (tmp <= 0xffff)
> +			break;
> +
> +		new_rate = clk_round_rate(clk, rate - 1);
> +
> +		if (new_rate < rate)
> +			rate = new_rate;
> +		else
> +			return -EINVAL;

You are assuming stuff here about the parent clk which isn't guaranteed
(AFAICT) by the clk framework: If you call clk_round_rate(clk, rate - 1)
this might well return rate even if the clock could run slower than
rate.

Wouldn't it make sense to start iterating with rate = 0xffff * 1e9 /
period? Otherwise you get bad configurations if rate is considerable
slower than necessary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
