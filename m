From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/4] ARM: PWM: add allwinner sun8i R40/V40/T3 pwm
 support.
Date: Wed, 13 Dec 2017 16:56:58 +0100
Message-ID: <20171213155658.3xfxiapkdwhg5yzf@flea.lan>
References: <20171213144446.GA18217@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="urxfukqap5bstbof"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171213144446.GA18217@arx-s1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--urxfukqap5bstbof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your patch.

It looks mostly good except for a few things below:

On Wed, Dec 13, 2017 at 10:44:46PM +0800, hao_zhang wrote:
> This patch add allwinner sun8i R40/V40/T3 pwm support.
>=20
> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/pwm/Kconfig         |  10 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-sun8i-r40.c | 449 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 460 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun8i-r40.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 763ee50..cde5a70 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN8I_R40
> +	tristate "Allwinner PWM SUN8I R40 support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner SoCs R40, V40, T3.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i-r40.
> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0258a74..026a55b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I_R40)	+=3D pwm-sun8i-r40.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun8i-r40.c b/drivers/pwm/pwm-sun8i-r40.c
> new file mode 100644
> index 0000000..8df538d
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i-r40.c
> @@ -0,0 +1,449 @@
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +
> +#define PWM_IRQ_ENABLE_REG	0x0000
> +#define PCIE(ch)	BIT(ch)
> +
> +#define PWM_IRQ_STATUS_REG	0x0004
> +#define PIS(ch)	BIT(ch)
> +
> +#define CAPTURE_IRQ_ENABLE_REG	0x0010
> +#define CFIE(ch)	BIT(ch << 1 + 1)
> +#define CRIE(ch)	BIT(ch << 1)
> +
> +#define CAPTURE_IRQ_STATUS_REG	0x0014
> +#define CFIS(ch)	BIT(ch << 1 + 1)
> +#define CRIS(ch)	BIT(ch << 1)
> +
> +#define CLK_CFG_REG(ch)	(0x0020 + (ch >> 1) * 4)
> +#define CLK_SRC	BIT(7)
> +#define CLK_SRC_BYPASS_SEC	BIT(6)
> +#define CLK_SRC_BYPASS_FIR	BIT(5)
> +#define CLK_GATING	BIT(4)
> +#define CLK_DIV_M	GENMASK(3, 0)
> +
> +#define PWM_DZ_CTR_REG(ch)	(0x0030 + (ch >> 1) * 4)
> +#define PWM_DZ_INTV	GENMASK(15, 8)
> +#define PWM_DZ_EN	BIT(0)
> +
> +#define PWM_ENABLE_REG	0x0040
> +#define PWM_EN(ch)	BIT(ch)
> +
> +#define CAPTURE_ENABLE_REG	0x0044
> +#define CAP_EN(ch)	BIT(ch)
> +
> +#define PWM_CTR_REG(ch)	(0x0060 + ch * 0x20)
> +#define PWM_PERIOD_RDY	BIT(11)
> +#define PWM_PUL_START	BIT(10)
> +#define PWM_MODE	BIT(9)
> +#define PWM_ACT_STA	BIT(8)
> +#define PWM_PRESCAL_K	GENMASK(7, 0)
> +
> +#define PWM_PERIOD_REG(ch)	(0x0064 + ch * 0x20)
> +#define PWM_ENTIRE_CYCLE	GENMASK(31, 16)
> +#define PWM_ACT_CYCLE	GENMASK(15, 0)
> +
> +#define PWM_CNT_REG(ch)	(0x0068 + ch * 0x20)
> +#define PWM_CNT_VAL	GENMASK(15, 0)
> +
> +#define CAPTURE_CTR_REG(ch)	(0x006c + ch * 0x20)
> +#define CAPTURE_CRLF	BIT(2)
> +#define CAPTURE_CFLF	BIT(1)
> +#define CAPINV	BIT(0)
> +
> +#define CAPTURE_RISE_REG(ch)	(0x0070 + ch * 0x20)
> +#define CAPTURE_CRLR	GENMASK(15, 0)
> +
> +#define CAPTURE_FALL_REG(ch)	(0x0074 + ch * 0x20)
> +#define CAPTURE_CFLR	GENMASK(15, 0)
> +
> +struct sunxi_pwm_data {

You should use the sun8i_pwm prefix (including r40 if you want).

> +static inline u32 sunxi_pwm_readl(struct sunxi_pwm_chip *chip,
> +		unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sunxi_pwm_writel(struct sunxi_pwm_chip *chip,
> +		u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static void sunxi_pwm_set_bit(struct sunxi_pwm_chip *sunxi_pwm,
> +		unsigned long reg, u32 bit)
> +{
> +	u32 val;
> +
> +	val =3D sunxi_pwm_readl(sunxi_pwm, reg);
> +	val |=3D bit;
> +	sunxi_pwm_writel(sunxi_pwm, val, reg);
> +}
> +
> +static void sunxi_pwm_clear_bit(struct sunxi_pwm_chip *sunxi_pwm,
> +		unsigned long reg, u32 bit)
> +{
> +	u32 val;
> +
> +	val =3D sunxi_pwm_readl(sunxi_pwm, reg);
> +	val &=3D ~bit;
> +	sunxi_pwm_writel(sunxi_pwm, val, reg);
> +}
> +
> +static void sunxi_pwm_set_value(struct sunxi_pwm_chip *sunxi_pwm,
> +		unsigned long reg, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp =3D sunxi_pwm_readl(sunxi_pwm, reg);
> +	tmp &=3D ~mask;
> +	tmp |=3D mask & val;
> +	sunxi_pwm_writel(sunxi_pwm, tmp, reg);
> +}
> +
> +static void sunxi_pwm_set_polarity(struct sunxi_pwm_chip *chip, u32 ch,
> +		enum pwm_polarity polarity)
> +{
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		sunxi_pwm_set_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +	else
> +		sunxi_pwm_clear_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +}
> +
> +static void sunxi_dump_reg(struct sunxi_pwm_chip *sunxi_pwm, u8 ch)
> +{
> +	dev_dbg(sunxi_pwm->chip.dev, "ch: %d\n"
> +			"\tPWM_IRQ_ENABLE_REG(%04x): \t0x%08x\n"
> +			"\tPWM_IRQ_STATUS_REG(%04x): \t0x%08x\n"
> +			"\tCAPTURE_IRQ_ENABLE_REG(%04x): \t0x%08x\n"
> +			"\tCAPTURE_IRQ_STATUS_REG(%04x): \t0x%08x\n"
> +			"\tCLK_CFG_REG(%04x)(%d): \t0x%08x\n"
> +			"\tPWM_DZ_CTR_REG(%04x)(%d): \t0x%08x\n"
> +			"\tPWM_ENABLE_REG(%04x): \t0x%08x\n"
> +			"\tCAPTURE_ENABLE_REG(%04x): \t0x%08x\n"
> +			"\tPWM_CTR_REG(%04x)(%d): \t0x%08x\n"
> +			"\tPWM_PERIOD_REG(%04x)(%d): \t0x%08x\n"
> +			"\tPWM_CNT_REG(%04x)(%d): \t0x%08x\n"
> +			"\tCAPTURE_CTR_REG(%04x)(%d): \t0x%08x\n"
> +			"\tCAPTURE_RISE_REG(%04x)(%d): \t0x%08x\n"
> +			"\tCAPTURE_FALL_REG(%04x)(%d): \t0x%08x\n",
> +			ch,
> +			PWM_IRQ_ENABLE_REG,
> +			readl(sunxi_pwm->base + PWM_IRQ_ENABLE_REG),
> +			PWM_IRQ_STATUS_REG,
> +			readl(sunxi_pwm->base + PWM_IRQ_STATUS_REG),
> +			CAPTURE_IRQ_ENABLE_REG,
> +			readl(sunxi_pwm->base + CAPTURE_IRQ_ENABLE_REG),
> +			CAPTURE_IRQ_STATUS_REG,
> +			readl(sunxi_pwm->base + CAPTURE_IRQ_STATUS_REG),
> +			CLK_CFG_REG(ch),
> +			ch, readl(sunxi_pwm->base + CLK_CFG_REG(ch)),
> +			PWM_DZ_CTR_REG(ch),
> +			ch, readl(sunxi_pwm->base + PWM_DZ_CTR_REG(ch)),
> +			PWM_ENABLE_REG,
> +			readl(sunxi_pwm->base + PWM_ENABLE_REG),
> +			CAPTURE_ENABLE_REG,
> +			readl(sunxi_pwm->base + CAPTURE_ENABLE_REG),
> +			PWM_CTR_REG(ch),
> +			ch, readl(sunxi_pwm->base + PWM_CTR_REG(ch)),
> +			PWM_PERIOD_REG(ch),
> +			ch, readl(sunxi_pwm->base + PWM_PERIOD_REG(ch)),
> +			PWM_CNT_REG(ch),
> +			ch, readl(sunxi_pwm->base + PWM_CNT_REG(ch)),
> +			CAPTURE_CTR_REG(ch),
> +			ch, readl(sunxi_pwm->base + CAPTURE_CTR_REG(ch)),
> +			CAPTURE_RISE_REG(ch),
> +			ch, readl(sunxi_pwm->base + CAPTURE_RISE_REG(ch)),
> +			CAPTURE_FALL_REG(ch),
> +			ch, readl(sunxi_pwm->base + CAPTURE_FALL_REG(ch)));
> +}

You should really consider using a regmap here. It provides all the
accessors you have defined above, you can read the regmap content
directly from debugfs without recompiling your kernel, and you have
ftrace events as well to trace the read / writes as they happen. All
of that for free, without having to maintain it in your driver :)

> +static int sunxi_pwm_config(struct sunxi_pwm_chip *sunxi_pwm, u8 ch,
> +		struct pwm_state *state)
> +{
> +	u64 clk_rate, clk_div, val;
> +	u16 prescaler =3D 0;
> +	u8 id =3D 0;
> +
> +	clk_rate =3D clk_get_rate(sunxi_pwm->clk);
> +	dev_dbg(sunxi_pwm->chip.dev, "clock rate:%lld\n", clk_rate);

This is also something you can retrieve through ftrace events.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--urxfukqap5bstbof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAloxTccACgkQ0rTAlCFN
r3RXrA//VQnmsoAY1GYvNVHInGizXeGICQSdWW8diOdOmNSKEHs0WuE/086TYvsv
wZCpuClNLA9/la2rSBC8E45+8DJzfDZaLH6yLugXiRsvsrAQNM6fQzRAdvRi8Kmw
J5L6/oKWSTqVUDKabOli2d6CFIZWbf/9Kp+6AtuaQIP9y/NqCn80uVVT78Ssml9r
PNPa/3iXNcm5vvsycQmHTVuadDNBwY5OralabXL2wXWQU+pa94B60yRKWMvGiYau
KQDhBXoWd+8SQddYfAijajJGblF/ELhCvC74uK4lbeFjm4O8Okz2rz2GXG4LwjfV
7ZMLdcS9rExzB+C7QWCoy3hSkoJbaKJCfWhPeG3QmQfLz1mdUYGtqTV3Dn+NKzd2
OUUW20Jps3hmVupmEp+B4KA5RhacALa6nN7mxaup9pHW9auYB/s+TsJrfQMaoXom
j8sS+7vTKJtKG9fdLDwvMMquitSSKeOPyvv9aWVAHnannhn1VUyqXVNeoNTJnbxu
Z3C8XHFJU+dQjIVrhxeiRYgq0HsKPk/XZBNJtUZQ0qfQLdsVT0bO7lnle7df8SbI
WWY9GAvRSJ5lN00V39tur0vEIm+346Zc9tmL7vYhyeJYQ3pabJDE4Sm7L0h7Mv0e
OKxVdyGQCtCz0YN7zNBdi/6b4ov+EUtnzwdyW50kY71ZEeTh+6E=
=CmNW
-----END PGP SIGNATURE-----

--urxfukqap5bstbof--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
