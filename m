From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 1/5] pwm: add the Berlin pwm controller driver
Date: Mon, 21 Sep 2015 10:40:08 +0200
Message-ID: <20150921084008.GE19865@ulmo.nvidia.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33721 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbbIUIkM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2015 04:40:12 -0400
Content-Disposition: inline
In-Reply-To: <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2015 at 12:13:04PM +0200, Antoine Tenart wrote:
> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> controller has 4 channels.
>=20
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  drivers/pwm/Kconfig      |   9 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-berlin.c | 229 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 drivers/pwm/pwm-berlin.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 062630ab7424..f3e8b7566ce5 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -92,6 +92,15 @@ config PWM_BCM2835
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-bcm2835.
> =20
> +config PWM_BERLIN
> +	tristate "Berlin PWM support"
> +	depends on ARCH_BERLIN
> +	help
> +	  PWM framework driver for Berlin.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-berlin.
> +
>  config PWM_BFIN
>  	tristate "Blackfin PWM support"
>  	depends on BFIN_GPTIMERS
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a0e00c09ead3..601833d82da5 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> +obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BFIN)		+=3D pwm-bfin.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> new file mode 100644
> index 000000000000..cb9790a2cde7
> --- /dev/null
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -0,0 +1,229 @@
> +/*
> + * Marvell Berlin PWM driver
> + *
> + * Copyright (C) 2015 Marvell Technology Group Ltd.
> + *
> + * Antoine Tenart <antoine.tenart@free-electrons.com>

There's no mention here about what this line means. From the commit
message and the MODULE_AUTHOR I know that you're the author, so either
this should just be dropped or it should be prefixed with "Author: ".

> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>
> +
> +#define BERLIN_PWM_EN			0x0
> +#define BERLIN_PWM_CONTROL		0x4
> +#define BERLIN_PWM_DUTY			0x8
> +#define BERLIN_PWM_TCNT			0xc
> +
> +#define BERLIN_PWM_ENABLE		BIT(0)
> +#define BERLIN_PWM_INVERT_POLARITY	BIT(3)
> +#define BERLIN_PWM_PRESCALE_MASK	0x7
> +#define BERLIN_PWM_PRESCALE_MAX		4096
> +#define BERLIN_PWM_MAX_TCNT		65535

It'd be nice to see some sort of connection between the register
definitions and which fields belong to them.

> +struct berlin_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	spinlock_t lock;

I don't think that lock is necessary here. You have per-channel
registers and each channel can only be used by one consumer at a time
anyway.

> +};
> +
> +#define to_berlin_pwm_chip(chip)	\
> +	container_of((chip), struct berlin_pwm_chip, chip)
> +
> +#define berlin_pwm_readl(chip, channel, offset)		\
> +	readl_relaxed((chip)->base + (channel) * 0x10 + offset)
> +#define berlin_pwm_writel(val, chip, channel, offset)	\
> +	writel_relaxed(val, (chip)->base + (channel) * 0x10 + offset)

These should be static inline functions. Also I think for
berlin_pwm_writel() val should come after chip and channel to preserve a
more natural ordering of parameters.

> +
> +/* prescaler table: {1, 4, 8, 16, 64, 256, 1024, 4096} */
> +static const u32 prescaler_diff_table[] =3D {
> +	1, 4, 2, 2, 4, 4, 4, 4,
> +};

I don't see any relationship between these values and the prescaler
table given in the comment. Please expand the comment to explain the
connection.

After reading the remainder of the code, I see that the values in this
table are the multiplication factors for each of the prescalers. It
shouldn't be necessary to read the code to find out, so please clarify
in the comment (and perhaps rename the table to something more related
to its purpose, such as prescale_factors).

Perhaps an even more easily digestible alternative would be to make this
a list of prescaler values and then use the values directly to compute
the number of cycles rather than iteratively dividing and needing this
unintuitive mapping.

