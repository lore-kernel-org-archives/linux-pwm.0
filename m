From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2 v2] pwm: add a driver for the STMPE PWM
Date: Mon, 7 Mar 2016 10:52:55 +0100
Message-ID: <20160307095255.GH31189@ulmo.nvidia.com>
References: <1455455325-17093-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34961 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbcCGJxB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2016 04:53:01 -0500
Received: by mail-pf0-f194.google.com with SMTP id x188so5637070pfb.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2016 01:53:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455455325-17093-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2016 at 02:08:45PM +0100, Linus Walleij wrote:
> This adds a driver for the STMPE 24xx series of multi-purpose
> I2C expanders. (I think STMPE means ST Microelectronics
> Multi-Purpose Expander.) This PWM was designed in accordance with
> Nokia specifications and is kind of weird and usually just
> switched between max and zero dutycycle. However it is indeed
> a PWM so it needs to live in the PWM subsystem.
>=20
> This PWM is mostly used for white LED backlight.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Split off the MFD hunk from the patch: no need to worry about
>   that, it can be merged orthogonally to the MFD tree.
> ---
>  drivers/pwm/Kconfig     |   7 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stmpe.c | 297 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stmpe.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8cf0dae78555..89665c6d6a4d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -362,6 +362,13 @@ config PWM_STI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sti.
> =20
> +config PWM_STMPE
> +	bool "STMPE expander PWM export"

tristate maybe? If not I suspect that we'll get a patch to this driver
shortly that will convert the module_platform_driver() to a
builtin_platform_driver().

> +	depends on MFD_STMPE
> +	help
> +	  This enables support for the PWMs found in the STMPE I/O
> +	  expanders.
> +
>  config PWM_SUN4I
>  	tristate "Allwinner PWM support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index dd35bc121a18..790353b7454e 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> +obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
[...]
> +struct stmpe_pwm {
> +	struct stmpe *stmpe;
> +	struct pwm_chip chip;
> +	u8 lastduty;
> +	bool enabled;

Can you not use the pwm_is_enabled() to track this?

> +static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +	struct stmpe_pwm *stmpe_pwm =3D to_stmpe_pwm(chip);
> +	int ret;
> +	u8 val;
> +
> +	ret =3D stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "error reading PWM%d control\n",
> +			pwm->hwpwm);
> +		return ret;
> +	}
> +	val =3D (u8)ret;
> +	val |=3D BIT(pwm->hwpwm);
> +	ret =3D stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, val);

Do you even need the cast to u8 here? Seems to me like it should all
work properly if you keep using ret (possibly renamed) here. Either way
is fine with me, though.

Perhaps add a couple more blank lines to make this easier on the eye. I
like to have blocks separated by blank lines, so a blank line after '}'
and before 'ret =3D ...' would be nice.

> +	if (ret) {
> +		dev_err(chip->dev, "error writing PWM%d control\n",
> +			pwm->hwpwm);
> +		return ret;
> +	}
> +	stmpe_pwm->enabled =3D true;
> +
> +	return 0;
> +}
> +
> +static void stmpe_24xx_pwm_disable(struct pwm_chip *chip,
> +				struct pwm_device *pwm)
> +{
> +	struct stmpe_pwm *stmpe_pwm =3D to_stmpe_pwm(chip);
> +	int ret;
> +	u8 val;
> +
> +	ret =3D stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "error reading PWM%d control\n",
> +			pwm->hwpwm);
> +		return;
> +	}
> +	val =3D (u8)ret;
> +	val &=3D ~BIT(pwm->hwpwm);
> +	ret =3D stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, val);
> +	if (ret) {
> +		dev_err(chip->dev, "error writing PWM%d control\n",
> +			pwm->hwpwm);
> +		return;
> +	}
> +	stmpe_pwm->enabled =3D false;
> +}

Same here, re: the blank lines.

> +
> +static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				int duty_ns, int period_ns)
> +{
> +	struct stmpe_pwm *stmpe_pwm =3D to_stmpe_pwm(chip);
> +	u8 reg;
> +	int ret;
> +	int i;

i can be unsigned int, and then merged into the below line that declares
pin.

> +	unsigned int pin;
> +	u16 program[3] =3D {
> +		0x007F, /* SMAX =3D logic low out */
> +		0x0000, /* GTS */
> +		0x0000, /* GTS */
> +	};
> +
> +	/* This preserves enablement state across reconfig */
> +	bool enabled =3D stmpe_pwm->enabled;
> +
> +	/* Make sure we are disabled */
> +	if (enabled)
> +		stmpe_24xx_pwm_disable(chip, pwm);

pwm_is_enabled() should do the trick here, shouldn't it?

> +	/* Connect the PWM to the pin */
> +	pin =3D pwm->hwpwm;
> +	/* On STMPE2401 and 2403 pins 21,22,23 are used */
> +	if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2401 ||
> +		stmpe_pwm->stmpe->partnum =3D=3D STMPE2403)
> +		pin +=3D STMPE_PWM_24XX_PINBASE;

