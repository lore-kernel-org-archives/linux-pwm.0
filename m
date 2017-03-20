From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Mon, 20 Mar 2017 14:42:52 +0100
Message-ID: <20170320134252.GM22463@ulmo.ba.sec>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170316064218.9169-2-ralph.sennhauser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: linux-gpio@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 07:42:15AM +0100, Ralph Sennhauser wrote:
> From: Andrew Lunn <andrew@lunn.ch>
>=20
> Armada 370/XP devices can 'blink' gpio lines with a configurable on
> and off period. This can be modelled as a PWM.
>=20
> However, there are only two sets of PWM configuration registers for
> all the gpio lines. This driver simply allows a single gpio line per
> gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>=20
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the gpio driver. Thus the gpio driver has been
> extended with a PWM driver.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * port forward
>   * merge pwm portion into gpio-mvebu.c
>   * merge doc patch
>   * update MAINAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  31 +++
>  MAINTAINERS                                        |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 274 +++++++++++++++=
+++++-
>  3 files changed, 295 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docu=
mentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index a6f3bec..86932e3 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -38,6 +38,23 @@ Required properties:
>  - #gpio-cells: Should be two. The first cell is the pin number. The
>    second cell is reserved for flags, unused at the moment.
> =20
> +Optional properties:
> +
> +In order to use the gpio lines in PWM mode, some additional optional
> +properties are required. Only Armada 370 and XP support these properties.
> +
> +- reg: an additional register set is needed, for the GPIO Blink
> +  Counter on/off registers.
> +
> +- reg-names: Must contain an entry "pwm" corresponding to the
> +  additional register range needed for pwm operation.
> +
> +- #pwm-cells: Should be two. The first cell is the pin number. The
> +  second cell is reserved for flags and should be set to 0, so it has a
> +  known value. It then becomes possible to use it in the future.

That's usually not how we do this. Either your hardware can support the
flags (which at this point effectively means polarity) or it can't. Any
potential future feature can be enabled when it emerges. No need to
concern ourselves with something that doesn't exist yet.

> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 029f43c..ce08b73 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -42,21 +42,33 @@
>  #include <linux/io.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_device.h>
> +#include <linux/pwm.h>
>  #include <linux/clk.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/irqchip/chained_irq.h>
> +#include <linux/platform_device.h>
> +
> +#include "gpiolib.h"
> =20
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
> @@ -77,6 +89,22 @@
> =20
>  #define MVEBU_MAX_GPIO_PER_BANK		32
> =20
> +struct mvebu_pwm {
> +	void __iomem		*membase;
> +	unsigned long		 clk_rate;
> +	bool			 used;
> +	unsigned int		 pin;
> +	struct pwm_chip		 chip;
> +	int			 id;
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
> @@ -85,6 +113,8 @@ struct mvebu_gpio_chip {
>  	int		   irqbase;
>  	struct irq_domain *domain;
>  	int		   soc_variant;
> +	struct clk	  *clk;
> +	struct mvebu_pwm  *pwm;
> =20
>  	/* Used to preserve GPIO registers across suspend/resume */
>  	u32		   out_reg;
> @@ -109,6 +139,11 @@ static void __iomem *mvebu_gpioreg_blink(struct mveb=
u_gpio_chip *mvchip)
>  	return mvchip->membase + GPIO_BLINK_EN_OFF;
>  }
> =20
> +static void __iomem *mvebu_gpioreg_blink_select(struct mvebu_gpio_chip *=
mvchip)
> +{
> +	return mvchip->membase + GPIO_BLINK_CNT_SELECT_OFF;
> +}

That's a really weird thing to do. Why not just use this expression in
your calls to readl() and writel() directly? Seems a lot of additional
code for no gain.

> +
>  static void __iomem *mvebu_gpioreg_io_conf(struct mvebu_gpio_chip *mvchi=
p)
>  {
>  	return mvchip->membase + GPIO_IO_CONF_OFF;
> @@ -180,6 +215,20 @@ static void __iomem *mvebu_gpioreg_level_mask(struct=
 mvebu_gpio_chip *mvchip)
>  }
> =20
>  /*
> + * Functions returning addresses of individual registers for a given
> + * PWM controller.
> + */
> +static void __iomem *mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *pw=
m)
> +{
> +	return pwm->membase + PWM_BLINK_ON_DURATION_OFF;
> +}
> +
> +static void __iomem *mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *p=
wm)
> +{
> +	return pwm->membase + PWM_BLINK_OFF_DURATION_OFF;
> +}
> +
> +/*
>   * Functions implementing the gpio_chip methods
>   */
>  static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int=
 value)
