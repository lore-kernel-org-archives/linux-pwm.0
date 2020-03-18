From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 05/18] mfd: Add support for Kontron sl28cpld management
 controller
Date: Tue, 17 Mar 2020 20:28:56 -0700
Message-ID: <1ea0ae38-c91d-810b-1474-71f17b66fbd0@roeck-us.net>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-6-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200317205017.28280-6-michael@walle.cc>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On 3/17/20 1:50 PM, Michael Walle wrote:
> This patch adds core support for the board management controller found
> on the SMARC-sAL28 board. It consists of the following functions:
>  - watchdog
>  - GPIO controller
>  - PWM controller
>  - fan sensor
>  - interrupt controller
> 
> At the moment, this controller is used on the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mfd/Kconfig    |  21 ++++++
>  drivers/mfd/Makefile   |   2 +
>  drivers/mfd/sl28cpld.c | 155 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/mfd/sl28cpld.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c547ed575e6..01588c366476 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2059,5 +2059,26 @@ config SGI_MFD_IOC3
>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>  	  then say Y. Otherwise say N.
>  
> +config MFD_SL28CPLD
> +	tristate "Kontron sl28 core driver"
> +	depends on I2C=y

Why I2C=y and not just I2C ?

> +	depends on OF
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select SL28CPLD_IRQ
> +	select MFD_CORE
> +	help
> +	  This option enables support for the board management controller
> +	  found on the Kontron sl28 CPLD. You have to select individual
> +	  functions, such as watchdog, GPIO, etc, under the corresponding menus
> +	  in order to enable them.
> +
> +	  Currently supported boards are:
> +
> +		Kontron SMARC-sAL28
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sl28cpld.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f935d10cbf0f..9bc38863b9c7 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -259,3 +259,5 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> +
> +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> diff --git a/drivers/mfd/sl28cpld.c b/drivers/mfd/sl28cpld.c
> new file mode 100644
> index 000000000000..789f21f90752
> --- /dev/null
> +++ b/drivers/mfd/sl28cpld.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MFD core for the CPLD on a SMARC-sAL28 board.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +
> +#define SL28CPLD_VERSION 0x03
> +#define SL28CPLD_WATCHDOG_BASE 0x4
> +#define SL28CPLD_HWMON_FAN_BASE 0xb
> +#define SL28CPLD_PWM0_BASE 0xc
> +#define SL28CPLD_PWM1_BASE 0xe
> +#define SL28CPLD_GPIO0_BASE 0x10
> +#define SL28CPLD_GPIO1_BASE 0x15
> +#define SL28CPLD_GPO_BASE 0x1a
> +#define SL28CPLD_GPI_BASE 0x1b
> +#define SL28CPLD_INTC_BASE 0x1c
> +
> +/* all subdevices share the same IRQ */
> +#define SL28CPLD_IRQ 0
> +
> +#define SL28CPLD_MIN_REQ_VERSION 14
> +
> +struct sl28cpld {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config sl28cpld_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +};
> +
> +static struct resource sl28cpld_watchdog_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_WATCHDOG_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_hwmon_fan_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_HWMON_FAN_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_pwm0_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_PWM0_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_pwm1_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_PWM1_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_gpio0_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPIO0_BASE, 1),
> +	DEFINE_RES_IRQ(SL28CPLD_IRQ),
> +};
> +
> +static struct resource sl28cpld_gpio1_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPIO1_BASE, 1),
> +	DEFINE_RES_IRQ(SL28CPLD_IRQ),
> +};
> +
> +static struct resource sl28cpld_gpo_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPO_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_gpi_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPI_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_intc_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_INTC_BASE, 1),
> +	DEFINE_RES_IRQ(SL28CPLD_IRQ),
> +};
> +
> +static const struct mfd_cell sl28cpld_devs[] = {
> +	OF_MFD_CELL("sl28cpld-wdt", sl28cpld_watchdog_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-wdt"),
> +	OF_MFD_CELL("sl28cpld-fan", sl28cpld_hwmon_fan_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-fan"),
> +	OF_MFD_CELL("sl28cpld-pwm", sl28cpld_pwm0_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-pwm"),
> +	OF_MFD_CELL("sl28cpld-pwm", sl28cpld_pwm1_resources, NULL, 0, 1,
> +		    "kontron,sl28cpld-pwm"),
> +	OF_MFD_CELL("sl28cpld-gpio", sl28cpld_gpio0_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-gpio"),
> +	OF_MFD_CELL("sl28cpld-gpio", sl28cpld_gpio1_resources, NULL, 0, 1,
> +		    "kontron,sl28cpld-gpio"),
> +	OF_MFD_CELL("sl28cpld-gpo", sl28cpld_gpo_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-gpo"),
> +	OF_MFD_CELL("sl28cpld-gpi", sl28cpld_gpi_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-gpi"),
> +	OF_MFD_CELL("sl28cpld-intc", sl28cpld_intc_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-intc"),
> +};
> +
> +static int sl28cpld_probe(struct i2c_client *i2c)
> +{
> +	struct sl28cpld *sl28cpld;
> +	struct device *dev = &i2c->dev;
> +	unsigned int cpld_version;
> +	int ret;
> +
> +	sl28cpld = devm_kzalloc(dev, sizeof(*sl28cpld), GFP_KERNEL);
> +	if (!sl28cpld)
> +		return -ENOMEM;
> +
> +	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
> +	if (IS_ERR(sl28cpld->regmap))
> +		return PTR_ERR(sl28cpld->regmap);
> +
> +	ret = regmap_read(sl28cpld->regmap, SL28CPLD_VERSION, &cpld_version);
> +	if (ret)
> +		return ret;
> +
> +	if (cpld_version < SL28CPLD_MIN_REQ_VERSION) {
> +		dev_err(dev, "unsupported CPLD version %d\n", cpld_version);
> +		return -ENODEV;
> +	}
> +
> +	sl28cpld->dev = dev;
> +	i2c_set_clientdata(i2c, sl28cpld);
> +
> +	dev_info(dev, "successfully probed. CPLD version %d\n", cpld_version);
> +
> +	return devm_mfd_add_devices(dev, -1, sl28cpld_devs,
> +				    ARRAY_SIZE(sl28cpld_devs), NULL,
> +				    i2c->irq, NULL);
> +}
> +
> +static const struct of_device_id sl28cpld_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_of_match);
> +
> +static struct i2c_driver sl28cpld_driver = {
> +	.probe_new = sl28cpld_probe,
> +	.driver = {
> +		.name = "sl28cpld",
> +		.of_match_table = of_match_ptr(sl28cpld_of_match),
> +	},
> +};
> +module_i2c_driver(sl28cpld_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld MFD Core Driver");
> +MODULE_LICENSE("GPL");
> 
