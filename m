From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: silently error on EPROBE_DEFER
Date: Thu, 6 Jul 2017 08:30:33 +0200
Message-ID: <20170706063033.GD16144@ulmo.fritz.box>
References: <20170523160503.16920-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523160503.16920-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 06:05:03PM +0200, Jerome Brunet wrote:
> In of_pwm_chip, if we fail to get the pwm chip due to probe defer, we
> shouldn't print an error message. Just be silent in this case.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld2QkACgkQ3SOs138+
s6FH7A/+MlPKXE6lTpUIrHol04QORB3JMn0e0IsMix6WIihtA5Qyrjs6EkPYK8eK
6HbcQ7RwZ5/zPkxISMCWcdlVUnph0HWeDvDwCaEOns/bv0hq7yS8zQTtfQoWyr03
tK54rRFTE+RUPbVx9r0GctoVRhouHbXGgTZl+fR1ratWyGzX2RGmgV8+HSL1Os1S
NdpGl1WB1rFpwgHQNd2jqC3o5g7wbkrl7RKuWd1/Us6cCEjnj+mTpGhM7na5gsKe
+wiG8PSw3tv3L4NjB9/Z5dsy/QF37S4h+rMhMLXkh/r/iSmBBGycS+wcnPq/X1Nl
yUZ5Jag3Am7eWHLYoCV8GT5DnAI5YojbSNRiRZtdka/NlDhLUYyjFINU5hEiYOf4
1EWAxyPB6/G+WVCdn91xU/T644hyB/WaxcFOZf0ZJskaumZS0J84Qzgdr7iIMXCt
xBYBcJCbWRmmGBzAsn8TTtWcYQ39rHD4WDIalUfJWA4OmjkFyDfayFdAwoPcgrMb
gr0knbsKAoEkf3JwW13eab+/S1JHFTHCc/AWv8adO5ltxWvV27sHQxn44Vrx72xl
agA1Z6U/2mk+MSxbf5v8MNpP/1DeJrMlm70UAgdIcvj1jwZYFsA9NP9EZcVYtLBO
qM/WART2mg4KQY6M1K5olfMBKp8FKC9RFTQYjTM3kOB+FzCgECs=
=9CM2
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
