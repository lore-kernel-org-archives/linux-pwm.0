From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: cros_ec: add __packed to prevent padding
Date: Mon, 5 Sep 2016 08:44:41 +0200
Message-ID: <20160905064441.GD3532@ulmo.ba.sec>
References: <1469557333-9497-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469557333-9497-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Gwendal Grignou <gwendal@chromium.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pwm@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2016 at 11:22:13AM -0700, Brian Norris wrote:
> While the particular usage in question is likely safe (struct
> cros_ec_command is 32-bit aligned, followed by <=3D32-bit fields), it's
> been suggested this is not a great pattern to follow for the general
> case -- for example, if we follow a 'struct cros_ec_command' (which is
> 32-bit- but not 64-bit-aligned) with a struct that starts with a 64-bit
> type (e.g., u64), the compiler may add padding.
>=20
> Let's add __packed, to inform the compiler of our true intention -- to
> have no padding between these struct elements -- and to future proof for
> any refactorings that might occur.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Hi Thierry,
>=20
> I don't know of any bugs directly resolved by this patch, so take it for
> v4.8/v4.9 at your discretion.
>=20
>  drivers/pwm/pwm-cros-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzRRZAAoJEN0jrNd/PrOhzwwQAJvlQzFLzDgg7nt5UZ9CI5cW
ipmq/s7TLGpdmh7qpD/+98rS1UTVvH5JUf4BO8D8qzcGY19wtCbXHu2QGO/ydJih
mGYFm57Vg6X2oYd8BhKPkAQ8ofKehyhfpBJ1qpHHaT0858D8KOuGkjJaukJs3k05
Gabuuj2w3n4RmM7nV+rvw6vrjXeQdqi3ZVsONMK9GHmYckkbrkkjeWHqzNvAGpU3
DPQEuqIpg2JhUU7QPof8HjWqZjPv7z5bRAR4wFGG+5AdCH601q13W12fLu8g2ChR
BAGez08EZcj1O03OJNIheRBnxP1W2tZPaeJOfiP39n1S46O9BTe+WIPEnewirV/q
sOITjQ5KDJ9kUVbHzyLrQcjuSLgQhjUrlGVLfuFGwlQ/IMLnf9EzJnOUPh+hcTqP
v1I6tCakVAlt4kbfG3dZqQrXPaB3qs36vgZBzgK0mybCl7tkU8M2Lm4c83VwEMdm
XgbLnMRYSXa3lLeOZZ2S7y9LpypjNX01FQaoEvoGkYgSPLv4ep3j4PxOOKlFNzuo
NSuYcIL3qpzzKzKAq+t0ZfQy7D1Ceea2LGW8g2uRRQCFpLfiTZbL29kcHaFPzn5S
1o+hAU2kY2s50xEagMygGTlMbob2TWMw7OZXqFO6XznXWAoXgUoZOGyXvVOGMdtg
R/2ri3LpMvxu6QNFAhsa
=bq34
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