This might be better as SoC specific data associated with this device
via of_device_id->data. That way you can properly parameterize and it
should be more forward-portable.

> +	ret =3D stmpe_set_altfunc(stmpe_pwm->stmpe,
> +				BIT(pin),
> +				STMPE_BLOCK_PWM);
> +	if (ret) {
> +		dev_err(chip->dev, "unable to connect PWM%d to pin\n",
> +			pwm->hwpwm);
> +		return ret;
> +	}
> +
> +	/* STMPE24XX */
> +	if (pwm->hwpwm =3D=3D 0)
> +		reg =3D STMPE24XX_PWMIC0;
> +	else if (pwm->hwpwm =3D=3D 1)
> +		reg =3D STMPE24XX_PWMIC1;
> +	else if (pwm->hwpwm =3D=3D 2)
> +		reg =3D STMPE24XX_PWMIC1;
> +	else
> +		/* Should not happen as npwm is 3 */
> +		return -ENODEV;

It's dead code, you might as well remove it.

> +
> +	dev_dbg(chip->dev, "PWM%d: config duty %d ns, period %d ns\n",
> +		pwm->hwpwm, duty_ns, period_ns);
> +	if (duty_ns =3D=3D 0) {
> +		if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2401)
> +			program[0] =3D 0x007F; /* SMAX =3D off all the time */
> +		if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2403)
> +			program[0] =3D BIT(14) | 0xFF; /* LOAD 0xFF */
> +		stmpe_pwm->lastduty =3D 0x00;
> +	} else if (duty_ns =3D=3D period_ns) {
> +		if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2401)
> +			program[0] =3D 0x00FF; /* SMIN =3D on all the time */
> +		if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2403)
> +			program[0] =3D BIT(14); /* LOAD 0x00 */
> +		stmpe_pwm->lastduty =3D 0xFF;
> +	} else {

Again, it might be easier to parameterize these, though admittedly this
would be somewhat more complicated than for the pin base. I'm fine with
constructs such as this for now, but if the list of part numbers starts
to increase, I'll likely request this to be changed to something easier
to maintain.

Also there are a bunch of BIT(X) in the above (and below). Can we get
some symbolic names for those, please?

> +		unsigned long cyc;
> +		u8 val;
> +
> +		/*
> +		 * Counter goes from 0x00 to 0xFF repeatedly at 32768 Hz,
> +		 * (means a period of 30517 ns)
> +		 * then this is compared to the counter from the ramp,
> +		 * if this is >=3D pwm counter the output is high.
> +		 * With LOAD we can define how much of the cycle it is on.
> +		 *
> +		 * Prescale =3D 0 -> 2 kHz -> T =3D 1/f =3D 488281,25 ns
> +		 */
> +		/* Scale to 0..FF */
> +		cyc =3D duty_ns * 256;
> +		cyc =3D DIV_ROUND_CLOSEST(cyc, period_ns);
> +		val =3D cyc;
> +
> +		if (val =3D=3D stmpe_pwm->lastduty) {
> +			/* Do nothing */

This fall-through will cause the program to be written to the channel,
is that really what you want? This looks slightly odd, perhaps inverting
the condition and putting the code below into its block would make this
more explicit. Maybe a "goto write_program;" would be equally explicit.

> +		} else if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2403) {
> +			/* STMPE2403 can simply set the right PWM value */
> +			program[0] =3D BIT(14) | val;
> +			program[1] =3D 0x0000;
> +		} else if (stmpe_pwm->stmpe->partnum =3D=3D STMPE2401) {
> +			/* STMPE2401 need a complex program */
> +			u16 incdec =3D 0x0000;
> +
> +			if (stmpe_pwm->lastduty < val)
> +				/* Count up */
> +				incdec =3D (val - stmpe_pwm->lastduty);
> +			else
> +				/* Count down */
> +				incdec =3D BIT(7) | (stmpe_pwm->lastduty - val);
> +			/* Step to desired value, smoothly */
> +			program[0] =3D BIT(14) | BIT(8) | incdec;
> +			/* Loop eternally */
> +			program[1] =3D BIT(15) | BIT(13);
> +		}
> +
> +		dev_dbg(chip->dev, "PWM%d: val =3D %02x, lastduty =3D %02x, "
> +			"program=3D%04x,%04x,%04x\n", pwm->hwpwm, val,
> +			stmpe_pwm->lastduty, program[0], program[1],
> +			program[2]);
> +		stmpe_pwm->lastduty =3D val;
> +	}
> +
> +	/*
> +	 * We can write programs of up to 64 16-bit words into this
> +	 * channel.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(program); i++) {
> +		u8 val;
> +
> +		val =3D (program[i] >> 8) & 0xFF;
> +		ret =3D stmpe_reg_write(stmpe_pwm->stmpe, reg, val);
> +		if (ret) {
> +			dev_err(chip->dev, "error writing reg\n");

Perhaps you want to say which register you failed to read...

> +			return ret;
> +		}
> +		val =3D program[i] & 0xFF;
> +		ret =3D stmpe_reg_write(stmpe_pwm->stmpe, reg, val);
> +		if (ret) {
> +			dev_err(chip->dev, "error writing reg\n");

=2E.. and write?

> +			return ret;
> +		}
> +	}
> +	/* If we were enabled, re-enable this PWM */
> +	if (enabled)
> +		stmpe_24xx_pwm_enable(chip, pwm);
> +
> +	/* Sleep for 200ms so we're sure it will take effect */
> +	msleep(200);
> +
> +	dev_dbg(chip->dev, "programmed PWM%d, %d bytes\n",
> +		pwm->hwpwm, i);

