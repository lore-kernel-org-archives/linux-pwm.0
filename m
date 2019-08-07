Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfHGHDf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Aug 2019 03:03:35 -0400
Date: Wed, 7 Aug 2019 09:03:26 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

On Mon, Jul 08, 2019 at 06:07:47PM +0900, Yoshihiro Shimoda wrote:
> The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
> adds gpio support to output it.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

I'd like to see a paragraph at the top of the driver describing the
limitations of this driver similar to what pwm-sifive.c does.

Something like:

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 5b2b8ecc354c..b67ac84db834 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -3,6 +3,9 @@
  * R-Car PWM Timer driver
  *
  * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * Limitations:
+ * - The hardware cannot generate a 0% duty cycle.
  */
=20
 #include <linux/clk.h>

While at it: If there is a publicly available reference manual adding a lin=
e:

	Reference Manual: https://...

would be great, too.

> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index c8cd43f..1c19a8b 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/log2.h>
>  #include <linux/math64.h>
> @@ -38,6 +39,7 @@ struct rcar_pwm_chip {
>  	struct pwm_chip chip;
>  	void __iomem *base;
>  	struct clk *clk;
> +	struct gpio_desc *gpio;
>  };
> =20
>  static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *ch=
ip)
> @@ -119,8 +121,11 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip=
 *rp, int div, int duty_ns,
>  	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> =20
>  	/* Avoid prohibited setting */
> -	if (cyc =3D=3D 0 || ph =3D=3D 0)
> +	if (cyc =3D=3D 0)
>  		return -EINVAL;
> +	/* Try to use GPIO to output duty zero */
> +	if (ph =3D=3D 0)
> +		return -EAGAIN;

If there is no gpio requesting cyc=3D0 should still yield an error.

>  	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> =20
> @@ -157,6 +162,28 @@ static void rcar_pwm_disable(struct rcar_pwm_chip *r=
p)
>  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
>  }
> =20
> +static int rcar_pwm_gpiod_get(struct rcar_pwm_chip *rp)
> +{
> +	if (rp->gpio)
> +		return 0;
> +
> +	rp->gpio =3D gpiod_get(rp->chip.dev, "renesas,duty-zero", GPIOD_OUT_LOW=
);
> +	if (!IS_ERR(rp->gpio))
> +		return 0;
> +
> +	rp->gpio =3D NULL;
> +	return -EINVAL;

Please use gpiod_get_optional() instead of open coding it.

Does getting the gpio automatically switch the pinmuxing?

If yes, this is IMHO a really surprising mis-feature of the gpio
subsystem. I'd prefer to "get" the gpio at probe time and only switch
the pinmuxing in .apply(). This makes .apply() quicker, ensures that all
resources necessary for pwm operation are available, handles
-EPROBE_DEFER (and maybe other errors) correctly.

Note you're introducing a bug here because switching to gpio doesn't
ensure that the currently running period is completed.

> +static void rcar_pwm_gpiod_put(struct rcar_pwm_chip *rp)
> +{
> +	if (!rp->gpio)
> +		return;
> +
> +	gpiod_put(rp->gpio);
> +	rp->gpio =3D NULL;
> +}
> +
>  static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			  struct pwm_state *state)
>  {
> @@ -171,6 +198,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
> =20
>  	if (!state->enabled) {
>  		rcar_pwm_disable(rp);
> +		rcar_pwm_gpiod_put(rp);

From the framework's POV disabling a PWM is quite similar to duty cycle
0. Assuming disabling the PWM completes the currently running period[1]
it might be better and easier to disable instead of switching to gpio.
(Further assuming that disable really yields the inactive level which is
should and is another limitation if not.)

>  		return 0;
>  	}
> =20
> @@ -187,8 +215,12 @@ static int rcar_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
>  	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> =20
> -	if (!ret)
> +	if (!ret) {
>  		ret =3D rcar_pwm_enable(rp);
> +		rcar_pwm_gpiod_put(rp);
> +	} else if (ret =3D=3D -EAGAIN) {
> +		ret =3D rcar_pwm_gpiod_get(rp);
> +	}
> =20
>  	return ret;
>  }

Best regards
Uwe

[1] if not, please add "Disabling doesn't complete the currently running
    period" to the list of limitations.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