> @@ -483,6 +532,198 @@ static void mvebu_gpio_irq_handler(struct irq_desc =
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
wmd)
> +{
> +	struct mvebu_pwm *pwm =3D to_mvebu_pwm(chip);
> +	struct mvebu_gpio_chip *mvchip =3D pwm->mvchip;
> +	struct gpio_desc *desc =3D gpio_to_desc(pwmd->pwm);
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&pwm->lock, flags);
> +	if (pwm->used) {
> +		ret =3D -EBUSY;
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
> +		pwm->pin =3D pwmd->pwm - mvchip->chip.base;

pwm->pin =3D pwmd->hwpwm? But then, why store something that you can
always access directly?

> +static int mvebu_pwm_config(struct pwm_chip *chip, struct pwm_device *pw=
md,
> +			    int duty_ns, int period_ns)
> +{
> +	struct mvebu_pwm *pwm =3D to_mvebu_pwm(chip);
> +	struct mvebu_gpio_chip *mvchip =3D pwm->mvchip;
> +	unsigned int on, off;
> +	unsigned long long val;
> +	u32 u;
> +
> +	val =3D (unsigned long long) pwm->clk_rate * duty_ns;
> +	do_div(val, NSEC_PER_SEC);
> +	if (val > UINT_MAX)
> +		return -EINVAL;
> +	if (val)
> +		on =3D val;
> +	else
> +		on =3D 1;
> +
> +	val =3D (unsigned long long) pwm->clk_rate * (period_ns - duty_ns);
> +	do_div(val, NSEC_PER_SEC);
> +	if (val > UINT_MAX)
> +		return -EINVAL;
> +	if (val)
> +		off =3D val;
> +	else
> +		off =3D 1;
> +
> +	u =3D readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
> +	u &=3D ~(1 << pwm->pin);
> +	u |=3D (pwm->id << pwm->pin);
> +	writel_relaxed(u, mvebu_gpioreg_blink_select(mvchip));
> +
> +	writel_relaxed(on, mvebu_pwmreg_blink_on_duration(pwm));
> +	writel_relaxed(off, mvebu_pwmreg_blink_off_duration(pwm));
> +
> +	return 0;
> +}
> +
> +static int mvebu_pwm_enable(struct pwm_chip *chip, struct pwm_device *pw=
md)
> +{
> +	struct mvebu_pwm *pwm =3D to_mvebu_pwm(chip);
> +	struct mvebu_gpio_chip *mvchip =3D pwm->mvchip;
> +
> +	mvebu_gpio_blink(&mvchip->chip, pwm->pin, 1);
> +
> +	return 0;
> +}
> +
> +static void mvebu_pwm_disable(struct pwm_chip *chip, struct pwm_device *=
pwmd)
> +{
> +	struct mvebu_pwm *pwm =3D to_mvebu_pwm(chip);
> +	struct mvebu_gpio_chip *mvchip =3D pwm->mvchip;
> +
> +	mvebu_gpio_blink(&mvchip->chip, pwm->pin, 0);
> +}
> +
> +static const struct pwm_ops mvebu_pwm_ops =3D {
> +	.request =3D mvebu_pwm_request,
> +	.free =3D mvebu_pwm_free,
> +	.config =3D mvebu_pwm_config,
> +	.enable =3D mvebu_pwm_enable,
> +	.disable =3D mvebu_pwm_disable,
> +	.owner =3D THIS_MODULE,
> +};

Can you please implement the atomic PWM API? Specifically the ->apply()
and ->get_state() implementations replace ->config(), ->enable() and
->disable().

> +static void mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
> +{
> +	struct mvebu_pwm *pwm =3D mvchip->pwm;
> +
> +	pwm->blink_select =3D readl_relaxed(mvebu_gpioreg_blink_select(mvchip));
> +	pwm->blink_on_duration =3D
> +		readl_relaxed(mvebu_pwmreg_blink_on_duration(pwm));
> +	pwm->blink_off_duration =3D
> +		readl_relaxed(mvebu_pwmreg_blink_off_duration(pwm));
> +}
> +
> +static void mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
> +{
> +	struct mvebu_pwm *pwm =3D mvchip->pwm;
> +
> +	writel_relaxed(pwm->blink_select, mvebu_gpioreg_blink_select(mvchip));
> +	writel_relaxed(pwm->blink_on_duration,
> +		       mvebu_pwmreg_blink_on_duration(pwm));
> +	writel_relaxed(pwm->blink_off_duration,
> +		       mvebu_pwmreg_blink_off_duration(pwm));
> +}
> +
> +/*
> + * Armada 370/XP has simple PWM support for gpio lines. Other SoCs
> + * don't have this hardware. So if we don't have the necessary
> + * resource, it is not an error.
> + */

There's a bit of inconsistency in this file regarding "pwm" -> "PWM" and
"gpio" -> "GPIO". In prose, please always use the uppercase version for
these abbreviations.

> +static int mvebu_pwm_probe(struct platform_device *pdev,
> +		    struct mvebu_gpio_chip *mvchip,
> +		    int id)

Is there any reason why id would want to be negative?

> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct mvebu_pwm *pwm;
> +	struct resource *res;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
> +	if (!res)
> +		return 0;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	mvchip->pwm =3D pwm;
> +	pwm->mvchip =3D mvchip;
> +
> +	pwm->membase =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pwm->membase))
> +		return PTR_ERR(pwm->membase);
> +
> +	if (id < 0 || id > 1)
> +		return -EINVAL;

