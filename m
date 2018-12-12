From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Wed, 12 Dec 2018 09:01:54 +0100
Message-ID: <20181212080154.kcfh57mulypwuscu@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Dec 06, 2018 at 01:41:31PM +0000, Vokáč Michal wrote:
> Normally the PWM output is held LOW when PWM is disabled. This can cause
> problems when inverted PWM signal polarity is needed. With this behavior
> the connected circuit is fed by 100% duty cycle instead of being shut-off.
> 
> Allow users to define a "pwm" and a "gpio" pinctrl states. The pwm pinctrl
> state is selected when PWM is enabled and the gpio pinctrl state is
> selected when PWM is disabled. In the gpio state the new pwm-gpios GPIO is
> configured as input and the internal pull-up resistor is used to pull the
> output level high.
> 
> If all the pinctrl states and the pwm-gpios GPIO are not correctly
> specified in DT the PWM work as usual.
> 
> As an example, with this patch a PWM controlled backlight with inversed
> signal polarity can be used in full brightness range. Without this patch
> the backlight can not be turned off as brightness = 0 disables the PWM
> and that in turn set PWM output LOW, that is full brightness.
> 
> Inverted output of the PWM with "default" and with "pwm"+"gpio" pinctrl:
> 
> +--------------+------------+---------------+----------- +-------------+
> | After reset  | Bootloader |   PWM probe   |     PWM    |     PWM     |
> | 100k pull-up |            |               | enable 30% |   disable   |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |    default    |   default  |   default   |
> | out H   __________________                   __   __                 |
> | out L                     \_________________/  \_/  \_/\____________ |
> |                                           ^    ^    ^                |
> +--------------+------------+---------------+------------+-------------+
> | pinctrl      |    none    |      gpio     |     pwm    |     gpio    |
> | out H   __________________________________   __   __   _____________ |
> | out L                                     \_/  \_/  \_/              |
> |                                           ^    ^    ^                |
> +----------------------------------------------------------------------+
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes in v3:
>  - Commit message update.
>  - Minor fix in code comment (Uwe)
>  - Align function arguments to the opening parentheses. (Uwe)
>  - Do not test devm_pinctrl_get for NULL. (Thierry)
>  - Convert all messages to dev_dbg() (Thierry)
>  - Do not actively drive the pin in gpio state. Configure it as input
>    and rely solely on the internal pull-up. (Thierry)
> 
> Changes in v2:
>  - Utilize the "pwm" and "gpio" pinctrl states.
>  - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
>  - Select the right pinctrl state in probe.
> 
>  drivers/pwm/pwm-imx.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 1d5242c..84eaec8 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -12,10 +12,12 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  /* i.MX1 and i.MX21 share the same PWM function block: */
>  
> @@ -52,10 +54,44 @@ struct imx_chip {
>  	void __iomem	*mmio_base;
>  
>  	struct pwm_chip	chip;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_pins_gpio;
> +	struct pinctrl_state *pinctrl_pins_pwm;
> +	struct gpio_desc *pwm_gpiod;
>  };
>  
>  #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
>  
> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> +		struct platform_device *pdev)
> +{
> +	imx_chip->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(imx_chip->pinctrl)) {
> +		dev_dbg(&pdev->dev, "can not get pinctrl\n");
> +		return PTR_ERR(imx_chip->pinctrl);
> +	}
> +
> +	imx_chip->pinctrl_pins_pwm = pinctrl_lookup_state(imx_chip->pinctrl,
> +							  "pwm");
> +	imx_chip->pinctrl_pins_gpio = pinctrl_lookup_state(imx_chip->pinctrl,
> +							   "gpio");
> +	imx_chip->pwm_gpiod = devm_gpiod_get_optional(&pdev->dev, "pwm",
> +						      GPIOD_IN);
> +
> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(imx_chip->pwm_gpiod) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_gpio)) {
> +		dev_dbg(&pdev->dev, "PWM pinctrl information incomplete\n");
> +		devm_pinctrl_put(imx_chip->pinctrl);
> +		imx_chip->pinctrl = NULL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx_pwm_config_v1(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
> @@ -216,7 +252,25 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
>  			cr |= MX3_PWMCR_POUTC;
>  
>  		writel(cr, imx->mmio_base + MX3_PWMCR);
> +
> +		/*
> +		 * If we are in charge of pinctrl then switch output to
> +		 * the PWM signal.
> +		 */
> +		if (imx->pinctrl)
> +			pinctrl_select_state(imx->pinctrl,
> +					     imx->pinctrl_pins_pwm);
>  	} else if (cstate.enabled) {
> +		/*
> +		 * PWM block will be disabled. Normally its output will be set
> +		 * low no matter what output polarity is configured. Let's use
> +		 * pinctrl to switch the output pin to GPIO functon and keep
> +		 * the output at the same level as for duty-cycle = 0.
> +		 */
> +		if (imx->pinctrl)
> +			pinctrl_select_state(imx->pinctrl,
> +					     imx->pinctrl_pins_gpio);
> +

On thing I noticed while looking at the rcar driver is: This doesn't
wait for the current period to end. Is this supposed to happen? Also for
the enable case the hardware is configured for the desired duty cycle
and only then the pinctrl is switched to pwm. Both might result in a
spike that is not desired.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
