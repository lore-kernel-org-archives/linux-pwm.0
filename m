From: Shobhit Kumar <kumar@shobhit.info>
Subject: Re: [Intel-gfx] [PATCH 6/8] drivers/pwm: Add Crystalcove (CRC) PWM driver
Date: Thu, 18 Jun 2015 23:24:35 +0530
Message-ID: <CAAbrOmc-71MO2N9sezbOONPAf8_XSCOtHBSGD9AS9hOk0vsE=A@mail.gmail.com>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
	<1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
	<1430428322.2187.24.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430428322.2187.24.camel@x220>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, May 1, 2015 at 2:42 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Wed, 2015-04-29 at 19:30 +0530, Shobhit Kumar wrote:
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>
>> +config PWM_CRC
>> +     bool "Intel Crystalcove (CRC) PWM support"
>> +     depends on X86 && INTEL_SOC_PMIC
>> +     help
>> +       Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
>> +       control.
>
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>
>> +obj-$(CONFIG_PWM_CRC)                += pwm-crc.o
>
> PWM_CRC is a bool symbol. So pwm-crc.o can never be part of a module.

I actually started this as a module but later decided to make it as
bool because INTEL_SOC_PMIC on which this depends is itself a bool as
well. Still it is good to keep the module based initialization.
Firstly because it causes no harm and even though some of the macros
are pre-processed out, gives info about the driver. Secondly there
were discussion on why INTEL_SOC_PMIC is bool (note this driver also
has module based initialization even when bool). I am guessing because
of some tricky module load order dependencies. If ever that becomes a
module, this can mostly be unchanged to be loaded as a module.

Regards
Shobhit

>
> (If I'm wrong, and that object file can actually be part of a module,
> you can stop reading here.)
>
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-crc.c
>
>> +#include <linux/module.h>
>
> Perhaps this include is not needed.
>
>> +static const struct pwm_ops crc_pwm_ops = {
>> +     .config = crc_pwm_config,
>> +     .enable = crc_pwm_enable,
>> +     .disable = crc_pwm_disable,
>> +     .owner = THIS_MODULE,
>
> For built-in only code THIS_MODULE is basically equivalent to NULL (see
> include/linux/export.h). So I guess this line can be dropped.
>
>> +};
>
>> +static struct platform_driver crystalcove_pwm_driver = {
>> +     .probe = crystalcove_pwm_probe,
>> +     .remove = crystalcove_pwm_remove,
>> +     .driver = {
>> +             .name = "crystal_cove_pwm",
>> +     },
>> +};
>> +
>> +module_platform_driver(crystalcove_pwm_driver);
>
> Speaking from memory: for built-in only code this is equivalent to
> calling
>     platform_driver_register(&crystalcove_pwm_driver);
>
> from a wrapper, and marking that wrapper with device_initcall().
>
>> +MODULE_AUTHOR("Shobhit Kumar <shobhit.kumar@intel.com>");
>> +MODULE_DESCRIPTION("Intel Crystal Cove PWM Driver");
>> +MODULE_LICENSE("GPL v2");
>
> These macros will be effectively preprocessed away for built-in only
> code.
>
>
> Paul Bolle
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx
