From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 07/15] pwm: move the enabled/disabled info to
 pwm_state struct
Date: Mon, 20 Jul 2015 10:11:04 +0200
Message-ID: <20150720081103.GH29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-8-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-8-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:53AM +0200, Boris Brezillon wrote:
> Prepare the transition to PWM atomic update by moving the enabled/disabled
> state into the pwm_state struct. This way we can easily update the whole
> PWM state by copying the new state in the ->state field.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c  | 15 ++++++++++++---
>  include/linux/pwm.h |  6 +++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a6bc8e6..3e830ce 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -474,8 +474,15 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
> -		return pwm->chip->ops->enable(pwm->chip, pwm);
> +	if (pwm && !pwm_is_enabled(pwm)) {
> +		int err;
> +
> +		err =3D pwm->chip->ops->enable(pwm->chip, pwm);
> +		if (!err)
> +			pwm->state.enabled =3D true;
> +
> +		return err;
> +	}

Technically there's now a race between the pwm_is_enabled() and
pwm->state.enabled =3D true; statements, but as discussed in the cover
letter I think that's fine because of the assumptions about concurrent
usage of PWMs.

The most important check (PWMF_REQUESTED) is still atomic, so it is
still up to drivers to properly lock concurrent access to a PWM device
and the core will make sure that a device can only be requested once.

Thierry

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrK0XAAoJEN0jrNd/PrOhtJ0QAKfchwwZ++kZeNCOUmVeq7Q8
+AbRc98I3rKtpiNn2tj//I3wvdWi6df82vplkChh/5VlLEtijdgWQysiFh2U8Rak
jJBLUS2Wevlqjj6SFED995VeRucOc91WkHVaCaxQxQdJ7xmTxkTyphr+lJ4y+sKE
EJ8H+ey2zzSWUw7Ginh/y3xcvQwNYD+nZk5PDSsP1e5cNSAwoMzStHTTkkaAGmdQ
kvo7F04jYz0w/o4RuvTBRWPDwN3FQfH0p13G0WUSdcSnvHcgrqGIGz67QOTnnRJQ
Wu/bPqdJkE3SVNp2zyXbfEFYMzrSaTdtAyDlKQgYqQ1ElwwS5pEBdJtS2G8DGUrS
S+5M0MLcojNvUKWQnFdyJpFqptLP56YC5aIEo9EEvH+FWVRqZTVMeTrKh46f8c5m
Hhe76C4+AjcOkp2q5og8ezrmjN+fJOTpV0OlpMM7cksPtuHe9vjFeJfWJD/Yg24Y
3j5KU+qnVfFH+cZSACgwldnBqSowFa61aQXv7D4dj8FhNXq8cdnwHy1u1rl7LzG5
/0ps4M3pGPh8OmzuoGy4nTqP0bXK4b1t9kuZw+RCdjPHG1C1VGW3g8K0fuACTrlb
AvjsqmDhwUP93Puv4hx6NIvHyPHkpfCMEy73jf8P7QKj1UVblrCnnqX1Gelt/R9C
YD1evsDZbXTZ11DbGak5
=XZMw
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
