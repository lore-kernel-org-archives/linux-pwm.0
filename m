Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLSh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Mar 2019 06:18:37 -0500
Date: Mon, 4 Mar 2019 12:18:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190304111833.GD5121@ulmo>
References: <1547021948-7664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1547021948-7664-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <1547021948-7664-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 05:19:06PM +0900, Yoshihiro Shimoda wrote:
> To remove legacy API related functions in the future, this patch
> uses "atomic" related function instead. No change in behavior.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-rcar.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index e3ab663..652a937 100644
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
>  #endif /* CONFIG_PM_SLEEP */
>  static SIMPLE_DEV_PM_OPS(rcar_pwm_pm_ops, rcar_pwm_suspend, rcar_pwm_res=
ume);

As was recently discussed elsewhere, it should really be up to the
consumer of PWMs to reinitialize the PWM on resume. However, this is a
preexisting condition, so let's do it in a follow-up.

Do you have any cases where you really rely on this? Resume ordering
does not guarantee that the PWM and consumer will be resumed in the
right order, so you may be enabling the PWM too soon, or too late, by
doing this in the PWM driver.

There are patches in the works to help with this using device links, but
I think even with those there will be cases where the consumer will want
to directly control when the PWM is restored, so you should consider
moving the driver away from implementing suspend/resume itself.

It'd be interesting to hear if there any cases where things break if you
simply remove these PM callbacks. If so we should investigate and fix
them so that these can be removed.

Thierry

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9CYkACgkQ3SOs138+
s6Ecow/+Lh5YDZ3eCQEcrYBCJoKVl8DrAEh9dZWpXas24wVJq9+r4wYgSjMrtaCx
UuXC+LgIV0lwbnxYyqNIYkKU9yGocDcvPrabz/FhBk0i2LpE/OduVG+HDygnPkqz
+6RFj4sosbGzeMadxhCwFrz55QO+v49mH4SvSCTiBhitStkQZiSnQHXroFwUNNQK
GXWRWfDL2VH/CaeKRrf6/tpxsWXOjrr/gDvHQIMvaQOE3zMOaqDf8QrnthEZ5iJn
v8DxlWOxQrXiZAo8oMMU+W6PSbe3LfEjzxq1E4+sYPIA2b2mCiEs1YVhrT9SId6W
awJUVT9F8mKZsK6C4mPf/K4cb9k4mrX3NSKpOaucumyZKdZBEnnFoDVNBhx2EM9w
vmMlxL05qEiXwYbkSRo3ghs7TkX55PDxpjcjqX0QpBI7qNHpd657MHAVQzgh16+S
wqO48VM/UccuaPZnMgyYTj3F/7r49gHf2NVeDPzBxQ4QWBtdEFxXTtcsXJh6yfrM
Av60CO29+HxUaJoyBEz2DHXFQWThUyWjKUHOQVqaCS552iHdeL79M6NvDELdGjwf
CMvJhUHg7/BHfW6nWyvxCgfPYKiva2rSUO+EL1xpk/C2eHjT8pZWGpiSjHvhlTIJ
nngwBx64GbZlSWeJHSIwdhDkXwyy9vR/jwTGMQQoG/Ra9E9Fcj8=
=VHQF
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
