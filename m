From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] pwm: Add MediaTek MT2701 display PWM driver support
Date: Wed, 8 Jun 2016 13:22:55 +0200
Message-ID: <5758000F.7050503@gmail.com>
References: <1464597712-5399-1-git-send-email-weiqing.kong@mediatek.com>
 <1464597712-5399-3-git-send-email-weiqing.kong@mediatek.com>
 <5751A3DD.7020402@gmail.com> <1465370478.5209.30.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465370478.5209.30.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: weiqing kong <weiqing.kong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org



On 08/06/16 09:21, weiqing kong wrote:
> On Fri, 2016-06-03 at 17:35 +0200, Matthias Brugger wrote:
>>
>> On 30/05/16 10:41, Weiqing Kong wrote:
>>> Use the mtk_pwm_data struction to define different registers
>>> and add MT2701 specific register operations, such as MT2701
>>> doesn't have commit register, needs to disable double buffer
>>> before writing register, and needs to select manual mode
>>> and use PWM_PERIOD/PWM_HIGH_WIDTH.
>>>
>>> Signed-off-by: Weiqing Kong <weiqing.kong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>> ---
>>>    drivers/pwm/pwm-mtk-disp.c | 89 +++++++++++++++++++++++++++++++++++++---------
>>>    1 file changed, 72 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
>>> index 0ad3385..03b9c9e 100644
>>> --- a/drivers/pwm/pwm-mtk-disp.c
>>> +++ b/drivers/pwm/pwm-mtk-disp.c
>>> @@ -18,33 +18,44 @@
>>>    #include <linux/io.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/pwm.h>
>>>    #include <linux/slab.h>
>>>
>>>    #define DISP_PWM_EN		0x00
>>> -#define PWM_ENABLE_MASK		BIT(0)
>>>
>>>    #define DISP_PWM_COMMIT		0x08
>>>    #define PWM_COMMIT_MASK		BIT(0)
>>>
>>> -#define DISP_PWM_CON_0		0x10
>>>    #define PWM_CLKDIV_SHIFT	16
>>>    #define PWM_CLKDIV_MAX		0x3ff
>>>    #define PWM_CLKDIV_MASK		(PWM_CLKDIV_MAX << PWM_CLKDIV_SHIFT)
>>>
>>> -#define DISP_PWM_CON_1		0x14
>>>    #define PWM_PERIOD_BIT_WIDTH	12
>>>    #define PWM_PERIOD_MASK		((1 << PWM_PERIOD_BIT_WIDTH) - 1)
>>>
>>>    #define PWM_HIGH_WIDTH_SHIFT	16
>>>    #define PWM_HIGH_WIDTH_MASK	(0x1fff << PWM_HIGH_WIDTH_SHIFT)
>>>
>>> +#define MT2701_PWM_MANUAL_SEL_MASK	BIT(1)
>>> +#define MT2701_PWM_BLS_DEBUG		0xb0
>>
>> Do we need to set magic 0x3 in the debug register? If so, this should be
>> part of mtk_pwm_data, just as con0_sel.
>
> Do you mean that add bls_debug into struct mtk_pwm_data,
> and set 0x3 in mt2701 data, 0x0 in mt8173 data?
>

Yes.