You check for negative values here, so might as well turn id into an
unsigned to prohibit them altogether.

> +	pwm->id =3D id;
> +
> +	if (IS_ERR(mvchip->clk))
> +		return PTR_ERR(mvchip->clk);
> +
> +	pwm->clk_rate =3D clk_get_rate(mvchip->clk);
> +	if (!pwm->clk_rate) {
> +		dev_err(dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	pwm->chip.dev =3D dev;
> +	pwm->chip.ops =3D &mvebu_pwm_ops;
> +	pwm->chip.base =3D mvchip->chip.base;
> +	pwm->chip.npwm =3D mvchip->chip.ngpio;

Isn't that a lie? The code above suggests you can only ever have a
single GPIO turn into a PWM, so I'd expect ".npwm =3D 1" here.

Thierry

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljP3FkACgkQ3SOs138+
s6E0vA//QfJsk373MTWWTvIg7of10wX/jtdDnzWJCcfkrtnAsqShiP6+u9vSW5HH
UCn9+RdTHwi7KBJ8bAa7G3sZjpP29D5y6eFEKo5TBcKXiJAYYY1b1epLCIqhma53
ecMOAgTeABnDGhPMw2luQtym3BOrgOXW4jI1Ofe/ZSmgYoy93pu9Op0taP46dwrU
wV3efJF2lqtjOFMX+r9MkM65pcBAIhmA89fjv8Ys5N7FA6vFbIc05HV1cUD/2ZNO
RCYBVzBHDDHlM6k15Vd/hNIgSd99RhxMxKo7CIQlLg/lHGMM4aGKtbqtbloYthyP
u7t2+nVPPqlPi01zGJfDlRbVf8JxllIUcnA4kTZjJ7Yym06s+grEwZSRH6DTn0mB
G9QZ6O+ci2Xmlbrk6CbsJSgSTT3ob37zlSkVUdjI3h9a4kKZGVz/3FTWzlU6K1+Z
R46W0MLAVMn0GyTxUu4Y+5bkMPN4CztjI4dAAS6yGW+hplD275QdX1He2Yb2ACt5
LV6lUqntm4uHZsQG28jUNjCgJJjtGx3kOwNINyFwpRQrAl/rq3LcVtcEV0B71nfJ
Cqrmotk8AMYstaGfPKxaWIicPGlS+Qv5IpQbbBkAvqWjTKGSjlo4UwobC35t8+r4
2j93NQBRmMCSeQu3UqrPEtAr61LbMx2IrCadB9hF1bK7hzViZJ0=
=lLL3
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
