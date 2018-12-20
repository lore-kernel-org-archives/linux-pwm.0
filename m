From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i
 R40/T3/V40 PWM support.
Date: Thu, 20 Dec 2018 18:57:50 +0100
Message-ID: <20181220175750.GG9408@ulmo>
References: <20181125162319.GA5422@arx-s1>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBINQ57QAKGQEVBHICPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20181125162319.GA5422@arx-s1>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Nov 26, 2018 at 12:23:19AM +0800, Hao Zhang wrote:
> The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM pairs,
> each PWM pair built-in 1 clock module, 2 timer logic module and 1
> programmable dead-time generator, it also support waveform capture.
> It has 2 clock sources OSC24M and APB1, it is different with the
> sun4i-pwm driver, Therefore add a new driver for it.
> 
> Signed-off-by: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/pwm/Kconfig     |  12 +-
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun8i.c | 418 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 430 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-sun8i.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 504d252..6105ac8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -426,7 +426,7 @@ config PWM_STMPE
>  	  expanders.
>  
>  config PWM_SUN4I
> -	tristate "Allwinner PWM support"
> +	tristate "Allwinner SUN4I PWM support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	depends on HAS_IOMEM && COMMON_CLK
>  	help
> @@ -435,6 +435,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
>  
> +config PWM_SUN8I
> +	tristate "Allwinner SUN8I (R40/V40/T3) PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner R40/V40/T3 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i.
> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9c676a0..32c8d2d 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I)		+= pwm-sun8i.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> new file mode 100644
> index 0000000..d8597e4
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +#include <linux/regmap.h>
> +
> +#define PWM_IRQ_ENABLE_REG	0x0000
> +#define PCIE(ch)		BIT(ch)
> +
> +#define PWM_IRQ_STATUS_REG	0x0004
> +#define PIS(ch)			BIT(ch)
> +
> +#define CAPTURE_IRQ_ENABLE_REG	0x0010
> +#define CRIE(ch)		BIT((ch) * 2)
> +#define CFIE(ch)		BIT((ch) * 2 + 1)
> +
> +#define CAPTURE_IRQ_STATUS_REG	0x0014
> +#define CRIS(ch)		BIT((ch) * 2)
> +#define CFIS(ch)		BIT((ch) * 2 + 1)
> +
> +#define CLK_CFG_REG(ch)		(0x0020 + ((ch) >> 1) * 4)
> +#define CLK_SRC_SEL		GENMASK(8, 7)
> +#define CLK_SRC_BYPASS_SEC	BIT(6)
> +#define CLK_SRC_BYPASS_FIR	BIT(5)
> +#define CLK_GATING		BIT(4)
> +#define CLK_DIV_M		GENMASK(3, 0)
> +
> +#define PWM_DZ_CTR_REG(ch)	(0x0030 + ((ch) >> 1) * 4)
> +#define PWM_DZ_INTV		GENMASK(15, 8)
> +#define PWM_DZ_EN		BIT(0)
> +
> +#define PWM_ENABLE_REG		0x0040
> +#define PWM_EN(ch)		BIT(ch)
> +
> +#define CAPTURE_ENABLE_REG	0x0044
> +#define CAP_EN(ch)		BIT(ch)
> +
> +#define PWM_CTR_REG(ch)		(0x0060 + (ch) * 0x20)
> +#define PWM_PERIOD_RDY		BIT(11)
> +#define PWM_PUL_START		BIT(10)
> +#define PWM_MODE		BIT(9)
> +#define PWM_ACT_STA		BIT(8)
> +#define PWM_PRESCAL_K		GENMASK(7, 0)
> +
> +#define PWM_PERIOD_REG(ch)	(0x0064 + (ch) * 0x20)
> +#define PWM_ENTIRE_CYCLE	GENMASK(31, 16)
> +#define PWM_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define PWM_CNT_REG(ch)		(0x0068 + (ch) * 0x20)
> +#define PWM_CNT_VAL		GENMASK(15, 0)
> +
> +#define CAPTURE_CTR_REG(ch)	(0x006c + (ch) * 0x20)
> +#define CAPTURE_CRLF		BIT(2)
> +#define CAPTURE_CFLF		BIT(1)
> +#define CAPINV			BIT(0)
> +
> +#define CAPTURE_RISE_REG(ch)	(0x0070 + (ch) * 0x20)
> +#define CAPTURE_CRLR		GENMASK(15, 0)
> +
> +#define CAPTURE_FALL_REG(ch)	(0x0074 + (ch) * 0x20)
> +#define CAPTURE_CFLR		GENMASK(15, 0)
> +
> +struct sun8i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	const struct sun8i_pwm_data *data;
> +	struct regmap *regmap;
> +};
> +
> +static struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct sun8i_pwm_chip, chip);
> +}
> +
> +static u32 sun8i_pwm_read(struct sun8i_pwm_chip *sun8i_pwm,
> +			  unsigned long offset)
> +{
> +	u32 val;
> +
> +	regmap_read(sun8i_pwm->regmap, offset, &val);
> +	return val;
> +}
> +
> +static void sun8i_pwm_set_bit(struct sun8i_pwm_chip *sun8i_pwm,
> +			      unsigned long reg, u32 bit)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, bit, bit);
> +}
> +
> +static void sun8i_pwm_clear_bit(struct sun8i_pwm_chip *sun8i_pwm,
> +				unsigned long reg, u32 bit)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, bit, 0);
> +}
> +
> +static void sun8i_pwm_set_value(struct sun8i_pwm_chip *sun8i_pwm,
> +				unsigned long reg, u32 mask, u32 val)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, mask, val);
> +}
> +
> +static void sun8i_pwm_set_polarity(struct sun8i_pwm_chip *chip, u32 ch,
> +				   enum pwm_polarity polarity)
> +{
> +	if (polarity == PWM_POLARITY_NORMAL)
> +		sun8i_pwm_set_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +	else
> +		sun8i_pwm_clear_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +}
> +
> +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> +			    struct pwm_state *state)
> +{
> +	u64 clk_rate, clk_div, val;
> +	u16 prescaler = 0;
> +	u16 div_id = 0;
> +	struct clk *clk;
> +	bool is_clk;
> +	int ret;
> +
> +	clk_rate = clk_get_rate(sun8i_pwm->clk);
> +
> +	/* check period and select clock source */
> +	val = state->period * clk_rate;
> +	do_div(val, NSEC_PER_SEC);
> +	is_clk = devm_clk_name_match(sun8i_pwm->clk, "mux-0");
> +	if (val <= 1 && is_clk) {
> +		clk = devm_clk_get(sun8i_pwm->chip.dev, "mux-1");
> +		if (IS_ERR(clk)) {
> +			dev_err(sun8i_pwm->chip.dev,
> +				"Period expects a larger value\n");
> +			return -EINVAL;
> +		}

You should never try to get resources at this point. You should have
requested them already at ->probe() time. Otherwise, how are you going
to handle failures here?

> +
> +		clk_rate = clk_get_rate(clk);
> +		val = state->period * clk_rate;
> +		do_div(val, NSEC_PER_SEC);
> +		if (val <= 1) {
> +			dev_err(sun8i_pwm->chip.dev,
> +				"Period expects a larger value\n");
> +			return -EINVAL;
> +		}
> +
> +		/* change clock source to "mux-1" */
> +		clk_disable_unprepare(sun8i_pwm->clk);
> +		devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
> +		sun8i_pwm->clk = clk;
> +
> +		ret = clk_prepare_enable(sun8i_pwm->clk);
> +		if (ret) {
> +			dev_err(sun8i_pwm->chip.dev,
> +				"Failed to enable PWM clock\n");
> +			return ret;
> +		}
> +
> +	} else {
> +		dev_err(sun8i_pwm->chip.dev,
> +			"Period expects a larger value\n");
> +		return -EINVAL;
> +	}
> +
> +	is_clk = devm_clk_name_match(sun8i_pwm->clk, "mux-0");
> +	if (is_clk)
> +		sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +				    CLK_SRC_SEL, 0 << 7);
> +	else
> +		sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +				    CLK_SRC_SEL, 1 << 7);
> +
> +	dev_info(sun8i_pwm->chip.dev, "clock source freq:%lldHz\n", clk_rate);
> +
> +	/* calculate and set prescaler, div table, PWM entire cycle */
> +	clk_div = val;
> +	while (clk_div > 65535) {
> +		prescaler++;
> +		clk_div = val;
> +		do_div(clk_div, 1U << div_id);
> +		do_div(clk_div, prescaler + 1);
> +
> +		if (prescaler == 255) {
> +			prescaler = 0;
> +			div_id++;
> +			if (div_id == 9) {
> +				dev_err(sun8i_pwm->chip.dev,
> +					"unsupport period value\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> +			    PWM_ENTIRE_CYCLE, clk_div << 16);
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_CTR_REG(ch),
> +			    PWM_PRESCAL_K, prescaler << 0);
> +	sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +			    CLK_DIV_M, div_id << 0);
> +
> +	/* set duty cycle */
> +	val = state->period;
> +	do_div(val, clk_div);
> +	clk_div = state->duty_cycle;
> +	do_div(clk_div, val);
> +	if (clk_div > 65535)
> +		clk_div = 65535;
> +
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> +			    PWM_ACT_CYCLE, clk_div << 0);
> +
> +	return 0;
> +}
> +
> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
> +{
> +	int ret;
> +	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
> +	struct pwm_state cstate;
> +
> +	pwm_get_state(pwm, &cstate);
> +	if (!cstate.enabled) {
> +		ret = clk_prepare_enable(sun8i_pwm->clk);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to enable PWM clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	if ((cstate.period != state->period) ||
> +	    (cstate.duty_cycle != state->duty_cycle)) {
> +		ret = sun8i_pwm_config(sun8i_pwm, pwm->hwpwm, state);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to config PWM\n");
> +			return ret;
> +		}
> +	}

So this isn't really how atomic is supposed to work. The whole point of
the single callback is to allow the driver to apply the changes in an
atomic way, which means that either everything is applied or nothing is
applied.

That's not what you do here. In the above you can end up with an enabled
clock but the settings not being applied. Similarly sun8i_pwm_config()
can abort in a number of places, which would leave you with a half-
configured PWM channel.

Instead, what you should be doing is precompute everything and check
that the configuration can be applied before touching any registers or
enabling clocks. Once you've validate the new state, you need to write
everything and there should be no more risk of failure.

Thierry
--oXNgvKVxGWJ0RPMJ--
