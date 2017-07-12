From: "David.Wu" <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 1/7] pwm: rockchip: Add APB and function both clocks
 support
Date: Wed, 12 Jul 2017 16:38:09 +0800
Message-ID: <caba81f3-d066-d64e-7e8e-6457b759e757@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
 <1499486629-9659-2-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=Vqkueo_cqU8bJXXT3pV5d1dZR5LF+c=O-Ka1qR-Ff-WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=Vqkueo_cqU8bJXXT3pV5d1dZR5LF+c=O-Ka1qR-Ff-WQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?B?6buE5rab?= <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Doug,

在 2017/7/12 1:03, Doug Anderson 写道:
> Hi,
> 
> On Fri, Jul 7, 2017 at 9:03 PM, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> 
>> @@ -6,7 +6,13 @@ Required properties:
>>      "rockchip,rk3288-pwm": found on RK3288 SoC
>>      "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
>>    - reg: physical base address and length of the controller's registers
>> - - clocks: phandle and clock specifier of the PWM reference clock
>> + - clocks: See ../clock/clock-bindings.txt
>> +   - For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399):
>> +     - There is one clock that's used both to derive the functional clock
>> +       for the device and as the bus clock.
>> +   - For newer hardware (rk3328 and future socs): specified by name
>> +     - "pwm": This is used to derive the functional clock.
>> +     - "pclk": This is the APB bus clock.
> 
> I'm pretty sure that that the above description doesn't quite match the code.
> 
> * The above description says that for old hardware there is one clock
> and 'clock-names' was not necessary (though as I understand it it's OK
> if it's there).
> 
> * The old code matched the old description.  AKA: if there was no
> "clock-names" then everything was OK.
> 
> * The new code will not work if there was no "clock-names".
> 
> Many of the old devices had a clock-names present (and it was "pwm"),
> but not all.  Specifically it looks like
> "arch/arm/boot/dts/rk3xxx.dtsi" doesn't specify a clock-names.
> 

So we can keep code: the pc->clk = devm_clk_get(&pdev->dev, NULL);
If the name is NULL, we can get the first clk defined at DTB.

>> @@ -343,13 +344,38 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>>          if (IS_ERR(pc->base))
>>                  return PTR_ERR(pc->base);
>>
>> -       pc->clk = devm_clk_get(&pdev->dev, NULL);
>> -       if (IS_ERR(pc->clk))
>> -               return PTR_ERR(pc->clk);
>> +       pc->clk = devm_clk_get(&pdev->dev, "pwm");
>> +       count = of_property_count_strings(pdev->dev.of_node, "clock-names");
>> +       if (count == 2)
>> +               pc->pclk = devm_clk_get(&pdev->dev, "pclk");
>> +       else
>> +               pc->pclk = pc->clk;
>> +
>> +       if (IS_ERR(pc->clk)) {
>> +               ret = PTR_ERR(pc->clk);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(&pdev->dev, "Can't get bus clk: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       if (IS_ERR(pc->pclk)) {
>> +               ret = PTR_ERR(pc->pclk);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
>> +               return ret;
>> +       }
> 
> In the above code you need to check the count _before_ trying to get
> the clock by name.

Okay, I will fix it.

> 
> 
> -Doug
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
