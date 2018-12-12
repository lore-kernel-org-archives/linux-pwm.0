From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Date: Wed, 12 Dec 2018 12:04:46 +0100
Message-ID: <20181212110446.GF17654@ulmo>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107093613.26734-2-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107093613.26734-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Suji Velupillai <suji.velupillai@broadcom.com>
List-Id: linux-pwm@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> From: Suji Velupillai <suji.velupillai@broadcom.com>
>=20
> When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> return false, this prevents the backlight being turn on at boot time.
>=20
> Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

I see v2 and v3 of patch 1 of the series. Did you work on v2 of this
patch (2/2) as well? I don't see it on the list and it didn't seem like
everyone was happy with this version.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ604ACgkQ3SOs138+
s6HurBAAu4FglpN1Tc0q8ipMLFF7FdNMQKJc5c8pjpK3EyqwfmtJXPZiEPKvA38F
kuOTau+A8Nu/AjwEtnVKp6h2XzOy9DUXtWEU8JnhGKQvomm01SucysxEd6a/f0/N
7WAlzabOMvYwhXZGAgeuIMiGNmlw5q2AuKhXOtCFeTmjHJC1tJU/kqYHrTjLOdoH
JCNCp8WzLLSsMXPi/4EkBz0T14kS3iWpnm5Bx3fVORyT+Ep22IRWf7r1wi21aK3X
6z88IqprWiKCjFdnhVoa3b3Qf152e+Rzr854Y5pZ4ihvdTqA735MZ+forHlxbjK7
VGUtEcK5NrjDP0l3r3qhH9dkGlfb/UpAX1001H9TzS0gcMyamlMVJneQ+ipBWRcL
BfTmyyuNiXShJjQ1UzkgOY+Je9vvdq9XV3NIzTA3d8qsHANM1JyPzus0WtIklDHf
RYxXw68OlbbFUKv70ShbWzYyKVBEGXN/BknUvM4lTcISMRVfxi0VwMQwlGXIDGND
d8Y25zA1J/s41H6ZxhG2h6/Na6ymsSJkNSaye/X5+BcpXEfDH1oZmkizKYqkuCnt
cMmzg/T1KlUxMIGKgB2TQ1+KzNbT+RiIDmLi6xFSnqhJwN3tQoCFi/83Kuy+fIRM
vVxxz9NyfZB9vMiZnk0qAndDSq4rc/DIMfg2JVGHv1ZM/GzYLSA=
=/vm3
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
