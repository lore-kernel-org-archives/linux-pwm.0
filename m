From: Shobhit Kumar <shobhit.kumar@linux.intel.com>
Subject: Re: [PATCH 5/8] drivers/mfd: ADD PWM lookup table for CRC PMIC based
 PWM
Date: Tue, 05 May 2015 15:18:26 +0530
Message-ID: <554891EA.7050906@linux.intel.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com> <1430316005-16480-6-git-send-email-shobhit.kumar@intel.com> <20150429142451.GS9169@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150429142451.GS9169@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Shobhit Kumar <shobhit.kumar@intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pwm@vger.kernel.org

On 04/29/2015 07:54 PM, Lee Jones wrote:
> On Wed, 29 Apr 2015, Shobhit Kumar wrote:
> 
>> On some BYT PLatform the PWM is controlled using CRC PMIC. Add a lookup
>> entry for the same to be used by the consumer (Intel GFX)
>>
>> v2: Remove the lookup table on driver unload (Thierry)
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
>> ---
>>  drivers/mfd/intel_soc_pmic_core.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
> 
> How do you expect this set to be managed?

There are some dependencies on the look up table remove functionality in
earlier patches, so I think 3/8 can go in only after 1/8. Similarly 5/8
can go only after 2/8. Rest all can be independent.	

Regards
Shobhit

> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
>> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
>> index f3d918e..a00ddd9 100644
>> --- a/drivers/mfd/intel_soc_pmic_core.c
>> +++ b/drivers/mfd/intel_soc_pmic_core.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/regmap.h>
>>  #include <linux/mfd/intel_soc_pmic.h>
>>  #include <linux/gpio/machine.h>
>> +#include <linux/pwm.h>
>>  #include "intel_soc_pmic_core.h"
>>  
>>  /* Lookup table for the Panel Enable/Disable line as GPIO signals */
>> @@ -37,6 +38,11 @@ static struct gpiod_lookup_table panel_gpio_table = {
>>  	},
>>  };
>>  
>> +/* PWM consumed by the Intel GFX */
>> +static struct pwm_lookup crc_pwm_lookup[] = {
>> +	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_backlight", 0, PWM_POLARITY_NORMAL),
>> +};
>> +
>>  static int intel_soc_pmic_find_gpio_irq(struct device *dev)
>>  {
>>  	struct gpio_desc *desc;
>> @@ -99,6 +105,9 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
>>  	/* Add lookup table binding for Panel Control to the GPIO Chip */
>>  	gpiod_add_lookup_table(&panel_gpio_table);
>>  
>> +	/* Add lookup table for crc-pwm */
>> +	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
>> +
>>  	ret = mfd_add_devices(dev, -1, config->cell_dev,
>>  			      config->n_cell_devs, NULL, 0,
>>  			      regmap_irq_get_domain(pmic->irq_chip_data));
>> @@ -121,6 +130,9 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
>>  	/* Remove lookup table for Panel Control from the GPIO Chip */
>>  	gpiod_remove_lookup_table(&panel_gpio_table);
>>  
>> +	/* remove crc-pwm lookup table */
>> +	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
>> +
>>  	mfd_remove_devices(&i2c->dev);
>>  
>>  	return 0;
> 
