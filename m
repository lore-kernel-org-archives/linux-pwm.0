From: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 15 Oct 2018 23:24:31 -0700
Message-ID: <c8a229c0-d8cb-2eac-0cca-d0b087414f5f@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
 <20181010141341.GF21134@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181010141341.GF21134@ulmo>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Wesley Terpstra <wesley@sifive.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linus.walleij@linaro.org, palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 10/10/18 7:13 AM, Thierry Reding wrote:
> On Tue, Oct 09, 2018 at 11:51:23AM -0700, Atish Patra wrote:
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
>>
>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> [Atish: Various fixes and code cleanup]
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   drivers/pwm/Kconfig      |  10 ++
>>   drivers/pwm/Makefile     |   1 +
>>   drivers/pwm/pwm-sifive.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 251 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-sifive.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 504d2527..dd12144d 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -378,6 +378,16 @@ config PWM_SAMSUNG
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-samsung.
>>   
>> +config PWM_SIFIVE
>> +	tristate "SiFive PWM support"
>> +	depends on OF
>> +	depends on COMMON_CLK
>> +	help
>> +	  Generic PWM framework driver for SiFive SoCs.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-sifive.
>> +
>>   config PWM_SPEAR
>>   	tristate "STMicroelectronics SPEAr PWM support"
>>   	depends on PLAT_SPEAR
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 9c676a0d..30089ca6 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
>>   obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>>   obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>>   obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>> +obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>>   obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>>   obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>>   obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
>> new file mode 100644
>> index 00000000..99580025
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sifive.c
>> @@ -0,0 +1,240 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2017 SiFive
>> + */
>> +#include <dt-bindings/pwm/pwm.h>
> 
> What do you need this for? Your driver should only be dealing with enum
> pwm_polarity, not the defines from the above header. This works but only
> because PWM_POLARITY_INVERTED and PWM_POLARITY_INVERSED happen to be the
> same value.
> 
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
> 
> Keep these in alphabetical order, please.
> 
>> +
>> +#define MAX_PWM			4
>> +
>> +/* Register offsets */
>> +#define REG_PWMCFG		0x0
>> +#define REG_PWMCOUNT		0x8
>> +#define REG_PWMS		0x10
>> +#define	REG_PWMCMP0		0x20
>> +
>> +/* PWMCFG fields */
>> +#define BIT_PWM_SCALE		0
>> +#define BIT_PWM_STICKY		8
>> +#define BIT_PWM_ZERO_ZMP	9
>> +#define BIT_PWM_DEGLITCH	10
>> +#define BIT_PWM_EN_ALWAYS	12
>> +#define BIT_PWM_EN_ONCE		13
>> +#define BIT_PWM0_CENTER		16
>> +#define BIT_PWM0_GANG		24
>> +#define BIT_PWM0_IP		28
>> +
>> +#define SIZE_PWMCMP		4
>> +#define MASK_PWM_SCALE		0xf
>> +
>> +struct sifive_pwm_device {
>> +	struct pwm_chip		chip;
>> +	struct notifier_block	notifier;
>> +	struct clk		*clk;
>> +	void __iomem		*regs;
>> +	unsigned int		approx_period;
>> +	unsigned int		real_period;
>> +};
> 
> No need to align these. A single space is enough to separate variable
> type and name.
> 
>> +
>> +static inline struct sifive_pwm_device *to_sifive_pwm_chip(struct pwm_chip *c)
>> +{
>> +	return container_of(c, struct sifive_pwm_device, chip);
>> +}
>> +
>> +static int sifive_pwm_apply(struct pwm_chip *chip, struct pwm_device *dev,
>> +			    struct pwm_state *state)
>> +{
>> +	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
>> +	unsigned int duty_cycle;
>> +	u32 frac;
>> +
>> +	duty_cycle = state->duty_cycle;
>> +	if (!state->enabled)
>> +		duty_cycle = 0;
>> +	if (state->polarity == PWM_POLARITY_NORMAL)
>> +		duty_cycle = state->period - duty_cycle;
> 
> That's not actually polarity inversion. This is "lightweight" inversion
> which should be up to the consumer, not the PWM driver, to implement. If
> you don't actually have a knob in hardware to switch the polarity, don't
> support it.
> 

I couldn't find anything about polarity support in the spec. Of course, 
I might be complete idiot as well :). I will wait for Wesly's confirmation.


