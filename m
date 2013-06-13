Return-Path: <heiko@sntech.de>
From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Date: Thu, 13 Jun 2013 22:14:19 +0200
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306132214.20017.heiko@sntech.de>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

Am Mittwoch, 5. Juni 2013, 23:18:13 schrieb Tomasz Figa:
> This patch introduces new Samsung PWM driver, which uses Samsung
> PWM/timer master driver to control shared parts of the hardware.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-samsung.c | 528
> ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 529
> insertions(+)
>  create mode 100644 drivers/pwm/pwm-samsung.c
> 
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile

[...]

> +static int pwm_samsung_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct samsung_pwm_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (chip == NULL) {
> +		dev_err(dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->chip.dev = &pdev->dev;
> +	chip->chip.ops = &pwm_samsung_ops;
> +	chip->chip.base = -1;
> +	chip->chip.npwm = SAMSUNG_PWM_NUM;
> +
> +	if (pdev->dev.of_node) {
> +		ret = pwm_samsung_parse_dt(chip);
> +		if (ret)
> +			return ret;
> +
> +		chip->chip.of_xlate = of_pwm_xlate_with_flags;
> +		chip->chip.of_pwm_n_cells = 3;
> +	} else {
> +		if (!pdev->dev.platform_data) {
> +			dev_err(&pdev->dev, "no platform data specified\n");
> +			return -EINVAL;
> +		}
> +
> +		memcpy(&chip->variant, pdev->dev.platform_data,
> +							sizeof(chip->variant));
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get mem resource\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!chip->base) {
> +		dev_err(&pdev->dev, "failed to request and map registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->base_clk = devm_clk_get(&pdev->dev, "timers");
> +	if (IS_ERR(chip->base_clk)) {
> +		dev_err(dev, "failed to get timer base clk\n");
> +		return PTR_ERR(chip->base_clk);
> +	}
> +	clk_prepare_enable(chip->base_clk);
> +
> +	chip->tclk0 = devm_clk_get(&pdev->dev, "pwm-tclk0");
> +	chip->tclk1 = devm_clk_get(&pdev->dev, "pwm-tclk1");
> +
> +	ret = pwmchip_add(&chip->chip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register pwm\n");
> +		goto err_clk_disable;
> +	}
> +
> +	dev_info(dev, "base_clk at %lu, tclk0 at %lu, tclk1 at %lu\n",
> +		clk_get_rate(chip->base_clk),
> +		!IS_ERR(chip->tclk0) ? clk_get_rate(chip->tclk0) : 0,
> +		!IS_ERR(chip->tclk1) ? clk_get_rate(chip->tclk1) : 0);

hmm, these values simply tell some internal state of the pwm, so wouldn't a 
dev_dbg be more appropriate?


> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(chip->base_clk);
> +
> +	return ret;
> +}
