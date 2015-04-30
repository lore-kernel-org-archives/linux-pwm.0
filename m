From: Shobhit Kumar <shobhit.kumar@linux.intel.com>
Subject: Re: [PATCH 3/8] drivers/mfd: Add lookup table for Panel Control as
 GPIO signal
Date: Thu, 30 Apr 2015 12:47:05 +0530
Message-ID: <5541D6F1.8090002@linux.intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com> <1430316005-16480-4-git-send-email-shobhit.kumar@intel.com> <20150429142743.GU9169@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52294 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbD3HRW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 30 Apr 2015 03:17:22 -0400
In-Reply-To: <20150429142743.GU9169@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Shobhit Kumar <shobhit.kumar@intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>

On 04/29/2015 07:57 PM, Lee Jones wrote:
> On Wed, 29 Apr 2015, Shobhit Kumar wrote:
> 
>> On some Intel SoC platforms, the panel enable/disable signals are
>> controlled by CRC PMIC. Add those control as a new GPIO in a lookup
>> table for gpio-crystalcove chip during CRC driver load
>>
>> v2: Make the lookup table static (Thierry)
>>     Remove the lookup table during driver remove (Thierry)
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
>> ---
>>  drivers/mfd/intel_soc_pmic_core.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
> 
> I have no idea what this stuff is, but it looks plausible.

The CRC PMIC controls the panel enable/disable signal using one of GPIO
like lines. It was agreed by Linus Walleij to go this way. The matching
crystalcove gpio changes are already merged in Linux next as -
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=e189ca56d91bbf1d3fe2f88ab6858bf919d42adf

This just adds a consumer lookup table for the gpio. Since we do not
have a DT or board files, and since this was part of CRC driver, just
added the lookup table during CRC driver load itself. Same is done for
PWM in a later patch.

Regards
Shobhit

> 
> For my own reference:
>   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
>> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
>> index 7b50b6b..f3d918e 100644
>> --- a/drivers/mfd/intel_soc_pmic_core.c
>> +++ b/drivers/mfd/intel_soc_pmic_core.c
>> @@ -24,8 +24,19 @@
>>  #include <linux/acpi.h>
>>  #include <linux/regmap.h>
>>  #include <linux/mfd/intel_soc_pmic.h>
>> +#include <linux/gpio/machine.h>
>>  #include "intel_soc_pmic_core.h"
>>  
>> +/* Lookup table for the Panel Enable/Disable line as GPIO signals */
>> +static struct gpiod_lookup_table panel_gpio_table = {
>> +	/* Intel GFX is consumer */
>> +	.dev_id = "0000:00:02.0",
>> +	.table = {
>> +		/* Panel EN/DISABLE */
>> +		GPIO_LOOKUP("gpio_crystalcove", 94, "panel", GPIO_ACTIVE_HIGH),
>> +	},
>> +};
>> +
>>  static int intel_soc_pmic_find_gpio_irq(struct device *dev)
>>  {
>>  	struct gpio_desc *desc;
>> @@ -85,6 +96,9 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
>>  	if (ret)
>>  		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
>>  
>> +	/* Add lookup table binding for Panel Control to the GPIO Chip */
>> +	gpiod_add_lookup_table(&panel_gpio_table);
>> +
>>  	ret = mfd_add_devices(dev, -1, config->cell_dev,
>>  			      config->n_cell_devs, NULL, 0,
>>  			      regmap_irq_get_domain(pmic->irq_chip_data));
>> @@ -104,6 +118,9 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
>>  
>>  	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
>>  
>> +	/* Remove lookup table for Panel Control from the GPIO Chip */
>> +	gpiod_remove_lookup_table(&panel_gpio_table);
>> +
>>  	mfd_remove_devices(&i2c->dev);
>>  
>>  	return 0;
> 
