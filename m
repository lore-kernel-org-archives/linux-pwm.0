From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] PWM: atmel: fix incorrect CDTY value after enabling
Date: Fri, 12 Jun 2015 11:14:37 +0200
Message-ID: <20150612091434.GA19400@ulmo.nvidia.com>
References: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33075 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbFLJPQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 05:15:16 -0400
Content-Disposition: inline
In-Reply-To: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2015 at 03:19:55PM +0200, Alexandre Belloni wrote:
> CUPD is not flushed before enabling the channel so it will update CDTY/CP=
RD just
> after one period. So we always set CUPD, even when the channel is not ena=
bled.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index d3c22de9ee47..89f9ca41d9af 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -155,24 +155,25 @@ static void atmel_pwm_config_v1(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  	struct atmel_pwm_chip *atmel_pwm =3D to_atmel_pwm_chip(chip);
>  	unsigned int val;
> =20
> -	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> -		/*
> -		 * If the PWM channel is enabled, using the update register,
> -		 * it needs to set bit 10 of CMR to 0
> -		 */
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
> =20
> -		val =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> -		val &=3D ~PWM_CMR_UPD_CDTY;
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> -	} else {
> -		/*
> -		 * If the PWM channel is disabled, write value to duty and
> -		 * period registers directly.
> -		 */
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> -		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
> -	}
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
> +
> +	val =3D atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
> +	val &=3D ~PWM_CMR_UPD_CDTY;
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
> +
> +	/*
> +	 * If the PWM channel is enabled, only update CDTY by using the update
> +	 * register, it needs to set bit 10 of CMR to 0
> +	 */
> +	if (test_bit(PWMF_ENABLED, &pwm->flags))
> +		return;
> +	/*
> +	 * If the PWM channel is disabled, write value to duty and period
> +	 * registers directly.
> +	 */
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
>  }
> =20
>  static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device=
 *pwm,

Applied, thanks.

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVeqL3AAoJEN0jrNd/PrOhdeYQAKgcAtDoOElcC5E1Bc57fA76
b2qtpHLVRPS/V7Sp2oupO1uASdkry/ijXF0QOpACz4s1orIIb/6PD0CKXR2CS3Zl
0Ah5dDnEv5ACcCmGEKCniSXFoEFjAG6nUwc1sBEmjBtc2wQIbF9ExG5HoIP5A5Qt
lgFB8AmwvZjw5oBLNsHecahlOEBaorx/w97iKJzv4L6J4G2kowddTogcmPS64MPf
0O00mbnTMaE3P+aN58ifKMCVfrmT5CCMWkrKxrGZeL+7BrNN6qu6FRpmiFQNE+1l
QmYVw40OCk+c9j04rWfhGCwSaIB1006JyaI7WSSAsGUF7GRVAL8KTAESNlpri5fr
4uJ3e0nWlTF6YgR6x5/85BDwFz81du4OxfRPwbRSNoIFAVjIJF/Dph2QPTcPkdfx
X9y4R6fuhOeB8oPYbo13DBB85nQB+FLfAvxwZ5WJh9PQUMw4d2P7w5Ubw3vM8gFh
FHOSEoZb2K2nf/li0Xp15swCxjkW7xIJePywVUnXpVrEL28RJDnDWqpDKryL0T0w
RmH9T3ifOpTaIXaNRucvEht9RpylSFSGQ73fmymdjv5CWiP6U5zuZMncAMlFTD/7
cPbhaR4kCscU6GVizH9P0qJpvVVNjbEAILk0un+8xj/ayXbTQcncrMwcUA8dpxW2
wcVob2t4LoX2lkEDc0Qr
=EoxL
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
