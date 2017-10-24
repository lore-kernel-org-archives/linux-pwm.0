From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v4 1/1] pwm: mediatek: add MT2712/MT7622 support
Date: Tue, 24 Oct 2017 16:25:46 +0300
Message-ID: <403f3709-a5bf-6d31-9cb0-62364ac596e6@microchip.com>
References: <1503367755-6519-1-git-send-email-zhi.mao@mediatek.com>
 <1503367755-6519-2-git-send-email-zhi.mao@mediatek.com>
 <78c6789f-6f9c-f075-b773-dcf90c2a42da@microchip.com>
 <1508757180.12324.12.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508757180.12324.12.camel@mhfsdcap03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: "john@phrozen.org" <john@phrozen.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "zhenbao.liu@mediatek.com" <zhenbao.liu@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "yt.shen@mediatek.com" <yt.shen@mediatek.com>, "yingjoe.chen@mediatek.com" <yingjoe.chen@mediatek.com>"linux-arm-kernel@lists.infradead.org" <linux>
List-Id: linux-pwm@vger.kernel.org

Hi Zhi,

Please see my answer below.

On 23.10.2017 14:13, Zhi Mao wrote:
> Hi Claudiu
> 
> please check the comments as below.
> 
> Regards
> Zhi
> 
> On Mon, 2017-10-23 at 11:22 +0300, m18063 wrote:
>> Hi Zhi,
>>
>> I have few comments regarding your patch. Please see them below.
>>
>> Thanks,
>> Claudiu
>>
>> On 22.08.2017 05:09, Zhi Mao wrote:
>>> Add support to MT2712 and MT7622.
>>> Due to register offset address of pwm7 for MT2712 is not fixed 0x40,
>>> add mtk_pwm_reg_offset array for pwm register offset.
>>>
>>> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
>>> ---
>>>  drivers/pwm/pwm-mediatek.c |   51 ++++++++++++++++++++++++++++++++++++--------
>>>  1 file changed, 42 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
>>> index 1d78ab1..ccd86e7 100644
>>> --- a/drivers/pwm/pwm-mediatek.c
>>> +++ b/drivers/pwm/pwm-mediatek.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/pwm.h>
>>>  #include <linux/slab.h>
>>> @@ -40,11 +41,19 @@ enum {
>>>  	MTK_CLK_PWM3,
>>>  	MTK_CLK_PWM4,
>>>  	MTK_CLK_PWM5,
>>> +	MTK_CLK_PWM6,
>>> +	MTK_CLK_PWM7,
>>> +	MTK_CLK_PWM8,
>>>  	MTK_CLK_MAX,
>>>  };
>>>  
>>> -static const char * const mtk_pwm_clk_name[] = {
>>> -	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5"
>>> +static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
>>> +	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6", "pwm7",
>>> +	"pwm8"
>>> +};
>>> +
>>> +struct mtk_pwm_platform_data {
>>> +	unsigned int num_pwms;
>>>  };
>>>  
>>>  /**
>>> @@ -57,6 +66,11 @@ struct mtk_pwm_chip {
>>>  	struct pwm_chip chip;
>>>  	void __iomem *regs;
>>>  	struct clk *clks[MTK_CLK_MAX];
>>> +	const struct mtk_pwm_platform_data *data;
>> I think you can remove this member since you only use it to initialize chip.npwm,
>> in probe function, just before platform_set_drvdata().
>>
>> 	pc->chip.npwm = pc->data->pwm_nums;
>>
>> 	platform_set_drvdata(pdev, pc);
> Here, the member of "mtk_pwm_platform_data" is an extension interface of
> pwm information for MTK SOC chips. At present, we use it to initialize
> npwms,

and maybe we will have more informations to use, in later. 

The use of *maybe* in here suggest me that this will not necessary happen.
Actually, what I wanted to emphasize is that, for the moment, you are keeping
same information in both driver private data structure and PWM framework data
structure. So, even if in future you will add more members to this data structure,
you will have the number of PWMs stored in both, your driver data structure
(via "struct mtk_pwm_platform_data *data" member) and PWM framework
(via "struct pwm_chip chip" member of struct mtk_pwm_chip).

For instance, if you will add more info to this data structure you could do it this way:

struct mtk_pwm_platform_data_other {
	typex memberx;
	typey membery;
	// ...
};

struct mtk_pwm_platform_data {
	unsigned int num_pwms;
	struct mtk_pwm_platform_data_other other_data;
};

And have struct mtk_pwm_chip as follows:
struct mtk_pwm_chip {
	struct pwm_chip chip;
	void __iomem *regs;
	struct clk *clks[MTK_CLK_MAX];
	struct mtk_pwm_platform_data_other *other_data;
}

and in probe:

static int mtk_pwm_probe(struct platform_device *pdev)
{
	struct mtk_pwm_platform_data *data;
	// ...
	data = of_device_get_match_data(&pdev->dev);
	if (data == NULL)
		return -EINVAL;
	pc->other_data = data->other_data;
	// ...
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
	pc->chip.npwm = data->num_pwms; /* Here you store the num_pwms in PWM framework
					 * data structure and you could use it from here. */

	// ...
}

