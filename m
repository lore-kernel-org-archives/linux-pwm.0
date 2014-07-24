From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v3 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Thu, 24 Jul 2014 10:13:55 +0800
Message-ID: <53D06BE3.7010509@rock-chips.com>
References: <1406097521-6457-1-git-send-email-caesar.wang@rock-chips.com> <1406097521-6457-3-git-send-email-caesar.wang@rock-chips.com> <1648580.P46ct6rREY@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:47928 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbaGXCOF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jul 2014 22:14:05 -0400
In-Reply-To: <1648580.P46ct6rREY@diego>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: thierry.reding@gmail.com, b.galvani@gmail.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com

Hi Heiko & thierry,

Thank you for your suggestion.

=E4=BA=8E 2014=E5=B9=B407=E6=9C=8824=E6=97=A5 00:01, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Hi Caesar.
>
> Am Mittwoch, 23. Juli 2014, 14:38:41 schrieb Caesar Wang:
>> This patch added to support the PWM controller found on
>> RK3288 SoC.
>>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   drivers/pwm/pwm-rockchip.c | 141
>> +++++++++++++++++++++++++++++++++++++++------ 1 file changed, 122
>> insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
>> index eec2145..8d72a98 100644
>> --- a/drivers/pwm/pwm-rockchip.c
>> +++ b/drivers/pwm/pwm-rockchip.c
>> @@ -2,6 +2,7 @@
>>    * PWM driver for Rockchip SoCs
>>    *
>>    * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
>> + * Copyright (C) 2014 Caesar Wang <caesar.wang@rock-chips.com>
> you might want to check who actually holds the copyright for your
> contributions, I guess a "Copyright (C) 2014 Rockchip"-something woul=
d be more
> appropriate?
>
Yes,you are right.
>>    *
>>    * This program is free software; you can redistribute it and/or
>>    * modify it under the terms of the GNU General Public License
>> @@ -12,6 +13,7 @@
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pwm.h>
>>   #include <linux/time.h>
>> @@ -25,17 +27,89 @@
>>
>>   #define PRESCALER		2
>>
>> +#define PWM_ENABLE		(1 << 0)
>> +#define PWM_CONTINUOUS		(1 << 1)
>> +#define PWM_DUTY_POSITIVE	(1 << 3)
>> +#define PWM_INACTIVE_NEGATIVE	(0 << 4)
>> +#define PWM_OUTPUT_LEFT		(0 << 5)
>> +#define PWM_LP_DISABLE		(0 << 8)
>> +
>>   struct rockchip_pwm_chip {
>>   	struct pwm_chip chip;
>>   	struct clk *clk;
>> +	const struct rockchip_pwm_data *data;
>>   	void __iomem *base;
>>   };
>>
>> +struct rockchip_pwm_regs {
>> +	unsigned long duty;
>> +	unsigned long period;
>> +	unsigned long cntr;
>> +	unsigned long ctrl;
>> +};
>> +
>> +struct rockchip_pwm_data {
>> +	struct rockchip_pwm_regs regs;
>> +	unsigned int prescaler;
>> +
>> +	void (*set_enable)(struct pwm_chip *chip, bool enable);
>> +};
>> +
>>   static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struc=
t
>> pwm_chip *c) {
>>   	return container_of(c, struct rockchip_pwm_chip, chip);
>>   }
>>
>> +static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip, bool =
enable)
>> +{
>> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>> +	u32 val =3D 0;
>> +	u32 enable_conf =3D PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
>> +
>> +	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>> +
>> +	if (enable)
>> +		val |=3D enable_conf;
>> +	else
>> +		val &=3D ~enable_conf;
>> +
>> +	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>> +}
>> +
>> +static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip, bool =
enable)
>> +{
>> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>> +	u32 val =3D 0;
>> +	u32 enable_conf =3D PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE =
|
>> +		PWM_CONTINUOUS | PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
>> +
>> +	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>> +
>> +	if (enable)
>> +		val |=3D enable_conf;
>> +	else
>> +		val &=3D ~enable_conf;
>> +
>> +	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>> +}
>> +
>> +static void rockchip_pwm_set_enable_vop(struct pwm_chip *chip, bool=
 enable)
>> +{
>> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>> +	u32 val =3D 0;
>> +	u32 enable_conf =3D PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE =
|
>> +		PWM_CONTINUOUS | PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
>> +
>> +	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>> +
>> +	if (enable)
>> +		val |=3D enable_conf;
>> +	else
>> +		val &=3D ~enable_conf;
>> +
>> +	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>> +}
> not sure if I'm just blind ... do rockchip_pwm_set_enable_v2 and
> rockchip_pwm_set_enable_vop differ at all?
>
> If they don't differ, I guess pwm_data_vop should just use
> rockchip_pwm_set_enable_v2 instead of duplicating it.
>
>
> Heiko
Yes, the rockchip_pwm_set_enable_v1 & v2 & vop is similar.

So my v2 patch use "u32 enable_conf" instead of it .
+struct rockchip_pwm_data {
 > + .........
 > + u32 enable_conf;
 > +};


The thierry has suggested it [1] in my v2 patch:

=46or this I think it would be more readable to provide function pointe=
rs
rather than a variable. That is:

	struct rockchip_pwm_data {
		...
		int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
		int (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
	};
Then you can implement these for each variant of the chip and call them
from the common rockchip_pwm_enable(), somewhat like this.


Perhaps,thierry's suggestion I got it wrong.

Hi thierry& Heiko :-)
Maybe,could you suggest solve it reasonable? thanks.

