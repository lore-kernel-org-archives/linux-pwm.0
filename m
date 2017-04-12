From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Wed, 12 Apr 2017 19:11:21 +0200
Message-ID: <20170412171121.GB11964@ulmo.ba.sec>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2017 at 08:09:27PM +0200, Ralph Sennhauser wrote:
> From: Andrew Lunn <andrew@lunn.ch>
>=20
> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
> and off period. This can be modelled as a PWM.
>=20
> However, there are only two sets of PWM configuration registers for
> all the GPIO lines. This driver simply allows a single GPIO line per
> GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>=20
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the GPIO driver. Thus the GPIO driver has been
> extended with a PWM driver.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * Port forward
>   * Merge PWM portion into gpio-mvebu.c
>   * Switch to atomic PWM API
>   * Add new compatible string marvell,armada-370-xp-gpio
>   * Update and merge documentation patch
>   * Update MAINTAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
>  MAINTAINERS                                        |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 324 +++++++++++++++=
+++++-
>  3 files changed, 346 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docu=
mentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index a6f3bec..fe49e9d 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -38,6 +38,24 @@ Required properties:
>  - #gpio-cells: Should be two. The first cell is the pin number. The
>    second cell is reserved for flags, unused at the moment.
> =20
> +Optional properties:
> +
> +In order to use the gpio lines in PWM mode, some additional optional
> +properties are required. Only Armada 370 and XP support these properties.
> +
> +- compatible: Must contain "marvell,armada-370-xp-gpio"
> +
> +- reg: an additional register set is needed, for the GPIO Blink
> +  Counter on/off registers.
> +
> +- reg-names: Must contain an entry "pwm" corresponding to the
> +  additional register range needed for pwm operation.
> +
> +- #pwm-cells: Should be two. The first cell is the GPIO line number. The
> +  second cell is the period in nanoseconds.
> +
> +- clocks: Must be a phandle to the clock for the gpio controller.
> +
>  Example:
> =20
>  		gpio0: gpio@d0018100 {
> @@ -51,3 +69,17 @@ Example:
>  			#interrupt-cells =3D <2>;
>  			interrupts =3D <16>, <17>, <18>, <19>;
>  		};
> +
> +		gpio1: gpio@18140 {
> +			compatible =3D "marvell,armada-370-xp-gpio";
> +			reg =3D <0x18140 0x40>, <0x181c8 0x08>;
> +			reg-names =3D "gpio", "pwm";
> +			ngpios =3D <17>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			#pwm-cells =3D <2>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			interrupts =3D <87>, <88>, <89>;
> +			clocks =3D <&coreclk 0>;
> +		};

This is going to need an Acked-by from one of the device tree
maintainers. Rob and devicetree@vger.kernel.org are on Cc, but I suspect
nobody might look for the binding change "hidden" in this patch.

