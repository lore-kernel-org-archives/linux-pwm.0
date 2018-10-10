From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
Date: Wed, 10 Oct 2018 14:35:19 +0200
Message-ID: <CACRpkdaoBwqQ4V5Hm9f_G5_jrdkvjT5anhBK1_HoFTj6=cba-Q@mail.gmail.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com> <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: atish.patra@wdc.com, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi Atish,

thanks for your patch!

On Tue, Oct 9, 2018 at 8:51 PM Atish Patra <atish.patra@wdc.com> wrote:

> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> Adds the GPIO driver for SiFive RISC-V SoCs.
>
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Various fixes and code cleanup]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

(...)

> +config GPIO_SIFIVE
> +       bool "SiFive GPIO support"
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP

I suggest to add
select GPIO_GENERIC as per below.

Maybe select REGMAP_MMIO as well.

> +       help
> +         Say yes here to support the GPIO device on SiFive SoCs.
> +

> +#include <linux/of_irq.h>
> +#include <linux/irqchip/chained_irq.h>

Do you need these two? I think <linux/gpio/driver.h>
will bring them in for you.

> +#include <linux/pinctrl/consumer.h>

Are you using this?

> +struct sifive_gpio {
> +       raw_spinlock_t          lock;
> +       void __iomem            *base;
> +       struct gpio_chip        gc;
> +       unsigned long           enabled;

Since max GPIO is 32 why not use an u32 for this?

> +       unsigned int            trigger[MAX_GPIO];
> +       unsigned int            irq_parent[MAX_GPIO];
> +       struct sifive_gpio      *self_ptr[MAX_GPIO];
> +};
> +
> +static void sifive_assign_bit(void __iomem *ptr, unsigned int offset, int value)
> +{
> +       /*
> +        * It's frustrating that we are not allowed to use the device atomics
> +        * which are GUARANTEED to be supported by this device on RISC-V
> +        */
> +       u32 bit = BIT(offset), old = ioread32(ptr);
> +
> +       if (value)
> +               iowrite32(old | bit, ptr);
> +       else
> +               iowrite32(old & ~bit, ptr);
> +}

This looks like a mask and set implementation, you are
essentially reinventing regmap MMIO and the
regmap_update_bits() call. Could you look into
just using regmap MMIO in that case?

If you need examples, look at gpio-mvebu.c that calls
devm_regmap_init_mmio() for example.

> +static int sifive_direction_input(struct gpio_chip *gc, unsigned int offset)
> +static int sifive_direction_output(struct gpio_chip *gc, unsigned int offset,
> +static int sifive_get_direction(struct gpio_chip *gc, unsigned int offset)
> +static int sifive_get_value(struct gpio_chip *gc, unsigned int offset)
> +static void sifive_set_value(struct gpio_chip *gc, unsigned int offset,

These functions look like a typical hardware that can use

GPIOLIB_GENERIC and bgpio_init() to set up the accessors.

See gpio-ftgpio010.c for an example.

As a bonus you will get .get/.set_multiple implemented by
the generic GPIO.

> +static void sifive_irq_enable(struct irq_data *d)
> +static void sifive_irq_disable(struct irq_data *d)
(...)
> +static struct irq_chip sifive_irqchip = {
> +       .name           = "sifive-gpio",
> +       .irq_set_type   = sifive_irq_set_type,
> +       .irq_mask       = sifive_irq_mask,
> +       .irq_unmask     = sifive_irq_unmask,
> +       .irq_enable     = sifive_irq_enable,
> +       .irq_disable    = sifive_irq_disable,

The handling of .irq_enable and .irq_disable has
changed upstream. Please align with the new codebase
as changed by Hans Verkuil:

commit 461c1a7d4733d1dfd5c47b040cf32a5e7eefbc6c
"gpiolib: override irq_enable/disable"
commit 4e9439ddacea06f35acce4d374bf6bd0acf99bc8
"gpiolib: add flag to indicate if the irq is disabled"

You will need to rebase your work on the v4.20-rc1 once it is
out. Right now the changes are on linux-next or my devel
branch.

> +       ngpio = of_irq_count(node);
> +       if (ngpio >= MAX_GPIO) {
> +               dev_err(dev, "Too many GPIO interrupts (max=%d)\n", MAX_GPIO);
> +               return -ENXIO;
> +       }
(...)
> +       for (gpio = 0; gpio < ngpio; ++gpio) {
> +               irq = platform_get_irq(pdev, gpio);
> +               if (irq < 0) {
> +                       dev_err(dev, "invalid IRQ\n");
> +                       gpiochip_remove(&chip->gc);
> +                       return -ENODEV;
> +               }

This is an hierarchical IRQ so it should use an hierarchical
irqdomain.

I am discussing with Thierry to make more generic irq domains
for hierarchical IRQ GPIOs, until then you have to look at
gpio-thunderx.c, gpio-uniphier.c or gpio-xgene-sb.c that all
use hierarchical IRQs.

Yours,
Linus Walleij
