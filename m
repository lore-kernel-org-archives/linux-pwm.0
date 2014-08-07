From: caesar <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Thu, 07 Aug 2014 21:04:30 +0800
Message-ID: <53E3795E.4080607@rock-chips.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com> <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com> <20140807061842.GB17340@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140807061842.GB17340@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cjf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Thierry,

=E5=9C=A8 2014=E5=B9=B408=E6=9C=8807=E6=97=A5 14:18, Thierry Reding =E5=
=86=99=E9=81=93:
> On Thu, Jul 24, 2014 at 06:21:35PM +0800, Caesar Wang wrote:
>> This patch added to support the PWM controller found on
>> RK3288 SoC.
>>
>> Signed-off-by: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>   drivers/pwm/pwm-rockchip.c | 124 +++++++++++++++++++++++++++++++++=
+++++-------
>>   1 file changed, 105 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
>> index eec2145..59c2513 100644
>> --- a/drivers/pwm/pwm-rockchip.c
>> +++ b/drivers/pwm/pwm-rockchip.c
>> @@ -2,6 +2,7 @@
>>    * PWM driver for Rockchip SoCs
>>    *
>>    * Copyright (C) 2014 Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> + * Copyright (C) 2014 ROCKCHIP, Inc.
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
>> @@ -25,17 +27,72 @@
>>  =20
>>   #define PRESCALER		2
>>  =20
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
>>  =20
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
t pwm_chip *c)
>>   {
>>   	return container_of(c, struct rockchip_pwm_chip, chip);
>>   }
>>  =20
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
>>   static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
>>   			       int duty_ns, int period_ns)
>>   {
>> @@ -52,20 +109,20 @@ static int rockchip_pwm_config(struct pwm_chip =
*chip, struct pwm_device *pwm,
>>   	 * default prescaler value for all practical clock rate values.
>>   	 */
>>   	div =3D clk_rate * period_ns;
>> -	do_div(div, PRESCALER * NSEC_PER_SEC);
>> +	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
>>   	period =3D div;
>>  =20
>>   	div =3D clk_rate * duty_ns;
>> -	do_div(div, PRESCALER * NSEC_PER_SEC);
>> +	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
>>   	duty =3D div;
>>  =20
>>   	ret =3D clk_enable(pc->clk);
>>   	if (ret)
>>   		return ret;
>>  =20
>> -	writel(period, pc->base + PWM_LRC);
>> -	writel(duty, pc->base + PWM_HRC);
>> -	writel(0, pc->base + PWM_CNTR);
>> +	writel(period, pc->base + pc->data->regs.period);
>> +	writel(duty, pc->base + pc->data->regs.duty);
>> +	writel(0, pc->base + pc->data->regs.cntr);
>>  =20
>>   	clk_disable(pc->clk);
>>  =20
>> @@ -76,15 +133,12 @@ static int rockchip_pwm_enable(struct pwm_chip =
*chip, struct pwm_device *pwm)
>>   {
>>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>>   	int ret;
>> -	u32 val;
>>  =20
>>   	ret =3D clk_enable(pc->clk);
>>   	if (ret)
>>   		return ret;
>>  =20
>> -	val =3D readl_relaxed(pc->base + PWM_CTRL);
>> -	val |=3D PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
>> -	writel_relaxed(val, pc->base + PWM_CTRL);
>> +	pc->data->set_enable(chip, true);
>>  =20
>>   	return 0;
>>   }
>> @@ -92,11 +146,8 @@ static int rockchip_pwm_enable(struct pwm_chip *=
chip, struct pwm_device *pwm)
>>   static void rockchip_pwm_disable(struct pwm_chip *chip, struct pwm=
_device *pwm)
>>   {
>>   	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
>> -	u32 val;
>>  =20
>> -	val =3D readl_relaxed(pc->base + PWM_CTRL);
>> -	val &=3D ~(PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN);
>> -	writel_relaxed(val, pc->base + PWM_CTRL);
>> +	pc->data->set_enable(chip, false);
>>  =20
>>   	clk_disable(pc->clk);
>>   }
>> @@ -108,12 +159,52 @@ static const struct pwm_ops rockchip_pwm_ops =3D=
 {
>>   	.owner =3D THIS_MODULE,
>>   };
>>  =20
>> +static const struct rockchip_pwm_data pwm_data_v1 =3D {
>> +	.regs.duty =3D PWM_HRC,
>> +	.regs.period =3D PWM_LRC,
>> +	.regs.cntr =3D PWM_CNTR,
>> +	.regs.ctrl =3D PWM_CTRL,
> Perhaps a slightly more idiomatic way to write this would be:
>
> 	static const struct rockchip_pwm_data pwm_data_v1 =3D {
> 		.regs =3D {
> 			.duty =3D PWM_HRC,
> 			.period =3D PWM_LRC,
> 			.cntr =3D PWM_CNTR,
> 			.ctrl =3D PWM_CTRL,
> 		},
> 		...
> 	};
>
> And similar for the v2 and vop structures. And like I said in another
> reply, since the defines are now only used in this structure it's a
> little redundant to give them symbolic names, so the above could equa=
lly
> well be:
>
> 	static const struct rockchip_pwm_data pwm_data_v1 =3D {
> 		.regs =3D {
> 			.duty =3D 0x04,
> 			.period =3D 0x08,
> 			.cntr =3D 0x00,
> 			.ctrl =3D 0x0c,
> 		},
> 		...
> 	};
>
>> +	.prescaler =3D PRESCALER,
> Similarly for the prescaler value, it can now simply be 2 here.
>
>> +	.set_enable =3D rockchip_pwm_set_enable_v1,
>> +};
>> +
>> +static const struct rockchip_pwm_data pwm_data_v2 =3D {
>> +	.regs.duty =3D PWM_LRC,
>> +	.regs.period =3D PWM_HRC,
>> +	.regs.cntr =3D PWM_CNTR,
>> +	.regs.ctrl =3D PWM_CTRL,
>> +	.prescaler =3D PRESCALER-1,
> And 1 here.
>
>> +	.set_enable =3D rockchip_pwm_set_enable_v2,
>> +};
>> +
>> +static const struct rockchip_pwm_data pwm_data_vop =3D {
>> +	.regs.duty =3D PWM_LRC,
>> +	.regs.period =3D PWM_HRC,
>> +	.regs.cntr =3D PWM_CTRL,
>> +	.regs.ctrl =3D PWM_CNTR,
>> +	.prescaler =3D PRESCALER-1,
> And 1 here.

As you say, I will rewrite the about if it's really need  do so it.
=46or example:

static const struct rockchip_pwm_data pwm_data_v1 =3D {
     .regs =3D {
                 .duty =3D 0x04,
                 .period =3D 0x08,
                 .cntr =3D 0x00,
                 .ctrl =3D 0x0c,
     },
     .prescaler =3D 2,
     .set_enable =3D rockchip_pwm_set_enable_v1,
};

static const struct rockchip_pwm_data pwm_data_v2 =3D {
     .regs =3D {
                 .duty =3D 0x08,
                 .period =3D 0x04,
                 .cntr =3D 0x00,
                 .ctrl =3D 0x0c,
     },
     .prescaler =3D 1,
     .set_enable =3D rockchip_pwm_set_enable_v2,
};

static const struct rockchip_pwm_data pwm_data_vop =3D {
     .regs =3D {
                 .duty =3D 0x08,
                 .period =3D 0x04,
                 .cntr =3D 0x0c,
                 .ctrl =3D 0x00,
     },
     .prescaler =3D 1,
     .set_enable =3D rockchip_pwm_set_enable_v2,
};

Is that right?

>> +	.set_enable =3D rockchip_pwm_set_enable_v2,
>> +};
> No need for the double indirection.

Sorry, I think is need if you mean a double indirection for ".set_enabl=
e".



Caesar
>
> Thierry


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
