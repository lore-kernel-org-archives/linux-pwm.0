Return-Path: <plagnioj@jcrosoft.com>
Date: Thu, 14 Nov 2013 17:38:17 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v6 1/2] PWM: atmel-pwm: add PWM controller driver
Message-ID: <20131114163817.GK28304@ns203013.ovh.net>
References: <1383292767-11211-1-git-send-email-voice.shen@atmel.com>
 <20131113095628.GI28304@ns203013.ovh.net>
 <52846D94.5090608@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52846D94.5090608@atmel.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Bo Shen <voice.shen@atmel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> >>+MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
> >>+#endif
> >>+
> >>+static int atmel_pwm_probe(struct platform_device *pdev)
> >>+{
> >>+	const struct of_device_id *of_id =
> >>+		of_match_device(atmel_pwm_dt_ids, &pdev->dev);
> >>+	const struct atmel_pwm_data *data;
> >>+	struct atmel_pwm_chip *atmel_pwm;
> >>+	struct resource *res;
> >>+	int ret;
> >>+
> >>+	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
> >>+	if (!atmel_pwm)
> >>+		return -ENOMEM;
> >>+
> >>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>+	if (!res)
> >>+		return -ENODEV;
> >>+
> >>+	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
> >>+	if (IS_ERR(atmel_pwm->base))
> >>+		return PTR_ERR(atmel_pwm->base);
> >>+
> >>+	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> >>+	if (IS_ERR(atmel_pwm->clk))
> >>+		return PTR_ERR(atmel_pwm->clk);
> >>+
> >>+	ret = clk_prepare(atmel_pwm->clk);
> >>+	if (ret) {
> >>+		dev_err(&pdev->dev, "failed to prepare pwm clock\n");
> >>+		return ret;
> >>+	}
> >>+
> >>+	atmel_pwm->chip.dev = &pdev->dev;
> >>+	atmel_pwm->chip.ops = &atmel_pwm_ops;
> >I get one issue here for non-dt platform
> 
> I will fix this issue for none-dt in next version.
> 
> >>+	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> >>+	atmel_pwm->chip.of_pwm_n_cells = 3;
> >those 3 no need
> 
> Which "those 3"?
> for dt / none-dt compatible, I will use following code
> --->8---
> if (pdev->dev.of_node) {
> 	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
>         atmel_pwm->chip.of_pwm_n_cells = 3;
>         atmel_pwm->chip.base = -1;
> } else {
> 	atmel_pwm->chip.base = 0;
base need to choose by the board not 0
> }
> ---8<---
> 
> >>+	atmel_pwm->chip.base = -1;
> >here we need specify the base from the board so we known which pwn to use
> >for DT -1 is good as we use phandle
> 
> I will fix this issue for none-dt in next version.
> 
Best Regards,
J.
