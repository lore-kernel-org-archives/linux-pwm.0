From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 00/11] Add support for Kontron sl28cpld
Date: Fri, 5 Jun 2020 07:13:50 +0100
Message-ID: <20200605061350.GC3714@dell>
References: <20200604211039.12689-1-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200604211039.12689-1-michael@walle.cc>
Sender: linux-hwmon-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, 04 Jun 2020, Michael Walle wrote:

> The Kontron sl28cpld is a board management chip providing gpio, pwm, fan
> monitoring and an interrupt controller. For now this controller is used on
> the Kontron SMARC-sAL28 board. But because of its flexible nature, it
> might also be used on other boards in the future. The individual blocks
> (like gpio, pwm, etc) are kept intentionally small. The MFD core driver
> then instantiates different (or multiple of the same) blocks. It also
> provides the register layout so it might be updated in the future without a
> device tree change; and support other boards with a different layout or
> functionalities.
> 
> See also [1] for more information.
> 
> This is my first take of a MFD driver. I don't know whether the subsystem
> maintainers should only be CCed on the patches which affect the subsystem
> or on all patches for this series. I've chosen the latter so you can get a
> more complete picture.

You chose wisely. :)

> [1] https://lore.kernel.org/linux-devicetree/0e3e8204ab992d75aa07fc36af7e4ab2@walle.cc/
> 
> Changes since v3:
>  - use of_platform_populate() to populate internal devices using the
>    internal register offsets as unit-addresses
>  - because we don't use mfd_cells anymore, we cannot use IORESOURCE_REG,
>    but instead parse the reg property in each individual driver
>  - dropped the following patches because they were already merged:
>      gpiolib: Introduce gpiochip_irqchip_add_domain()
>      gpio: add a reusable generic gpio_chip using regmap
>  - dropped the following patches because they are no longer needed:
>      include/linux/ioport.h: add helper to define REG resource constructs
>      mfd: mfd-core: Don't overwrite the dma_mask of the child device
>      mfd: mfd-core: match device tree node against reg property
>  - rephrase commit messages, as suggested by Thomas Gleixner

It's great to have this changelog overview.

However it's equally, if not arguably more important to have a more
fine grained changelog in each of the patches, usually placed between
the '---' and the diff stat.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
