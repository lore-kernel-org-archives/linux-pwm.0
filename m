Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] pwm: pxa: add device tree support to pwm driver
Date: Wed, 4 Sep 2013 00:20:54 +0200
References: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com>
In-Reply-To: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201309040020.55029.marex@denx.de>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Mike Dunn <mikedunn@newsguy.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Thierry Reding <thierry.reding@gmail.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Grant Likely <grant.likely@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>

Dear Mike Dunn,

> This patch adds device tree support to the pxa's pwm driver.  Only an OF
> match table is added; nothing needs to be extracted from the device tree
> node.  The existing platform_device id table is reused for the match table
> data.
> 
> Tested on a Palm Treo 680 (both platform data and DT cases).
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
> 
> I don't have data sheets handy for the newer Marvell pxa's (and I'm
> confused about the presence of a pwm unit on pxa25x), so only pxa27x.dtsi
> was updated. Thanks for looking!
> 
>  arch/arm/boot/dts/pxa27x.dtsi | 12 ++++++++++++
>  drivers/pwm/pwm-pxa.c         | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> index d7c5d72..4031dce 100644
> --- a/arch/arm/boot/dts/pxa27x.dtsi
> +++ b/arch/arm/boot/dts/pxa27x.dtsi
> @@ -10,5 +10,17 @@
>  			marvell,intc-priority;
>  			marvell,intc-nr-irqs = <34>;
>  		};
> +
> +		pwm0: pwm@40b00000 {
> +			compatible = "marvell,pxa27x-pwm";
> +			reg = <0x40b00000 0x100000>;
> +			#pwm-cells = <2>;
> +		};
> +
> +		pwm1: pwm@40c00000 {
> +			compatible = "marvell,pxa27x-pwm";
> +			reg = <0x40c00000 0x100000>;
> +			#pwm-cells = <2>;
> +		};
>  	};
>  };
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index a4d2164..be5f914 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
> +#include <linux/of_device.h>
> 
>  #include <asm/div64.h>
> 
> @@ -124,6 +125,30 @@ static struct pwm_ops pxa_pwm_ops = {
>  	.owner = THIS_MODULE,
>  };
> 
> +#ifdef CONFIG_OF
> +/* use the platform_device id table for OF match table data */
> +static struct of_device_id pwm_of_match[] = {
> +	{ .compatible = "marvell,pxa25x-pwm", .data = &pwm_id_table[0] },
> +	{ .compatible = "marvell,pxa27x-pwm", .data = &pwm_id_table[1] },
> +	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[2] },
> +	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[3] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_of_match);

Are PXA2xx and PXA3xx PWM impleemntations not all the same ? If so, why not just 
stick with pxa25x-pwm only for all of the CPUs (aka. the lowest CPU model). Then 
the table would have but a single entry.

[...]

Best regards,
Marek Vasut
