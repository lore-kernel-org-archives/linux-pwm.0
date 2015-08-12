From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 1/5] pwm: add the Berlin pwm controller driver
Date: Wed, 12 Aug 2015 16:21:16 +0200
Message-ID: <55CB565C.8050906@gmail.com>
References: <1439387497-6863-1-git-send-email-antoine.tenart@free-electrons.com> <1439387497-6863-2-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439387497-6863-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 08/12/2015 03:51 PM, Antoine Tenart wrote:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Antoine,

nice rework, but...

[...]
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> new file mode 100644
> index 000000000000..f89e25ea5c6d
> --- /dev/null
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -0,0 +1,227 @@
[...]
> +#define BERLIN_PWM_ENABLE		BIT(0)
> +#define BERLIN_PWM_DISABLE		0x0

I'd drop BERLIN_PWM_DISABLE and use reg & ~BERLIN_PWM_ENABLE below.
Even if there are no more writable bits in that register, IMHO it
is good practice to affect as little bits as possible.

[...]
> +/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> +static const u32 prescaler_diff_table[] = {
> +	1, 4, 2, 2, 4, 4, 4, 4,
> +};
> +
> +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     int duty_ns, int period_ns)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +	int ret, prescale = 0;
> +	u32 val, duty, period;
> +	u64 cycles;
> +
> +	cycles = clk_get_rate(berlin_chip->clk);
> +	cycles *= period_ns;
> +	do_div(cycles, NSEC_PER_SEC);
> +
> +	while (cycles > BERLIN_PWM_MAX_TCNT)
> +		do_div(cycles, prescaler_diff_table[++prescale]);
> +
> +	if (cycles > BERLIN_PWM_MAX_TCNT)
> +		return -EINVAL;

Does my idea actually work? Did you test it with some different
pwm frequencies?

> +	period = cycles;
> +	cycles *= duty_ns;
> +	do_div(cycles, period_ns);
> +	duty = cycles;
> +
> +	ret = clk_prepare_enable(berlin_chip->clk);
> +	if (ret)
> +		return ret;

Hmm. I understand that this may be required as the pwm framework
calls .pwm_config before .pwm_enable, but...

> +
> +	spin_lock(&berlin_chip->lock);
> +
> +	val = berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +	val &= ~BERLIN_PWM_PRESCALE_MASK;
> +	val |= prescale;
> +	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	berlin_pwm_writel(duty, berlin_chip, pwm->hwpwm, BERLIN_PWM_DUTY);
> +	berlin_pwm_writel(period, berlin_chip, pwm->hwpwm, BERLIN_PWM_TCNT);
> +
> +	spin_unlock(&berlin_chip->lock);
> +
> +	clk_disable_unprepare(berlin_chip->clk);

Are you sure that register contents are retained after disabling the
clock? I understand that cfg_clk is the _ip_ input clock and pwm gets
derived from it.

Actually, since cfg_clk seems to be an important, internal SoC clock
I'd say to clk_prepare_enable() in _probe() before reading any
registers and clk_disable_unprepare() on _remove() (see below).

Internal low-frequency clocks don't consume that much power that it
is worth the pain ;)

> +	return 0;
> +}
> +
> +static int berlin_pwm_set_polarity(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   enum pwm_polarity polarity)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +	int ret;
> +	u32 val;
> +
> +	ret = clk_prepare_enable(berlin_chip->clk);
> +	if (ret)
> +		return ret;

These would become unnecessary then.

> +	spin_lock(&berlin_chip->lock);
> +
> +	val = berlin_pwm_readl(berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	if (polarity == PWM_POLARITY_NORMAL)
> +		val &= ~BERLIN_PWM_INVERT_POLARITY;
> +	else
> +		val |= BERLIN_PWM_INVERT_POLARITY;
> +
> +	berlin_pwm_writel(val, berlin_chip, pwm->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	spin_unlock(&berlin_chip->lock);
> +
> +	clk_disable_unprepare(berlin_chip->clk);

ditto.

> +	return 0;
> +}
> +
> +static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +	int ret;
> +
> +	ret = clk_prepare_enable(berlin_chip->clk);
> +	if (ret)
> +		return ret;

ditto.

> +	spin_lock(&berlin_chip->lock);
> +	berlin_pwm_writel(BERLIN_PWM_ENABLE, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);
> +	spin_unlock(&berlin_chip->lock);
> +
> +	return 0;
> +}
> +
> +static void berlin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct berlin_pwm_chip *berlin_chip = to_berlin_pwm_chip(chip);
> +
> +	spin_lock(&berlin_chip->lock);
> +	berlin_pwm_writel(BERLIN_PWM_DISABLE, berlin_chip, pwm->hwpwm, BERLIN_PWM_EN);
> +	spin_unlock(&berlin_chip->lock);
> +
> +	clk_disable_unprepare(berlin_chip->clk);

ditto.

> +}
> +
> +static const struct pwm_ops berlin_pwm_ops = {
> +	.config = berlin_pwm_config,
> +	.set_polarity = berlin_pwm_set_polarity,
> +	.enable = berlin_pwm_enable,
> +	.disable = berlin_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct of_device_id berlin_pwm_match[] = {
> +	{ .compatible = "marvell,berlin-pwm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, berlin_pwm_match);
> +
> +static int berlin_pwm_probe(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	pwm->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return PTR_ERR(pwm->clk);
> +
> +	pwm->chip.dev = &pdev->dev;
> +	pwm->chip.ops = &berlin_pwm_ops;
> +	pwm->chip.base = -1;
> +	pwm->chip.npwm = 4;
> +	pwm->chip.can_sleep = true;
> +	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
> +	pwm->chip.of_pwm_n_cells = 3;
> +
> +	spin_lock_init(&pwm->lock);

add clk_prepare_enable() before adding the pwmchip...

> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_remove(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&pwm->chip);

... and clk_disable_unprepare after removing it.

Besides the comments, for Berlin you get my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks!

> +}
> +
> +static struct platform_driver berlin_pwm_driver = {
> +	.probe	= berlin_pwm_probe,
> +	.remove	= berlin_pwm_remove,
> +	.driver	= {
> +		.name	= "berlin-pwm",
> +		.of_match_table = berlin_pwm_match,
> +	},
> +};
> +module_platform_driver(berlin_pwm_driver);
> +
> +MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
> +MODULE_DESCRIPTION("Marvell Berlin PWM driver");
> +MODULE_LICENSE("GPL v2");
>
