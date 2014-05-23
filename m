From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
Date: Fri, 23 May 2014 10:43:59 +0200
Message-ID: <20140523084359.GD20155@pengutronix.de>
References: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48010 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbaEWIoC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 23 May 2014 04:44:02 -0400
Content-Disposition: inline
In-Reply-To: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Liu Ying <Ying.Liu@freescale.com>

On Fri, May 23, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> The .config() hook imx_pwm_config() calls clk APIs like clk_prepare()
> and clk_get_rate(), which might sleep, so we need to set can_sleep fl=
ag
> on pwm_chip.
Wasn't there a bug that was fixed or at least made more obvious with
this change? Is it worth mentioning in the commit log?

Otherwise
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Uwe
>=20
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes since v1:
>  - Set can_sleep flag for both imx_pwm_v1 and imx_pwm_v2
>=20
>  drivers/pwm/pwm-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d797c7b84c3f..5449d9150d40 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -262,6 +262,7 @@ static int imx_pwm_probe(struct platform_device *=
pdev)
>  	imx->chip.dev =3D &pdev->dev;
>  	imx->chip.base =3D -1;
>  	imx->chip.npwm =3D 1;
> +	imx->chip.can_sleep =3D true;
> =20
>  	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
> --=20
> 1.8.3.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