[1]: https://lkml.org/lkml/2014/7/21/113
>> +
>>   static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_d=
evice
>> *pwm, int duty_ns, int period_ns)
>>   {
>> @@ -52,20 +126,20 @@ static int rockchip_pwm_config(struct pwm_chip =
*chip,
>> struct pwm_device *pwm, * default prescaler value for all practical =
clock
>> rate values.
>>   	 */
>>   	div =3D clk_rate * period_ns;
>> -	do_div(div, PRESCALER * NSEC_PER_SEC);
>> +	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
>>   	period =3D div;
>>
>>   	div =3D clk_rate * duty_ns;
>> -	do_div(div, PRESCALER * NSEC_PER_SEC);
>> +	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
>>   	duty =3D div;
>>
>>   	ret =3D clk_enable(pc->clk);
>>   	if (ret)
>>   		return ret;
>>
>> -	writel(period, pc->base + PWM_LRC);
>> -	writel(duty, pc->base + PWM_HRC);
>> -	writel(0, pc->base + PWM_CNTR);
>> +	writel(period, pc->base + pc->data->regs.period);
>> +	writel(duty, pc->base + pc->data->regs.duty);
>> +	writel(0, pc->base + pc->data->regs.cntr);
>>
>>   	clk_disable(pc->clk);
>>
>> @@ -76,15 +150,12 @@ static int rockchip_pwm_enable(struct pwm_chip =
*chip,
>> struct pwm_device *pwm) {
>>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>   	int ret;
>> -	u32 val;
>>
>>   	ret =3D clk_enable(pc->clk);
>>   	if (ret)
>>   		return ret;
>>
>> -	val =3D readl_relaxed(pc->base + PWM_CTRL);
>> -	val |=3D PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
>> -	writel_relaxed(val, pc->base + PWM_CTRL);
>> +	pc->data->set_enable(chip, true);
>>
>>   	return 0;
>>   }
>> @@ -92,11 +163,8 @@ static int rockchip_pwm_enable(struct pwm_chip *=
chip,
>> struct pwm_device *pwm) static void rockchip_pwm_disable(struct pwm_=
chip
>> *chip, struct pwm_device *pwm) {
>>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>> -	u32 val;
>>
>> -	val =3D readl_relaxed(pc->base + PWM_CTRL);
>> -	val &=3D ~(PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN);
>> -	writel_relaxed(val, pc->base + PWM_CTRL);
>> +	pc->data->set_enable(chip, false);
>>
>>   	clk_disable(pc->clk);
>>   }
>> @@ -108,12 +176,52 @@ static const struct pwm_ops rockchip_pwm_ops =3D=
 {
>>   	.owner =3D THIS_MODULE,
>>   };
>>
>> +static const struct rockchip_pwm_data pwm_data_v1 =3D {
>> +	.regs.duty =3D PWM_HRC,
>> +	.regs.period =3D PWM_LRC,
>> +	.regs.cntr =3D PWM_CNTR,
>> +	.regs.ctrl =3D PWM_CTRL,
>> +	.prescaler =3D PRESCALER,
>> +	.set_enable =3D rockchip_pwm_set_enable_v1,
>> +};
>> +
>> +static const struct rockchip_pwm_data pwm_data_v2 =3D {
>> +	.regs.duty =3D PWM_LRC,
>> +	.regs.period =3D PWM_HRC,
>> +	.regs.cntr =3D PWM_CNTR,
>> +	.regs.ctrl =3D PWM_CTRL,
>> +	.prescaler =3D PRESCALER-1,
>> +	.set_enable =3D rockchip_pwm_set_enable_v2,
>> +};
>> +
>> +static const struct rockchip_pwm_data pwm_data_vop =3D {
>> +	.regs.duty =3D PWM_LRC,
>> +	.regs.period =3D PWM_HRC,
>> +	.regs.cntr =3D PWM_CTRL,
>> +	.regs.ctrl =3D PWM_CNTR,
>> +	.prescaler =3D PRESCALER-1,
>> +	.set_enable =3D rockchip_pwm_set_enable_vop,
>> +};
>> +
>> +static const struct of_device_id rockchip_pwm_dt_ids[] =3D {
>> +	{ .compatible =3D "rockchip,rk2928-pwm", .data =3D &pwm_data_v1},
>> +	{ .compatible =3D "rockchip,rk3288-pwm", .data =3D &pwm_data_v2},
>> +	{ .compatible =3D "rockchip,vop-pwm", .data =3D &pwm_data_vop},
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
>> +
>>   static int rockchip_pwm_probe(struct platform_device *pdev)
>>   {
>> +	const struct of_device_id *id;
>>   	struct rockchip_pwm_chip *pc;
>>   	struct resource *r;
>>   	int ret;
>>
>> +	id =3D of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
>> +	if (!id)
>> +		return -EINVAL;
>> +
>>   	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
>>   	if (!pc)
>>   		return -ENOMEM;
>> @@ -133,6 +241,7 @@ static int rockchip_pwm_probe(struct platform_de=
vice
>> *pdev)
>>
>>   	platform_set_drvdata(pdev, pc);
>>
>> +	pc->data =3D id->data;
>>   	pc->chip.dev =3D &pdev->dev;
>>   	pc->chip.ops =3D &rockchip_pwm_ops;
>>   	pc->chip.base =3D -1;
>> @@ -156,12 +265,6 @@ static int rockchip_pwm_remove(struct platform_=
device
>> *pdev) return pwmchip_remove(&pc->chip);
>>   }
>>
>> -static const struct of_device_id rockchip_pwm_dt_ids[] =3D {
>> -	{ .compatible =3D "rockchip,rk2928-pwm" },
>> -	{ /* sentinel */ }
>> -};
>> -MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
>> -
>>   static struct platform_driver rockchip_pwm_driver =3D {
>>   	.driver =3D {
>>   		.name =3D "rockchip-pwm",
>
>
>


