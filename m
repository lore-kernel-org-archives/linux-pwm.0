From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Fri, 5 Jun 2020 07:57:09 +0100
Message-ID: <20200605065709.GD3714@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200604211039.12689-3-michael-QKn5cuLxLXY@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Mark, what do you think?

On Thu, 04 Jun 2020, Michael Walle wrote:

> Add the core support for the board management controller found on the
> SMARC-sAL28 board. It consists of the following functions:
>  - watchdog
>  - GPIO controller
>  - PWM controller
>  - fan sensor
>  - interrupt controller
> 
> At the moment, this controller is used on the Kontron SMARC-sAL28 board.
> 
> Please note that the MFD driver is defined as bool in the Kconfig
> because the next patch will add interrupt support.
> 
> Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
> ---
>  drivers/mfd/Kconfig    | 19 ++++++++++
>  drivers/mfd/Makefile   |  2 ++
>  drivers/mfd/sl28cpld.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
>  create mode 100644 drivers/mfd/sl28cpld.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4f8b73d92df3..5c0cd514d197 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2109,5 +2109,24 @@ config SGI_MFD_IOC3
>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>  	  then say Y. Otherwise say N.
>  
> +config MFD_SL28CPLD
> +	bool "Kontron sl28 core driver"

"Kontron SL28 Core Driver"

> +	depends on I2C=y
> +	depends on OF
> +	select REGMAP_I2C
> +	select MFD_CORE
> +	help
> +	  This option enables support for the board management controller
> +	  found on the Kontron sl28 CPLD. You have to select individual

I can't find any reference to the "Kontron sl28 CPLD" online.

Is there a datasheet?

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
> index 9367a92f795a..be59fb40aa28 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -264,3 +264,5 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> +
> +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> diff --git a/drivers/mfd/sl28cpld.c b/drivers/mfd/sl28cpld.c
> new file mode 100644
> index 000000000000..a23194bb6efa
> --- /dev/null
> +++ b/drivers/mfd/sl28cpld.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MFD core for the sl28cpld.

Ideally this would match the Kconfig subject line.

> + * Copyright 2019 Kontron Europe GmbH

This is out of date.

> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +#define SL28CPLD_VERSION	0x03
> +#define SL28CPLD_MIN_REQ_VERSION 14
> +
> +struct sl28cpld {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};

Why do you need this structure?

> +static const struct regmap_config sl28cpld_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_stride = 1,
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

This is now a shared memory allocator and not an MFD at all.

I'm clamping down on these type of drivers!

Please find a better way to accomplish this.

Potentially using "simple-mfd" and "simple-regmap".

The former already exists and does what you want.  The latter doesn't
yet exist, but could solve your and lots of other contributor's
issues.

Heck maybe I'll implement it myself if this keeps happening.

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

If the struct definition is in here, how do you use it elsewhere?

> +	dev_info(dev, "successfully probed. CPLD version %d\n", cpld_version);
> +
> +	return devm_of_platform_populate(&i2c->dev);
> +}
> +
> +static const struct of_device_id sl28cpld_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-r1", },
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
> +MODULE_AUTHOR("Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