At this moment I think there is no need for "const struct mtk_pwm_platform_data" member
to be part of struct mtk_pwm_chip.

Thanks,
Claudiu

> so, we want to keep it and make the interface more flexible. 
> 
>>> +};
>>> +
>>> +static const unsigned int mtk_pwm_reg_offset[] = {
>>> +	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
>>>  };
>>>  
>>>  static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
>>> @@ -103,14 +117,14 @@ static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>>>  static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
>>>  				unsigned int offset)
>>>  {
>>> -	return readl(chip->regs + 0x10 + (num * 0x40) + offset);
>>> +	return readl(chip->regs + mtk_pwm_reg_offset[num] + offset);
>>>  }
>>>  
>>>  static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
>>>  				  unsigned int num, unsigned int offset,
>>>  				  u32 value)
>>>  {
>>> -	writel(value, chip->regs + 0x10 + (num * 0x40) + offset);
>>> +	writel(value, chip->regs + mtk_pwm_reg_offset[num] + offset);
>>>  }
>>>  
>>>  static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>> @@ -194,15 +208,20 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>>>  	if (!pc)
>>>  		return -ENOMEM;
>>>  
>>> +	pc->data = of_device_get_match_data(&pdev->dev);
>> You forgot to check pc->data == NULL (in case device tree inputs are not provided)
>> and you may use here a stack allocated variable to store the number of PWMs returned
>> by of_device_get_match_data(). This is used only for pc->chip.npwm, and anyway, if
>> any, you could get that information from chip.npwm.
>> You could also check here the number of PWMs returned via of_device_get_match_data()
>> to avoid waiting for pwmchip_add() to fail (e.g. if number of PWMs is zero, the
>> pwmchip_add() will fail).
>>
> Here, I will add the NULL pointer checking for "pc->data", and it will
> be released, soon.
> 
>>> +
>>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
>>>  	if (IS_ERR(pc->regs))
>>>  		return PTR_ERR(pc->regs);
>>>  
>>> -	for (i = 0; i < MTK_CLK_MAX; i++) {
>>> +	for (i = 0; i < pc->data->num_pwms + 2; i++) {
>>>  		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
>>> -		if (IS_ERR(pc->clks[i]))
>>> +		if (IS_ERR(pc->clks[i])) {
>>> +			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
>>> +				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));
>>>  			return PTR_ERR(pc->clks[i]);
>>> +		}
>>>  	}
>>>  
>>>  	platform_set_drvdata(pdev, pc);
>>> @@ -210,7 +229,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>>>  	pc->chip.dev = &pdev->dev;
>>>  	pc->chip.ops = &mtk_pwm_ops;
>>>  	pc->chip.base = -1;
>>> -	pc->chip.npwm = 5;
>>> +	pc->chip.npwm = pc->data->num_pwms;
>>>  
>>>  	ret = pwmchip_add(&pc->chip);
>>>  	if (ret < 0) {
>>> @@ -228,9 +247,23 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>>>  	return pwmchip_remove(&pc->chip);
>>>  }
>>>  
>>> +static const struct mtk_pwm_platform_data mt2712_pwm_data = {
>>> +	.num_pwms = 8,
>>> +};
>>> +
>>> +static const struct mtk_pwm_platform_data mt7622_pwm_data = {
>>> +	.num_pwms = 6,
>>> +};
>>> +
>>> +static const struct mtk_pwm_platform_data mt7623_pwm_data = {
>>> +	.num_pwms = 5,
>>> +};
>>> +
>>>  static const struct of_device_id mtk_pwm_of_match[] = {
>>> -	{ .compatible = "mediatek,mt7623-pwm" },
>>> -	{ }
>>> +	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
>>> +	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
>>> +	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>>> +	{ },
>>>  };
>>>  MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
>>>  
>>>
> 
> 
