From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 02/13] mfd: add simple regmap based I2C driver
Date: Mon, 20 Jul 2020 00:25:52 +0200
Message-ID: <09810b67fb0259a57086f938cd8382c5@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-3-michael@walle.cc> <20200717090444.GE3165313@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20200717090444.GE3165313@dell>
Sender: linux-hwmon-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg
List-Id: linux-pwm@vger.kernel.org

Am 2020-07-17 11:04, schrieb Lee Jones:
> On Mon, 06 Jul 2020, Michael Walle wrote:
> 
>> There are I2C devices which contain several different functions but
>> doesn't require any special access functions. For these kind of 
>> drivers
>> an I2C regmap should be enough.
>> 
>> Create an I2C driver which creates an I2C regmap and enumerates its
>> children. If a device wants to use this as its MFD core driver, it has
>> to add an individual compatible string. It may provide its own regmap
>> configuration.
>> 
>> Subdevices can use dev_get_regmap() on the parent to get their regmap
>> instance.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Changes since v4:
>>  - new patch. Lee, please bear with me. I didn't want to delay the
>>    new version (where a lot of remarks on the other patches were
>>    addressed) even more, just because we haven't figured out how
>>    to deal with the MFD part. So for now, I've included this one.
>> 
>>  drivers/mfd/Kconfig          |  9 +++++++
>>  drivers/mfd/Makefile         |  1 +
>>  drivers/mfd/simple-mfd-i2c.c | 50 
>> ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 60 insertions(+)
>>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
>> 
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 33df0837ab41..f1536a710aca 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called si476x-core.
>> 
>> +config MFD_SIMPLE_MFD_I2C
>> +	tristate "Simple regmap based I2C devices"
>> +	depends on I2C
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	help
>> +	  This is a consolidated driver for all MFD devices which are
>> +	  basically just a regmap bus driver.
>> +
>>  config MFD_SM501
>>  	tristate "Silicon Motion SM501"
>>  	depends on HAS_DMA
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index a60e5f835283..78d24a3e7c9e 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>> 
>>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>> +obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>> diff --git a/drivers/mfd/simple-mfd-i2c.c 
>> b/drivers/mfd/simple-mfd-i2c.c
>> new file mode 100644
>> index 000000000000..1fdca89964b1
>> --- /dev/null
>> +++ b/drivers/mfd/simple-mfd-i2c.c
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/regmap.h>
> 
> I'm pretty sure you do not require all of these headers.

Shot, I'll clean that up.

>> +struct simple_mfd_i2c_config {
>> +	const struct regmap_config *regmap_config;
>> +};
> 
> No need for this yet I feel.
> 
> Let's keep it as simple as possible.

ok

>> +static const struct regmap_config simple_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +};
>> +
>> +static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	const struct regmap_config *regmap_config = &simple_regmap_config;
>> +	const struct simple_mfd_i2c_config *config;
>> +	struct regmap *regmap;
>> +
>> +	config = device_get_match_data(&i2c->dev);
> 
> Have this return regmap_config.

ok

>> +	if (config && config->regmap_config)
>> +		regmap_config = config->regmap_config;
>> +
>> +	regmap = devm_regmap_init_i2c(i2c, regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	return devm_of_platform_populate(&i2c->dev);
>> +}
>> +
>> +static const struct of_device_id simple_mfd_i2c_of_match[] = {
>> +	{}
>> +};
>> +
>> +static struct i2c_driver simple_mfd_i2c_driver = {
>> +	.probe_new = simple_mfd_i2c_probe,
>> +	.driver = {
>> +		.name = "simple-mfd-i2c",
>> +		.of_match_table = simple_mfd_i2c_of_match,
>> +	},
>> +};
>> +builtin_i2c_driver(simple_mfd_i2c_driver);

-- 
-michael
