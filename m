Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:13536
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbfHHDw5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Aug 2019 23:52:57 -0400
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 8 Aug 2019 03:52:52 +0000
Message-ID: <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
In-Reply-To: <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: RE: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Uwe,

Thank you for your review!

> From: Uwe Kleine-K=F6nig, Sent: Wednesday, August 7, 2019 4:03 PM
>=20
> Hello,
>=20
> On Mon, Jul 08, 2019 at 06:07:47PM +0900, Yoshihiro Shimoda wrote:
> > The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
> > adds gpio support to output it.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pwm/pwm-rcar.c | 36 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
> I'd like to see a paragraph at the top of the driver describing the
> limitations of this driver similar to what pwm-sifive.c does.
>=20
> Something like:
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 5b2b8ecc354c..b67ac84db834 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -3,6 +3,9 @@
>   * R-Car PWM Timer driver
>   *
>   * Copyright (C) 2015 Renesas Electronics Corporation
> + *
> + * Limitations:
> + * - The hardware cannot generate a 0% duty cycle.
>   */

I'll add this.

>  #include <linux/clk.h>
>=20
> While at it: If there is a publicly available reference manual adding a l=
ine:
>=20
> 	Reference Manual: https://...
>=20
> would be great, too.

Unfortunately, the document is not public...

> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > index c8cd43f..1c19a8b 100644
> > --- a/drivers/pwm/pwm-rcar.c
> > +++ b/drivers/pwm/pwm-rcar.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> >  #include <linux/math64.h>
> > @@ -38,6 +39,7 @@ struct rcar_pwm_chip {
> >  	struct pwm_chip chip;
> >  	void __iomem *base;
> >  	struct clk *clk;
> > +	struct gpio_desc *gpio;
> >  };
> >
> >  static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *=
chip)
> > @@ -119,8 +121,11 @@ static int rcar_pwm_set_counter(struct rcar_pwm_ch=
ip *rp, int div, int duty_ns,
> >  	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> >
> >  	/* Avoid prohibited setting */
> > -	if (cyc =3D=3D 0 || ph =3D=3D 0)
> > +	if (cyc =3D=3D 0)
> >  		return -EINVAL;
> > +	/* Try to use GPIO to output duty zero */
> > +	if (ph =3D=3D 0)
> > +		return -EAGAIN;
>=20
> If there is no gpio requesting cyc=3D0 should still yield an error.

I'm sorry, I cannot understand this.

> >  	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> >
> > @@ -157,6 +162,28 @@ static void rcar_pwm_disable(struct rcar_pwm_chip =
*rp)
> >  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> >  }
> >
> > +static int rcar_pwm_gpiod_get(struct rcar_pwm_chip *rp)
> > +{
> > +	if (rp->gpio)
> > +		return 0;
> > +
> > +	rp->gpio =3D gpiod_get(rp->chip.dev, "renesas,duty-zero", GPIOD_OUT_L=
OW);
> > +	if (!IS_ERR(rp->gpio))
> > +		return 0;
> > +
> > +	rp->gpio =3D NULL;
> > +	return -EINVAL;
>=20
> Please use gpiod_get_optional() instead of open coding it.

I got it.

> Does getting the gpio automatically switch the pinmuxing?
>=20
> If yes, this is IMHO a really surprising mis-feature of the gpio
> subsystem. I'd prefer to "get" the gpio at probe time and only switch
> the pinmuxing in .apply(). This makes .apply() quicker, ensures that all
> resources necessary for pwm operation are available, handles
> -EPROBE_DEFER (and maybe other errors) correctly.

The current pinctrl subsystem only has .set_mux(). I checked the pinctrl su=
bsystem
history and the commit 2243a87d90b42eb38bc281957df3e57c712b5e56 removed the=
 ".disable()" ops.
So, IIUC, we cannot such a handling.

> Note you're introducing a bug here because switching to gpio doesn't
> ensure that the currently running period is completed.

Umm, the hardware doesn't have such a condition so that the driver cannot m=
anage it.
So, I'll add this into the "Limitations" too.

> > +static void rcar_pwm_gpiod_put(struct rcar_pwm_chip *rp)
> > +{
> > +	if (!rp->gpio)
> > +		return;
> > +
> > +	gpiod_put(rp->gpio);
> > +	rp->gpio =3D NULL;
> > +}
> > +
> >  static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >  			  struct pwm_state *state)
> >  {
> > @@ -171,6 +198,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >
> >  	if (!state->enabled) {
> >  		rcar_pwm_disable(rp);
> > +		rcar_pwm_gpiod_put(rp);
>=20
> From the framework's POV disabling a PWM is quite similar to duty cycle
> 0. Assuming disabling the PWM completes the currently running period[1]
> it might be better and easier to disable instead of switching to gpio.
> (Further assuming that disable really yields the inactive level which is
> should and is another limitation if not.)

If we disable the hardware, the duty cycle is 100% unfortunately. So,
I think I should describe it as one of "Limitations".

> >  		return 0;
> >  	}
> >
> > @@ -187,8 +215,12 @@ static int rcar_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
> >  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> >
> > -	if (!ret)
> > +	if (!ret) {
> >  		ret =3D rcar_pwm_enable(rp);
> > +		rcar_pwm_gpiod_put(rp);
> > +	} else if (ret =3D=3D -EAGAIN) {
> > +		ret =3D rcar_pwm_gpiod_get(rp);
> > +	}
> >
> >  	return ret;
> >  }
>=20
> Best regards
> Uwe
>=20
> [1] if not, please add "Disabling doesn't complete the currently running
>     period" to the list of limitations.

Yeah, the hardware will complete the currently running period, but as I sai=
d,
the hardware doesn't have such a condition, so that the driver's .apply()
returns immediately without the completion. So, I'll add it as a Limitation=
.

Best regards,
Yoshihiro Shimoda

> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
