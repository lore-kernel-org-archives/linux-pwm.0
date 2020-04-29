From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
Date: Thu, 30 Apr 2020 00:18:48 +0200
Message-ID: <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200423174543.17161-4-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Lee,

Am 2020-04-23 19:45, schrieb Michael Walle:
> There might be multiple children with the device tree compatible, for
> example if a MFD has multiple instances of the same function. In this
> case only the first is matched and the other children get a wrong
> of_node reference.
> Add a new option to match also against the unit address of the child
> node. Additonally, a new helper OF_MFD_CELL_REG is added.


Do you think this is feasible? I guess this is the biggest uncertainty
for me at the moment in this patch series.

-michael

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
>  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
>  2 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index e735565969b3..4ecb376338f7 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, 
> int id,
>  	struct device_node *np = NULL;
>  	int ret = -ENOMEM;
>  	int platform_id;
> +	u32 of_reg;
>  	int r;
> 
>  	if (id == PLATFORM_DEVID_AUTO)
> @@ -151,16 +152,26 @@ static int mfd_add_device(struct device *parent, 
> int id,
> 
>  	if (parent->of_node && cell->of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
> -			if (of_device_is_compatible(np, cell->of_compatible)) {
> -				if (!of_device_is_available(np)) {
> -					/* Ignore disabled devices error free */
> -					ret = 0;
> -					goto fail_alias;
> -				}
> -				pdev->dev.of_node = np;
> -				pdev->dev.fwnode = &np->fwnode;
> -				break;
> +			if (!of_device_is_compatible(np, cell->of_compatible))
> +				continue;
> +
> +			/* also match the unit address if set */
> +			if (cell->of_reg & MFD_OF_REG_VALID) {
> +				if (of_property_read_u32(np, "reg", &of_reg))
> +					continue;
> +				if ((cell->of_reg & MFD_OF_REG_MASK) != of_reg)
> +					continue;
>  			}
> +
> +			if (!of_device_is_available(np)) {
> +				/* Ignore disabled devices error free */
> +				ret = 0;
> +				goto fail_alias;
> +			}
> +
> +			pdev->dev.of_node = np;
> +			pdev->dev.fwnode = &np->fwnode;
> +			break;
>  		}
>  	}
> 
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index d01d1299e49d..c2c0ad6b14f3 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -13,8 +13,11 @@
>  #include <linux/platform_device.h>
> 
>  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
> +#define MFD_OF_REG_VALID	BIT(31)
> +#define MFD_OF_REG_MASK		GENMASK(30, 0)
> 
> -#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, 
> _match)\
> +#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +		     _of_reg, _match)					\
>  	{								\
>  		.name = (_name),					\
>  		.resources = (_res),					\
> @@ -22,24 +25,32 @@
>  		.platform_data = (_pdata),				\
>  		.pdata_size = (_pdsize),				\
>  		.of_compatible = (_compat),				\
> +		.of_reg = (_of_reg),					\
>  		.acpi_match = (_match),					\
>  		.id = (_id),						\
>  	}
> 
> +#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +			_of_reg)					\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +		     ((_of_reg) | MFD_OF_REG_VALID), NULL)		\
> +
>  #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> +		     0, NULL)						\
> 
>  #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0,	\
> +		     _match)						\
> 
>  #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, NULL) \
> 
>  #define MFD_CELL_RES(_name, _res)					\
> -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
> +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, NULL)		\
> 
>  #define MFD_CELL_NAME(_name)						\
> -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
> +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, NULL)		\
> 
>  struct irq_domain;
>  struct property_entry;
> @@ -78,6 +89,9 @@ struct mfd_cell {
>  	 */
>  	const char		*of_compatible;
> 
> +	/* matching the reg property if set */
> +	unsigned int		of_reg;
> +
>  	/* Matches ACPI */
>  	const struct mfd_cell_acpi_match	*acpi_match;
