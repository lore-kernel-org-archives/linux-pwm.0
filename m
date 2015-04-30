From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 6/8] drivers/pwm: Add Crystalcove (CRC) PWM driver
Date: Thu, 30 Apr 2015 23:12:02 +0200
Message-ID: <1430428322.2187.24.camel@x220>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
	 <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lb2-smtp-cloud2.xs4all.net ([194.109.24.25]:35653 "EHLO
	lb2-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbbD3VMK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Apr 2015 17:12:10 -0400
In-Reply-To: <1430316005-16480-7-git-send-email-shobhit.kumar@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Lee Jones <lee.jones@linaro.org>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>

On Wed, 2015-04-29 at 19:30 +0530, Shobhit Kumar wrote:
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
 
> +config PWM_CRC
> +	bool "Intel Crystalcove (CRC) PWM support"
> +	depends on X86 && INTEL_SOC_PMIC
> +	help
> +	  Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
> +	  control.

> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile

> +obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o

PWM_CRC is a bool symbol. So pwm-crc.o can never be part of a module.

(If I'm wrong, and that object file can actually be part of a module,
you can stop reading here.)

> --- /dev/null
> +++ b/drivers/pwm/pwm-crc.c

> +#include <linux/module.h>

Perhaps this include is not needed.

> +static const struct pwm_ops crc_pwm_ops = {
> +	.config = crc_pwm_config,
> +	.enable = crc_pwm_enable,
> +	.disable = crc_pwm_disable,
> +	.owner = THIS_MODULE,

For built-in only code THIS_MODULE is basically equivalent to NULL (see
include/linux/export.h). So I guess this line can be dropped.

> +};

> +static struct platform_driver crystalcove_pwm_driver = {
> +	.probe = crystalcove_pwm_probe,
> +	.remove = crystalcove_pwm_remove,
> +	.driver = {
> +		.name = "crystal_cove_pwm",
> +	},
> +};
> +
> +module_platform_driver(crystalcove_pwm_driver);

Speaking from memory: for built-in only code this is equivalent to
calling 
    platform_driver_register(&crystalcove_pwm_driver);

from a wrapper, and marking that wrapper with device_initcall().

> +MODULE_AUTHOR("Shobhit Kumar <shobhit.kumar@intel.com>");
> +MODULE_DESCRIPTION("Intel Crystal Cove PWM Driver");
> +MODULE_LICENSE("GPL v2");

These macros will be effectively preprocessed away for built-in only
code.


Paul Bolle
