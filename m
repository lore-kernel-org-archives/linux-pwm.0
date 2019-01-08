Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42397 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHHnf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 02:43:35 -0500
Date: Tue, 8 Jan 2019 08:43:31 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190108074331.lqwtex2pyumilfyn@pengutronix.de>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1546918094-13960-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 1/4] pwm: rcar: Add support "atomic" API
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

On Tue, Jan 08, 2019 at 12:28:11PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for "atomic" API. Behavior is the same as
> when using legacy APIs.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index a41812f..ba70e83 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -192,12 +192,49 @@ static void rcar_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
>  }
> =20
> +static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  struct pwm_state *state)
> +{
> +	struct rcar_pwm_chip *rp =3D to_rcar_pwm_chip(chip);
> +	struct pwm_state cur_state;
> +	int div, ret;
> +
> +	/* This HW doesn't support changing polarity */
> +	pwm_get_state(pwm, &cur_state);
> +	if (state->polarity !=3D cur_state.polarity)
> +		return -ENOTSUPP;

Does the driver only support normal polarity or only inversed polarity?
If so checking against that would be more clear here.

> +
> +	div =3D rcar_pwm_get_clock_division(rp, state->period);
> +	if (div < 0)
> +		return div;
> +
> +	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> +
> +	ret =3D rcar_pwm_set_counter(rp, div, state->duty_cycle, state->period);
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

Assume the PWM runs with duty cycle 33% when
pwm_apply_state({ .enabled=3D0, .duty_cycle=3D66, .period=3D100 }) is calle=
d.

Does this might result in a 66% wave form being emitted? If yes, this
needs fixing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
