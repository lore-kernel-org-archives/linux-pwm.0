From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/7] pwm: rockchip: Add APB and function both clocks support
Date: Tue, 11 Jul 2017 10:03:34 -0700
Message-ID: <CAD=FV=Vqkueo_cqU8bJXXT3pV5d1dZR5LF+c=O-Ka1qR-Ff-WQ@mail.gmail.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com> <1499486629-9659-2-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36425 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932456AbdGKRDg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jul 2017 13:03:36 -0400
Received: by mail-wr0-f170.google.com with SMTP id c11so7398302wrc.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Jul 2017 10:03:36 -0700 (PDT)
In-Reply-To: <1499486629-9659-2-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Boris Brezillon <boris.brezillon@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Brian Norris <briannorris@chromium.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?B?6buE5rab?= <huangtao@rock-chips.com>, linux-pwm <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Fri, Jul 7, 2017 at 9:03 PM, David Wu <david.wu@rock-chips.com> wrote:

> @@ -6,7 +6,13 @@ Required properties:
>     "rockchip,rk3288-pwm": found on RK3288 SoC
>     "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
>   - reg: physical base address and length of the controller's registers
> - - clocks: phandle and clock specifier of the PWM reference clock
> + - clocks: See ../clock/clock-bindings.txt
> +   - For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399):
> +     - There is one clock that's used both to derive the functional clock
> +       for the device and as the bus clock.
> +   - For newer hardware (rk3328 and future socs): specified by name
> +     - "pwm": This is used to derive the functional clock.
> +     - "pclk": This is the APB bus clock.

I'm pretty sure that that the above description doesn't quite match the code.

* The above description says that for old hardware there is one clock
and 'clock-names' was not necessary (though as I understand it it's OK
if it's there).

* The old code matched the old description.  AKA: if there was no
"clock-names" then everything was OK.

* The new code will not work if there was no "clock-names".

Many of the old devices had a clock-names present (and it was "pwm"),
but not all.  Specifically it looks like
"arch/arm/boot/dts/rk3xxx.dtsi" doesn't specify a clock-names.

> @@ -343,13 +344,38 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>         if (IS_ERR(pc->base))
>                 return PTR_ERR(pc->base);
>
> -       pc->clk = devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(pc->clk))
> -               return PTR_ERR(pc->clk);
> +       pc->clk = devm_clk_get(&pdev->dev, "pwm");
> +       count = of_property_count_strings(pdev->dev.of_node, "clock-names");
> +       if (count == 2)
> +               pc->pclk = devm_clk_get(&pdev->dev, "pclk");
> +       else
> +               pc->pclk = pc->clk;
> +
> +       if (IS_ERR(pc->clk)) {
> +               ret = PTR_ERR(pc->clk);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Can't get bus clk: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (IS_ERR(pc->pclk)) {
> +               ret = PTR_ERR(pc->pclk);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
> +               return ret;
> +       }

In the above code you need to check the count _before_ trying to get
the clock by name.


-Doug
