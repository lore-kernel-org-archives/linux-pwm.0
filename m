Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57447 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJHU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 04:07:20 -0500
Date: Fri, 7 Dec 2018 10:07:17 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20181207090717.qht2q6r3xzo2mzu4@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544171373-29618-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/5] pwm: rcar: Add support "atomic" API
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

On Fri, Dec 07, 2018 at 05:29:30PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for "atomic" API. Behavior is the same as
> when using legacy APIs.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index 9cf4567..a5ea0f3 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -200,12 +200,44 @@ static void rcar_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
>  }
> =20
> +static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  struct pwm_state *state)
> +{
> +	struct rcar_pwm_chip *rp =3D to_rcar_pwm_chip(chip);
> +	int div, ret;
> +
> +	div =3D rcar_pwm_get_clock_division(rp, state->period);
> +	if (div < 0)
> +		return div;
> +
> +	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> +
> +	rcar_pwm_calc_counter(rp, div, state->duty_cycle, state->period);
> +	ret =3D rcar_pwm_set_counter(rp);
> +	if (!ret)
> +		rcar_pwm_set_clock_control(rp, div);
> +
> +	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
> +	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> +
> +	if (!ret && state->enabled)
> +		ret =3D rcar_pwm_enable(chip, pwm);
> +
> +	if (!state->enabled) {
> +		rcar_pwm_disable(chip, pwm);
> +		ret =3D 0;
> +	}
> +
> +	return ret;

state->polarity isn't used here which is a bug I think.

Is the documentation for this hardware publically available?

If the pwm runs at say 30% duty cycle and then pwm_apply is called with

	.period =3D 1000,
	.duty_cycle =3D 600,
	.enabled =3D false,

can it happen that for some time a duty cycle of 60% is provided? If so,
that's a bug.

Out of interest: How does the output behave if you disable the hardware?
Does it give a 0, or high-z?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
