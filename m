From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Wed, 2 Apr 2014 07:53:50 +0200
Message-ID: <20140402055350.GX17250@pengutronix.de>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46506 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbaDBFxz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Apr 2014 01:53:55 -0400
Content-Disposition: inline
In-Reply-To: <1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>

On Fri, Mar 28, 2014 at 09:48:58AM +0100, Lothar Wa=DFmann wrote:
> Change the pwm chip driver registration, so that a chip driver that
> supports polarity inversion can still be used with DTBs that don't
> provide the 'PWM_POLARITY' flag.
>=20
> This is done to provide polarity inversion support for the pwm-imx
> driver without having to modify all existing DTS files.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  drivers/pwm/core.c |   46 ++++++++++++++++--------------------------=
----
>  1 file changed, 16 insertions(+), 30 deletions(-)
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a804713..dc15543 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -131,12 +131,12 @@ static int pwm_device_request(struct pwm_device=
 *pwm, const char *label)
>  	return 0;
>  }
> =20
> -struct pwm_device *
> -of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle=
_args *args)
> +struct pwm_device *of_pwm_xlate(struct pwm_chip *pc,
> +				const struct of_phandle_args *args)
>  {
>  	struct pwm_device *pwm;
> =20
> -	if (pc->of_pwm_n_cells < 3)
> +	if (pc->of_pwm_n_cells < 2)
>  		return ERR_PTR(-EINVAL);
> =20
>  	if (args->args[0] >=3D pc->npwm)
> @@ -148,6 +148,9 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, cons=
t struct of_phandle_args *args)
> =20
>  	pwm_set_period(pwm, args->args[1]);
> =20
> +	if (pc->of_pwm_n_cells < 3)
> +		return pwm;
> +
>  	if (args->args[2] & PWM_POLARITY_INVERTED)
>  		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
>  	else
> @@ -155,27 +158,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, co=
nst struct of_phandle_args *args)
> =20
>  	return pwm;
>  }
> -EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
> =20
> -static struct pwm_device *
> -of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_arg=
s *args)
> +struct pwm_device *
> +of_pwm_xlate_with_flags(struct pwm_chip *pc,
> +			const struct of_phandle_args *args)
>  {
> -	struct pwm_device *pwm;
> -
> -	if (pc->of_pwm_n_cells < 2)
> -		return ERR_PTR(-EINVAL);
> -
> -	if (args->args[0] >=3D pc->npwm)
> -		return ERR_PTR(-EINVAL);
> -
> -	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
> -	if (IS_ERR(pwm))
> -		return pwm;
> -
> -	pwm_set_period(pwm, args->args[1]);
> -
> -	return pwm;
> +	return of_pwm_xlate(pc, args);
>  }
> +EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
> =20
>  static void of_pwmchip_add(struct pwm_chip *chip)
>  {
> @@ -183,8 +173,11 @@ static void of_pwmchip_add(struct pwm_chip *chip=
)
>  		return;
> =20
>  	if (!chip->of_xlate) {
> -		chip->of_xlate =3D of_pwm_simple_xlate;
> -		chip->of_pwm_n_cells =3D 2;
> +		chip->of_xlate =3D of_pwm_xlate;
> +		if (chip->ops->set_polarity)
> +			chip->of_pwm_n_cells =3D 3;
> +		else
> +			chip->of_pwm_n_cells =3D 2;

I think the presence of the set_polarity callback shouldn't influence
the number of cells the parser expects. As commented on 2/2 this doesn'=
t
actually mean the device actually support polarity inversion. Also,
polarity inversion could still be done in software for hardware that
doesn't support it.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