Maybe best to split this off into a separate patch, or explicitly ping
Rob to look at this patch.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58b3a22..19382f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10295,6 +10295,8 @@ F:	include/linux/pwm.h
>  F:	drivers/pwm/
>  F:	drivers/video/backlight/pwm_bl.c
>  F:	include/linux/pwm_backlight.h
> +F:	drivers/gpio/gpio-mvebu.c
> +F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> =20
>  PXA2xx/PXA3xx SUPPORT
>  M:	Daniel Mack <daniel@zonque.org>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index fae4db6..e310951 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -42,22 +42,34 @@
>  #include <linux/io.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_device.h>
> +#include <linux/pwm.h>
>  #include <linux/clk.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/irqchip/chained_irq.h>
> +#include <linux/platform_device.h>
>  #include <linux/bitops.h>
> =20
> +#include "gpiolib.h"
> +
>  /*
>   * GPIO unit register offsets.
>   */
> -#define GPIO_OUT_OFF		0x0000
> -#define GPIO_IO_CONF_OFF	0x0004
> -#define GPIO_BLINK_EN_OFF	0x0008
> -#define GPIO_IN_POL_OFF		0x000c
> -#define GPIO_DATA_IN_OFF	0x0010
> -#define GPIO_EDGE_CAUSE_OFF	0x0014
> -#define GPIO_EDGE_MASK_OFF	0x0018
> -#define GPIO_LEVEL_MASK_OFF	0x001c
> +#define GPIO_OUT_OFF			0x0000
> +#define GPIO_IO_CONF_OFF		0x0004
> +#define GPIO_BLINK_EN_OFF		0x0008
> +#define GPIO_IN_POL_OFF			0x000c
> +#define GPIO_DATA_IN_OFF		0x0010
> +#define GPIO_EDGE_CAUSE_OFF		0x0014
> +#define GPIO_EDGE_MASK_OFF		0x0018
> +#define GPIO_LEVEL_MASK_OFF		0x001c
> +#define GPIO_BLINK_CNT_SELECT_OFF	0x0020
> +
> +/*
> + * PWM register offsets.
> + */
> +#define PWM_BLINK_ON_DURATION_OFF	0x0
> +#define PWM_BLINK_OFF_DURATION_OFF	0x4
> +
> =20
>  /* The MV78200 has per-CPU registers for edge mask and level mask */
>  #define GPIO_EDGE_MASK_MV78200_OFF(cpu)	  ((cpu) ? 0x30 : 0x18)
> @@ -78,6 +90,20 @@
> =20
>  #define MVEBU_MAX_GPIO_PER_BANK		32
> =20
> +struct mvebu_pwm {
> +	void __iomem		*membase;
> +	unsigned long		 clk_rate;
> +	bool			 used;

I think you could've probably made this a little simpler by making bool
used into struct gpio_desc *gpio; and reference that rather than having
to convert with gpio_to_desc(). More on why I think that's important
below.

> +	struct pwm_chip		 chip;
> +	spinlock_t		 lock;
> +	struct mvebu_gpio_chip	*mvchip;
> +
> +	/* Used to preserve GPIO/PWM registers across suspend/resume */
> +	u32			 blink_select;
> +	u32			 blink_on_duration;
> +	u32			 blink_off_duration;
> +};
> +
>  struct mvebu_gpio_chip {
>  	struct gpio_chip   chip;
>  	spinlock_t	   lock;
> @@ -87,6 +113,10 @@ struct mvebu_gpio_chip {
>  	struct irq_domain *domain;
>  	int		   soc_variant;
> =20
> +	/* Used for PWM support */
> +	struct clk	  *clk;
> +	struct mvebu_pwm  *mvpwm;
> +
>  	/* Used to preserve GPIO registers across suspend/resume */
>  	u32		   out_reg;
>  	u32		   io_conf_reg;
> @@ -110,6 +140,12 @@ static void __iomem *mvebu_gpioreg_blink(struct mveb=
u_gpio_chip *mvchip)
>  	return mvchip->membase + GPIO_BLINK_EN_OFF;
>  }
> =20
> +static void __iomem *mvebu_gpioreg_blink_counter_select(struct mvebu_gpi=
o_chip
> +							*mvchip)
> +{
> +	return mvchip->membase + GPIO_BLINK_CNT_SELECT_OFF;
> +}
> +
>  static void __iomem *mvebu_gpioreg_io_conf(struct mvebu_gpio_chip *mvchi=
p)
>  {
>  	return mvchip->membase + GPIO_IO_CONF_OFF;
> @@ -181,6 +217,20 @@ static void __iomem *mvebu_gpioreg_level_mask(struct=
 mvebu_gpio_chip *mvchip)
>  }
> =20
>  /*
> + * Functions returning addresses of individual registers for a given
> + * PWM controller.
> + */
> +static void __iomem *mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mv=
pwm)
> +{
> +	return mvpwm->membase + PWM_BLINK_ON_DURATION_OFF;
> +}
> +
> +static void __iomem *mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *m=
vpwm)
> +{
> +	return mvpwm->membase + PWM_BLINK_OFF_DURATION_OFF;
> +}
> +
> +/*
>   * Functions implementing the gpio_chip methods
>   */
>  static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int=
 value)
> @@ -484,6 +534,243 @@ static void mvebu_gpio_irq_handler(struct irq_desc =
*desc)
>  	chained_irq_exit(chip, desc);
>  }
> =20
> +/*
> + * Functions implementing the pwm_chip methods
> + */
> +static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct mvebu_pwm, chip);
> +}
> +
> +static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct mvebu_pwm *mvpwm =3D to_mvebu_pwm(chip);
> +	struct gpio_desc *desc =3D gpio_to_desc(pwm->pwm);

