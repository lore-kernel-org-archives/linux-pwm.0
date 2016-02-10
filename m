From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] pwm: add a driver for the STMPE PWM
Date: Wed, 10 Feb 2016 16:06:12 +0000
Message-ID: <20160210160612.GD26950@x1>
References: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
 <1455094468-25521-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34297 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcBJQGR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 11:06:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id 128so33131856wmz.1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 08:06:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455094468-25521-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Wed, 10 Feb 2016, Linus Walleij wrote:

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
> Lee could you ACK the few lines added to drivers/mfd/stmpe.c
> so that the PWM maintainers can take this through their tree?

Hells no! ;)

> Thanks.
> ---
>  drivers/mfd/stmpe.c     |  37 ++++++
>  drivers/pwm/Kconfig     |   7 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stmpe.c | 297 ++++++++++++++++++++++++++++++++++++++=
++++++++++

Any reason why you're bundling up changes in two subsystems?

>  4 files changed, 342 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stmpe.c
>=20
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 8222e374e4b1..4eb08e0471f8 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -333,6 +333,33 @@ static const struct mfd_cell stmpe_keypad_cell =3D=
 {
>  	.num_resources	=3D ARRAY_SIZE(stmpe_keypad_resources),
>  };
> =20
> +

Superflous '\n'.

> +/*
> + * PWM (1601, 2401, 2403)
> + */
> +static struct resource stmpe_pwm_resources[] =3D {
> +	{
> +		.name	=3D "PWM0",
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +	{
> +		.name	=3D "PWM1",
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +	{
> +		.name	=3D "PWM2",
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};

I prefer the DEFINE_RES_* stuff these days.

> +static const struct mfd_cell stmpe_pwm_cell =3D {
> +	.name		=3D "stmpe-pwm",
> +	.of_compatible  =3D "st,stmpe-pwm",
> +	.resources	=3D stmpe_pwm_resources,
> +	.num_resources	=3D ARRAY_SIZE(stmpe_pwm_resources),
> +};
> +
> +

What's with the '\n\n'?

>  /*
>   * STMPE801
>   */
> @@ -537,6 +564,11 @@ static struct stmpe_variant_block stmpe1601_bloc=
ks[] =3D {
>  		.irq	=3D STMPE1601_IRQ_KEYPAD,
>  		.block	=3D STMPE_BLOCK_KEYPAD,
>  	},
> +	{
> +		.cell	=3D &stmpe_pwm_cell,
> +		.irq	=3D STMPE1601_IRQ_PWM0,
> +		.block	=3D STMPE_BLOCK_PWM,
> +	},
>  };
> =20
>  /* supported autosleep timeout delay (in msecs) */
> @@ -771,6 +803,11 @@ static struct stmpe_variant_block stmpe24xx_bloc=
ks[] =3D {
>  		.irq	=3D STMPE24XX_IRQ_KEYPAD,
>  		.block	=3D STMPE_BLOCK_KEYPAD,
>  	},
> +	{
> +		.cell	=3D &stmpe_pwm_cell,
> +		.irq	=3D STMPE24XX_IRQ_PWM0,
> +		.block	=3D STMPE_BLOCK_PWM,
> +	},
>  };

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
