From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] pwm: add support for atmel-hlcdc-pwm device
Date: Tue, 7 Oct 2014 10:45:16 +0200
Message-ID: <20141007084514.GE24254@ulmo>
References: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412604423-19329-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:48189 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbaJGIpT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 04:45:19 -0400
Content-Disposition: inline
In-Reply-To: <1412604423-19329-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 04:07:02PM +0200, Boris Brezillon wrote:
> The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,
> at91sam9x5 family or sama5d3 family) provide a PWM device.
>=20
> This driver add support for a PWM chip exposing a single PWM device (which
> will most likely be used to drive a backlight device).
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/Kconfig           |   9 ++
>  drivers/pwm/Makefile          |   1 +
>  drivers/pwm/pwm-atmel-hlcdc.c | 248 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 258 insertions(+)
>  create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c

Just noticed a couple more things.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index b800783..9bb331b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -50,6 +50,15 @@ config PWM_ATMEL
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-atmel.
> =20
> +config PWM_ATMEL_HLCDC_PWM
> +	tristate "Atmel HLCDC PWM support"
> +	select MFD_ATMEL_HLCDC
> +	help
> +	  Generic PWM framework driver for Atmel HLCDC PWM.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-atmel.

This should be "pwm-atmel-hlcdc".

> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
[...]
> +static int atmel_hlcdc_pwm_enable(struct pwm_chip *c, struct pwm_device =
*pwm)
> +{
> +	struct atmel_hlcdc_pwm *chip =3D to_atmel_hlcdc_pwm(c);
> +	struct atmel_hlcdc *hlcdc =3D chip->hlcdc;
> +	u32 status;
> +	int ret;
> +
> +	regmap_write(hlcdc->regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PWM);

I just noticed that regmap_write() can also fail. But perhaps that's
only for I2C or the like backends and you can indeed ignore it for MMIO
backends.

> +	do {
> +		usleep_range(1, 10);
> +		ret =3D regmap_read(hlcdc->regmap, ATMEL_HLCDC_SR, &status);
> +		if (ret)
> +			return ret;
> +	} while ((status & ATMEL_HLCDC_PWM) =3D=3D 0);

A slightly better loop might be to do the sleep only after you've
determined that the status bit isn't set. That way you avoid a needless
sleep if the status bit is immediately set or an error occurs during
read.

	while (true) {
		ret =3D regmap_read(...);
		if (ret)
			return ret;

		if (status & ATMEL_HLCDC_PWM)
			break;

		usleep_range(1, 10);
	}

> +static int atmel_hlcdc_pwm_remove(struct platform_device *pdev)
> +{
> +	struct atmel_hlcdc_pwm *chip =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D pwmchip_remove(&chip->chip);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(chip->hlcdc->periph_clk);

You might want to call clk_disable_unprepare() regardless of whether or
not pwmchip_remove() failed. You could simply leave out the above check
for ret and instead...

> +
> +	return 0;

"return ret;" here.

Thierry

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM6gZAAoJEN0jrNd/PrOhFk0P/RSq9bk+Z3vlzFK0nGYWdYAE
uRbIZOk6qd5r+bLdy1t7E/kAKy5NmgVt63v0XqnNv+wf5mLUXq4FM/AQ96qekqaF
KzikLMj+5ZXkpZkbc7gPWUu3nyOmKs6t4akIQfcULj921bxArVajT3x8gY13Kap8
3LZGDT+joDktzISvmZMrvi/BpMcLb+Fbn1bIYJASiOQif6uYAAFmtOy57qay8CIt
2HhZyXK2TyDic7ZBU2OnqB8Jbe/wcnQUm+i4P9t2ZmwHO6z9jDTTdmw3Agac46B6
V+BeJMx7xb92ZJ9ttGcGDXTyvTXEzYBsA7AiH96A5QOOI1QT6p7QVAbbRFD1sqrN
NkHcMv8HpN1mmTdiNt8Vd/43y7sU5FWIPmQbsg9bD19lp2V1n93cXIbfOlI88woS
o6zxOxJd+LWWXhV+3TGUVGmQbLWyuOV7Wm+dPKdgRLueZPqSWLPeWs/GDBuLO2jC
9VScFYuc/hMqcVcTlj9lkvj/Wi9FTGK88S+NAyi2VgQR/Yveophv2WnTsktF5/fT
9UWaphTjazWbqrCyotfSQFLBASBXphMcCFgLLbni5pAW/48uKeI1az94MUl0I9wP
Angbb4dk5iPVNDfao4TfbyyPq+E6I7C7EOL+GRf1rMm7cNQCTY2WYNVlw9MSzAX/
mc85pTmzBopuxxIrRFhy
=CWz2
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
