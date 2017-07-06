From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC] pwm: Add Xilinx AXI Timer in PWM mode support
Date: Thu, 6 Jul 2017 11:13:44 +0200
Message-ID: <20170706091344.GO16144@ulmo.fritz.box>
References: <20170627100522.30447-1-alvaro.gamez@hazent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E+IgQzR66AIOcbjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170627100522.30447-1-alvaro.gamez@hazent.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--E+IgQzR66AIOcbjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 12:05:22PM +0200, Alvaro Gamez Machado wrote:
> This patch adds support for the IP core provided by Xilinx.
> This IP core can function as a two independent timers, but can also use
> both counters as values for period and duty cycle of a PWM output.
>=20
> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> ---
>=20
> Hi!
>=20
> AXI timer IP core is also used on Microblaze based systems to generate a
> periodic interrupt, as defined in arch/microblaze/kernel/timer.c
>=20
> If this patch is applied as is on a hardware that defines two timers (one
> intended to generate the periodic interrupt and the other one to be the
> PWM controller), the driver finds two devices:
>=20
> axi_timer-pwm 41c00000.timer: at 0x41C00000 mapped to 0xf0080000
> axi_timer-pwm 41c10000.timer: at 0x41C10000 mapped to 0xf00a0000
>=20
> Of course, the first one is the interrupt generator, so using this PWM
> would alter its configuration and screw everything up.
>=20
> I'm quite new tinkering with the kernel, so I'd like to know which would
> be a nice solution for this:
>=20
> a) Changing "xlnx,axi-timer-2.0" compatible string for this device to som=
ething
>    different like xlnx,axi-pwm-2.0?

I don't see a xlnx,axi-timer-2.0 compatible string defined in the
kernel. There's an xlnx,xps-timer-1.00.a used in Microblaze and PowerPC,
but it might not be related.

> b) Is there a way to make arch/microblaze/kernel/timer.c take full posess=
ion
>    of its axi timer device so that any further driver can't access it?

Typically a driver would call request_resource(), which marks the given
resource (i.e. memory-mapped I/O region) as in-use, before mapping it.
However, the Microblaze code doesn't do that. Instead it uses of_iomap()
which maps the region without requesting it.

However, request_resource() isn't a complete solution to this problem
either because it works on a first-come, first-serve basis. That is, if
you've requested the region in the Microblaze timer code, then the PWM
driver won't be able to claim it, and vice versa. So this gives you a
simple solution to prevent the PWM driver from messing with the timer
code.

However, you wouldn't be able to configure the two blocks in your
example differently. The reason is that both will be claimed by the same
driver (timer code or PWM driver). At least in general terms. In this
particular case, the Microblaze timer code only initializes one instance
and leaves the second alone. So in fact simply claiming the region via a
call to request_resource() should be enough to make this work for your
particular use-case. The PWM driver would still try to bind to both
devices, but it will fail during devm_ioremap_resource() for the first
instance because the timer code would've claimed the region. The
downside is that you'd get an error in the boot log because the driver
probe failed.

As for ARCH_ZYNQ the problem can likely be ignored because it doesn't
use the Microblaze timer code. So you could simply enable the driver and
have it claim whatever devices match. For the sake of completeness I
should say that this only works (reliably) if you have a single driver
claiming to be compatible with a given string. Only a single driver can
bind to a given device (inherently, even before trying to request the
I/O region).

> I've tried option (a) and works flawlessly as far as I can tell (tested
> through /sys interface), but I think option (b) would be better, if it's
> something that can be done.

I think (a) is certainly the cleaner approach because it lets you select
the mode via DT. However, it's probably best to get DT maintainers'
opinion on this. Cc'ing them. Quoting in full for context.

As you point out, using a completely different compatible string is the
easiest way to side-step the problem. However, it's also "wrong" in that
you're still dealing with the same hardware, and consequently should be
identified by the same compatible string.

One possible option I can think of would be to define a somewhat generic
compatible string to identify the block as a whole and require a second
compatible string to specify what mode to use the block in.

Another alternative would be to mark the node as PWM controller with an
additional property (e.g. pwm-controller) and use that as the selector
for the mode. The timer code would have to be modified to abort if it
encounters a node marked with this property, and similarily the PWM
driver would abort if the property is absent.

Anyway, let's see what the device tree maintainers think about it.

Thierry