>>
>>> +#define MT2701_PWM_BLS_DEBUG_MASK	0x3
>>> +
>>> +struct mtk_pwm_data {
>>> +	unsigned int enable_bit;
>>> +	unsigned int con0;
>>> +	unsigned int con0_sel;
>>> +	unsigned int con1;
>>> +	bool have_commit_reg;
>>> +};
>>> +
>>>    struct mtk_disp_pwm {
>>>    	struct pwm_chip chip;
>>>    	struct clk *clk_main;
>>>    	struct clk *clk_mm;
>>>    	void __iomem *base;
>>> +	const struct mtk_pwm_data *data;
>>
>> Couldn't that just be the offset for the commit register and set it to
>> 0x0 if the commit register is not present. Right now, we suppose the
>> DISP_PWM_EN is at offset 0x0, so this should not be a problem.
>>
>
> Do you mean that replace have_commit_reg with commit_reg_offset?
> just like this?
> bool have_commit_reg;
> ->
> unsigned int commit_reg_offset;
> and set commit_reg_offset 0x0 in mt2701, 0x1 in mt8173?
>

No, you can set comit_reg_offset to the value of DISP_PWM_COMMIT for 
mt8173 and 0x0 for mt2701. Then you can get rid of DISP_PWM_COMMIT.

Regards,
Matthias

>>>    };
>>>
>>>    static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
>>> @@ -106,12 +117,18 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>    		return err;
>>>    	}
>>>
>>> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_CON_0, PWM_CLKDIV_MASK,
>>> +	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
>>> +				 PWM_CLKDIV_MASK,
>>>    				 clk_div << PWM_CLKDIV_SHIFT);
>>> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_CON_1,
>>> -				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK, value);
>>> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_COMMIT, PWM_COMMIT_MASK, 1);
>>> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_COMMIT, PWM_COMMIT_MASK, 0);
>>> +	mtk_disp_pwm_update_bits(mdp, mdp->data->con1,
>>> +				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
>>> +				 value);
>>> +	if (mdp->data->have_commit_reg) {
>>> +		mtk_disp_pwm_update_bits(mdp, DISP_PWM_COMMIT,
>>> +					 PWM_COMMIT_MASK, 0x1);
>>> +		mtk_disp_pwm_update_bits(mdp, DISP_PWM_COMMIT,
>>> +					 PWM_COMMIT_MASK, 0x0);
>>
>> should be renamed to MT8173_PWM_COMMIT_MASK, although I'm not really a
>> friend of mixing up SoC specific defines with a Soc specific
>> mtk_disp_pwm structure.
>>
>> Regards,
>> Matthias
>
> ok, I will modify it as you said. thanks for you suggestion.
>
>>
>>> +	}
>>>
>>>    	clk_disable(mdp->clk_mm);
>>>    	clk_disable(mdp->clk_main);
>>> @@ -134,7 +151,9 @@ static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>>    		return err;
>>>    	}
>>>
>>> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, PWM_ENABLE_MASK, 1);
>>> +	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
>>> +				 mdp->data->enable_bit,
>>> +				 mdp->data->enable_bit);
>>>
>>>    	return 0;
>>>    }
>>> @@ -143,7 +162,8 @@ static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>>>    {
>>>    	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
>>>
>>> -	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, PWM_ENABLE_MASK, 0);
>>> +	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
>>> +				 mdp->data->enable_bit, 0x0);
>>>
>>>    	clk_disable(mdp->clk_mm);
>>>    	clk_disable(mdp->clk_main);
>>> @@ -156,12 +176,41 @@ static const struct pwm_ops mtk_disp_pwm_ops = {
>>>    	.owner = THIS_MODULE,
>>>    };
>>>
>>> +static const struct mtk_pwm_data mt8173_pwm_data = {
>>> +	.enable_bit = BIT(0),
>>> +	.con0 = 0x10,
>>> +	.con0_sel = 0x0,
>>> +	.con1 = 0x14,
>>> +	.have_commit_reg = true,
>>> +};
>>> +
>>> +static const struct mtk_pwm_data mt2701_pwm_data = {
>>> +	.enable_bit = BIT(16),
>>> +	.con0 = 0xa8,
>>> +	.con0_sel = 0x2,
>>> +	.con1 = 0xac,
>>> +	.have_commit_reg = false,
>>> +};
>>> +
>>> +static const struct of_device_id mtk_disp_pwm_of_match[] = {
>>> +	{ .compatible = "mediatek,mt2701-disp-bls", .data = &mt2701_pwm_data},
>>> +	{ .compatible = "mediatek,mt6595-disp-pwm", .data = &mt8173_pwm_data},
>>> +	{ .compatible = "mediatek,mt8173-disp-pwm", .data = &mt8173_pwm_data},
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
>>> +
>>>    static int mtk_disp_pwm_probe(struct platform_device *pdev)
>>>    {
>>> +	const struct of_device_id *id;
>>>    	struct mtk_disp_pwm *mdp;
>>>    	struct resource *r;
>>>    	int ret;
>>>
>>> +	id = of_match_device(mtk_disp_pwm_of_match, &pdev->dev);
>>> +	if (!id)
>>> +		return -EINVAL;
>>> +
>>>    	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
>>>    	if (!mdp)
>>>    		return -ENOMEM;
>>> @@ -191,6 +240,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>>>    	mdp->chip.ops = &mtk_disp_pwm_ops;
>>>    	mdp->chip.base = -1;
>>>    	mdp->chip.npwm = 1;
>>> +	mdp->data = id->data;
>>>
>>>    	ret = pwmchip_add(&mdp->chip);
>>>    	if (ret < 0) {
>>> @@ -200,6 +250,18 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
>>>
>>>    	platform_set_drvdata(pdev, mdp);
>>>
>>> +	/*
>>> +	 * For MT2701, disable double buffer before writing register
>>> +	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
>>> +	 */
>>> +	if (!mdp->data->have_commit_reg) {
>>> +		mtk_disp_pwm_update_bits(mdp, MT2701_PWM_BLS_DEBUG,
>>> +					 MT2701_PWM_BLS_DEBUG_MASK, 0x3);
>>> +		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
>>> +					 MT2701_PWM_MANUAL_SEL_MASK,
>>> +					 mdp->data->con0_sel);
>>> +	}
>>> +
>>>    	return 0;
>>>
>>>    disable_clk_mm:
>>> @@ -221,13 +283,6 @@ static int mtk_disp_pwm_remove(struct platform_device *pdev)
>>>    	return ret;
>>>    }
>>>
>>> -static const struct of_device_id mtk_disp_pwm_of_match[] = {
>>> -	{ .compatible = "mediatek,mt8173-disp-pwm" },
>>> -	{ .compatible = "mediatek,mt6595-disp-pwm" },
>>> -	{ }
>>> -};
>>> -MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
>>> -
>>>    static struct platform_driver mtk_disp_pwm_driver = {
>>>    	.driver = {
>>>    		.name = "mediatek-disp-pwm",
>>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
