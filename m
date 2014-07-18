From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH 2/2] pwm: add this series patch to support for rk-pwm
 and vop-pwm.
Date: Fri, 18 Jul 2014 13:05:56 +0800
Message-ID: <53C8AB34.3050102@rock-chips.com>
References: <1405577294-19336-1-git-send-email-caesar.wang@rock-chips.com> <1405577294-19336-3-git-send-email-caesar.wang@rock-chips.com> <20140717192459.GA4617@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140717192459.GA4617@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, addy.ke@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com
List-Id: linux-pwm@vger.kernel.org

Hi Beniamino,

=E4=BA=8E 2014=E5=B9=B407=E6=9C=8818=E6=97=A5 03:24, Beniamino Galvani =
=E5=86=99=E9=81=93:
> On Thu, Jul 17, 2014 at 02:08:14PM +0800, caesar wrote:
>> Signed-off-by: caesar<caesar.wang@rock-chips.com>
> Hi Caesar,
>
> just a couple of comments below.
>
>> ---
>>   drivers/pwm/pwm-rockchip.c | 108 +++++++++++++++++++++++++++++++++=
+++---------
>>   1 file changed, 88 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
>> index eec2145..59b0380 100644
>> --- a/drivers/pwm/pwm-rockchip.c
>> +++ b/drivers/pwm/pwm-rockchip.c
>> @@ -2,6 +2,7 @@
>>    * PWM driver for Rockchip SoCs
>>    *
>>    * Copyright (C) 2014 Beniamino Galvani<b.galvani@gmail.com>
>> + * Copyright (C) 2014 Caesar Wang<caesar.wang@rock-chips.com>
>>    *
>>    * This program is free software; you can redistribute it and/or
>>    * modify it under the terms of the GNU General Public License
>> @@ -12,6 +13,8 @@
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_address.h>
> These two should be swapped to keep the alphabetical order of the
> includes.
ok,II will fix it.
>>   #include <linux/platform_device.h>
>>   #include <linux/pwm.h>
>>   #include <linux/time.h>
>> @@ -23,14 +26,37 @@
>>   #define PWM_CTRL_TIMER_EN	(1 << 0)
>>   #define PWM_CTRL_OUTPUT_EN	(1 << 3)
>> +
> [...]
:-( ok,I will remove it.
>>   static int rockchip_pwm_probe(struct platform_device *pdev)
>>   {
>> +	const struct of_device_id *of_id =3D
>> +	    of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
>> +	struct device_node *np =3D pdev->dev.of_node;
>>   	struct rockchip_pwm_chip *pc;
>>   	struct resource *r;
>>   	int ret;
>> @@ -119,9 +185,12 @@ static int rockchip_pwm_probe(struct platform_d=
evice *pdev)
>>   		return -ENOMEM;
>>  =20
>>   	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>> -	if (IS_ERR(pc->base))
>> -		return PTR_ERR(pc->base);
>> +	pc->base =3D of_iomap(np, 0);
>> +	if (!pc->base) {
>> +		dev_err(&pdev->dev, "failed to map controller\n");
>> +		ret =3D -ENOMEM;
>> +		goto fail_map;
>> +	}
> I think that this change is not needed. devm_ioremap_resource()
> guarantees an automatic unmapping when the device is destroyed.
>
> Moreover, when of_iomap() fails you don't need to call iounmap().
>
> Beniamino
VOP-PWM base has be requested for lcdc.
When I use devm_ioremap_resource(), the vop-pwm will request region fai=
l.

Example:.931020] rockchip-pwm ff9401a0.pwm: can't request region for=20
resource [mem 0xff9401a0-0xff9401af] /pwm@ff9401a0.
So ,I have to charge it.

I will be simplyfied by having:
- pc->base =3D devm_ioremap_resource(&pdev->dev, r);
+ if (!strcmp(of_id->compatible, "rockchip,vop-pwm"))
+ pc->base =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
+ else
+ pc->base =3D devm_ioremap_resource(&pdev->dev, r);

Maybe, Could you give me better suggestions for it?

Caesar

>>  =20
>>   	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
>>   	if (IS_ERR(pc->clk))
>> @@ -133,6 +202,7 @@ static int rockchip_pwm_probe(struct platform_de=
vice *pdev)
>>  =20
>>   	platform_set_drvdata(pdev, pc);
>>  =20
>> +	pc->data =3D of_id->data;
>>   	pc->chip.dev =3D &pdev->dev;
>>   	pc->chip.ops =3D &rockchip_pwm_ops;
>>   	pc->chip.base =3D -1;
>> @@ -145,6 +215,10 @@ static int rockchip_pwm_probe(struct platform_d=
evice *pdev)
>>   	}
>>  =20
>>   	return ret;
>> +
>> +fail_map:
>> +	iounmap(pc->base);
>> +	return ret;
>>   }
>>  =20
>>   static int rockchip_pwm_remove(struct platform_device *pdev)
>> @@ -156,12 +230,6 @@ static int rockchip_pwm_remove(struct platform_=
device *pdev)
>>   	return pwmchip_remove(&pc->chip);
>>   }
>>  =20
>> -static const struct of_device_id rockchip_pwm_dt_ids[] =3D {
>> -	{ .compatible =3D "rockchip,rk2928-pwm" },
>> -	{ /* sentinel */ }
>> -};
>> -MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
>> -
>>   static struct platform_driver rockchip_pwm_driver =3D {
>>   	.driver =3D {
>>   		.name =3D "rockchip-pwm",
>> --=20
>> 1.9.1
>>
>


