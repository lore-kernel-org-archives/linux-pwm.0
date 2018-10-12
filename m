From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: =?utf-8?Q?=5BRCF=C2=A0PATC?= =?utf-8?Q?H?= v2 2/2] pwm: imx:
 Configure output to GPIO in disabled state
Date: Fri, 12 Oct 2018 18:00:37 +0200
Message-ID: <20181012160037.GH31561@ulmo>
References: <1539163920-9442-1-git-send-email-michal.vokac@ysoft.com>
 <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 09:33:26AM +0000, Vok=C3=A1=C4=8D Michal wrote:
> Normally the PWM output is held LOW when PWM is disabled. This can cause
> problems when inverted PWM signal polarity is needed. With this behavior
> the connected circuit is fed by 100% duty cycle instead of being shut-off.
>=20
> Allow users to define a "gpio" and a "pwm" pinctrl states. The pwm pinctrl
> state is then selected when PWM is enabled and the gpio pinctrl state is
> selected when PWM is disabled. Also add a new pwm-gpios GPIO that is used
> to drive the output in the gpio state.
>=20
> If all the pinctrl states and the pwm-gpios are not correctly specified
> in DT the logic will work as before.
>=20
> As an example, with this patch a PWM controlled backlight with inversed
> signal polarity can be used in full brightness range. Without this patch
> the backlight can not be turned off as brightness =3D 0 disables the PWM
> and that in turn set PWM output LOW, that is full brightness.
>=20
> Output of the PWM with "default" pinctrl and with "pwm"+"gpio" pinctrl:
>=20
> +--------------+------------+---------------+---------------------------+
> | After reset  | Bootloader | Linux pinctrl | User (sysfs, backlight..) |
> | 100k pull-up | (not used) |               |   enable    |   disable   |
> +--------------+------------+---------------+---------------------------+
>  ___________________________    default        _   _   _
>                             |_________________| |_| |_| |_|_____________
>=20
>                                pwm + gpio
>  ___________________________________________   _   _   _   _____________
>                                             |_| |_| |_| |_|
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
> Changes in v2:
>  - Utilize the "pwm" and "gpio" pinctrl states.
>  - Use the pwm-gpios signal to drive the output in "gpio" pinctrl state.
>  - Select the right pinctrl state in probe.=20
>=20
>  drivers/pwm/pwm-imx.c | 86 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 86 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 6cd3b72..3502123 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -10,11 +10,13 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
> @@ -92,10 +94,45 @@ struct imx_chip {
>  	void __iomem	*mmio_base;
> =20
>  	struct pwm_chip	chip;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_pins_gpio;
> +	struct pinctrl_state *pinctrl_pins_pwm;
> +	struct gpio_desc *pwm_gpiod;
>  };
> =20
> +
>  #define to_imx_chip(chip)	container_of(chip, struct imx_chip, chip)
> =20
> +static int imx_pwm_init_pinctrl_info(struct imx_chip *imx_chip,
> +		struct platform_device *pdev)
> +{
> +	imx_chip->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> +	if (!imx_chip->pinctrl || IS_ERR(imx_chip->pinctrl)) {

This is not correct. First, I don't think devm_pinctrl_get() will ever
return NULL, so the !imx_chip->pinctrl is useless. And if it did return
NULL and imx_chip->pinctrl could therefore be NULL, then...

> +		dev_info(&pdev->dev, "can not get pinctrl\n");
> +		return PTR_ERR(imx_chip->pinctrl);

=2E.. this is rubbish because it returns PTR_ERR(NULL) which is 0 and that
represents success.

While at it, dev_info() -> dev_err() might be more appropriate here. Or
if you want to make pinctrl support optional make this dev_dbg() like
the message further below.

> +	}
> +
> +	imx_chip->pinctrl_pins_pwm =3D pinctrl_lookup_state(imx_chip->pinctrl,
> +			"pwm");
> +	imx_chip->pinctrl_pins_gpio =3D pinctrl_lookup_state(imx_chip->pinctrl,
> +			"gpio");
> +	imx_chip->pwm_gpiod =3D devm_gpiod_get_optional(&pdev->dev, "pwm",
> +			GPIOD_IN);
> +
> +	if (PTR_ERR(imx_chip->pwm_gpiod) =3D=3D -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(imx_chip->pwm_gpiod) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_pwm) ||
> +		   IS_ERR(imx_chip->pinctrl_pins_gpio)) {
> +		dev_dbg(&pdev->dev, "PWM pinctrl information incomplete\n");

Another option would be to make this (and the above) dev_warn() since we
do want people to update the DTB if at all possible. Without the DTB the
PWM could be susceptible to the issue that we're trying to fix.

Thierry

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAxSUACgkQ3SOs138+
s6EfoBAAnYEVc7DcFSV5KMlf1NkzSA5dNVXkMFfFQKZqg4ZyldDhkXhh171nE8Qb
2gCqIbw/AaOqIFfIHtpCxlXchO6vKbMzWQgAyMQSfswjqZq5K6EMyTZr9LwbcUHd
Ianvbz+nv4Kd/0SJ7UVtHB+MLuO2TFcGPtsrkCgvRmAFWyWtL7o/HTV3HvjlL3Sj
aTkhKv2Z3y0FGuKSKygGfftFueWxGq9J2b9qf/fABIxsvmsx4hVd8YIdFPGXF34J
z/e8WzYpRGlQcVz2tiMTwwPfu1rfs1APhnVabi/y1kwqFyIjULcKPKb7hfPx6LKL
ZDDgMLQ3aWABnO+lJWI1kIVsriHNZYLXja+2XQIJ9uMnW+K4gf24Lbq7mA3x3NBU
pz1sT78/6x5y3Phmq3WUXvCYMSeN0ExEKLrnVka+UFMp3f253ZxzS2aMNT79U4QP
OO0oGwOpwPjW84iy6BXPcHHnbfKBZ1EBxd+qEkwhM+QnyhpcKWN/AYOU3ROasptp
3UTnEGDLsu0QrBuwUIJDbi+vsozO8GpRbhPm3MNoDn2ZmaMwwv4ojiNxSSiTf11L
EwufbGY+Jr8mxflK4rNdFdLYAzmLP3Zgg4hl7zwT5Gj/2sa/UX90273OD3N3CKev
Es+Mkr1qnNtALSL4YVLtCec30EK3Y/2kwIE0XaUsjvwFm+BOAYQ=
=pv8N
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
