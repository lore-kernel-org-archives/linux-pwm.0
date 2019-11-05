From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock
 directly
Date: Tue, 5 Nov 2019 15:56:59 +0100
Message-ID: <20191105145659.ffezqntodsys4phn@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-5-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191105131456.32400-5-peron.clem@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <pza@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:53PM +0100, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> =

> PWM core has an option to bypass whole logic and output unchanged source
> clock as PWM output. This is achieved by enabling bypass bit.
> =

> Note that when bypass is enabled, no other setting has any meaning, not
> even enable bit.
> =

> This mode of operation is needed to achieve high enough frequency to
> serve as clock source for AC200 chip which is integrated into same
> package as H6 SoC.
> =

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 54e19fa56a4e..810abf47c261 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -3,6 +3,10 @@
>   * Driver for Allwinner sun4i Pulse Width Modulation Controller
>   *
>   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electron=
s.com>
> + *
> + * Limitations:
> + * - When outputing the source clock directly, the PWM logic will be byp=
assed
> + *   and the currently running period is not guaranteed to be completed
>   */
>  =

>  #include <linux/bitops.h>
> @@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
>  =

>  struct sun4i_pwm_data {
>  	bool has_prescaler_bypass;
> +	bool has_direct_mod_clk_output;
>  	unsigned int npwm;
>  };
>  =

> @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *chi=
p,
>  =

>  	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  =

> +	/*
> +	 * PWM chapter in H6 manual has a diagram which explains that if bypass
> +	 * bit is set, no other setting has any meaning. Even more, experiment
> +	 * proved that also enable bit is ignored in this case.
> +	 */
> +	if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> +	    sun4i_pwm->data->has_direct_mod_clk_output) {
> +		state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
> +		state->duty_cycle =3D state->period / 2;

Please round up here.

> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +		state->enabled =3D true;
> +		return;
> +	}
> +
>  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
>  	    sun4i_pwm->data->has_prescaler_bypass)
>  		prescaler =3D 1;
> @@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  {
>  	struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
>  	struct pwm_state cstate;
> -	u32 ctrl;
> +	u32 ctrl, clk_rate;
> +	bool bypass;
>  	int ret;
>  	unsigned int delay_us;
>  	unsigned long now;
> @@ -218,6 +238,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		}
>  	}
>  =

> +	/*
> +	 * Although it would make much more sense to check for bypass in
> +	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
> +	 */
> +	clk_rate =3D clk_get_rate(sun4i_pwm->clk);

clk_get_rate must not be called if the clk might be off.

> +	bypass =3D state->enabled &&
> +		 (state->period * clk_rate >=3D NSEC_PER_SEC) &&

This is too coarse. With state->period =3D 1000000 this is fulfilled
(unless the multiplication overflows).

> +		 (state->duty_cycle * 2 =3D=3D state->period);

This is too strict. See my previous mail about how this should be done.

If bypass is true (and the hardware support it) you can skip the
calculation of the other parameters.

> +
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  =

> @@ -265,6 +294,13 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>  	}
>  =

> +	if (sun4i_pwm->data->has_direct_mod_clk_output) {
> +		if (bypass)
> +			ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +		else
> +			ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> +	}
> +
>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  =

>  	spin_unlock(&sun4i_pwm->ctrl_lock);

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
