From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 10 Oct 2018 06:11:29 -0700
Message-ID: <20181010131128.GA29142@infradead.org>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>
Cc: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org
List-Id: linux-pwm@vger.kernel.org

Thanks for getting these drivers submitted upstream!

I don't really know anything about PWM, so just some random nitpicking
below..

> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));

* already has a higher precedence than +, so no need for the inner
braces.

> +	duty = ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));

Same here.

> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
	unsigned long scalePow = (pwm->approx_period * (u64)rate) / 1000000000;

no camcel case, please.

> +	int scale = ilog2(scalePow) - 16;
> +
> +	scale = clamp(scale, 0, 0xf);

Why not:

	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);

> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> +				     unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +	struct sifive_pwm_device *pwm = container_of(nb,
> +						     struct sifive_pwm_device,
> +						     notifier);

I don't think there are any guidlines, but I always prefer to just move
the whole container_of onto a new line:

	struct sifive_pwm_device *pwm =
		container_of(nb, struct sifive_pwm_device, notifier);

> +static struct platform_driver sifive_pwm_driver = {
> +	.probe = sifive_pwm_probe,
> +	.remove = sifive_pwm_remove,
> +	.driver = {
> +		.name = "pwm-sifivem",
> +		.of_match_table = of_match_ptr(sifive_pwm_of_match),
> +	},
> +};

What about using tabs to align this a little more nicely?

static struct platform_driver sifive_pwm_driver = {
	.probe			= sifive_pwm_probe,
	.remove			= sifive_pwm_remove,
	.driver = {
		.name		= "pwm-sifivem",
		.of_match_table	= of_match_ptr(sifive_pwm_of_match),
	},
};
