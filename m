From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH v5 02/13] mfd: add simple regmap based I2C driver
Date: Mon, 20 Jul 2020 00:31:29 +0200
Message-ID: <52d85ea1ddc488762df547168e2001e9@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-3-michael@walle.cc> <20200717090656.GF3165313@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200717090656.GF3165313@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg
List-Id: linux-pwm@vger.kernel.org

Am 2020-07-17 11:06, schrieb Lee Jones:
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
>> Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
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
> 
> Doesn't look like tristate to me.
> 
> Haven't you made this builtin only?

Mh yeah, I forgot to change it to module in the driver. I don't
know whats better though, have it tristate or just offer a boolean
option because it should be small anyway. What do you think?
My interrupt driver will force it to boolean anyway.

> 
>> +	depends on I2C
>> +	select MFD_CORE
> 
> Why?

leftover :( I'll remove it.


>> +	select REGMAP_I2C
>> +	help
>> +	  This is a consolidated driver for all MFD devices which are
>> +	  basically just a regmap bus driver.
> 
> Please expand on this.  I think it deserves greater explanation.

ok.

> 
>>  config MFD_SM501
>>  	tristate "Silicon Motion SM501"
>>  	depends on HAS_DMA

-- 
-michael
