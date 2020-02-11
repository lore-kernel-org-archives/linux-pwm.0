From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RESEND PATCH V8 3/3] Input: new da7280 haptic driver
Date: Tue, 11 Feb 2020 15:26:22 +0100
Message-ID: <20200211142622.5vt34ftdt242agaq@pengutronix.de>
References: <cover.1581383604.git.Roy.Im@diasemi.com>
 <ba04fc95afbf3d77a49ad6d52ade20fe79a4b7eb.1581383604.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ba04fc95afbf3d77a49ad6d52ade20fe79a4b7eb.1581383604.git.Roy.Im@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 11, 2020 at 10:13:24AM +0900, Roy Im wrote:
> diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> new file mode 100644
> index 0000000..4d1d1fc
> --- /dev/null
> +++ b/drivers/input/misc/da7280.c
> @@ -0,0 +1,1688 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DA7280 Haptic device driver
> + *
> + * Copyright (c) 2019 Dialog Semiconductor.
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
> +#include "da7280.h"

Don't introduce a header file that is only used once. Better put the
definitions into the c file then.

> [...]
> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics)
> +{
> +	struct pwm_args pargs;
> +	u64 period_mag_multi;
> +	unsigned int pwm_duty;
> +	int error;
> +
> +	pwm_get_args(haptics->pwm_dev, &pargs);
> +	period_mag_multi =
> +		(u64)(pargs.period * haptics->gain);

This cast does not do anything, does it?

> +	if (haptics->acc_en)
> +		pwm_duty =
> +			(unsigned int)(period_mag_multi >> 16);
> +	else
> +		pwm_duty =
> +			(unsigned int)((period_mag_multi >> 16)
> +				+ pargs.period) / 2;
> +
> +	error = pwm_config(haptics->pwm_dev,
> +			   pwm_duty, pargs.period);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to configure pwm : %d\n", error);
> +		return error;
> +	}
> +
> +	error = pwm_enable(haptics->pwm_dev);
> +	if (error) {
> +		pwm_disable(haptics->pwm_dev);
> +		dev_err(haptics->dev,
> +			"failed to enable haptics pwm device : %d\n", error);
> +	}

You should not use the legacy pwm API. Please stick to
pwm_apply_state().

Also consider using %pE for more expressive error messages.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
