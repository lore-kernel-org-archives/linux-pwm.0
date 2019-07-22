From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/6] pwm: jz4740: Apply configuration atomically
Date: Mon, 22 Jul 2019 21:34:56 +0200
Message-ID: <20190722193456.h4hfte5cczucermd@pengutronix.de>
References: <20190607154410.10633-1-paul@crapouillou.net>
 <20190607154410.10633-4-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190607154410.10633-4-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Paul,

On Fri, Jun 07, 2019 at 05:44:07PM +0200, Paul Cercueil wrote:
> -static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			     int duty_ns, int period_ns)
> +static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    struct pwm_state *state)
>  {
>  	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
>  	unsigned long long tmp;
>  	unsigned long period, duty;
>  	unsigned int prescaler = 0;
>  	uint16_t ctrl;
> -	bool is_enabled;
>  
> -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
> +	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
>  	do_div(tmp, 1000000000);
>  	period = tmp;
>  
> @@ -96,16 +95,14 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (prescaler == 6)
>  		return -EINVAL;
>  
> -	tmp = (unsigned long long)period * duty_ns;
> -	do_div(tmp, period_ns);
> +	tmp = (unsigned long long)period * state->duty_cycle;
> +	do_div(tmp, state->period);
>  	duty = period - tmp;
>  
>  	if (duty >= period)
>  		duty = period - 1;
>  
> -	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
> -	if (is_enabled)
> -		jz4740_pwm_disable(chip, pwm);
> +	jz4740_pwm_disable(chip, pwm);

I assume this stops the PWM. Does this complete the currently running
period? How does the PWM behave then? (Does it still drive the output?
If so, on which level?)

>  
>  	jz4740_timer_set_count(pwm->hwpwm, 0);
>  	jz4740_timer_set_duty(pwm->hwpwm, duty);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