pwm->hwpwm is unsigned, so %u. Same for i when you turn that into
unsigned int.

> +	return 0;
> +}
[...]
> +static int stmpe_pwm_probe(struct platform_device *pdev)
> +{
> +	struct stmpe *stmpe =3D dev_get_drvdata(pdev->dev.parent);
> +	struct stmpe_pwm *pwm;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->stmpe =3D stmpe;
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.base =3D pdev->id;

Why would you need to hard-code the base? Doesn't dynamic allocation
work for you?

Also, since the device is instantiated as a child of an MFD, won't it
end up with -1 anyway?

> +	if (stmpe->partnum =3D=3D STMPE2401 || stmpe->partnum =3D=3D STMPE2403)=
 {
> +		pwm->chip.ops =3D &stmpe_24xx_pwm_ops;
> +		pwm->chip.npwm =3D 3;
> +	} else if (stmpe->partnum =3D=3D STMPE1601) {
> +		dev_err(&pdev->dev, "STMPE1601 PWM not yet supported\n");
> +		return -EINVAL;
> +	} else {
> +		dev_err(&pdev->dev, "Unsupported STMPE PWM\n");
> +		return -EINVAL;
> +	}

Perhaps -ENODEV? Though I don't understand why we need to do this here.
I guess I've become used to enabling support via compatible strings so
much that these constructs look strange to me.

> +
> +	ret =3D stmpe_enable(stmpe, STMPE_BLOCK_PWM);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret)
> +		return ret;

Don't you need to disable the PWM block here again?

> +
> +	dev_info(&pdev->dev, "STMPE PWM registered\n");

I don't think this is warranted. Let the user know if there's been an
error, but no need to brag if everything went well. They're supposed to.

Thierry

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW3U9zAAoJEN0jrNd/PrOhcU4QAIgCU0/caA295YCjIdLcDQAl
T4ZxxQbAD+W8ZDNdUe2jF+SftS2idg9LL8vZhrEV5etFRNJ2YVRx9/j02WVRfDWG
iDzJvWzu6KG82QM+Mfa9YZ3h+taReRfvBm84YXUaZwSQgG6n0d8PKZYSOjWXAxH/
Z3QN2I9RCXZBDvYoM+Dwi6oh/jqtIxjmTYRzszMvIy+jlu+OIWi3PLaGA62ukW9d
qr0YPhquV4cP2k66/yCk3+6CPy3UWad3AZojM1cbGa65k959ZAl6v7B7M8pngG/c
EtikXJNsLKDw6SsdZ63G15kMZ53VRGiv5uMXwQaDQAy0KLlur3zYTOJ4Yox+ID2T
Qc9hG+kv69Z92HsZUflS6NBSKoRbWMWL0URAq+GvTkXqy+9CVgyjahb7JjdJAxoO
UnieAa9/82zVRxI8bxGPC4K++9XSOwgmxWRZnUXz+INOpYPX7VXyXQdPwSAw8o0K
eQuAUUhV8HJilwJb/1uE4osCSporALbgTE39LTokYTU588EO4gkFZU5X4DBm4xoo
ORj7v3vsLPiu1Nl+S16arP4iexS1Gj+KNz4fjxyekxI2AidjwkBoFiPVIzkH5DUa
pOGat64RIKu3uUXxsm7xertQIc1UZ1+12WjMiCNgS4m3UMyOE+WbcjbwGQsBfN00
J8kc244UnDO/Xy2uqY5M
=q4bg
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
