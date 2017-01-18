From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: lpss: Switch to new atomic API
Date: Wed, 18 Jan 2017 12:15:18 +0100
Message-ID: <20170118111518.GP18989@ulmo.ba.sec>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U0B5otXy6WXfork9"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36670 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbdARLWh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2017 06:22:37 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so3293477wmr.3
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2017 03:22:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170102091647.86910-5-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>


--U0B5otXy6WXfork9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 11:16:47AM +0200, Andy Shevchenko wrote:
> Instead of doing things separately, which is not so reliable on some plat=
forms,
> switch the driver to use new atomic API, i.e. ->apply() callback.
>=20
> The change has been tested on Intel platforms such as Broxton, BayTrail, =
and
> Merrifield.
>=20
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 63 +++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 34 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index e7d612e9df51..7d3ac8204618 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -85,15 +85,20 @@ static inline void pwm_lpss_write(const struct pwm_de=
vice *pwm, u32 value)
> =20
>  static void pwm_lpss_update(struct pwm_device *pwm)
>  {
> +	/*
> +	 * Set a limit for busyloop since not all implementations correctly
> +	 * clear PWM_SW_UPDATE bit (at least it's not visible on OS side).
> +	 */
> +	unsigned int count =3D 10;
> +
>  	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
> -	/* Give it some time to propagate */
> -	usleep_range(10, 50);
> +	while (pwm_lpss_read(pwm) & PWM_SW_UPDATE && --count)
> +		usleep_range(10, 20);
>  }
> =20
> -static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +static int pwm_lpss_config(struct pwm_lpss_chip *lpwm, struct pwm_device=
 *pwm,
>  			   int duty_ns, int period_ns)
>  {
> -	struct pwm_lpss_chip *lpwm =3D to_lpwm(chip);
>  	unsigned long long on_time_div;
>  	unsigned long c =3D lpwm->info->clk_rate, base_unit_range;
>  	unsigned long long base_unit, freq =3D NSEC_PER_SEC;
> @@ -114,8 +119,6 @@ static int pwm_lpss_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	do_div(on_time_div, period_ns);
>  	on_time_div =3D 255ULL - on_time_div;
> =20
> -	pm_runtime_get_sync(chip->dev);
> -
>  	ctrl =3D pwm_lpss_read(pwm);
>  	ctrl &=3D ~PWM_ON_TIME_DIV_MASK;
>  	ctrl &=3D ~(base_unit_range << PWM_BASE_UNIT_SHIFT);
> @@ -124,41 +127,43 @@ static int pwm_lpss_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	ctrl |=3D on_time_div;
>  	pwm_lpss_write(pwm, ctrl);
> =20
> -	/*
> -	 * If the PWM is already enabled we need to notify the hardware
> -	 * about the change by setting PWM_SW_UPDATE.
> -	 */
> -	if (pwm_is_enabled(pwm))
> -		pwm_lpss_update(pwm);
> -
> -	pm_runtime_put(chip->dev);
> -
> +	pwm_lpss_update(pwm);
>  	return 0;
>  }
> =20
> -static int pwm_lpss_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +static void pwm_lpss_enable(struct pwm_device *pwm)
>  {
> -	pm_runtime_get_sync(chip->dev);
> -
> -	/*
> -	 * Hardware must first see PWM_SW_UPDATE before the PWM can be
> -	 * enabled.
> -	 */
> -	pwm_lpss_update(pwm);
>  	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
> -	return 0;
>  }
> =20
> -static void pwm_lpss_disable(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +static void pwm_lpss_disable(struct pwm_device *pwm)
>  {
>  	pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> -	pm_runtime_put(chip->dev);
> +}
> +
> +static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  struct pwm_state *state)
> +{
> +	struct pwm_lpss_chip *lpwm =3D to_lpwm(chip);
> +
> +	if (state->enabled) {
> +		if (!pwm_is_enabled(pwm)) {
> +			pm_runtime_get_sync(chip->dev);
> +			pwm_lpss_config(lpwm, pwm, state->duty_cycle, state->period);
> +			pwm_lpss_enable(pwm);
> +		} else {
> +			pwm_lpss_config(lpwm, pwm, state->duty_cycle, state->period);
> +		}
> +	} else if (pwm_is_enabled(pwm)) {
> +		pwm_lpss_disable(pwm);
> +		pm_runtime_put(chip->dev);
> +	}

Would you mind doing another pass over this and inline the
pwm_lpss_enable(), pwm_lpss_disable() and pwm_lpss_config() functions
into pwm_lpss_apply()? Your current version effectively duplicates the
transitional helpers, but the goal should be to fully get rid of the
remainders of the legacy API.

Besides being much cleaner this also gets rid of slight inconsistencies
between the two APIs.

Thierry

--U0B5otXy6WXfork9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/TkYACgkQ3SOs138+
s6Gr3hAAmGUebBD8M7eY0xFjYZyeElQ+VNYzCnafUiiVuJGU7jUJ2iJV0pO9fFEA
Klbm6VODi37BcuS2fapeFOxozFc2xye5mi5RJ/Suru3Dt1ESNg7V+JgAim9t2CB/
zObE8nBg6XDnO2GjeLFhvuURRa3ONcgRPIMtLZ2mUQ4gEfq2joRVHJLoflXQ1HfJ
z7rF3bDFQy1VvPwrroPn6IQ5zqEEr8XR64jREQI2LPG0clPI6M9mS3pkmRzqSa9x
eZb0eBbKbKbwvCiVD8ze9EkKhWvkIpudpFcsoK6gwKDq/asveFE9CYV+ymVQmxG/
2k5x0d6X4+Q6bIoZ5bvLNATnlh3kJ8dRHmqoNM24mDDybuKnXI5LG0JBm9XcyZdn
xsa3isnTDKKjSDfqEZdzRt6NDa5SGoROJfMTCcrZow/cfHvvR5m56pqwGXgOoXdC
QwlWWt6FuKGR0IykBCTVMn2ToDQ59q6Jd+jEfE8KJsIqPpFmfk7z7YykY1yQxn5W
oFEY9Z/5lmQX57zrVDnJY/28FtKm2wg67U9EgFg8WD2zGlEHOmg3TlpBJmQh0a2e
2fBXNYZ/YoCbUgWja219AOy25gaFWeZqL2y2vWXsXcCnrrGdxDOnFiDZQBxU++oL
Gl7OIV1Ywc9iYEuPliobDMGrelDgbeQ63QAq0ix8rIUwzKfU0yY=
=ywlc
-----END PGP SIGNATURE-----

--U0B5otXy6WXfork9--
