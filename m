Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39809 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJPLPZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 07:15:25 -0400
Date: Wed, 16 Oct 2019 13:15:22 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20191016111522.vzsipskmt66q27bq@pengutronix.de>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-4-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016110601.1765415-4-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 3/3] pwm: stm32: Validate breakinput data from DT
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 01:06:01PM +0200, Thierry Reding wrote:
> Both index and level can only be either 0 or 1 and the filter value is
> limited to values between (and including) 0 and 15. Validate that the
> device tree node contains values that are within these ranges.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index db1d675b45fb..7ff48c14fae8 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -530,6 +530,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_p=
wm *priv,
>  				       struct device_node *np)
>  {
>  	int nb, ret, array_size;
> +	unsigned int i;
> =20
>  	nb =3D of_property_count_elems_of_size(np, "st,breakinput",
>  					     sizeof(struct stm32_breakinput));
> @@ -551,6 +552,13 @@ static int stm32_pwm_probe_breakinputs(struct stm32_=
pwm *priv,
>  	if (ret)
>  		return ret;
> =20
> +	for (i =3D 0; i < priv->num_breakinputs; i++) {
> +		if (priv->breakinputs[i].index > 1 ||
> +		    priv->breakinputs[i].level > 1 ||
> +		    priv->breakinputs[i].filter > 15)
> +			return -EINVAL;
> +	}
> +

maybe put this patch before patch 1 that relies on index not being
bigger than 1?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
