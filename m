From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: stm32-lp: add check in case requested period cannot
 be achieved
Date: Tue, 17 Sep 2019 22:28:51 +0200
Message-ID: <20190917202851.ygvvo6c7rbvofl4g@pengutronix.de>
References: <1568728310-20948-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568728310-20948-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Sep 17, 2019 at 03:51:50PM +0200, Fabrice Gasnier wrote:
> LPTimer can use a 32KHz clock for counting. It depends on clock tree
> configuration. In such a case, PWM output frequency range is limited.
> Although unlikely, nothing prevents user from requesting a PWM frequency
> above counting clock (32KHz for instance):
> - This causes (prd - 1) = 0xffff to be written in ARR register later in
> the apply() routine.
> This results in badly configured PWM period (and also duty_cycle).
> Add a check to report an error is such a case.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 2211a64..5c2c728 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -59,6 +59,12 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	/* Calculate the period and prescaler value */
>  	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
>  	do_div(div, NSEC_PER_SEC);
> +	if (!div) {
> +		/* Fall here in case source clock < period */

Does "clock < period" make sense? I'd just write: "Clock is too slow to
achieve period."

> +		dev_err(priv->chip.dev, "Can't reach expected period\n");

IMHO this is little helpful. If a consumer requests such an
unsatisfiable state several times your log is spammed and you don't even
see the what was requested. I'd drop the message completely (or make it
a dev_debug).

> +		return -EINVAL;
> +	}
> +
>  	prd = div;
>  	while (div > STM32_LPTIM_MAX_ARR) {
>  		presc++;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