>> +
>> +	frac = ((u64)duty_cycle << 16) / state->period;
>> +	frac = min(frac, 0xFFFFU);
>> +
>> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> 
> writel()?
> 


>> +
>> +	if (state->enabled) {
>> +		state->period = pwm->real_period;
>> +		state->duty_cycle = ((u64)frac * pwm->real_period) >> 16;
>> +		if (state->polarity == PWM_POLARITY_NORMAL)
>> +			state->duty_cycle = state->period - state->duty_cycle;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void sifive_pwm_get_state(struct pwm_chip *chip, struct pwm_device *dev,
>> +				 struct pwm_state *state)
>> +{
>> +	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
>> +	unsigned long duty;
>> +
>> +	duty = ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> 
> readl()? Maybe also change duty to u32, which is what readl() returns.
> 
Sure. I will convert all iowrite/read to readl/writel.

>> +
>> +	state->period     = pwm->real_period;
>> +	state->duty_cycle = ((u64)duty * pwm->real_period) >> 16;
>> +	state->polarity   = PWM_POLARITY_INVERSED;
>> +	state->enabled    = duty > 0;
>> +}
>> +
>> +static const struct pwm_ops sifive_pwm_ops = {
>> +	.get_state	= sifive_pwm_get_state,
>> +	.apply		= sifive_pwm_apply,
>> +	.owner		= THIS_MODULE,
> 
> Again, no need to artificially align these.
> 

Sure. I will fix the other alignment comment as well.

>> +};
>> +
>> +static struct pwm_device *sifive_pwm_xlate(struct pwm_chip *chip,
>> +					   const struct of_phandle_args *args)
>> +{
>> +	struct sifive_pwm_device *pwm = to_sifive_pwm_chip(chip);
>> +	struct pwm_device *dev;
>> +
>> +	if (args->args[0] >= chip->npwm)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	dev = pwm_request_from_chip(chip, args->args[0], NULL);
>> +	if (IS_ERR(dev))
>> +		return dev;
>> +
>> +	/* The period cannot be changed on a per-PWM basis */
>> +	dev->args.period   = pwm->real_period;
>> +	dev->args.polarity = PWM_POLARITY_NORMAL;
>> +	if (args->args[1] & PWM_POLARITY_INVERTED)
>> +		dev->args.polarity = PWM_POLARITY_INVERSED;
>> +
>> +	return dev;
>> +}
>> +
>> +static void sifive_pwm_update_clock(struct sifive_pwm_device *pwm,
>> +				    unsigned long rate)
>> +{
>> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
>> +	unsigned long scalePow = (pwm->approx_period * (u64)rate) / 1000000000;
>> +	int scale = ilog2(scalePow) - 16;
>> +
>> +	scale = clamp(scale, 0, 0xf);
>> +	iowrite32((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
>> +		  pwm->regs + REG_PWMCFG);
>> +
>> +	pwm->real_period = (1000000000ULL << (16 + scale)) / rate;
>> +}
>> +
>> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
>> +				     unsigned long event, void *data)
>> +{
>> +	struct clk_notifier_data *ndata = data;
>> +	struct sifive_pwm_device *pwm = container_of(nb,
>> +						     struct sifive_pwm_device,
>> +						     notifier);
>> +
>> +	if (event == POST_RATE_CHANGE)
>> +		sifive_pwm_update_clock(pwm, ndata->new_rate);
>> +
>> +	return NOTIFY_OK;
>> +}
> 
> Does this mean that the PWM source clock can be shared with other IP
> blocks? 

PWM clock update is required to be reprogrammed because of single PLL.
It runs at bus clock rate which is half of the PLL rate.
In case of, cpu clock rate change, pwm settings need to be calculated 
again to maintain the same rate.


What happens if some other user sets a frequency that we can't
> support? Or what if the clock rate change results in a real period that
> is out of the limits that are considered valid?
> 

@Wesley: What should be the expected behavior in these cases ?

>> +static int sifive_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct sifive_pwm_device *pwm;
>> +	struct pwm_chip *chip;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	chip = &pwm->chip;
>> +	chip->dev = dev;
>> +	chip->ops = &sifive_pwm_ops;
>> +	chip->of_xlate = sifive_pwm_xlate;
>> +	chip->of_pwm_n_cells = 2;
>> +	chip->base = -1;
>> +
>> +	ret = of_property_read_u32(node, "sifive,npwm", &chip->npwm);
>> +	if (ret < 0 || chip->npwm > MAX_PWM)
>> +		chip->npwm = MAX_PWM;
> 
> This property is not documented. Also, why is it necessary? Do you
> expect the number of PWMs to differ depending on the instance of the IP
> block? I would argue that the number of PWMs can be derived from the
> compatible string, so it's unnecessary here.
> 

I think this is left over from old code. Sorry for that.
I will remove it.

> I think you can also remove the MAX_PWM macro, since that's only used in
> one location and it's meaning is very clear in the context, so the
> symbolic name isn't useful.
> 

Sure.

>> +
>> +	ret = of_property_read_u32(node, "sifive,approx-period",
>> +				   &pwm->approx_period);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to read sifive,approx-period from DTS\n");
>> +		return -ENOENT;
>> +	}
> 
> Maybe propagate ret instead of always returning -ENOENT?
> 
ok.

