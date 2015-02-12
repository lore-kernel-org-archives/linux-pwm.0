From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] clk: Add PWM clock driver
Date: Thu, 12 Feb 2015 23:29:26 +0100
Message-ID: <20150212222923.GA23372@mithrandir>
References: <1418381269-26399-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418381269-26399-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mike Turquette <mturquette@linaro.org>, Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2014 at 11:47:49AM +0100, Philipp Zabel wrote:
> Some board designers, when running out of clock output pads, decide to
> (mis)use PWM output pads to provide a clock to external components.
> This driver supports this practice by providing an adapter between the
> PWM and clock bindings in the device tree. As the PWM bindings specify
> the period in the device tree, this is a fixed clock.

Typically the period is specified in DT because it is a board-level
characteristic. In this case where you emulate a clock using the PWM
channel you could simply ignore the period. After all you can freely
choose it during pwm_config() irrespective of the period specified in
DT.

Other than that looks mostly good to me, just a few nits below.

[...]
> diff --git a/Documentation/devicetree/bindings/clock/pwm-clock.txt b/Docu=
mentation/devicetree/bindings/clock/pwm-clock.txt
> new file mode 100644
> index 0000000..751fff5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/pwm-clock.txt
> @@ -0,0 +1,26 @@
> +Binding for an external clock signal driven by a PWM pin.
> +
> +This binding uses the common clock binding[1] and the common PWM binding=
[2].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/pwm/pwm.txt
> +
> +Required properties:
> +- compatible : shall be "pwm-clock".
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- pwms : from common PWM binding; this determines the clock frequency
> +  via the PWM period given in the pwm-specifier.

Perhaps: "the period given in the PWM specifier"?

> +Optional properties:
> +- clock-output-names : From common clock binding.
> +- clock-frequency : Exact output frequency, in case the pwm period

"PWM period"

> +  is not exact but was rounded to nanoseconds.

Does this make sense? For one it's now easy to specify two different
values for the frequency, one using the PWM specifier, the other with
clock-frequency. According to the above, clock-frequency takes
precedence, but in that case, what use is there in having the PWM
specifier?

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 455fd17..36a6918a 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -129,6 +129,13 @@ config COMMON_CLK_PALMAS
>  	  This driver supports TI Palmas devices 32KHz output KG and KG_AUDIO
>  	  using common clock framework.
> =20
> +config COMMON_CLK_PWM
> +	bool "Clock driver for PWMs used as clock outputs"
> +	depends on PWM
> +	---help---
> +	  Adapter driver so that any PWM output can be (mis)used as clock signal
> +	  at 50% duty cycle.

Any reason why this isn't tristate?

>  config COMMON_CLK_PXA
>  	def_bool COMMON_CLK && ARCH_PXA
>  	---help---
[...]
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> new file mode 100644
> index 0000000..c7d5652
> --- /dev/null
> +++ b/drivers/clk/clk-pwm.c
> @@ -0,0 +1,129 @@
> +/*
> + * Copyright (C) 2014 Philipp Zabel, Pengutronix
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * PWM (mis)used as clock output
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +struct clk_pwm {
> +	struct clk_hw hw;
> +	struct pwm_device *pwm;
> +	u32 fixed_rate;
> +};
> +
> +#define to_clk_pwm(_hw) container_of(_hw, struct clk_pwm, hw)

Perhaps use a static inline so you get proper type checking?

> +int clk_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct clk_init_data init;
> +	struct clk_pwm *clk_pwm;
> +	struct pwm_device *pwm;
> +	const char *clk_name;
> +	struct clk *clk;
> +	int ret;
> +
> +	clk_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
> +	if (!clk_pwm)
> +		return -ENOMEM;
> +
> +	pwm =3D devm_pwm_get(&pdev->dev, NULL);
> +	if (IS_ERR(pwm))
> +		return PTR_ERR(pwm);
> +
> +	if (!pwm || !pwm->period) {

I don't think there's a case where pwm can be NULL here.

> +		dev_err(&pdev->dev, "invalid pwm period\n");

"PWM"

> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> +		clk_pwm->fixed_rate =3D NSEC_PER_SEC / pwm->period;
> +
> +	if (pwm->period !=3D NSEC_PER_SEC / clk_pwm->fixed_rate &&
> +	    pwm->period !=3D DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
> +		dev_err(&pdev->dev,
> +			"clock-frequency does not match pwm period\n");

"PWM"

> +static struct platform_driver clk_pwm_driver =3D {
> +	.probe =3D clk_pwm_probe,
> +	.remove =3D clk_pwm_remove,
> +	.driver =3D {
> +		.name =3D "pwm-clock",
> +		.of_match_table =3D of_match_ptr(clk_pwm_dt_ids),
> +	},
> +};
> +
> +module_platform_driver(clk_pwm_driver);

This is missing MODULE_AUTHOR, MODULE_DESCRIPTION and MODULE_LICENSE.

Thierry

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU3Sk8AAoJEN0jrNd/PrOhLbwQALUcYU5oO9LqskAFV5zrzsuz
dHypoTs08KgKcRVckVc+fpPIYTTQJTvD6q5T/fnfWSocZ+AH/a014gCiJaxRSpf4
j7hScXG9hLDhmthzIYW1Lz2p8Jg70PDRreTmT6kdbMvcK/nIaZvk5c0ttabPtuLJ
TTREUOSDPktyki/CICB6mq2/+Wm8bfpuj+KefJT16EbxeUbsQyictnsDADLAJMsC
bI+/Fj5e8E0ARuqPukh0y1vOIlxiSUGjdd6haurZ3xBM4zwGYYjeZhcwOZvVFCzg
/DoD5G6NZwcvQpOxNUczOuFW6y5FQUrltYHiylxcwAGE3ukUaRvFOdwfpvgcrwwb
huVyygJT1dIH5ZWObsZbAc8mGdCkiu0wjemRF6EJITfpJRo2ByN8hbtaKX5yJgvT
1oWc6FQIAZiOTtGK35pK0oNi9iVJogLQjhhJB4EANrmWFKJ0f5m7sX/QWJKDJbbf
y0jTOafjWyhoUd6D7g/FiuAJRvRGFyGow6tHp5F7xv/v0fnX5KNsUsZArHADFFMo
rEjieVP8TL+mpb/rPxmrBfG70QHhn2eOk8OV/lPREpE/9+zOXHnQ+lWhYV0XADf7
qfc+1o5IurW3rwxoQT8D3U1v8TTJxFYfhAZZGL7DqXF/8KjKiMKRrDPQN96GBOuJ
/iQlC8mMEd76Ae1dwR5z
=gbiU
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
