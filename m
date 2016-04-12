From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 10/11] pwm: sti: Enable PWM Capture
Date: Tue, 12 Apr 2016 12:56:09 +0200
Message-ID: <20160412105609.GF18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-11-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37105 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcDLK4M (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Apr 2016 06:56:12 -0400
Content-Disposition: inline
In-Reply-To: <1456932729-9667-11-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 03:32:08PM +0000, Lee Jones wrote:
> Once all functionality is in place, we provide the means to
> enable PWM Capture.  Here we are simply obtaining the
> associated regmap and twiddling the relevant enable register
> bits.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 8de9b4a..93cf20e 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -279,6 +279,13 @@ static int sti_pwm_enable(struct pwm_chip *chip, str=
uct pwm_device *pwm)
>  				pwm->hwpwm);
>  			goto out;
>  		}
> +
> +		ret =3D regmap_field_write(pc->pwm_cpt_en, 1);
> +		if (ret) {
> +			dev_err(dev, "failed to enable PWM capture:%d\n",
> +				pwm->hwpwm);
> +			goto out;
> +		}

Should this perhaps be part of the driver's ->capture() implementation?
It seems redundant to have this logic enabled if we may never use it.

Thierry

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNRJAAoJEN0jrNd/PrOhoMoP/3b7phq6PkrEgyd9gU3sfXJW
nSRxexuvavZLyQ0p8rSzU3yJfFzcAjw5Gw3xPYU6yK3NmZcvdX3kGqBerylFhlyu
ZuGkhj3tKrCCI8SZuvZ1olpo7+zlVPHM6tHmcAfn1S8l8Fh8Z668eckAX4E0MekM
4wvwFf1MDQhcUAj1+kzdNYELM2pJ2pdPzGlSqHnKBxKRdfrn9lxp/j/ZE2W7EzEH
cvHg+HNQoNOJoTqydHryqaaDHvyVfYGffQBgeQnex7YZAM6kZEj3Nr7XPYqwQ/FX
alFkMDRuFyvNEP45ZuBrTwi1mPt1QdV7RQv8/6F8t5zmxJR4CSgM859+KUbV0Mzr
y6GYPv1ryrBlWjLLrtt4eDM8LJrsGSuNQ2INOLXCFZ2cLirQaC/E+kGqgiyk1PrP
GBoeyYNq0XnpEh61sSho2aofi6b37RhrJwuTD9My0TYu+v+XLpyQxaFiJGiQm5WK
005PoQTNklsih+NnypFPzhF4Oe27aeFKSP4qhFWfOTOnE7vJuu4lOqsS9PnC5JA3
+ZICC2dXl+tTNAd2VcAtxL9zddKqqP0+R7kufuz421DgELcfNothsHWICqG17U/y
NzaVhMIRIbv8RXqZR6xmCzuX9wlK8jqKoqyI359Z2IkqBRZQY8adCQzPG+7BWGDX
YJF/KGPn/962gXkmIJn+
=St3Z
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