This assumes that the GPIO chip base and the PWM chip base are the same.
You make sure of that by setting the PWM chip base to be the same as the
GPIO chip base, which is the easy way out. It's also somewhat brittle
because some other PWM chip may have occupied the region that you want
to use. It's fairly unlikely, but I think you can very easily side-step
any issues by simply doing:

	struct mvebu_gpio_chip *mvchip =3D mvpwm->mvchip;

	desc =3D gpio_to_desc(mvchip->chip.base + pwm->hwpwm);

Now that's somewhat complicated, but you only have to do it once if you
store the desc in mvpwm->gpio as pointed out above.

> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&mvpwm->lock, flags);
> +	if (mvpwm->used) {
> +		ret =3D -EBUSY;

Then you can also easily use mvpwm->gpio to check for -EBUSY here.

> +	} else {
> +		if (!desc) {
> +			ret =3D -ENODEV;
> +			goto out;
> +		}
> +		ret =3D gpiod_request(desc, "mvebu-pwm");
> +		if (ret)
> +			goto out;
> +
> +		ret =3D gpiod_direction_output(desc, 0);
> +		if (ret) {
> +			gpiod_free(desc);
> +			goto out;
> +		}
> +
> +		mvpwm->used =3D true;
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +	return ret;
> +}
> +
> +static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct mvebu_pwm *mvpwm =3D to_mvebu_pwm(chip);
> +	struct gpio_desc *desc =3D gpio_to_desc(pwm->pwm);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mvpwm->lock, flags);
> +	gpiod_free(desc);
> +	mvpwm->used =3D false;
> +	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +}
> +
> +static void mvebu_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state) {
> +
> +	struct mvebu_pwm *mvpwm =3D to_mvebu_pwm(chip);
> +	struct mvebu_gpio_chip *mvchip =3D mvpwm->mvchip;
> +	unsigned long long val;
> +	unsigned long flags;
> +	u32 u;
> +
> +	spin_lock_irqsave(&mvpwm->lock, flags);
> +
> +	val =3D (unsigned long long)
> +		readl_relaxed(mvebu_pwmreg_blink_on_duration);
> +	val *=3D NSEC_PER_SEC;
> +	do_div(val, mvpwm->clk_rate);
> +	if (val > UINT_MAX)
> +		state->duty_cycle =3D UINT_MAX;
> +	else if (val)
> +		state->duty_cycle =3D val;
> +	else
> +		state->duty_cycle =3D 1;
> +
> +	val =3D (unsigned long long)
> +		readl_relaxed(mvebu_pwmreg_blink_off_duration);
> +	val *=3D NSEC_PER_SEC;
> +	do_div(val, mvpwm->clk_rate);
> +	if (val < state->duty_cycle) {
> +		state->period =3D 1;
> +	} else {
> +		val -=3D state->duty_cycle;
> +		if (val > UINT_MAX)
> +			state->period =3D UINT_MAX;
> +		else if (val)
> +			state->period =3D val;
> +		else
> +			state->period =3D 1;
> +	}
> +
> +	u =3D readl_relaxed(mvebu_gpioreg_blink(mvchip));
> +	if (u)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +}
> +
> +static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
> +{
> +	struct mvebu_pwm *mvpwm =3D to_mvebu_pwm(chip);
> +	struct mvebu_gpio_chip *mvchip =3D mvpwm->mvchip;
> +	unsigned long long val;
> +	unsigned long flags;
> +	unsigned int on, off;
> +
> +	val =3D (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
> +	do_div(val, NSEC_PER_SEC);
> +	if (val > UINT_MAX)
> +		return -EINVAL;
> +	if (val)
> +		on =3D val;
> +	else
> +		on =3D 1;
> +
> +	val =3D (unsigned long long) mvpwm->clk_rate *
> +		(state->period - state->duty_cycle);
> +	do_div(val, NSEC_PER_SEC);
> +	if (val > UINT_MAX)
> +		return -EINVAL;
> +	if (val)
> +		off =3D val;
> +	else
> +		off =3D 1;
> +
> +	spin_lock_irqsave(&mvpwm->lock, flags);
> +
> +	writel_relaxed(on, mvebu_pwmreg_blink_on_duration(mvpwm));
> +	writel_relaxed(off, mvebu_pwmreg_blink_off_duration(mvpwm));
> +	if (state->enabled)
> +		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 1);
> +	else
> +		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 0);
> +
> +	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops mvebu_pwm_ops =3D {
> +	.request =3D mvebu_pwm_request,
> +	.free =3D mvebu_pwm_free,
> +	.get_state =3D mvebu_pwm_get_state,
> +	.apply =3D mvebu_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvc=
hip)
> +{
> +	struct mvebu_pwm *mvpwm =3D mvchip->mvpwm;
> +
> +	mvpwm->blink_select =3D
> +		readl_relaxed(mvebu_gpioreg_blink_counter_select(mvchip));
> +	mvpwm->blink_on_duration =3D
> +		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
> +	mvpwm->blink_off_duration =3D
> +		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
> +}
> +
> +static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvch=
ip)
> +{
> +	struct mvebu_pwm *mvpwm =3D mvchip->mvpwm;
> +
> +	writel_relaxed(mvpwm->blink_select,
> +		       mvebu_gpioreg_blink_counter_select(mvchip));
> +	writel_relaxed(mvpwm->blink_on_duration,
> +		       mvebu_pwmreg_blink_on_duration(mvpwm));
> +	writel_relaxed(mvpwm->blink_off_duration,
> +		       mvebu_pwmreg_blink_off_duration(mvpwm));
> +}
> +
> +static int mvebu_pwm_probe(struct platform_device *pdev,
> +			   struct mvebu_gpio_chip *mvchip,
> +			   int id)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct mvebu_pwm *mvpwm;
> +	struct resource *res;
> +
> +	if (!of_device_is_compatible(mvchip->chip.of_node,
> +				     "marvell,armada-370-xp-gpio"))
> +		return 0;
> +	/*
> +	 * There are only two sets of PWM configuration registers for
> +	 * all the GPIO lines on those SoCs which this driver reserves
> +	 * for the first two GPIO chips. So if the resource is missing
> +	 * we can't treat it as an error.
> +	 */
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
> +	if (!res)
> +		return 0;
> +
> +	/*
> +	 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
> +	 * with id 1. Don't allow further GPIO chips to be used for PWM.
> +	 */
> +	if (id =3D=3D 0)
> +		writel_relaxed(0, mvebu_gpioreg_blink_counter_select(mvchip));
> +	else if (id =3D=3D 1)
> +		writel_relaxed(U32_MAX,
> +			       mvebu_gpioreg_blink_counter_select(mvchip));

