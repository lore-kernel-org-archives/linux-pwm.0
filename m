From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: add the proper PWM resources
Date: Mon, 15 Feb 2016 08:30:35 +0000
Message-ID: <20160215083035.GC3455@x1>
References: <1455455227-16848-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35487 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcBOIak (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Feb 2016 03:30:40 -0500
Received: by mail-wm0-f53.google.com with SMTP id c200so101082966wme.0
        for <linux-pwm@vger.kernel.org>; Mon, 15 Feb 2016 00:30:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455455227-16848-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Sun, 14 Feb 2016, Linus Walleij wrote:

> This adds the PWM resources to the STMPE MFD driver, so that
> it can properly grab and use them.
>=20
> Cc: linux-pwm@vger.kernel.org
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog: split this patch off from the PWM driver and sent
> separately. This can be merged separately too so we need no
> criss-cross between MFD and PWM anymore, Lee: this one is for
> you if it looks all right, excess newlines are gone too.
> ---
>  drivers/mfd/stmpe.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Applied, thanks.
=20
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 8222e374e4b1..fb8f9e8b75df 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -334,6 +334,31 @@ static const struct mfd_cell stmpe_keypad_cell =3D=
 {
>  };
> =20
>  /*
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
> +
> +static const struct mfd_cell stmpe_pwm_cell =3D {
> +	.name		=3D "stmpe-pwm",
> +	.of_compatible  =3D "st,stmpe-pwm",
> +	.resources	=3D stmpe_pwm_resources,
> +	.num_resources	=3D ARRAY_SIZE(stmpe_pwm_resources),
> +};
> +
> +/*
>   * STMPE801
>   */
>  static const u8 stmpe801_regs[] =3D {
> @@ -537,6 +562,11 @@ static struct stmpe_variant_block stmpe1601_bloc=
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
> @@ -771,6 +801,11 @@ static struct stmpe_variant_block stmpe24xx_bloc=
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
> =20
>  static int stmpe24xx_enable(struct stmpe *stmpe, unsigned int blocks=
,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
