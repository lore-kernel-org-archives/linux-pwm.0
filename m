From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/8] drivers/mfd: ADD PWM lookup table for CRC PMIC based
 PWM
Date: Wed, 29 Apr 2015 15:24:51 +0100
Message-ID: <20150429142451.GS9169@x1>
References: <1430316005-16480-1-git-send-email-shobhit.kumar@intel.com>
 <1430316005-16480-6-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33194 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966088AbbD2OY4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Apr 2015 10:24:56 -0400
Received: by wief7 with SMTP id f7so41552326wie.0
        for <linux-pwm@vger.kernel.org>; Wed, 29 Apr 2015 07:24:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430316005-16480-6-git-send-email-shobhit.kumar@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>

On Wed, 29 Apr 2015, Shobhit Kumar wrote:

> On some BYT PLatform the PWM is controlled using CRC PMIC. Add a look=
up
> entry for the same to be used by the consumer (Intel GFX)
>=20
> v2: Remove the lookup table on driver unload (Thierry)
>=20
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

How do you expect this set to be managed?

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_so=
c_pmic_core.c
> index f3d918e..a00ddd9 100644
> --- a/drivers/mfd/intel_soc_pmic_core.c
> +++ b/drivers/mfd/intel_soc_pmic_core.c
> @@ -25,6 +25,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/intel_soc_pmic.h>
>  #include <linux/gpio/machine.h>
> +#include <linux/pwm.h>
>  #include "intel_soc_pmic_core.h"
> =20
>  /* Lookup table for the Panel Enable/Disable line as GPIO signals */
> @@ -37,6 +38,11 @@ static struct gpiod_lookup_table panel_gpio_table =
=3D {
>  	},
>  };
> =20
> +/* PWM consumed by the Intel GFX */
> +static struct pwm_lookup crc_pwm_lookup[] =3D {
> +	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_backlight", =
0, PWM_POLARITY_NORMAL),
> +};
> +
>  static int intel_soc_pmic_find_gpio_irq(struct device *dev)
>  {
>  	struct gpio_desc *desc;
> @@ -99,6 +105,9 @@ static int intel_soc_pmic_i2c_probe(struct i2c_cli=
ent *i2c,
>  	/* Add lookup table binding for Panel Control to the GPIO Chip */
>  	gpiod_add_lookup_table(&panel_gpio_table);
> =20
> +	/* Add lookup table for crc-pwm */
> +	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> +
>  	ret =3D mfd_add_devices(dev, -1, config->cell_dev,
>  			      config->n_cell_devs, NULL, 0,
>  			      regmap_irq_get_domain(pmic->irq_chip_data));
> @@ -121,6 +130,9 @@ static int intel_soc_pmic_i2c_remove(struct i2c_c=
lient *i2c)
>  	/* Remove lookup table for Panel Control from the GPIO Chip */
>  	gpiod_remove_lookup_table(&panel_gpio_table);
> =20
> +	/* remove crc-pwm lookup table */
> +	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> +
>  	mfd_remove_devices(&i2c->dev);
> =20
>  	return 0;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