You could've just set a variable and then call writel_relaxed() after
the return -EINVAL below.

> +	else
> +		return -EINVAL;
> +
> +	mvpwm =3D devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
> +	if (!mvpwm)
> +		return -ENOMEM;
> +	mvchip->mvpwm =3D mvpwm;
> +	mvpwm->mvchip =3D mvchip;
> +
> +	mvpwm->membase =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(mvpwm->membase))
> +		return PTR_ERR(mvpwm->membase);
> +
> +	if (IS_ERR(mvchip->clk))
> +		return PTR_ERR(mvchip->clk);

Maybe do this much earlier to avoid all the unnecessary register
accesses, allocations and mappings?

> +
> +	mvpwm->clk_rate =3D clk_get_rate(mvchip->clk);
> +	if (!mvpwm->clk_rate) {
> +		dev_err(dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	mvpwm->chip.dev =3D dev;
> +	mvpwm->chip.ops =3D &mvebu_pwm_ops;
> +	mvpwm->chip.base =3D mvchip->chip.base;
> +	mvpwm->chip.npwm =3D mvchip->chip.ngpio;

I still would've done this differently. If you use this with a PWM user
you have to hook it up via DT anyway, so it doesn't matter whether you
specify the PWM index or the GPIO via some other property. The _only_
use-case where this might actually be an advantage is if you request a
PWM via the sysfs interface.

> +	spin_lock_init(&mvpwm->lock);
> +
> +	return pwmchip_add(&mvpwm->chip);
> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  #include <linux/seq_file.h>
> =20
> @@ -555,6 +842,10 @@ static const struct of_device_id mvebu_gpio_of_match=
[] =3D {
>  		.data	    =3D (void *) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
>  	},
>  	{
> +		.compatible =3D "marvell,armada-370-xp-gpio",
> +		.data	    =3D (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
> +	},
> +	{
>  		/* sentinel */
>  	},
>  };
> @@ -600,6 +891,9 @@ static int mvebu_gpio_suspend(struct platform_device =
*pdev, pm_message_t state)
>  		BUG();
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_PWM))
> +		mvebu_pwm_suspend(mvchip);
> +
>  	return 0;
>  }
> =20
> @@ -643,6 +937,9 @@ static int mvebu_gpio_resume(struct platform_device *=
pdev)
>  		BUG();
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_PWM))
> +		mvebu_pwm_resume(mvchip);
> +
>  	return 0;
>  }
> =20
> @@ -654,7 +951,6 @@ static int mvebu_gpio_probe(struct platform_device *p=
dev)
>  	struct resource *res;
>  	struct irq_chip_generic *gc;
>  	struct irq_chip_type *ct;
> -	struct clk *clk;
>  	unsigned int ngpios;
>  	bool have_irqs;
>  	int soc_variant;
> @@ -688,10 +984,10 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
>  		return id;
>  	}
> =20
> -	clk =3D devm_clk_get(&pdev->dev, NULL);
> +	mvchip->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	/* Not all SoCs require a clock.*/
> -	if (!IS_ERR(clk))
> -		clk_prepare_enable(clk);
> +	if (!IS_ERR(mvchip->clk))
> +		clk_prepare_enable(mvchip->clk);
> =20
>  	mvchip->soc_variant =3D soc_variant;
>  	mvchip->chip.label =3D dev_name(&pdev->dev);
> @@ -822,6 +1118,10 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
>  						 mvchip);
>  	}
> =20
> +	/* Armada 370/XP has simple PWM support for GPIO lines */
> +	if (IS_ENABLED(CONFIG_PWM))
> +		return mvebu_pwm_probe(pdev, mvchip, id);
> +
>  	return 0;
> =20
>  err_domain:
> --=20
> 2.10.2

