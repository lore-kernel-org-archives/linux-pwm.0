From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V8 3/3] Input: new da7280 haptic driver
Date: Fri, 14 Feb 2020 01:35:50 +0000
Message-ID: <VE1PR10MB3085C12BDD9B0713A5A1772785150@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1581383604.git.Roy.Im@diasemi.com>
 <ba04fc95afbf3d77a49ad6d52ade20fe79a4b7eb.1581383604.git.Roy.Im@diasemi.com>
 <20200211142622.5vt34ftdt242agaq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20200211142622.5vt34ftdt242agaq@pengutronix.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tuesday, February 11, 2020 11:26 PM, Uwe Kleine-K=F6nig wrote

> On Tue, Feb 11, 2020 at 10:13:24AM +0900, Roy Im wrote:
> > diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> > new file mode 100644 index 0000000..4d1d1fc
> > --- /dev/null
> > +++ b/drivers/input/misc/da7280.c
> > @@ -0,0 +1,1688 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * DA7280 Haptic device driver
> > + *
> > + * Copyright (c) 2019 Dialog Semiconductor.
> > + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>  */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/uaccess.h>
> > +#include "da7280.h"
>=20
> Don't introduce a header file that is only used once. Better put the defi=
nitions into the c file then.

I will put the definitions into the c file.

>=20
> > [...]
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics) {
> > +	struct pwm_args pargs;
> > +	u64 period_mag_multi;
> > +	unsigned int pwm_duty;
> > +	int error;
> > +
> > +	pwm_get_args(haptics->pwm_dev, &pargs);
> > +	period_mag_multi =3D
> > +		(u64)(pargs.period * haptics->gain);
>=20
> This cast does not do anything, does it?

I will remove this.

>=20
> > +	if (haptics->acc_en)
> > +		pwm_duty =3D
> > +			(unsigned int)(period_mag_multi >> 16);
> > +	else
> > +		pwm_duty =3D
> > +			(unsigned int)((period_mag_multi >> 16)
> > +				+ pargs.period) / 2;
> > +
> > +	error =3D pwm_config(haptics->pwm_dev,
> > +			   pwm_duty, pargs.period);
> > +	if (error) {
> > +		dev_err(haptics->dev,
> > +			"failed to configure pwm : %d\n", error);
> > +		return error;
> > +	}
> > +
> > +	error =3D pwm_enable(haptics->pwm_dev);
> > +	if (error) {
> > +		pwm_disable(haptics->pwm_dev);
> > +		dev_err(haptics->dev,
> > +			"failed to enable haptics pwm device : %d\n", error);
> > +	}
>=20
> You should not use the legacy pwm API. Please stick to pwm_apply_state().
>=20
> Also consider using %pE for more expressive error messages.

I will replace the legacy pwm API and stick to pwm_apply_state() and consid=
er using the %pE.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Hello Uwe,

Thanks for your comments.
I will try to update as you advise.

Best regards,
Roy
