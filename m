From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v1 2/4] ARM: PWM: add allwinner sun8i R40/V40/T3 pwm
 support.
Date: Thu, 11 Jan 2018 17:33:01 +0200
Message-ID: <340c371f-549e-a2b2-c8b0-b03d98227f9b@microchip.com>
References: <20180111113241.GA21953@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111113241.GA21953@arx-s1>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, maxime.ripard@free-electrons.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 11.01.2018 13:32, hao_zhang wrote:
> This patch add allwinner sun8i R40/V40/T3 pwm support.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  drivers/pwm/Kconfig         |  10 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-sun8i-r40.c | 394 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 405 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun8i-r40.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 763ee50..cde5a70 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
>  
> +config PWM_SUN8I_R40
> +	tristate "Allwinner PWM SUN8I R40 support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner SoCs R40, V40, T3.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i-r40.
> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0258a74..026a55b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I_R40)	+= pwm-sun8i-r40.o
>  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun8i-r40.c b/drivers/pwm/pwm-sun8i-r40.c
> new file mode 100644
> index 0000000..3d34285
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i-r40.c
> @@ -0,0 +1,394 @@
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
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
> +#define PCIE(ch)	BIT(ch)
> +
> +#define PWM_IRQ_STATUS_REG	0x0004
> +#define PIS(ch)	BIT(ch)
> +
> +#define CAPTURE_IRQ_ENABLE_REG	0x0010
> +#define CFIE(ch)	BIT(ch << 1 + 1)
> +#define CRIE(ch)	BIT(ch << 1)
> +
> +#define CAPTURE_IRQ_STATUS_REG	0x0014
> +#define CFIS(ch)	BIT(ch << 1 + 1)
> +#define CRIS(ch)	BIT(ch << 1)
> +
> +#define CLK_CFG_REG(ch)	(0x0020 + (ch >> 1) * 4)
> +#define CLK_SRC	BIT(7)
> +#define CLK_SRC_BYPASS_SEC	BIT(6)
> +#define CLK_SRC_BYPASS_FIR	BIT(5)
> +#define CLK_GATING	BIT(4)
> +#define CLK_DIV_M	GENMASK(3, 0)
> +
> +#define PWM_DZ_CTR_REG(ch)	(0x0030 + (ch >> 1) * 4)
> +#define PWM_DZ_INTV	GENMASK(15, 8)
> +#define PWM_DZ_EN	BIT(0)
> +
> +#define PWM_ENABLE_REG	0x0040
> +#define PWM_EN(ch)	BIT(ch)
> +
> +#define CAPTURE_ENABLE_REG	0x0044
> +#define CAP_EN(ch)	BIT(ch)
> +
> +#define PWM_CTR_REG(ch)	(0x0060 + ch * 0x20)
> +#define PWM_PERIOD_RDY	BIT(11)
> +#define PWM_PUL_START	BIT(10)
> +#define PWM_MODE	BIT(9)
> +#define PWM_ACT_STA	BIT(8)
> +#define PWM_PRESCAL_K	GENMASK(7, 0)
> +
> +#define PWM_PERIOD_REG(ch)	(0x0064 + ch * 0x20)
> +#define PWM_ENTIRE_CYCLE	GENMASK(31, 16)
> +#define PWM_ACT_CYCLE	GENMASK(15, 0)
> +
> +#define PWM_CNT_REG(ch)	(0x0068 + ch * 0x20)
> +#define PWM_CNT_VAL	GENMASK(15, 0)
> +
> +#define CAPTURE_CTR_REG(ch)	(0x006c + ch * 0x20)
> +#define CAPTURE_CRLF	BIT(2)
> +#define CAPTURE_CFLF	BIT(1)
> +#define CAPINV	BIT(0)
> +
> +#define CAPTURE_RISE_REG(ch)	(0x0070 + ch * 0x20)
> +#define CAPTURE_CRLR	GENMASK(15, 0)
> +
> +#define CAPTURE_FALL_REG(ch)	(0x0074 + ch * 0x20)
> +#define CAPTURE_CFLR	GENMASK(15, 0)
> +
> +struct sun8i_pwm_data {
> +	bool has_prescaler_bypass;
> +	bool has_rdy;
> +	unsigned int npwm;
> +};
> +
> +struct sun8i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	spinlock_t ctrl_lock;
> +	const struct sun8i_pwm_data *data;
> +	struct regmap *regmap;
> +};
> +
> +static const u16 div_m_table[] = {
> +	1,
> +	2,
> +	4,
> +	8,
> +	16,
> +	32,
> +	64,
> +	128,
> +	256
> +};
> +
> +static inline struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct sun8i_pwm_chip, chip);
> +}
> +
> +static u32 sun8i_pwm_read(struct sun8i_pwm_chip *sun8i_pwm,
> +		unsigned long offset)
> +{
> +	u32 val;
> +
> +	regmap_read(sun8i_pwm->regmap, offset, &val);
> +
> +	return val;
> +}
> +
> +static inline void sun8i_pwm_set_bit(struct sun8i_pwm_chip *sun8i_pwm,
> +		unsigned long reg, u32 bit)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, bit, bit);
> +}
> +
> +static inline void sun8i_pwm_clear_bit(struct sun8i_pwm_chip *sun8i_pwm,
> +		unsigned long reg, u32 bit)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, bit, 0);
> +}
> +
> +static inline void sun8i_pwm_set_value(struct sun8i_pwm_chip *sun8i_pwm,
> +		unsigned long reg, u32 mask, u32 val)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, mask, val);
> +}
> +
> +static void sun8i_pwm_set_polarity(struct sun8i_pwm_chip *chip, u32 ch,
> +		enum pwm_polarity polarity)
> +{
> +	if (polarity == PWM_POLARITY_NORMAL)
> +		sun8i_pwm_set_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +	else
> +		sun8i_pwm_clear_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +}
> +
> +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> +		struct pwm_state *state)
> +{
> +	u64 clk_rate, clk_div, val;
> +	u16 prescaler = 0;
> +	u8 id = 0;
> +
> +	clk_rate = clk_get_rate(sun8i_pwm->clk);
> +
> +	if (clk_rate == 24000000)
> +		sun8i_pwm_clear_bit(sun8i_pwm, CLK_CFG_REG(ch), CLK_SRC);
> +	else
> +		sun8i_pwm_set_bit(sun8i_pwm, CLK_CFG_REG(ch), CLK_SRC);
> +
> +	if (sun8i_pwm->data->has_prescaler_bypass) {
> +		/* pwm output bypass */
> +		if (ch % 2)
> +			sun8i_pwm_set_bit(sun8i_pwm, CLK_CFG_REG(ch),
> +					CLK_SRC_BYPASS_FIR);
> +		else
> +			sun8i_pwm_set_bit(sun8i_pwm, CLK_CFG_REG(ch),
> +					CLK_SRC_BYPASS_SEC);
> +		return 0;
> +	}
> +
> +	val = state->period * clk_rate;
> +	do_div(val, NSEC_PER_SEC);
> +	if (val < 1) {
> +		dev_err(sun8i_pwm->chip.dev,
> +				"period expects a larger value\n");
> +		return -EINVAL;
> +	}
> +
> +	/* calculate and set prescalar, div table, pwn entrie cycle */
> +	clk_div = val;
> +	
> +	while (clk_div > 65535) {
> +		prescaler++;
> +		clk_div = val;
> +		do_div(clk_div, prescaler + 1);
> +		do_div(clk_div, div_m_table[id]);
> +
> +		if (prescaler == 255) {
> +			prescaler = 0;
> +			id++;
> +			if (id == 9)
> +				return -EINVAL;
> +		}
> +	}
> +
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> +			PWM_ENTIRE_CYCLE, clk_div << 16);
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_CTR_REG(ch),
> +			PWM_PRESCAL_K, prescaler << 0);
> +	sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +			CLK_DIV_M, id << 0);
> +
> +	/* set duty cycle */
> +	val = (prescaler + 1) * div_m_table[id] * clk_div;
> +	val = state->period;
> +	do_div(val, clk_div);
> +	clk_div = state->duty_cycle;
> +	do_div(clk_div, val);
> +
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> +			PWM_ACT_CYCLE, clk_div << 0);
> +
> +	return 0;
> +}
> +
> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +		struct pwm_state *state)
> +{
> +	int ret;
> +	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
> +	struct pwm_state cstate;
> +
> +	pwm_get_state(pwm, &cstate);
> +	if (!cstate.enabled) {
> +		ret = clk_prepare_enable(sun8i_pwm->clk);
You call clk_prepare_enable() here, under !cstate.enabled condition.
> +		if (ret) {
> +			dev_err(chip->dev, "failed to enable PWM clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock(&sun8i_pwm->ctrl_lock);
> +
> +	if ((cstate.period != state->period) ||
> +			(cstate.duty_cycle != state->duty_cycle)) {
> +		ret = sun8i_pwm_config(sun8i_pwm, pwm->hwpwm, state);
> +		if (ret) > +			clk_disable_unprepare(sun8i_pwm->clk);
You need to call clk_disable_unprepare() only if !cstate.enabled:
			if (!cstate.enabled)
				clk_disable_unprepare();

> +			spin_unlock(&sun8i_pwm->ctrl_lock);
> +			dev_err(chip->dev, "failed to config PWM\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (state->polarity != cstate.polarity)
> +		sun8i_pwm_set_polarity(sun8i_pwm, pwm->hwpwm, state->polarity);
> +
> +	if (state->enabled) {
> +		sun8i_pwm_set_bit(sun8i_pwm,
> +				CLK_CFG_REG(pwm->hwpwm), CLK_GATING);
> +
> +		sun8i_pwm_set_bit(sun8i_pwm,
> +				PWM_ENABLE_REG, PWM_EN(pwm->hwpwm));
> +	} else {
> +		sun8i_pwm_clear_bit(sun8i_pwm,
> +				CLK_CFG_REG(pwm->hwpwm), CLK_GATING);
> +
> +		sun8i_pwm_clear_bit(sun8i_pwm,
> +				PWM_ENABLE_REG, PWM_EN(pwm->hwpwm));
> +	}
> +
> +	spin_unlock(&sun8i_pwm->ctrl_lock);
> +
> +	return 0;
> +}
> +
> +static void sun8i_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +		struct pwm_state *state)
> +{
> +	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
> +	u64 clk_rate, tmp;
> +	u32 val;
> +	u16 clk_div, act_cycle;
> +	u8 prescal, id;
> +
> +	clk_rate = clk_get_rate(sun8i_pwm->clk);
> +
> +	val = sun8i_pwm_read(sun8i_pwm, PWM_CTR_REG(pwm->hwpwm));
> +	if (PWM_ACT_STA & val)
> +		state->polarity = PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity = PWM_POLARITY_INVERSED;
> +
> +	prescal = PWM_PRESCAL_K & val;
> +
> +	val = sun8i_pwm_read(sun8i_pwm, PWM_ENABLE_REG);
> +	if (PWM_EN(pwm->hwpwm) & val)
> +		state->enabled = true;
> +	else
> +		state->enabled = false;
> +
> +	val = sun8i_pwm_read(sun8i_pwm, PWM_PERIOD_REG(pwm->hwpwm));
> +	act_cycle = PWM_ACT_CYCLE & val;
> +	clk_div = val >> 16;
> +
> +	val = sun8i_pwm_read(sun8i_pwm, CLK_CFG_REG(pwm->hwpwm));
> +	id = CLK_DIV_M & val;
> +
> +	tmp = act_cycle * prescal * div_m_table[id] * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> +	tmp = clk_div * prescal * div_m_table[id] * NSEC_PER_SEC;
> +	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> +}
> +
> +static const struct regmap_config sun8i_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = CAPTURE_FALL_REG(7),
> +};
> +
> +static const struct pwm_ops sun8i_pwm_ops = {
> +	.apply = sun8i_pwm_apply,
> +	.get_state = sun8i_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct sun8i_pwm_data sun8i_pwm_data_r40 = {
> +	.has_prescaler_bypass = false,
> +	.has_rdy = true,
> +	.npwm = 8,
> +};
> +
> +static const struct of_device_id sun8i_pwm_dt_ids[] = {
> +	{
> +		.compatible = "allwinner,sun8i-r40-pwm",
> +		.data = &sun8i_pwm_data_r40,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
> +
> +static int sun8i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sun8i_pwm_chip *pwm;
> +	struct resource *res;
> +	int ret;
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(sun8i_pwm_dt_ids, &pdev->dev);
check for !match
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	pwm->regmap = devm_regmap_init_mmio(&pdev->dev, pwm->base,
> +			&sun8i_pwm_regmap_config);
Check for IS_ERR(pwm->regmap)                                                  

> +
> +	pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return PTR_ERR(pwm->clk);
> +
> +	pwm->data = match->data;
> +	pwm->chip.dev = &pdev->dev;
> +	pwm->chip.ops = &sun8i_pwm_ops;
> +	pwm->chip.base = -1;
> +	pwm->chip.npwm = pwm->data->npwm;
> +	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> +	pwm->chip.of_pwm_n_cells = 3;
> +
> +	spin_lock_init(&pwm->ctrl_lock);
> +
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int sun8i_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sun8i_pwm_chip *pwm = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&pwm->chip);
> +}
> +
> +static struct platform_driver sun8i_pwm_driver = {
> +	.driver = {
> +		.name = "sun8i-r40-pwm",
> +		.of_match_table = sun8i_pwm_dt_ids,
> +	},
> +	.probe = sun8i_pwm_probe,
> +	.remove = sun8i_pwm_remove,
> +};
> +module_platform_driver(sun8i_pwm_driver);
> +
> +MODULE_ALIAS("platform:sun8i-r40-pwm");
> +MODULE_AUTHOR("Hao Zhang <hao5781286@gmail.com>");
> +MODULE_DESCRIPTION("Allwinner sun8i-r40 PWM driver");
> +MODULE_LICENSE("GPL v2");
> 
