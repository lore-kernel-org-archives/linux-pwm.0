From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 14 Mar 2019 10:17:02 +0100
Message-ID: <20190314091702.sooxvnzd4mqr2ilz@pengutronix.de>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
 <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm->
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 13, 2019 at 07:31:16AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, add TPM PWM driver support.
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- improve coding style, function name's prefix;
> 	- improve Kconfig's help info;
> 	- use .apply instead for .enable/.disable/.config etc. to simply the cod=
e;
> 	- improve clock operation, make clock enabled during probe phase and ONL=
Y disabled
> 	  when suspend, as register read/write need to sync with clock, keeping =
it enabled
> 	  makes the register read/write simple;
> 	- improve prescale calculation;
> 	- add error message print during probe for ioremap and clk get;
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 332 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> =

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df..c1cbb43 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -201,6 +201,16 @@ config PWM_IMX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx.
>  =

> +config PWM_IMX_TPM
> +	tristate "i.MX TPM PWM support"
> +	depends on ARCH_MXC

Can you please make this

	depends on ARCH_MXC || COMPILE_TEST
	depends on HAVE_CLK && HAS_IOMEM

> +	help
> +	  Generic PWM framework driver for i.MX7ULP TPM module, TPM's full
> +	  name is Low Power Timer/Pulse Width Modulation Module.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-imx-tpm.
> +
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9c676a0..64e036c 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX)		+=3D pwm-imx.o
> +obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> new file mode 100644
> index 0000000..8c1a1ba
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define TPM_GLOBAL	0x8
> +#define TPM_SC		0x10
> +#define TPM_CNT		0x14
> +#define TPM_MOD		0x18
> +#define TPM_C0SC	0x20
> +#define TPM_C0V		0x24

PWM_IMX_TPM_COV etc. please

> +
> +#define TPM_SC_CMOD_SHIFT	3
> +#define TPM_SC_CMOD_MASK	(0x3 << TPM_SC_CMOD_SHIFT)

If you use the macros that are documented in <linux/bitops.h> you don't
need these MASK and SHIFT stuff.

> +#define TPM_SC_CPWMS		BIT(5)
> +
> +#define TPM_CnSC_CHF		BIT(7)
> +#define TPM_CnSC_MSnB		BIT(5)
> +#define TPM_CnSC_MSnA		BIT(4)
> +#define TPM_CnSC_ELSnB		BIT(3)
> +#define TPM_CnSC_ELSnA		BIT(2)
> +
> +#define TPM_SC_PS_MASK		0x7
> +#define TPM_MOD_MOD_MASK	0xffff
> +
> +#define TPM_COUNT_MAX		0xffff
> +
> +#define TPM_CHn_ADDR_OFFSET	0x8
> +#define TPM_DEFAULT_PWM_CHANNEL_NUM	2

Is this better called "..._MAX_..." instead of "..._DEFAULT_..."? This
is used as array size below and when reading

	u32 chn_config[TPM_DEFAULT_PWM_CHANNEL_NUM];

I wonder if the actual number of PWMs can be bigger than the default.

> +struct imx_tpm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	spinlock_t lock;
> +	u32 chn_config[TPM_DEFAULT_PWM_CHANNEL_NUM];
> +	bool chn_status[TPM_DEFAULT_PWM_CHANNEL_NUM];
> +};
> +
> +#define to_imx_tpm_pwm_chip(_chip)	container_of(_chip, struct imx_tpm_pw=
m_chip, chip)
> +
> +static void imx_tpm_pwm_config_counter(struct pwm_chip *chip, u32 period)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	unsigned int period_cnt;
> +	u32 val, div;
> +	u64 tmp;
> +
> +	tmp =3D clk_get_rate(tpm->clk);
> +	tmp *=3D period;
> +	val =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	if (val < TPM_COUNT_MAX)
> +		div =3D 0;
> +	else
> +		div =3D ilog2(roundup_pow_of_two(val / TPM_COUNT_MAX));

Are you sure you have to divide by TPM_COUNT_MAX and not by
(TPM_COUNT_MAX + 1)?

> +	if (div > TPM_SC_PS_MASK) {
> +		dev_err(chip->dev,
> +			"failed to find valid prescale value!\n");
> +		return;

I think you should handle this failure and make imx_tpm_pwm_apply() fail.

> +	}
> +	/* set TPM counter prescale */
> +	val =3D readl(tpm->base + TPM_SC);
> +	val &=3D ~TPM_SC_PS_MASK;
> +	val |=3D div;
> +	writel(val, tpm->base + TPM_SC);

According to the documentation PS can only be written if the counter is
disabled, I think this isn't ensured here.

> +	/* set period counter */
> +	do_div(tmp, NSEC_PER_SEC);
> +	period_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, 1 << div);
> +	writel(period_cnt & TPM_MOD_MOD_MASK, tpm->base + TPM_MOD);

If there is already a value pending in the MOD register, another write
to it is ignored. A comment, why this cannot happen, would be
appropriate. (Note, I'm not sure this cannot happen.)

> +}
> +
> +static void imx_tpm_pwm_config(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	static bool tpm_cnt_initialized;
> +	unsigned int duty_cnt;
> +	u32 val;
> +	u64 tmp;
> +
> +	/*
> +	 * TPM counter is shared by multi channels, let's make it to be
> +	 * ONLY first channel can config TPM counter's precale and period
> +	 * count.
> +	 */
> +	if (!tpm_cnt_initialized) {
> +		imx_tpm_pwm_config_counter(chip, state->period);
> +		tpm_cnt_initialized =3D true;
> +	}

So the period can only be configured once. That is not as good as it
could be. You should allow a change whenever there is exactly one PWM in
use.

> +	/* set duty counter */
> +	tmp =3D readl(tpm->base + TPM_MOD) & TPM_MOD_MOD_MASK;
> +	tmp *=3D state->duty_cycle;
> +	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, state->period);

Uah, you use state->period here even though for the 2nd PWM the Divider
might not be setup appropriately.

> [...]
> +static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			  struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	struct pwm_state curstate;
> +	unsigned long flags;
> +
> +	imx_tpm_pwm_get_state(chip, pwm, &curstate);
> +
> +	spin_lock_irqsave(&tpm->lock, flags);
> +
> +	if (state->period !=3D curstate.period ||
> +	    state->duty_cycle !=3D curstate.duty_cycle ||
> +	    state->polarity !=3D curstate.polarity)
> +		imx_tpm_pwm_config(chip, pwm, state);
> +
> +	if (state->enabled !=3D curstate.enabled)
> +		imx_tpm_pwm_enable(chip, pwm, state->enabled);

This is wrong. This sequence:

	pwm_apply_state(pwm, { .duty_cycle =3D 0, .period =3D 10000, .enabled =3D =
true });
	pwm_apply_state(pwm, { .duty_cycle =3D 10000, .period =3D 10000, .enabled =
=3D false });

must keep the output pin low which isn't guaranteed here.

> +
> +	spin_unlock_irqrestore(&tpm->lock, flags);
> +
> +	return 0;
> +}

I didn't look in depth through the complete driver yet, but there is
IIRC still some feedback on v1 that wasn't addressed in v2 (because v2
was sent before the last feedback). So I will look in more depth in v3
(assuming it comes late enough address the concerns from this mail).

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
