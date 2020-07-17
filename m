From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 02/13] mfd: add simple regmap based I2C driver
Date: Fri, 17 Jul 2020 10:06:56 +0100
Message-ID: <20200717090656.GF3165313@dell>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-3-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJHA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 05:07:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE434C08C5C0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 02:07:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so13890887wmi.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 02:07:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200706175353.16404-3-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>

On Mon, 06 Jul 2020, Michael Walle wrote:

> There are I2C devices which contain several different functions but
> doesn't require any special access functions. For these kind of drivers
> an I2C regmap should be enough.
> 
> Create an I2C driver which creates an I2C regmap and enumerates its
> children. If a device wants to use this as its MFD core driver, it has
> to add an individual compatible string. It may provide its own regmap
> configuration.
> 
> Subdevices can use dev_get_regmap() on the parent to get their regmap
> instance.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:
>  - new patch. Lee, please bear with me. I didn't want to delay the
>    new version (where a lot of remarks on the other patches were
>    addressed) even more, just because we haven't figured out how
>    to deal with the MFD part. So for now, I've included this one.
> 
>  drivers/mfd/Kconfig          |  9 +++++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/simple-mfd-i2c.c | 50 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df0837ab41..f1536a710aca 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called si476x-core.
>  
> +config MFD_SIMPLE_MFD_I2C
> +	tristate "Simple regmap based I2C devices"

Doesn't look like tristate to me.

Haven't you made this builtin only?

> +	depends on I2C
> +	select MFD_CORE

Why?

> +	select REGMAP_I2C
> +	help
> +	  This is a consolidated driver for all MFD devices which are
> +	  basically just a regmap bus driver.

Please expand on this.  I think it deserves greater explanation.

>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
>  	depends on HAS_DMA

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
