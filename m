From: Jian Yuan <yuanjian12@hisilicon.com>
Subject: Re: [PATCH v2] pwm: add pwm driver for HiSilicon BVT SOCs
Date: Thu, 25 Aug 2016 17:15:36 +0800
Message-ID: <09f4946b-0e67-d2f7-cb43-03dead1ec4a9@hisilicon.com>
References: <1471852213-86777-1-git-send-email-yuanjian12@hisilicon.com>
 <20160824130546.GD3714@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824130546.GD3714@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com, jalen.hsu@hisilicon.com
List-Id: linux-pwm@vger.kernel.org



On 2016/8/24 21:05, Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 03:50:13PM +0800, Jian Yuan wrote:
>> From: yuanjian <yuanjian12@hisilicon.com>
>>
>> Add pwm driver for HiSilicon BVT SOCs
> 
> pwm -> PWM, please. It'd be good to have more information here about
> what the hardware can do, where to find it, etc.
> 
Not sure what you mean? Should I describe what the PWM or the BVT SoCs can do?
>>
>> Reviewed-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>> Signed-off-by: Jian Yuan <yuanjian12@hisilicon.com>
>> ---
>> Change Log:
>> v2:
>> The number of PWMs is change to be probeable based on the compatible string.
>>
>>  .../devicetree/bindings/pwm/pwm-hibvt.txt          |  18 ++
>>  drivers/pwm/Kconfig                                |  10 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-hibvt.c                            | 274 +++++++++++++++++++++
>>  4 files changed, 303 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>>  create mode 100644 drivers/pwm/pwm-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> new file mode 100644
>> index 0000000..1274119
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-hibvt.txt
>> @@ -0,0 +1,18 @@
>> +Hisilicon PWM controller
>> +
>> +Required properties:
>> +-compatible: should contain one soc specific compatible string and one generic compatible
>> +string "hisilicon, hibvt-pwm". The soc specific strings supported including:
> 
> Why the generic compatible string? You've already shown in the driver
> that the two versions you support aren't compatible.
>
The generic compatible string should be contained in every devicetree bindings that BVT Socs support.
But I'll add another specific compatible string to distinguish it from "hisilicon,hi3516cv300-pwm".

