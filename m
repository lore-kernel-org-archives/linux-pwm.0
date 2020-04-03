From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 08/16] watchdog: add support for sl28cpld watchdog
Date: Thu, 2 Apr 2020 23:25:08 -0700
Message-ID: <20200403062508.GA206903@roeck-us.net>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-9-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200402203656.27047-9-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 02, 2020 at 10:36:48PM +0200, Michael Walle wrote:
> This adds support for the watchdog of the sl28cpld board management
> controller. This is part of a multi-function device driver.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/watchdog/Kconfig        |  11 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/sl28cpld_wdt.c | 242 ++++++++++++++++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/watchdog/sl28cpld_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0663c604bd64..6c53c1d0f348 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -340,6 +340,17 @@ config MLX_WDT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mlx-wdt.
>  
> +config SL28CPLD_WATCHDOG
> +	tristate "Kontron sl28 watchdog"
> +	depends on MFD_SL28CPLD
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include support for the watchdog timer
> +	  on the Kontron sl28 CPLD.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sl28cpld_wdt.
> +
>  # ALPHA Architecture
>  
>  # ARM Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 6de2e4ceef19..b9ecdf2d7347 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -224,3 +224,4 @@ obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
>  obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
>  obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
>  obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
> +obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
> diff --git a/drivers/watchdog/sl28cpld_wdt.c b/drivers/watchdog/sl28cpld_wdt.c
> new file mode 100644
> index 000000000000..79a7e36217a6
> --- /dev/null
> +++ b/drivers/watchdog/sl28cpld_wdt.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld watchdog driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +
> +/*
> + * Watchdog timer block registers.
> + */
> +#define WDT_CTRL			0x00
> +#define  WDT_CTRL_EN			BIT(0)
> +#define  WDT_CTRL_LOCK			BIT(2)
> +#define  WDT_CTRL_ASSERT_SYS_RESET	BIT(6)
> +#define  WDT_CTRL_ASSERT_WDT_TIMEOUT	BIT(7)
> +#define WDT_TIMEOUT			0x01
> +#define WDT_KICK			0x02
> +#define  WDT_KICK_VALUE			0x6b
> +#define WDT_COUNT			0x03
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int timeout;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> +
> +struct sl28cpld_wdt {
> +	struct watchdog_device wdd;
> +	struct regmap *regmap;
> +	u32 offset;
> +	bool assert_wdt_timeout;
> +};
> +
> +static int sl28cpld_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_write(wdt->regmap, wdt->offset + WDT_KICK,
> +			    WDT_KICK_VALUE);
> +}
> +
> +static int sl28cpld_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int val;
> +
> +	val = WDT_CTRL_EN | WDT_CTRL_ASSERT_SYS_RESET;
> +	if (wdt->assert_wdt_timeout)
> +		val |= WDT_CTRL_ASSERT_WDT_TIMEOUT;
> +	if (nowayout)
> +		val |= WDT_CTRL_LOCK;
> +
> +	return regmap_update_bits(wdt->regmap, wdt->offset + WDT_CTRL,
> +				  val, val);
> +}
> +
> +static int sl28cpld_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	return regmap_update_bits(wdt->regmap, wdt->offset + WDT_CTRL,
> +				  WDT_CTRL_EN, 0);
> +}
> +
> +static unsigned int sl28cpld_wdt_status(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, &status);
> +	if (ret < 0)
> +		return 0;
> +
> +	/* is the watchdog timer running? */
> +	return (status & WDT_CTRL_EN) << WDOG_ACTIVE;

This is really bad coding style. It uses the fact that WDT_CTRL_EN is
at bit position 0 and sets WDOG_ACTIVE accordingly.

But that it is wrong, not even considering the coding style problem.
The status function is supposed to return WDIOF_ bits. What it returns
if the watchdog is running is WDOG_ACTIVE, or BIT(0), which is then
reported to userspace as WDIOF_OVERHEAT.

