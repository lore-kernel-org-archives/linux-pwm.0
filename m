From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 15/27] pwm: jz4740: Allow selection of PWM channels 0
 and 1
Date: Mon, 4 Mar 2019 13:34:56 +0100
Message-ID: <20190304123456.GG9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-16-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-16-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:34:01PM -0300, Paul Cercueil wrote:
> The TCU channels 0 and 1 were previously reserved for system tasks, and
> thus unavailable for PWM.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v6: New patch
>    =20
>          v7: No change
>    =20
>          v8: ingenic_tcu_[request,release]_channel are dropped. We now use
>              the memory resources provided to the driver to detect whether
>     	 or not we are allowed to use the TCU channel.
>    =20
>          v9: Drop previous system. Call a API function provided by the
>              clocksource driver to know if we can use the channel as PWM.
>    =20
>          v10: No change
>=20
>  drivers/pwm/pwm-jz4740.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f497388fc818..c914589d547b 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -44,11 +44,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	char clk_name[16];
>  	int ret;
> =20
> -	/*
> -	 * Timers 0 and 1 are used for system tasks, so they are unavailable
> -	 * for use as PWMs.
> -	 */
> -	if (pwm->hwpwm < 2)
> +	if (!ingenic_tcu_pwm_can_use_chn(pwm->hwpwm))
>  		return -EBUSY;

Like I said earlier, I think this would be nicer to take a parameter to
a struct device * to remove the need for a global variable (at least for
this particular case).

Thierry

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9G3AACgkQ3SOs138+
s6GsoBAAlgsmxh5F3erzL0YSoFLi9YUFWsXW2ac2aWNG727Q8nKu59W9ZYGGimxk
os1XIwKsey4CI/zaAId1lIc74rTrOBooY5AjWApD9+HjU5xeePuSKTzmQkAs38DV
ZUCw7icfbeWIaNtSZmXPwxzbQIgyLJkkdO7CXKzTg5Hj1Ty9Fcn7xa850dKLKbpv
MOlS7msP6FhY8HVDgjt/Wn2yxEoUWPncdZROBwhYH6W3NNXgI6zU++xTgDIYOWHm
YIlxgo2QUmRGChruJuxtnN8GniJdSnqemBZevLdWFsCOs6hH+HTXTO1Arb0yttGI
QDKMUfilZ0BnNfoZJ7qopbC2D856bHvkQBvOw5hsTHZqgs/P9TKxDjDRtnBvMMHk
KPSlscjq2sKR+9BK7FOR1ikkzDVvQpq28yWfw93Fh2yJTvUndk29f+EjLOADg/lE
UbSU/+7dpS4n2lVv4z4vl3xFBWWUCIW7Rmu0K0UFv9lzY90mI6aEH0qe32lO8lhK
FIsofG/ifAkNgJI1SiR6IV4KA61mqCMeVs4v6Oaj7sFluz1Izq9SPCaHhmkJY1jC
YfRgu2GJpnG5dSa2gRwxFIh2HeLvqKBQhIwRQitiSVUJQHwcIKJGqnDgf0SABuea
fplDG6LMvlKjk6QGXy1jrDhYpaDasxtwV+Ur2I/yc/qlBCd/P1E=
=ACVI
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
