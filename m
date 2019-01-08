Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHHrw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 02:47:52 -0500
Date: Tue, 8 Jan 2019 08:47:49 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Tue, Jan 08, 2019 at 12:28:12PM +0900, Yoshihiro Shimoda wrote:
> To remove legacy API related functions in the future, this patch
> uses "atomic" related function instead. No change in behavior.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index ba70e83..4987c12 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -316,18 +316,16 @@ static int rcar_pwm_suspend(struct device *dev)
>  static int rcar_pwm_resume(struct device *dev)
>  {
>  	struct pwm_device *pwm =3D rcar_pwm_dev_to_pwm_dev(dev);
> +	struct pwm_state state;
> =20
>  	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>  		return 0;
> =20
>  	pm_runtime_get_sync(dev);
> =20
> -	rcar_pwm_config(pwm->chip, pwm, pwm->state.duty_cycle,
> -			pwm->state.period);
> -	if (pwm_is_enabled(pwm))
> -		rcar_pwm_enable(pwm->chip, pwm);
> +	pwm_get_state(pwm, &state);
> =20
> -	return 0;
> +	return rcar_pwm_apply(pwm->chip, pwm, &state);
>  }

Orthogonal to this patch I wonder what the intended behaviour for a pwm
is on suspend. Should it stop oscilating unconditionally? Or should it
only stop if the consumer stops it as part of its own suspend callback?

As the patch only reworks and improves the code without a change in
behaviour, it is fine for me.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
