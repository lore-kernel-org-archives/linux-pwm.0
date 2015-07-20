From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to
 pwm_set_period
Date: Mon, 20 Jul 2015 10:16:00 +0200
Message-ID: <20150720081559.GI29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> The PWM period will be set when calling pwm_config. Remove this useless
> call to pwm_set_period, which might mess up with the initial PWM state
> once we have added proper support for PWM init state retrieval.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index ae498c1..fe5597c 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  	 * via the PWM lookup table.
>  	 */
>  	pb->period =3D pwm_get_default_period(pb->pwm);
> -	if (!pb->period && (data->pwm_period_ns > 0)) {
> +	if (!pb->period && (data->pwm_period_ns > 0))
>  		pb->period =3D data->pwm_period_ns;
> -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> -	}
> =20
>  	pb->lth_brightness =3D data->lth_brightness * (pb->period / pb->scale);

As far as I remember this line is there in order to pass in a period if
the backlight driver is initialized from board setup files. In such a
case there won't be an period associated with the PWM channel in the
first place.

I think even with the introduction of a default period, we'd be missing
out on the board setup case because there is no standard place where it
is being set, so it must come from the platform data.

Thierry

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrK4+AAoJEN0jrNd/PrOhhz4QALQMop9/W4KBetWzP02Z/0pO
5bPdEEUE52967zON+58OBQSN3r0hate0J9aRO20ML9FA+fnM9BaWK43uth+d+OyH
Kq7oWtIG3ojQJoFyYq5kCo9rV42sbT0kQhoUTHlZmtt3WK6F5D0GVGgT37N+GD+r
J0kwHvR9C5VnBpQkABteRnRL5gUBgChIsyr2XOXLpCc8epWDserXzsoblRaizt/X
2Q5uGeB2azYn4kWdAQQWo83jUyr6xhgiXefviH5pRgorBIoov3kizqA1t7l6YqCd
i7R94GUtoJcPwyxA/lA44XC9+FJ8v1B0si4CEE9s7Mi2gQjSxxTe58oVzl1SiImd
uvh58bA45lPHZwsbcyYnXB5ziV/uEH2na4FskxD1c4t8GgGorbzSJfbhSofh18e5
Yz+mqsO98+ppId8FSUV4g77he5Wbr+Kv6u/ybpt999XyBiXzLCz7mBcXZ++Lu2Mq
6Y3tmHBFaudRxzaFlSH1pPZo29l8fPjRpJ1LFqyT/Lu3c4Z/otp3KVn+Lc99LzRO
nhuhzXFQ9sgG+HOhODY3U4CsBzUFwPLGfrIaoITWjXGj0BIt0VK/qD1ZhannmUbF
o4tutCS28omRs7o1G1EqSBtPdJ16XPtRTwKKhYEMUScqgrm69evzQNiYENveJCCS
bJR4OXsOc0pNiTqV2lFD
=+fm1
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
