From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Wed, 12 Dec 2018 12:05:27 +0100
Message-ID: <20181212110527.GG17654@ulmo>
References: <20181123093559.10397-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123093559.10397-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:35:59AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> The Cygnus architecture use a Kona PWM. This is already present
> in the device tree but can't be built actually. Hence, allow the
> Kona PWM to be built for Cygnus arch.
>=20
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks. I did fixup the subject to be consistent with other
commit messages.

Thierry

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ63cACgkQ3SOs138+
s6Gaug//ULne9E+EP+aa0IM3LLUq/M0sF9a5Y8e3y2sRu6V0yPkt5JAqc1n4HiRV
H9ntOZiqxAT0bUuve1RHjtwQkwEsnuB1OdzacZitzTDixSVggQ5Y8pFP7Ct3EKfR
z1lMHrjcc+zY82Xlz84sTT4K/ApNKFZCtMSsPLaVq3PBi+uKX8i4YznKP1VkyCMY
FoiymU2BYrhIGiyrdCG/Yh3UlO685CFMP6ritmDmvPuVj4NBEIFD3Cay+MtLcaSo
mRZMyhgC0vyOUwHT6w8xeWJ3KfdlxIaJSzMTT6BlDMQQk9M8HllXmTIR4tSTp4Og
oq2NS7ph5+Jw6zig3TXXvif0uK3mYmu9jysBJsqufKZ1rFvtYBmVS6gE6ERYN589
TzkC98UH0O9ucp+8276/kj/GhqGx3l/HybR+GNw2hkOOwZhXZIP0fN+U8DUP/sl2
qhkAIZ6R2LRPXU6eBj6rJS6L74dYohdMLbD1smMP95MSxQInSCK9s2lyv+9GSoA2
kU6T0WDJhy7VU0s9km8Kgk4NgPs0sIuTucbDALwM2WDtXUUN6p3rui8mdIOx1vGq
mrZoJ40r82YvfeIMXZEI/C+Ro04V2C1yioHz+zFDicq1FJ8dEepDANHpMzcPRrRf
Mf2RGIS17mn5yxWEdwKm78IX3Oc1V8hPpVAPnelTJmhMSM1MqS0=
=QaWF
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