> +
> +static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm_dev,
> +			     int duty_ns, int period_ns)
> +{
> +	struct berlin_pwm_chip *pwm =3D to_berlin_pwm_chip(chip);
> +	int prescale =3D 0;

This can be unsigned.

> +	u32 val, duty, period;
> +	u64 cycles;
> +
> +	cycles =3D clk_get_rate(pwm->clk);
> +	cycles *=3D period_ns;
> +	do_div(cycles, NSEC_PER_SEC);
> +
> +	while (cycles > BERLIN_PWM_MAX_TCNT)
> +		do_div(cycles, prescaler_diff_table[++prescale]);

Don't you need to make sure that prescale doesn't exceed the table size?

> +
> +	if (cycles > BERLIN_PWM_MAX_TCNT)
> +		return -EINVAL;

Perhaps -ERANGE?

> +
> +	period =3D cycles;
> +	cycles *=3D duty_ns;
> +	do_div(cycles, period_ns);
> +	duty =3D cycles;
> +
> +	spin_lock(&pwm->lock);
> +
> +	val =3D berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +	val &=3D ~BERLIN_PWM_PRESCALE_MASK;
> +	val |=3D prescale;
> +	berlin_pwm_writel(val, pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
> +
> +	berlin_pwm_writel(duty, pwm, pwm_dev->hwpwm, BERLIN_PWM_DUTY);
> +	berlin_pwm_writel(period, pwm, pwm_dev->hwpwm, BERLIN_PWM_TCNT);
> +
> +	spin_unlock(&pwm->lock);
> +
> +	return 0;
> +}
[...]
> +static int berlin_pwm_probe(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return PTR_ERR(pwm->clk);
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret)
> +		return ret;
> +
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &berlin_pwm_ops;
> +	pwm->chip.base =3D -1;
> +	pwm->chip.npwm =3D 4;
> +	pwm->chip.can_sleep =3D true;
> +	pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +	pwm->chip.of_pwm_n_cells =3D 3;
> +
> +	spin_lock_init(&pwm->lock);
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		clk_disable_unprepare(pwm->clk);

Why not enable the clock until after successful registration? It doesn't
seem like you need access before that. Doing so would introduce a subtle
race condition between adding the chip (and hence exposing it via sysfs)
and enabling the clock, so perhaps an even better approach would be to
add more fine-grained clock management by enabling or disabling it only
when necessary (clock enables are reference counted, so ->request() and
->free() would probably work fine in this case).

This isn't a real objection, though. If you prefer to keep things simple
the current code is fine with me.

> +
> +		dev_err(&pdev->dev, "Failed to add PWM chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int berlin_pwm_remove(struct platform_device *pdev)
> +{
> +	struct berlin_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&pwm->chip);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pwm->clk);

You might want to disable the clock regardless. The driver will be
unloaded regardless of whether pwmchip_remove() returns failure or
not. The above would leak a clock enable, which may not be what you
want.

> +	return 0;
> +}
> +
> +static struct platform_driver berlin_pwm_driver =3D {
> +	.probe	=3D berlin_pwm_probe,
> +	.remove	=3D berlin_pwm_remove,
> +	.driver	=3D {
> +		.name	=3D "berlin-pwm",
> +		.of_match_table =3D berlin_pwm_match,
> +	},

Please don't artificially pad. Single spaces around '=3D' is just fine.

Thierry

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV/8JlAAoJEN0jrNd/PrOhcF8P+gN3o7Hlw8KgeTshfvX5i5E/
XPltyO1xzb+73r4b42wbMjYmqfbZK0WSuchAcMtkAHz3ehzCmg7qdXFZ2l3QlMZi
Gyj6p+1LLIvrMPgzT0voWT/aoL/7a/ChacAhgRQDV342F4MjTB95LVDl6OCgiMm+
FTtFCN4IAk4obL4MAkOD08AYT0Xp8EY9kG+QP7j/1F7FliqvlIV/6rX6mJoDiGL5
tdRSxgts4bWqL6/tJgj0eITMr6I7Ut7a+e/Pn3kABPpIqxdEQUYKMrogKwGqRJg6
EN0HFdofagCsRQjllp+ntl3eI0wlGRof0VNypug+6EvIiMmQ4MdeG/T4rt5Wj5uN
LZU96ZcTGnkmpgyyhTXv26jTqZ22Wb0D4b21DETDPYKIam4ZXYE7JQEx64cH8t62
3rZjwTNDSp96rEb6Yy3hnWx4NH0hLmM+hSHUfO7SuPZjqrVARpqKZsgfOkUJbkOF
1Qr5JqwWId0ULoovAZY5Iy+0LoS4sxbKA/k0nGrUZdE/BgoJDE4vBcP929+IKjWo
+FY+UaoyWM4iq5VLVM4ZFd5lSYjxMOTI+2NrG7849mbovWPuC5SCgjbn4qnPpyK1
2iHX2jRhecUZ/l7Lx5BX0yKNCuo7AwU9dO1uG74AJ54prc0nSDXgrxni+R+Qa3rr
ztKRn9XtIxJF0ttg8xlv
=oTS9
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
