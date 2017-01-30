From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 05/11] pwm: imx: Move PWMv2 software reset code to a
 separate function
Date: Mon, 30 Jan 2017 08:26:10 +0100
Message-ID: <20170130072610.GJ3585@ulmo.ba.sec>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
 <1485726855-16236-6-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35169 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752269AbdA3H0N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 02:26:13 -0500
Content-Disposition: inline
In-Reply-To: <1485726855-16236-6-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <l.majewski@majess.pl>


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2017 at 10:54:09PM +0100, Lukasz Majewski wrote:
> From: Lukasz Majewski <l.majewski@majess.pl>
>=20
> The software reset code has been extracted from imx_pwm_config_v2 function
> and moved to new one - imx_pwm_sw_reset().
>=20
> This change reduces the overall size of imx_pwm_config_v2() and prepares
> it for atomic PWM operation.
>=20
> Suggested-by: Stefan Agner <stefan@agner.ch>
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
>=20
> ---
> Changes for v5:
> - None
>=20
> Changes for v4:
> - None
>=20
> Changes for v3:
> - None
>=20
> Changes for v2:
> - Add missing parenthesis
> ---
>  drivers/pwm/pwm-imx.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 11e3f3e..f0d78f3 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -120,6 +120,25 @@ static void imx_pwm_disable_v1(struct pwm_chip *chip=
, struct pwm_device *pwm)
>  	clk_disable_unprepare(imx->clk_per);
>  }
> =20
> +static void imx_pwm_sw_reset(struct pwm_chip *chip)
> +{
> +	struct imx_chip *imx =3D to_imx_chip(chip);
> +	struct device *dev =3D chip->dev;
> +	int wait_count =3D 0;
> +	u32 cr;
> +
> +	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
> +	do {
> +		usleep_range(200, 1000);
> +		cr =3D readl(imx->mmio_base + MX3_PWMCR);
> +	} while ((cr & MX3_PWMCR_SWR) &&
> +		 (wait_count++ < MX3_PWM_SWR_LOOP));

I think you could replace this by one of the accessors from
linux/iopoll.h, but that can be a separate patch.

Thierry

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO6pEACgkQ3SOs138+
s6GbXxAAvh68lCmRRt9Rd8A9RdlDClOQFxZNLsEM95bCDGTQW2M1/Cbb+dBr2tF8
9DfTftNdX76xpKISJuBwR6T1kCfwlQuI00zvA4f1vTIBIdw1JIZDB/jzT3j/IAPi
MKSb+9VeXYsudTfBmCGISKnF2SvgvvHKjJh9KqmD0Mp0gBXnkjgkSBrYBulp6vH3
Dq9IHQTJCaz4RvTKAgmKuPwqByocBk0RwlRgKC6LxH3lRQH80JUtDHpLKzK6OBv3
gQbs8ZNSO9qdqzFHE5VJHWZG1RrOy22nxvTj9TTA0yNNft5HlQq2SwRvcPTFq8+F
Ou1Nozz3G/mQQi33kMmt8FkCv7AqZpwONVn23iP7D+Q0zsYloAxx3LOMEnppBTAt
iy5046MgykUzI8NFSdaWzcdX37e5GoNXGASnAVCDfXk1+bREQ5slBG15gEN2VTEe
aL7UZvxAvgUBC91YcUxkSpJUI0FIVdmT912QrlY6MqqCrbgcbnK3mzWoqosseJN1
Kg1TauRDy5yfHEWDnm1emtMZ+1g0uER2ncWvt43LfmaA1IVPe6QJ1vId6gnjBjfu
FjvLUFgjHl7VKDBILQDwcUMNJAJp08Balups9D6f1KOwupd/w9uipOSIsaH0a+mh
UClTylXPt5ubVAtFMF5NcjG5UiZ0AE4PcPAVGXw1xUwOYX4tSKA=
=6TWf
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--