>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	pwm->regs = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(pwm->regs)) {
>> +		dev_err(dev, "Unable to map IO resources\n");
>> +		return PTR_ERR(pwm->regs);
>> +	}
>> +
>> +	pwm->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pwm->clk)) {
>> +		dev_err(dev, "Unable to find controller clock\n");
>> +		return PTR_ERR(pwm->clk);
>> +	}
>> +
>> +	/* Watch for changes to underlying clock frequency */
>> +	pwm->notifier.notifier_call = sifive_pwm_clock_notifier;
>> +	clk_notifier_register(pwm->clk, &pwm->notifier);
> 
> Check for errors from this?
> 
>> +
>> +	/* Initialize PWM config */
>> +	sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
>> +
>> +	/* No interrupt handler needed yet */
> 
> That's not a useful comment.
> 
Will remove it.

>> +
>> +	ret = pwmchip_add(chip);
>> +	if (ret < 0) {
>> +		dev_err(dev, "cannot register PWM: %d\n", ret);
>> +		clk_notifier_unregister(pwm->clk, &pwm->notifier);
> 
> Might be worth introducing a managed version of clk_notifier_register()
> so that we can avoid having to unregister it.
> 

If I understand correctly, it should be defined in clk.c as a 
devm_clk_notifier_register. I can add it as as a separate patch and 
rebase this patch on top of it.


>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pwm);
>> +	dev_info(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> 
> Remove this, or at least make it dev_dbg(). This is not noteworthy news,
> so no need to bother the user with it.
> 

Sure.

>> +
>> +	return 0;
>> +}
>> +
>> +static int sifive_pwm_remove(struct platform_device *dev)
>> +{
>> +	struct sifive_pwm_device *pwm = platform_get_drvdata(dev);
>> +	struct pwm_chip *chip = &pwm->chip;
> 
> Not sure that this intermediate variable is useful, might as well use
> &pwm->chip in the one location where you need it.
> 

Correct. I will remove it.

>> +
>> +	clk_notifier_unregister(pwm->clk, &pwm->notifier);
>> +	return pwmchip_remove(chip);
>> +}
>> +
>> +static const struct of_device_id sifive_pwm_of_match[] = {
>> +	{ .compatible = "sifive,pwm0" },
>> +	{ .compatible = "sifive,fu540-c000-pwm0" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, sifive_pwm_of_match);
>> +
>> +static struct platform_driver sifive_pwm_driver = {
>> +	.probe = sifive_pwm_probe,
>> +	.remove = sifive_pwm_remove,
>> +	.driver = {
>> +		.name = "pwm-sifivem",
> 
> Why does this have the 'm' at the end? I don't see that anywhere else in
> the names.

My bad. It's a typo.

> 
>> +		.of_match_table = of_match_ptr(sifive_pwm_of_match),
> 
> No need for of_match_ptr() here since you depend on OF, so this is
> always going to expand to sifive_pwm_of_match.
> 

ok.

Thanks a lot for reviewing the patch.

Regards,
Atish
> Thierry
> 
