From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Date: Tue, 26 May 2020 13:05:53 +0100
Message-ID: <81646862-8cbd-95f1-506d-ea375e365d69@nvidia.com>
References: <1590492335-25857-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3097 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgEZMF6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 08:05:58 -0400
In-Reply-To: <1590492335-25857-1-git-send-email-spatra@nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sandipan Patra <spatra@nvidia.com>, treding@nvidia.com, u.kleine-koenig@pengutronix.de
Cc: bbasu@nvidia.com, ldewangan@nvidia.com, kyarlagadda@nvidia.com, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


On 26/05/2020 12:25, Sandipan Patra wrote:
> Added support for dynamic clock freq configuration in pwm kernel driver.
> Earlier the pwm driver used to cache boot time clock rate by pwm clock
> parent during probe. Hence dynamically changing pwm frequency was not
> possible for all the possible ranges. With this change, dynamic calculati=
on
> is enabled and it is able to set the requested period from sysfs knob
> provided the value is supported by clock source.
>=20
> Changes mainly have 2 parts:
>   - T186 and later chips [1]
>   - T210 and prior chips [2]
>=20
> For [1] - Changes implemented to set pwm period dynamically and
>           also checks added to allow only if requested period(ns) is
>           below or equals to higher range.
>=20
> For [2] - Only checks if the requested period(ns) is below or equals
>           to higher range defined by max clock limit. The limitation
>           in T210 or prior chips are due to the reason of having only
>           one pwm-controller supporting multiple channels. But later
>           chips have multiple pwm controller instances each having
> 	  single channel support.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>=20
> PATCH V3:
> 1. Return -EINVAL if requested period does not fall inside limit.
> 2. Store the new clock rate for further references.
> 3. Varible name change reverted.
> 4. Comments corrected and new comments are added.
>=20
>  drivers/pwm/pwm-tegra.c | 85 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 80 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index d26ed8f..c6e5dcf 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -4,8 +4,35 @@
>   *
>   * Tegra pulse-width-modulation controller driver
>   *
> - * Copyright (c) 2010, NVIDIA Corporation.
> - * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix=
.de>

We should not remove the above line as this is giving credit to the
above developer.

> + * Copyright (c) 2010-2020, NVIDIA Corporation.
> + *
> + * Overview of Tegra Pulse Width Modulator Register:
> + * 1. 13-bit: Frequency division (SCALE)
> + * 2. 8-bit : Puls division (DUTY)
> + * 3. 1-bit : Enable bit
> + *
> + * The PWM clock frequency is divided by 256 before subdividing it based
> + * on the programmable frequency division value to generate the required
> + * frequency for PWM output. The maximum output frequency that can be
> + * achieved is (max rate of source clock) / 256.
> + * e.g. if source clock rate is 408 MHz, maximum output frequency can be=
:
> + * 408 MHz/256 =3D 1.6 MHz.
> + * This 1.6 MHz frequency can further be divided using SCALE value in PW=
M.
> + *
> + * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
> + * To achieve 100% duty cycle, program Bit [24] of this register to
> + * 1=E2=80=99b1. In which case the other bits [23:16] are set to don't c=
are.
> + *
> + * Limitations:
> + * -	When PWM is disabled, the output is driven to inactive.
> + * -	It does not allow the current PWM period to complete and
> + *	stops abruptly.
> + *
> + * -	If the register is reconfigured while PWM is running,
> + *	it does not complete the currently running period.
> + *
> + * -	If the user input duty is beyond acceptible limits,
> + *	-EINVAL is returned.
>   */
> =20
>  #include <linux/clk.h>
> @@ -41,6 +68,7 @@ struct tegra_pwm_chip {
>  	struct reset_control*rst;
> =20
>  	unsigned long clk_rate;
> +	unsigned long min_period_ns;
> =20
>  	void __iomem *regs;
> =20
> @@ -68,7 +96,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  {
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>  	unsigned long long c =3D duty_ns, hz;
> -	unsigned long rate;
> +	unsigned long rate, required_clk_rate;
>  	u32 val =3D 0;
>  	int err;
> =20
> @@ -83,9 +111,51 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	val =3D (u32)c << PWM_DUTY_SHIFT;
> =20
>  	/*
> +	 *  Period in nano second has to be <=3D highest allowed period
> +	 *  based on max clock rate of the pwm controller.
> +	 *
> +	 *  higher limit =3D max clock limit >> PWM_DUTY_WIDTH
> +	 *  lower limit =3D min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDT=
H

Not sure why we mention the lower limit if we are not testing this
condition. Does not appear to be relevant here. Or should we be checking
this as well?

> +	 */
> +	if (period_ns < pc->min_period_ns)
> +		return -EINVAL;

Something does not seem right here. If this is the highest allowed
period, shouldn't this variable be called 'max_period_ns'?

> +
> +	/*
>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
> +	 *
> +	 * num_channels: If single instance of PWM controller has multiple
> +	 * channels (e.g. Tegra210 or older) then it is not applicable to

s/applicable/possible

> +	 * configure separate clock rates to each of the channels, in such
> +	 * case the value stored during probe will be referred.
> +	 *
> +	 * If every PWM controller instance has one channel respectively, i.e.
> +	 * nums_channels =3D=3D 1 then only the clock rate can be modified
> +	 * dynamically (e.g. Tegra186 or Tegra194).
>  	 */
> +	if (pc->soc->num_channels =3D=3D 1) {
> +		/*
> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
> +		 * with the highest applicable rate that the controller can

s/applicable/possible

> +		 * provide. Any further lower value can be derived by setting
> +		 * PFM bits[0:12].
> +		 *
> +		 * required_clk_rate is a reference rate for source clock and
> +		 * it is derived based on user requested period. By setting the
> +		 * source clock rate as required_clk_rate, PWM controller will
> +		 * be able to configure the requested period.
> +		 */
> +		required_clk_rate =3D
> +			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> +
> +		err =3D clk_set_rate(pc->clk, required_clk_rate);
> +		if (err < 0)
> +			return -EINVAL;
> +
> +		/* Store the new rate for further references */
> +		pc->clk_rate =3D clk_get_rate(pc->clk);
> +	}
> +
>  	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;=20
> =20
>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> @@ -94,7 +164,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
> =20
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider
> -	 * field minus 1, we need to decrement to get the correct value to
> +	 * field plus 1, we need to decrement to get the correct value to

Technically, this is a comment fix not related to the current change and
so should be a separate patch. However, I will defer to Thierry on how
he would prefer to handle this.

Cheers
Jon

--=20
nvpublic
