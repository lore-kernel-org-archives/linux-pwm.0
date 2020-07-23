From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V17 3/3] Input: new da7280 haptic driver
Date: Thu, 23 Jul 2020 13:55:02 -0700
Message-ID: <ad4f8a07-9e78-ce97-021f-094210d99a3c@infradead.org>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgGWUzK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 16:55:10 -0400
In-Reply-To: <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On 7/23/20 8:01 AM, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
> 
> Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> 
> 
>  drivers/input/misc/Kconfig  |   13 +
>  drivers/input/misc/Makefile |    1 +
>  drivers/input/misc/da7280.c | 1840 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1854 insertions(+)
>  create mode 100644 drivers/input/misc/da7280.c
> 

> diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> new file mode 100644
> index 0000000..6e3ead5
> --- /dev/null
> +++ b/drivers/input/misc/da7280.c
> @@ -0,0 +1,1840 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DA7280 Haptic device driver
> + *
> + * Copyright (c) 2020 Dialog Semiconductor.
> + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/workqueue.h>
> +#include <linux/uaccess.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +

...


> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
> +{
> +	struct pwm_state state;
> +	u64 period_mag_multi;
> +	int error;
> +
> +	if (!haptics->gain && enabled) {
> +		dev_err(haptics->dev,
> +			"Please set the gain first for the pwm mode\n");
> +		return -EINVAL;
> +	}
> +
> +	pwm_get_state(haptics->pwm_dev, &state);
> +	state.enabled = enabled;
> +	if (enabled) {
> +		period_mag_multi = (u64)state.period * haptics->gain;
> +		period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
> +
> +		/* The interpretation of duty cycle depends on the acc_en,
> +		 * it should be between 50% and 100% for acc_en = 0.
> +		 * See datasheet 'PWM mode' section.
> +		 */

from coding-style.rst:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

(except for networking code)

Please fix multiple locations.


thanks.
-- 
~Randy
