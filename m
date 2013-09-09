Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] pwm: pxa: add device tree support to pwm driver
Date: Mon, 9 Sep 2013 02:49:47 +0200
References: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
In-Reply-To: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201309090249.47407.marex@denx.de>
List-ID: <linux-pwm.vger.kernel.org>
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Dear Mike Dunn,

> This patch adds device tree support to the pxa's pwm driver.  Only an OF
> match table is added; nothing needs to be extracted from the device tree
> node.  The existing platform_device id table is reused for the match table
> data.  Support for inverted polarity is also added.
> 
> Tested on a Palm Treo 680 (both platform data and DT cases).
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
> Changle log:
> v2:
> - of_match_table contains only the "pxa250-pwm" compatible string; require
> one device instance per pwm
> - add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> - add support for polarity flag in DT and implement set_polarity() method
>   (the treo 680 inverts the signal between pwm out and backlight)
> - return -EINVAL instead of -ENODEV if platform data or DT node not found
> - output dev_info string if platform data missing
> - expanded CC list of patch
> 
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 33 +++++++++++++
>  arch/arm/boot/dts/pxa27x.dtsi                     | 24 ++++++++++
>  drivers/pwm/pwm-pxa.c                             | 57
> +++++++++++++++++++++++ 3 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt new file mode 100644
> index 0000000..7b09bfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -0,0 +1,33 @@
> +Marvell pwm controller
> +
> +Required properties:
> +- compatible:
> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible =
> "marvell,pxa250-pwm"; +- reg: physical base address and length of the
> registers used by the pwm channel +  NB: One device instance must be
> created for each pwm that is used, so the +  length covers only the
> register window for one pwm output, not that of the +  entire pwm
> controller.  Currently length is 0x10 for all supported devices. +-
> #pwm-cells: should be 3.
> +   cell 1: the per-chip index of the PWM to use,
> +   cell 2: the period in nanoseconds,

Is there no generic OF prop for this?

> +   cell 3: flags; set bit 0 to specify inverse polarity.

Do we not have some generic flag to indicate inverted PWM polarity?

[...]
 
> +#ifdef CONFIG_OF
> +/*
> + * Device tree users should create one device instance for each pwm
> channel. + * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the
> original driver + * code that this is a single channel pxa25x-pwm.
> + */

Above ... pxa250-pwm , no ?

> +static struct of_device_id pwm_of_match[] = {
> +	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},

Surely, data can be NULL, no ?

[...]

> @@ -145,6 +199,8 @@ static int pwm_probe(struct platform_device *pdev)
>  	pwm->chip.ops = &pxa_pwm_ops;
>  	pwm->chip.base = -1;
>  	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
> +	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> +	pwm->chip.of_pwm_n_cells = 3;

Are these two settings needed ?

[...]
Best regards,
Marek Vasut
