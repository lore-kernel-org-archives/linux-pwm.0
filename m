From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v3 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Thu, 24 Jul 2014 17:29:54 +0800
Message-ID: <53D0D212.40400@rock-chips.com>
References: <1406097521-6457-1-git-send-email-caesar.wang@rock-chips.com> <1648580.P46ct6rREY@diego> <53D06BE3.7010509@rock-chips.com> <1949437.1N5XrQ9a4Y@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:42191 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaGXJaH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Jul 2014 05:30:07 -0400
In-Reply-To: <1949437.1N5XrQ9a4Y@diego>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: thierry.reding@gmail.com, b.galvani@gmail.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com

Hi Heiko,

=E5=9C=A8 2014=E5=B9=B407=E6=9C=8824=E6=97=A5 16:05, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Hi caesar.
>
> Am Donnerstag, 24. Juli 2014, 10:13:55 schrieb caesar:
>>>> +static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip, boo=
l
>>>> enable)
>>>> +{
>>>> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>>> +	u32 val =3D 0;
>>>> +	u32 enable_conf =3D PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
>>>> +
>>>> +	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>>>> +
>>>> +	if (enable)
>>>> +		val |=3D enable_conf;
>>>> +	else
>>>> +		val &=3D ~enable_conf;
>>>> +
>>>> +	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>>>> +}
>>>> +
>>>> +static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip, boo=
l
>>>> enable)
>>>> +{
>>>> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>>> +	u32 val =3D 0;
>>>> +	u32 enable_conf =3D PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABL=
E |
>>>> +		PWM_CONTINUOUS | PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
>>>> +
>>>> +	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>>>> +
>>>> +	if (enable)
>>>> +		val |=3D enable_conf;
>>>> +	else
>>>> +		val &=3D ~enable_conf;
>>>> +
>>>> +	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>>>> +}
>>>> +
>>>> +static void rockchip_pwm_set_enable_vop(struct pwm_chip *chip, bo=
ol
>>>> enable) +{
>>>> +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>>> +	u32 val =3D 0;
>>>> +	u32 enable_conf =3D PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABL=
E |
>>>> +		PWM_CONTINUOUS | PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
>>>> +
>>>> +	val =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>>>> +
>>>> +	if (enable)
>>>> +		val |=3D enable_conf;
>>>> +	else
>>>> +		val &=3D ~enable_conf;
>>>> +
>>>> +	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
>>>> +}
>>> not sure if I'm just blind ... do rockchip_pwm_set_enable_v2 and
>>> rockchip_pwm_set_enable_vop differ at all?
>>>
>>> If they don't differ, I guess pwm_data_vop should just use
>>> rockchip_pwm_set_enable_v2 instead of duplicating it.
>>>
>> Yes, the rockchip_pwm_set_enable_v1 & v2 & vop is similar.
>>
>> So my v2 patch use "u32 enable_conf" instead of it .
>> +struct rockchip_pwm_data {
>>
>>   > + .........
>>   > + u32 enable_conf;
>>   > +};
>>
>> The thierry has suggested it [1] in my v2 patch:
>>
>> For this I think it would be more readable to provide function point=
ers
>> rather than a variable. That is:
>>
>> 	struct rockchip_pwm_data {
>> 		...
>> 		int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
>> 		int (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
>> 	};
>> Then you can implement these for each variant of the chip and call t=
hem
>> from the common rockchip_pwm_enable(), somewhat like this.
>>
>>
>> Perhaps,thierry's suggestion I got it wrong.
> Using the function pointers like Thierry suggested looks nice, so no =
I don't
> think you got it wrong :-)
>
> What I meant was to simply reuse the existing function
> rockchip_pwm_set_enable_v2 when there is _no_ difference at all to
> rockchip_pwm_set_enable_vop, like
>
> static const struct rockchip_pwm_data pwm_data_v2 =3D {
> 	.regs.duty =3D PWM_LRC,
> 	.regs.period =3D PWM_HRC,
> 	.regs.cntr =3D PWM_CNTR,
> 	.regs.ctrl =3D PWM_CTRL,
> 	.prescaler =3D PRESCALER-1,
> 	.set_enable =3D rockchip_pwm_set_enable_v2,
> };
>
> static const struct rockchip_pwm_data pwm_data_vop =3D {
> 	.regs.duty =3D PWM_LRC,
> 	.regs.period =3D PWM_HRC,
> 	.regs.cntr =3D PWM_CTRL,
> 	.regs.ctrl =3D PWM_CNTR,
> 	.prescaler =3D PRESCALER-1,
> 	.set_enable =3D rockchip_pwm_set_enable_v2,
> };
>
>
> Heiko
:-( ok, I will fix this and the other issuses in v4, thanks.
>> Hi thierry& Heiko :-)
>> Maybe,could you suggest solve it reasonable? thanks.
>>
>> [1]: https://lkml.org/lkml/2014/7/21/113
>>
>>>> +
>>>>
>>>>    static int rockchip_pwm_config(struct pwm_chip *chip, struct pw=
m_device
>>>>
>>>> *pwm, int duty_ns, int period_ns)
>>>>
>>>>    {
>>>>
>>>> @@ -52,20 +126,20 @@ static int rockchip_pwm_config(struct pwm_chi=
p
>>>> *chip,
>>>> struct pwm_device *pwm, * default prescaler value for all practica=
l clock
>>>> rate values.
>>>>
>>>>    	 */
>>>>    =09
>>>>    	div =3D clk_rate * period_ns;
>>>>
>>>> -	do_div(div, PRESCALER * NSEC_PER_SEC);
>>>> +	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
>>>>
>>>>    	period =3D div;
>>>>    =09
>>>>    	div =3D clk_rate * duty_ns;
>>>>
>>>> -	do_div(div, PRESCALER * NSEC_PER_SEC);
>>>> +	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
>>>>
>>>>    	duty =3D div;
>>>>    =09
>>>>    	ret =3D clk_enable(pc->clk);
>>>>    	if (ret)
>>>>    =09
>>>>    		return ret;
>>>>
>>>> -	writel(period, pc->base + PWM_LRC);
>>>> -	writel(duty, pc->base + PWM_HRC);
>>>> -	writel(0, pc->base + PWM_CNTR);
>>>> +	writel(period, pc->base + pc->data->regs.period);
>>>> +	writel(duty, pc->base + pc->data->regs.duty);
>>>> +	writel(0, pc->base + pc->data->regs.cntr);
>>>>
>>>>    	clk_disable(pc->clk);
>>>>
>>>> @@ -76,15 +150,12 @@ static int rockchip_pwm_enable(struct pwm_chi=
p
>>>> *chip,
>>>> struct pwm_device *pwm) {
>>>>
>>>>    	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>>>    	int ret;
>>>>
>>>> -	u32 val;
>>>>
>>>>    	ret =3D clk_enable(pc->clk);
>>>>    	if (ret)
>>>>    =09
>>>>    		return ret;
>>>>
>>>> -	val =3D readl_relaxed(pc->base + PWM_CTRL);
>>>> -	val |=3D PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
>>>> -	writel_relaxed(val, pc->base + PWM_CTRL);
>>>> +	pc->data->set_enable(chip, true);
>>>>
>>>>    	return 0;
>>>>   =20
>>>>    }
>>>>
>>>> @@ -92,11 +163,8 @@ static int rockchip_pwm_enable(struct pwm_chip=
 *chip,
>>>> struct pwm_device *pwm) static void rockchip_pwm_disable(struct pw=
m_chip
>>>> *chip, struct pwm_device *pwm) {
>>>>
>>>>    	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>>>
>>>> -	u32 val;
>>>>
>>>> -	val =3D readl_relaxed(pc->base + PWM_CTRL);
>>>> -	val &=3D ~(PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN);
>>>> -	writel_relaxed(val, pc->base + PWM_CTRL);
>>>> +	pc->data->set_enable(chip, false);
>>>>
>>>>    	clk_disable(pc->clk);
>>>>   =20
>>>>    }
>>>>
>>>> @@ -108,12 +176,52 @@ static const struct pwm_ops rockchip_pwm_ops=
 =3D {
>>>>
>>>>    	.owner =3D THIS_MODULE,
>>>>   =20
>>>>    };
>>>>
>>>> +static const struct rockchip_pwm_data pwm_data_v1 =3D {
>>>> +	.regs.duty =3D PWM_HRC,
>>>> +	.regs.period =3D PWM_LRC,
>>>> +	.regs.cntr =3D PWM_CNTR,
>>>> +	.regs.ctrl =3D PWM_CTRL,
>>>> +	.prescaler =3D PRESCALER,
>>>> +	.set_enable =3D rockchip_pwm_set_enable_v1,
>>>> +};
>>>> +
>>>> +static const struct rockchip_pwm_data pwm_data_v2 =3D {
>>>> +	.regs.duty =3D PWM_LRC,
>>>> +	.regs.period =3D PWM_HRC,
>>>> +	.regs.cntr =3D PWM_CNTR,
>>>> +	.regs.ctrl =3D PWM_CTRL,
>>>> +	.prescaler =3D PRESCALER-1,
>>>> +	.set_enable =3D rockchip_pwm_set_enable_v2,
>>>> +};
>>>> +
>>>> +static const struct rockchip_pwm_data pwm_data_vop =3D {
>>>> +	.regs.duty =3D PWM_LRC,
>>>> +	.regs.period =3D PWM_HRC,
>>>> +	.regs.cntr =3D PWM_CTRL,
>>>> +	.regs.ctrl =3D PWM_CNTR,
>>>> +	.prescaler =3D PRESCALER-1,
>>>> +	.set_enable =3D rockchip_pwm_set_enable_vop,
>>>> +};
>>>> +
>>>> +static const struct of_device_id rockchip_pwm_dt_ids[] =3D {
>>>> +	{ .compatible =3D "rockchip,rk2928-pwm", .data =3D &pwm_data_v1}=
,
>>>> +	{ .compatible =3D "rockchip,rk3288-pwm", .data =3D &pwm_data_v2}=
,
>>>> +	{ .compatible =3D "rockchip,vop-pwm", .data =3D &pwm_data_vop},
>>>> +	{ /* sentinel */ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
>>>> +
>>>>
>>>>    static int rockchip_pwm_probe(struct platform_device *pdev)
>>>>    {
>>>>
>>>> +	const struct of_device_id *id;
>>>>
>>>>    	struct rockchip_pwm_chip *pc;
>>>>    	struct resource *r;
>>>>    	int ret;
>>>>
>>>> +	id =3D of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
>>>> +	if (!id)
>>>> +		return -EINVAL;
>>>> +
>>>>
>>>>    	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
>>>>    	if (!pc)
>>>>    =09
>>>>    		return -ENOMEM;
>>>>
>>>> @@ -133,6 +241,7 @@ static int rockchip_pwm_probe(struct platform_=
device
>>>> *pdev)
>>>>
>>>>    	platform_set_drvdata(pdev, pc);
>>>>
>>>> +	pc->data =3D id->data;
>>>>
>>>>    	pc->chip.dev =3D &pdev->dev;
>>>>    	pc->chip.ops =3D &rockchip_pwm_ops;
>>>>    	pc->chip.base =3D -1;
>>>>
>>>> @@ -156,12 +265,6 @@ static int rockchip_pwm_remove(struct
>>>> platform_device
>>>> *pdev) return pwmchip_remove(&pc->chip);
>>>>
>>>>    }
>>>>
>>>> -static const struct of_device_id rockchip_pwm_dt_ids[] =3D {
>>>> -	{ .compatible =3D "rockchip,rk2928-pwm" },
>>>> -	{ /* sentinel */ }
>>>> -};
>>>> -MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
>>>> -
>>>>
>>>>    static struct platform_driver rockchip_pwm_driver =3D {
>>>>   =20
>>>>    	.driver =3D {
>>>>    =09
>>>>    		.name =3D "rockchip-pwm",
>
>
>