> Also soc -> SoC, please.
> 
>> +	"hisilicon,hi3516cv300-pwm"
>> +- reg: physical base address and length of the controller's registers.
>> +- clocks: phandle and clock specifier of the PWM reference clock.
>> +- resets: offset address and offset bit for reset or unreset of the controller.
> 
> That's weird. Usually this should say just that the property should
> contain the phandle plus a reset specifier for the controller reset. The
> above description already defines what the specifier looks like, which
> may not be true on all SoCs that this hardware gets integrated into.
> 
Ok.
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index c182efc..3c48768 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -158,6 +158,15 @@ config PWM_FSL_FTM
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-fsl-ftm.
>>  
>> +config PWM_HIBVT
>> +	tristate "HiSilicon BVT PWM support"
>> +	depends on ARCH_HISI
>> +	help
>> +	  Generic PWM framework driver for hisilicon BVT SOCs.
> 
> Please use a consistent spelling for HiSilicon. Also: SOC -> SoC.
> 
Ok.
>> @@ -438,4 +447,5 @@ config PWM_VT8500
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-vt8500.
>>  
>> +
> 
> Please don't add this extra blank line.
> 
Ok.
>> diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> [...]
>> new file mode 100644
>> index 0000000..84f617e
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-hibvt.c
>> @@ -0,0 +1,274 @@
>> +/*
>> + * PWM Controller Driver for HiSilicon BVT SOCs
>> + *
>> + * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/reset.h>
>> +
>> +#define PWM_CFG0_ADDR(x)    (((x) * 0x20) + 0x0)
>> +#define PWM_CFG1_ADDR(x)    (((x) * 0x20) + 0x4)
>> +#define PWM_CFG2_ADDR(x)    (((x) * 0x20) + 0x8)
>> +#define PWM_CTRL_ADDR(x)    (((x) * 0x20) + 0xC)
>> +
>> +#define PWM_ENABLE_SHIFT    0
>> +#define PWM_ENABLE_MASK		BIT(0)
>> +
>> +#define PWM_POLARITY_SHIFT	1
>> +#define PWM_POLARITY_MASK	BIT(1)
>> +
>> +#define PWM_KEEP_SHIFT	    2
>> +#define PWM_KEEP_MASK	    BIT(2)
>> +
>> +#define PWM_PERIOD_MASK	    GENMASK(31, 0)
>> +#define PWM_DUTY_MASK	    GENMASK(31, 0)
> 
> There's inconsistent padding in the above. I thought checkpatch warned
> about this nowadays.
> 
>> +
>> +struct hibvt_pwm_chip {
>> +	struct pwm_chip	chip;
>> +	struct clk	*clk;
>> +	void __iomem	*mmio_base;
>> +	struct reset_control *rstc;
>> +};
> 
> No artificial padding with tabs above. A single space between type and
> variable name is good enough. Also why the extra mmio_ prefix for the
> I/O memory base address? You use the much shorter "base" for variables
> elsewhere, why not in this structure?
> 
Ok.
>> +
>> +static int pwm_num_array[] = {8, 4};
> 
> static const unsigned, please. Or better yet, introduce a separate
> structure for this type of SoC-specific data. Something like:
> 
> 	struct hibvt_pwm_soc {
> 		unsigned int num_pwms;
> 	};
> 
Good idea.
>> +
>> +static inline
>> +struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
> 
> It's more idiomatic to put the return type on the first line as well.
> 
Ok.
>> +{
>> +	return container_of(chip, struct hibvt_pwm_chip, chip);
>> +}
>> +
>> +static void hibvt_pwm_set_bits(void __iomem *base, unsigned int offset,
>> +					unsigned int mask, unsigned int data)
> 
> Please align arguments on subsequent lines with the first argument on
> the first line. And use u32 for mask and data since that's what readl()
> and writel() use.
> 
Ok.
>> +{
>> +	void __iomem *address = base + offset;
>> +	unsigned int value;
> 
> u32, please.
> 
Ok.
>> +
>> +	value = readl(address);
>> +	value &= ~mask;
>> +	value |= (data & mask);
>> +	writel(value, address);
>> +}
>> +
>> +static int hibvt_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
>> +	unsigned int offset;
>> +
>> +	offset = PWM_CTRL_ADDR(pwm->hwpwm);
>> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
> 
> I don't think the temporary variable "offset" is useful here.
> 
>> +			PWM_ENABLE_MASK, 0x1);
> 
> Also, please align this properly.
> 
Ok.
>> +
>> +	return 0;
>> +}
>> +
>> +static void hibvt_pwm_disable(struct pwm_chip *chip,
>> +					struct pwm_device *pwm)
> 
> The above will fit on a single line.
> 
Ok.
>> +{
>> +	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
>> +	unsigned int offset;
>> +
>> +	offset = PWM_CTRL_ADDR(pwm->hwpwm);
>> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
>> +			PWM_ENABLE_MASK, 0x0);
> 
> Again, I don't think the offset variable is any good here.
> 
Ok.
>> +}
>> +
>> +static int hibvt_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> +					int duty_cycle_ns, int period_ns)
>> +{
>> +	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
>> +	unsigned int offset;
>> +	unsigned int freq;
>> +	unsigned int period_num, duty_num;
> 
> Why the _num suffix? You could just name them "period" and "duty". Also
> you can put the last four variables above on the same line.
> 
Ok.
>> +
>> +	freq = div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
>> +
>> +	period_num = div_u64(freq * period_ns, 1000);
>> +	duty_num = div_u64(period_num * duty_cycle_ns, period_ns);
>> +
>> +	offset = PWM_CFG0_ADDR(pwm->hwpwm);
>> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
>> +			PWM_PERIOD_MASK, period_num);
>> +
>> +	offset = PWM_CFG1_ADDR(pwm->hwpwm);
>> +	hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
>> +			PWM_DUTY_MASK, duty_num);
> 
> offset can be dropped here as well, in my opinion.
> 
Ok.
>> +
>> +	return 0;
>> +}
>> +
>> +static int hibvt_pwm_set_polarity(struct pwm_chip *chip,
>> +					struct pwm_device *pwm,
>> +					enum pwm_polarity polarity)
>> +{
>> +	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
>> +	unsigned int offset;
>> +
>> +	offset = PWM_CTRL_ADDR(pwm->hwpwm);
>> +	if (polarity == PWM_POLARITY_INVERSED)
>> +		hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
>> +				PWM_POLARITY_MASK, (0x1 << PWM_POLARITY_SHIFT));
>> +	else
>> +		hibvt_pwm_set_bits(hi_pwm_chip->mmio_base, offset,
>> +				PWM_POLARITY_MASK, (0x0 << PWM_POLARITY_SHIFT));
>> +
>> +	return 0;
>> +}
>> +
>> +void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				struct pwm_state *state)
>> +{
>> +	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
>> +	void __iomem *base;
>> +	unsigned int offset;
>> +	unsigned int freq;
>> +	unsigned int period_num, duty_num;
>> +	unsigned int enable;
> 
> I think you could trim the list of variables down a little. offset can
> go away for reasons given above. And of the other four, the only one
> that you need to reuse is freq, so period_num, duty_num and enable can
> all be replaced by a "value" variable, for example. Also, make that an
> u32, because that's what readl() returns.
> 
Fine, it looks like a better solution.
>> +
>> +	freq = div_u64(clk_get_rate(hi_pwm_chip->clk), 1000000);
>> +	base = hi_pwm_chip->mmio_base;
>> +
>> +	offset = PWM_CFG0_ADDR(pwm->hwpwm);
>> +	period_num = readl(base + offset);
>> +	state->period = div_u64(period_num * 1000, freq);
>> +
>> +	offset = PWM_CFG1_ADDR(pwm->hwpwm);
>> +	duty_num = readl(base + offset);
>> +	state->duty_cycle = div_u64(duty_num * 1000, freq);
>> +
>> +	offset = PWM_CTRL_ADDR(pwm->hwpwm);
>> +	enable = readl(base + offset);
>> +	state->enabled = (PWM_ENABLE_MASK & enable);
>> +}
>> +
>> +static struct pwm_ops hibvt_pwm_ops = {
>> +	.enable       = hibvt_pwm_enable,
>> +	.disable      = hibvt_pwm_disable,
>> +	.config       = hibvt_pwm_config,
>> +	.set_polarity = hibvt_pwm_set_polarity,
>> +	.get_state    = hibvt_pwm_get_state,
> 
> Please don't mix legacy and atomic support. If you support .get_state(),
> you should implement .apply() instead of .enable()/.disable()/.config().
> Also, please remove the artificial padding.
> 
I agree to implement .apply() function.
>> +
>> +	.owner        = THIS_MODULE,
>> +};
>> +
>> +static const struct of_device_id hibvt_pwm_of_match[];
> 
> No need for this...
> 
Ok.
>> +
>> +static int hibvt_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct hibvt_pwm_chip *pwm_chip;
>> +	const struct of_device_id *of_id =
>> +				of_match_device(hibvt_pwm_of_match, &pdev->dev);
> 
> ... if you use of_device_get_match_data() here.
> 
>> +	struct resource *res;
>> +	int ret = 0;
> 
> No need to initialize to 0 here.
> 
>> +	int i;
> 
> unsigned int, please.
> 
>> +	int offset;
>> +	int pwm_nums;
> 
> I think both of these can be dropped. See below.
> 
>> +
>> +	if (!of_id)
>> +		return -ENODEV;
>> +
>> +	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
>> +	if (pwm_chip == NULL)
>> +		return -ENOMEM;
>> +
>> +	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(pwm_chip->clk)) {
>> +		dev_err(&pdev->dev, "getting clock failed with %ld\n",
>> +				PTR_ERR(pwm_chip->clk));
>> +		return PTR_ERR(pwm_chip->clk);
>> +	}
>> +
>> +	pwm_nums = *((int *)of_id->data);
> 
> This becomes a lot easier to read if you use a proper structure for the
> SoC specific data:
> 
> 	const struct hibvt_pwm_soc *soc = of_device_get_match_data(&pdev->dev);
> 
> 	pwm_chip->chip.npwm = soc->num_pwms;
> 
That's right.
>> +
>> +	pwm_chip->chip.ops = &hibvt_pwm_ops;
>> +	pwm_chip->chip.dev = &pdev->dev;
>> +	pwm_chip->chip.base = -1;
>> +	pwm_chip->chip.npwm = pwm_nums;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	pwm_chip->mmio_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(pwm_chip->mmio_base))
>> +		return PTR_ERR(pwm_chip->mmio_base);
>> +
>> +	ret = clk_prepare_enable(pwm_chip->clk);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	pwm_chip->rstc = devm_reset_control_get(&pdev->dev, NULL);
>> +	if (IS_ERR(pwm_chip->rstc))
>> +		return PTR_ERR(pwm_chip->rstc);
>> +
> 
> You might want to move clk_prepare_enable() below this so you don't keep
> it enabled when the reset control can't be requested.
> 
Ok, I'll add it.
>> +	reset_control_assert(pwm_chip->rstc);
>> +	msleep(30);
>> +	reset_control_deassert(pwm_chip->rstc);
>> +
>> +	ret = pwmchip_add(&pwm_chip->chip);
>> +	if (ret < 0)
>> +		return ret;
> 
> You might want to assert the reset and disable and unprepare the clock
> when this fails.
> 
>> +
>> +	for (i = 0; i < pwm_nums; i++) {
>> +		offset = PWM_CTRL_ADDR(i);
>> +		hibvt_pwm_set_bits(pwm_chip->mmio_base, offset,
> 
> Things will still fit on one line if you use PWM_CTRL_ADDR(i) in place
> above, so I don't think you gain anything by adding the temporary
> variable.
> 
>> +				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pwm_chip);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hibvt_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct hibvt_pwm_chip *pwm_chip;
>> +
>> +	pwm_chip = platform_get_drvdata(pdev);
>> +	if (pwm_chip == NULL)
>> +		return -ENODEV;
> 
> There's no way this will ever happen.
> 
>> +
>> +	clk_disable_unprepare(pwm_chip->clk);
> 
> What about the reset?
> 
Ok.
>> +
>> +	return pwmchip_remove(&pwm_chip->chip);
>> +}
>> +
>> +static const struct of_device_id hibvt_pwm_of_match[] = {
>> +	{.compatible = "hisilicon,hibvt-pwm", .data = &pwm_num_array[0]},
>> +	{.compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_num_array[1]},
> 
> Spaces after { and before }, please.
> 
Ok.
>> +	{  }
>> +};
>> +MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
>> +
>> +static struct platform_driver hibvt_pwm_driver = {
>> +	.driver		= {
>> +		.name	= "hibvt-pwm",
>> +		.of_match_table = hibvt_pwm_of_match,
>> +	},
>> +	.probe		= hibvt_pwm_probe,
>> +	.remove		= hibvt_pwm_remove,
>> +};
> 
> No need for the artificial padding, it's not working correctly for the
> .of_match_table field anyway.
> 
>> +
>> +module_platform_driver(hibvt_pwm_driver);
> 
> No blank line between the "};" and "module_platform_driver(...);" line,
> please.
> 
>> +
>> +MODULE_AUTHOR("yuanjian12@hisilicon.com");
> 
> It's customary to put your real name here.
> 
>> +MODULE_DESCRIPTION("Hisilicon BVT SOCs PWM driver");
> 
> Again, please use consistent spelling for HiSilicon.
> 
>> +MODULE_LICENSE("GPL v2");
> 
> The header comment says "GPL v2 or later", but "GPL v2" here means GPL
> v2 only.
> 
Ok.
> Thierry
> 

Thanks.
Jian Yuan