All of my comments are effectively of a bikeshed nature, so from a PWM
perspective this is:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljuX7YACgkQ3SOs138+
s6En2w/9ElQ6kJhPYV/+8CDxDvGgmHA2ATgUx4RjzFRVGbPFh0MmV0aBo+YHiO65
T5+AHmrzcgg0VFcD8/4wSpvzynEpi2jWfaqGBtgSeRActMEZCSHE7GJ4XJ7uLSSc
ZfXnUoqt0nGqhXrzvqjkOztnZBKlbPySUvsucgGq0Esu2O5cQwDtxXFyyQjEatIA
MjXp+fpmwa7fCnjHA/2W7zTP6wO/s6CguKprErfzMH7LwYhTDn7Re6NrW9HGoWIN
cB8Y02km3uQfLJs7x5oN+9EepO74egeQuF+/vmL6xmRgE48UjXFIPVRDa4PE/cCT
u5P1O8I/Va/7vkeJdZ+plNLidUZq9+Qc5mT/b3H40tzi9rT2KeBoqvwzLfG495VQ
eoHNQh2Z4Nn0DuDmS+V4iBPR0cqfW52K/F19Re/8xSSEpuiR3KubyTU+13H82jKk
Vka7zk5txtr8lkuDUANWGppStr5ipz815FwMlbHiYWTP/YhlARr9LkRb8tKl3zxk
n7dQ9cPYjhbo/eEfjUvlfxbNomeWEA7ZkwGHfVJ2Kc447js2s4ouKFMNmDbBEV3y
nn6tAmWcDum+22/4oiSLna6eSnZ5+hzvK51dcUK7vSZNNrVrHn2na8+qUm2dw6pX
V428343R5BCqLww/7sLSYXQ/ymAo1P12Nps8UIkDjh6wU2gZdKU=
=VBaa
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
