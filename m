From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v11 08/12] pwm: stm32-lp: Use %llu format specifier for
 period
Date: Fri, 20 Mar 2020 03:45:35 -0700
Message-ID: <f957b11abb70457e7bd8c2652d41e7f07024e301.camel@perches.com>
References: <cover.1584667964.git.gurus@codeaurora.org>
         <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 2020-03-19 at 18:41 -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's
> datatype to u64, prepare for this transition by using the right
> specifier for printing a 64-bit value.
[]
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
[]
> @@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	do_div(div, NSEC_PER_SEC);
>  	if (!div) {
>  		/* Clock is too slow to achieve requested period. */
> -		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
> +		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
>  		return -EINVAL;
>  	}

Doesn't this introduce a warning now without the
actual change to the type of state->period?

Likely these patches should either not be separated
or this should also use a cast to avoid introducing
intermediate compilation warnings.