>  drivers/pwm/Kconfig         |   9 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-axi-timer.c | 196 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/pwm/pwm-axi-timer.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 313c10789ca2..d4e9fa4ed40e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -74,6 +74,15 @@ config PWM_ATMEL_TCB
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel-tcb.
> =20
> +config PWM_AXI_TIMER
> +	tristate "AXI Timer PWM support"
> +	depends on ARCH_ZYNQ || MICROBLAZE
> +	help
> +	  Generic PWM framework driver for Xilinx's AXI Timer
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-axi-timer.
> +
>  config PWM_BCM_IPROC
>  	tristate "iProc PWM support"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 93da1f79a3b8..773f99f20d4b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> +obj-$(CONFIG_PWM_AXI_TIMER)	+=3D pwm-axi-timer.o
>  obj-$(CONFIG_PWM_BCM_IPROC)	+=3D pwm-bcm-iproc.o
>  obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> diff --git a/drivers/pwm/pwm-axi-timer.c b/drivers/pwm/pwm-axi-timer.c
> new file mode 100644
> index 000000000000..94748e526eb8
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-timer.c
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright 2017 Alvaro Gamez Machado <alvaro.gamez@hazent.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +struct axi_timer_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *regs;  /* virt. address of the control registers */
> +};
> +
> +#define TCSR0   (0x00)
> +#define TLR0    (0x04)
> +#define TCR0    (0x08)
> +#define TCSR1   (0x10)
> +#define TLR1    (0x14)
> +#define TCR1    (0x18)
> +
> +#define TCSR_MDT        BIT(0)
> +#define TCSR_UDT        BIT(1)
> +#define TCSR_GENT       BIT(2)
> +#define TCSR_CAPT       BIT(3)
> +#define TCSR_ARHT       BIT(4)
> +#define TCSR_LOAD       BIT(5)
> +#define TCSR_ENIT       BIT(6)
> +#define TCSR_ENT        BIT(7)
> +#define TCSR_TINT       BIT(8)
> +#define TCSR_PWMA       BIT(9)
> +#define TCSR_ENALL      BIT(10)
> +#define TCSR_CASC       BIT(11)
> +
> +#define to_axi_timer_pwm_chip(_chip) \
> +	container_of(_chip, struct axi_timer_pwm_chip, chip)
> +
> +static int axi_timer_pwm_config(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				int duty_ns, int period_ns)
> +{
> +	struct axi_timer_pwm_chip *axi_timer =3D to_axi_timer_pwm_chip(chip);
> +	unsigned long long c;
> +	int period_cycles, duty_cycles;
> +
> +	c =3D clk_get_rate(axi_timer->clk);
> +
> +	/* When counters are configured to count down, UDT=3D1 (see datasheet):
> +	 * PWM_PERIOD =3D (TLR0 + 2) * AXI_CLOCK_PERIOD
> +	 * PWM_HIGH_TIME =3D (TLR1 + 2) * AXI_CLOCK_PERIOD
> +	 */
> +	period_cycles =3D div64_u64(c * period_ns, NSEC_PER_SEC) - 2;
> +	duty_cycles =3D div64_u64(c * duty_ns, NSEC_PER_SEC) - 2;
> +
> +	iowrite32(period_cycles, axi_timer->regs + TLR0);
> +	iowrite32(duty_cycles, axi_timer->regs + TLR1);
> +
> +	/* Load timer values */
> +	u32 tcsr;
> +
> +	tcsr =3D ioread32(axi_timer->regs + TCSR0);
> +	iowrite32(tcsr | TCSR_LOAD, axi_timer->regs + TCSR0);
> +	iowrite32(tcsr, axi_timer->regs + TCSR0);
> +
> +	tcsr =3D ioread32(axi_timer->regs + TCSR1);
> +	iowrite32(tcsr | TCSR_LOAD, axi_timer->regs + TCSR1);
> +	iowrite32(tcsr, axi_timer->regs + TCSR1);
> +
> +	return 0;
> +}
> +
> +static int axi_timer_pwm_enable(struct pwm_chip *chip, struct pwm_device=
 *pwm)
