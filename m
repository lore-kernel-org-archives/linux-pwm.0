From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 05/13] irqchip: add sl28cpld interrupt controller
 support
Date: Wed, 08 Jul 2020 10:37:39 +0100
Message-ID: <30c8a3b40003f8805ba8ebacd328583c@kernel.org>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-6-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200706175353.16404-6-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Mark Brown <broonie@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On 2020-07-06 18:53, Michael Walle wrote:
> Add support for the interrupt controller inside the sl28 CPLD 
> management
> controller.
> 
> The interrupt controller can handle at most 8 interrupts and is really
> simplistic and consists only of an interrupt mask and an interrupt
> pending register.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:
>  - update copyright year
>  - don't use "int irq" instead of "unsigne int irq", because
>    platform_get_irq() might return a negative error code. Found by 
> "kernel
>    test robot <lkp@intel.com>
>  - remove comma in terminator line of the compatible strings list,
>    suggested by Andy
>  - use newer devm_regmap_add_irq_chip_fwnode()
>  - don't use KBUID_MODNAME, suggested by Andy
>  - remove the platform device table
> 
> Changes since v3:
>  - see cover letter
> 
>  drivers/irqchip/Kconfig        |  8 +++
>  drivers/irqchip/Makefile       |  1 +
>  drivers/irqchip/irq-sl28cpld.c | 96 ++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/irqchip/irq-sl28cpld.c

Acked-by: Marc Zyngier <maz@kernel.org>

Given the dependency on the MFD patches, I assume this will
be routed to that subsystem. Please let me know if you want
it to be handled differently.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