> +}
> +
> +static unsigned int sl28cpld_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +	unsigned int val;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
> +	if (ret < 0)
> +		return 0;
> +
> +	return val;
> +}
> +
> +static int sl28cpld_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	int ret;
> +	struct sl28cpld_wdt *wdt = watchdog_get_drvdata(wdd);

Nit: Reverse christmas tree order looks a bit nicer.

> +
> +	ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, timeout);
> +	if (ret == 0)

Please run checkpatch --strict and fix this and the reported alignment
problem.

> +		wdd->timeout = timeout;
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_info sl28cpld_wdt_info = {
> +	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "SMARC-sAL28 CPLD watchdog",
> +};
> +
> +static struct watchdog_ops sl28cpld_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = sl28cpld_wdt_start,
> +	.stop = sl28cpld_wdt_stop,
> +	.status = sl28cpld_wdt_status,
> +	.ping = sl28cpld_wdt_ping,
> +	.set_timeout = sl28cpld_wdt_set_timeout,
> +	.get_timeleft = sl28cpld_wdt_get_timeleft,
> +};
> +
> +static int sl28cpld_wdt_locked(struct sl28cpld_wdt *wdt)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return val & WDT_CTRL_LOCK;
> +}
> +
> +static int sl28cpld_wdt_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_wdt *wdt;
> +	struct watchdog_device *wdd;
> +	struct resource *res;
> +	unsigned int val;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!wdt->regmap)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (res == NULL)
> +		return -EINVAL;
> +	wdt->offset = res->start;
> +
> +	if (device_property_read_bool(&pdev->dev,
> +				      "kontron,assert-wdt-timeout-pin"))
> +		wdt->assert_wdt_timeout = true;

This might be simpler written as
	wdt->assert_wdt_timeout = device_property_read_bool(...);

> +
> +	/* initialize struct watchdog_device */
> +	wdd = &wdt->wdd;
> +	wdd->parent = &pdev->dev;
> +	wdd->info = &sl28cpld_wdt_info;
> +	wdd->ops = &sl28cpld_wdt_ops;
> +	wdd->min_timeout = 1;
> +	wdd->max_timeout = 255;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +
> +	/* if the watchdog is locked, we set nowayout to true */
> +	ret = sl28cpld_wdt_locked(wdt);
> +	if (ret < 0)
> +		return ret;
> +	if (ret)
> +		nowayout = true;
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	/*
> +	 * Initial timeout value, can either be set by kernel parameter or by
> +	 * the device tree. If both are not given the current value is used.
> +	 */
> +	watchdog_init_timeout(wdd, timeout, &pdev->dev);
> +	if (wdd->timeout) {
> +		sl28cpld_wdt_set_timeout(wdd, wdd->timeout);
> +	} else {
> +		ret = regmap_read(wdt->regmap, wdt->offset + WDT_TIMEOUT,
> +				  &val);
> +		if (ret < 0)
> +			return ret;
> +		wdd->timeout = val;

Oddly enough that can result in a timeout of 0 if that is what the chip
reports. Are you sure that is acceptable ?

> +	}
> +
> +	watchdog_stop_on_reboot(wdd);
> +	ret = devm_watchdog_register_device(&pdev->dev, wdd);

This does not inform the watchdog core if the watchdog is already active,
even though that is clearly supported. You might want to consider setting
WDOG_HW_RUNNING in that case.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +

I don't see where this is used.

> +	dev_info(&pdev->dev, "CPLD watchdog: initial timeout %d sec%s\n",
> +		wdd->timeout, nowayout ? ", nowayout" : "");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sl28cpld_wdt_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_wdt_of_match);
> +
> +static const struct platform_device_id sl28cpld_wdt_id_table[] = {
> +	{ "sl28cpld-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_wdt_id_table);
> +
> +static struct platform_driver sl28cpld_wdt_driver = {
> +	.probe = sl28cpld_wdt_probe,
> +	.id_table = sl28cpld_wdt_id_table,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = sl28cpld_wdt_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_wdt_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Watchdog Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