> +{
> +	struct axi_timer_pwm_chip *axi_timer =3D to_axi_timer_pwm_chip(chip);
> +
> +	/* see timer data sheet for detail
> +	 * !CASC - disable cascaded operation
> +	 * ENALL - enable all
> +	 * PWMA - enable PWM
> +	 * !TINT - don't care about interrupts
> +	 * ENT- enable timer itself
> +	 * !ENIT - disable interrupt
> +	 * !LOAD - clear the bit to let go
> +	 * ARHT - auto reload
> +	 * !CAPT - no external trigger
> +	 * GENT - required for PWM
> +	 * UDT - set the timer as down counter
> +	 * !MDT - generate mode
> +	 */
> +	iowrite32(TCSR_ENALL | TCSR_PWMA | TCSR_ENT | TCSR_ARHT |
> +		  TCSR_GENT | TCSR_UDT, axi_timer->regs + TCSR0);
> +	iowrite32(TCSR_ENALL | TCSR_PWMA | TCSR_ENT | TCSR_ARHT |
> +		  TCSR_GENT | TCSR_UDT, axi_timer->regs + TCSR1);
> +
> +	return 0;
> +}
> +
> +static void axi_timer_pwm_disable(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
> +{
> +	struct axi_timer_pwm_chip *axi_timer =3D to_axi_timer_pwm_chip(chip);
> +
> +	u32 tcsr;
> +
> +	tcsr =3D ioread32(axi_timer->regs + TCSR0);
> +	iowrite32(tcsr & ~TCSR_PWMA, axi_timer->regs + TCSR0);
> +
> +	tcsr =3D ioread32(axi_timer->regs + TCSR1);
> +	iowrite32(tcsr & ~TCSR_PWMA, axi_timer->regs + TCSR1);
> +}
> +
> +static const struct pwm_ops axi_timer_pwm_ops =3D {
> +	.config =3D axi_timer_pwm_config,
> +	.enable =3D axi_timer_pwm_enable,
> +	.disable =3D axi_timer_pwm_disable,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int axi_timer_pwm_probe(struct platform_device *pdev)
> +{
> +	struct axi_timer_pwm_chip *axi_timer;
> +	struct resource *res;
> +	int ret;
> +
> +	axi_timer =3D devm_kzalloc(&pdev->dev, sizeof(*axi_timer), GFP_KERNEL);
> +	if (!axi_timer)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	axi_timer->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(axi_timer->regs))
> +		return PTR_ERR(axi_timer->regs);
> +
> +	axi_timer->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(axi_timer->clk))
> +		return PTR_ERR(axi_timer->clk);
> +
> +	axi_timer->chip.dev =3D &pdev->dev;
> +	axi_timer->chip.ops =3D &axi_timer_pwm_ops;
> +	axi_timer->chip.npwm =3D 1;
> +	axi_timer->chip.base =3D -1;
> +
> +	dev_info(&pdev->dev, "at 0x%08llX mapped to 0x%p\n",
> +		 (unsigned long long)res->start, axi_timer->regs);
> +
> +	ret =3D pwmchip_add(&axi_timer->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, axi_timer);
> +
> +	return 0;
> +}
> +
> +static int axi_timer_pwm_remove(struct platform_device *pdev)
> +{
> +	struct axi_timer_pwm_chip *axi_timer =3D platform_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	for (i =3D 0; i < axi_timer->chip.npwm; i++)
> +		pwm_disable(&axi_timer->chip.pwms[i]);
> +
> +	return pwmchip_remove(&axi_timer->chip);
> +}
> +
> +static const struct of_device_id axi_timer_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "xlnx,axi-timer-2.0", },
> +};
> +MODULE_DEVICE_TABLE(of, axi_timer_pwm_dt_ids);
> +
> +static struct platform_driver axi_timer_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "axi_timer-pwm",
> +		.of_match_table =3D axi_timer_pwm_dt_ids,
> +	},
> +	.probe =3D axi_timer_pwm_probe,
> +	.remove =3D axi_timer_pwm_remove,
> +};
> +module_platform_driver(axi_timer_pwm_driver);
> +
> +MODULE_ALIAS("platform:axi_timer-pwm");
> +MODULE_AUTHOR("Alvaro Gamez Machado <alvaro.gamez@hazent.com>");
> +MODULE_DESCRIPTION("AXI TIMER PWM Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.11.0
>=20

--E+IgQzR66AIOcbjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld/0YACgkQ3SOs138+
s6G8WRAAp1xNkzD+ODz1hR37WDWd9iQvJLE48Uv2tiRY5FbCQgydZxvJIWOv+OQx
36jDrP60Z3h/kRDIvdyGBzF1EHaBhot8fmbDWUEwCOM1tAFuWEPBiKNXx2jrC1VV
dadOhyKJwZmHl8kP6y5oTbo7SaelIrHrGsm3aKpLNnlv7UDBs9VHNIzwpdT5DnYf
v/PfSkvOg304AhMtq8Sp799ANXNDwu3MbNVl6XAxgz5qQFI4ZHN9iPeS0QxeJm0M
35sUsUziiKkDQ+eXRsmtjdd888dDBb3sqM+PgNkoKS4RES/M5trXcbZa67R4WXJE
ONvAzZpHtq81Ts3PvE3YfbQmisnRAKn8YRSCNp3SzOaU6Rs9WBNozqbRTkrw0MPf
olYiez9AhrRHWyz5bqY7cpbKl0shoQH2bPZHAT26093DmifTz0ZU3IiXeU3pg+yU
JKGFFgyAaAcoDlZfeBPaCr/IHY5lhqC320wLMsGP6qu26OT/6isMSMpCnzt2l98W
iO2Vtudn2tGxbAn1K44+yWAnRcBW95EgbxEMnQiBCR73Rw/NIXQicG/dGHAqTodS
Mbj3AhZ3TY4Vne/3Jh3/M6SQmwW+TFnBr0bH04s2Fb745qlw/Q3DfpSL8sdTfTje
dUm/6dUrx53/9qoCZi938a5c/BmdyNH5YoB40cT2WU5Mlp/4IQM=
=djcm
-----END PGP SIGNATURE-----

--E+IgQzR66AIOcbjA--
