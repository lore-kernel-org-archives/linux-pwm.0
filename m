From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH 2/2] pwm: add this series patch to support for rk-pwm
 and vop-pwm.
Date: Fri, 18 Jul 2014 19:04:24 +0800
Message-ID: <53C8FF38.8010506@rock-chips.com>
References: <1405577294-19336-1-git-send-email-caesar.wang@rock-chips.com> <1405577294-19336-3-git-send-email-caesar.wang@rock-chips.com> <20140717192459.GA4617@gmail.com> <53C8AB34.3050102@rock-chips.com> <20140718100341.GA30497@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140718100341.GA30497@ulmo>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, addy.ke@rock-chips.com, xjq@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

=E4=BA=8E 2014=E5=B9=B407=E6=9C=8818=E6=97=A5 18:03, Thierry Reding =E5=
=86=99=E9=81=93:
> On Fri, Jul 18, 2014 at 01:05:56PM +0800, caesar wrote:
>> =E4=BA=8E 2014=E5=B9=B407=E6=9C=8818=E6=97=A5 03:24, Beniamino Galva=
ni =E5=86=99=E9=81=93:
>>> On Thu, Jul 17, 2014 at 02:08:14PM +0800, caesar wrote:
> [...]
>>>> @@ -119,9 +185,12 @@ static int rockchip_pwm_probe(struct platform=
_device *pdev)
>>>>   		return -ENOMEM;
>>>>   	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> -	pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>>>> -	if (IS_ERR(pc->base))
>>>> -		return PTR_ERR(pc->base);
>>>> +	pc->base =3D of_iomap(np, 0);
>>>> +	if (!pc->base) {
>>>> +		dev_err(&pdev->dev, "failed to map controller\n");
>>>> +		ret =3D -ENOMEM;
>>>> +		goto fail_map;
>>>> +	}
>>> I think that this change is not needed. devm_ioremap_resource()
>>> guarantees an automatic unmapping when the device is destroyed.
>>>
>>> Moreover, when of_iomap() fails you don't need to call iounmap().
>>>
>>> Beniamino
>> VOP-PWM base has be requested for lcdc.
> Why?
VOP is  a seperate controllers for rk3288 and genenation SoCs.
The VOP contains lcdc,pwm......

=46or example :Rk3288 SOC address mapping

lcdc0: lcdc@ff930000                     vop0pwm: pwm@ff9301a0
reg =3D <0xff930000 0x10000>       reg =3D <0xff9301a0 0x10>;
offset =3D 0x10000                            offset =3D 0x10

lcdc1: lcdc@ff940000                    vop1pwm: pwm@ff9401a0
reg =3D <0xff940000 0x10000>      reg =3D <0xff9401a0 0x10>;
offset =3D 0x10000                           offset =3D 0x10

In a word, lcdc and vop-pwm has shared the map address.
>> When I use devm_ioremap_resource(), the vop-pwm will request region =
fail.
>>
>> Example:.931020] rockchip-pwm ff9401a0.pwm: can't request region for
>> resource [mem 0xff9401a0-0xff9401af] /pwm@ff9401a0.
>> So ,I have to charge it.
>>
>> I will be simplyfied by having:
>> - pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>> + if (!strcmp(of_id->compatible, "rockchip,vop-pwm"))
>> + pc->base =3D devm_ioremap(&pdev->dev, r->start, resource_size(r));
>> + else
>> + pc->base =3D devm_ioremap_resource(&pdev->dev, r);
>>
>> Maybe, Could you give me better suggestions for it?
> The right thing to do is not have two drivers access the same device.
> Why does lcdc request the PWM register region?
>
> Thierry
Ditto,
Maybe,Could you give me a better suggestion to do it?


