From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v2 2/2] pwm: add this patch to support the new pwm of
 Rockchip SoCs
Date: Mon, 21 Jul 2014 22:10:04 +0800
Message-ID: <53CD1F3C.3070000@rock-chips.com>
References: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com> <1405774529-26027-3-git-send-email-caesar.wang@rock-chips.com> <20140721085001.GG8843@ulmo> <53CD0E82.6030901@rock-chips.com> <20140721132723.GH15238@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140721132723.GH15238@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: heiko@sntech.de, b.galvani@gmail.com, cf@rock-chips.com, huangtao@rock-chips.com, addy.ke@rock-chips.com, xjq@rock-chips.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


=E4=BA=8E 2014=E5=B9=B407=E6=9C=8821=E6=97=A5 21:27, Thierry Reding =E5=
=86=99=E9=81=93:
> On Mon, Jul 21, 2014 at 08:58:42PM +0800, caesar wrote:
>> =E4=BA=8E 2014=E5=B9=B407=E6=9C=8821=E6=97=A5 16:50, Thierry Reding =
=E5=86=99=E9=81=93:
>>> On Sat, Jul 19, 2014 at 08:55:29PM +0800, Caesar Wang wrote:
> [...]
>>>>   	struct rockchip_pwm_chip *pc;
>>>>   	struct resource *r;
>>>>   	int ret;
>>>> @@ -119,7 +182,10 @@ static int rockchip_pwm_probe(struct platform=
_device *pdev)
>>>>   		return -ENOMEM;
>>>>   	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> -	pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>>>> +	if (!strcmp(of_id->compatible, "rockchip,vop-pwm"))
>>>> +		pc->base =3D devm_ioremap(&pdev->dev, r->start, resource_size(r=
));
>>>> +	else
>>>> +		pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>>> Sorry, this still isn't an option. You really shouldn't remap I/O
>>> regions that other drivers may be using. You hinted at a shared reg=
ister
>>> space during the review of the initial version. Can you provide mor=
e
>>> detail about what exactly the memory map looks like of the rk3288? =
Is
>>> there some kind of technical reference manual that I could look at?=
 Or
>>> do you have a device tree extract that shows what the memory map lo=
oks
>>> like?
>>>
>>> Thierry
>> Maybe,you can look at the ARM: dts: rk3288:
>> https://github.com/rkchrome/kernel/blob/master/arch/arm/boot/dts/rk3=
288.dtsi
>> There is some lcdc and vop-pwm map address for rk3288.
>>
>> ,and you can look at the vop-introduce.pdf and vop-register.pdf in A=
nnex.
>>
>> Maybe,I should put the vop-pwm in lcdc driver,but I don't hope do so=
 it.
>>
>> Could you give a suggestion to solve it? Thanks.
> It looks like you could turn the lcdc device into an MFD device so th=
at
> it can instantiate two devices, one for the display controller, the
> other for the PWM. Or perhaps it would even work with only a single
> child device.
>
> The device tree would become something like this:
>
> 	lcdc@ff930000 {
> 		compatible =3D "rockchip,rk3288-lcdc";
> 		...
>
> 		pwm@ff9301a0 {
> 			compatible =3D "rockchip,vop-pwm";
> 			...
> 		};
> 	};
>
> And your driver would do something like:
>
> 	static const struct resource pwm_resources[] =3D {
> 		{
> 			.start =3D 0x1a0,
> 			.end =3D 0x1af,
> 			.flags =3D IORESOURCE_MEM,
> 		},
> 	};
>
> 	static const struct mfd_cell subdevices[] =3D {
> 		{
> 			.name =3D "pwm",
> 			.id =3D 1,
> 			.of_compatible =3D "rockchip,vop-pwm",
> 			.num_resources =3D ARRAY_SIZE(pwm_resources),
> 			.resources =3D pwm_resources,
> 		},
> 	};
>
> 	static int lcdc_probe(struct platform_device *pdev)
> 	{
> 		struct resource *regs;
> 		...
>
> 		regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> 		...
>
> 		err =3D mfd_add_devices(&pdev->dev, 0, subdevices, ARRAY_SIZE(subde=
vices),
> 				      regs, NULL, NULL);
> 		...
> 	}
>
> Thierry

Seems resonable.

I will fix this and the other issues v3,Thanks.

Caesar
