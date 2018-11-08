From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Thu, 8 Nov 2018 13:22:46 +0100
Message-ID: <20181108122246.GB1340@ulmo>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107161247.sesu2comhes2d4kx@pengutronix.de>
 <dbd99d36-4ff2-8e14-cc54-0896459fdb0e@broadcom.com>
 <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCccuFKaht93QPvT+taaT8g7CHGS9uP9Ekr0VWASp+ZGZmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Scott Branden <scott.branden@broadcom.com>, u.kleine-koenig@pengutronix.de, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 11:47:53AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi Uwe, Scott,
>=20
> On Wed, 7 Nov 2018 at 17:48, Scott Branden <scott.branden@broadcom.com> w=
rote:
> >
> >
> > On 2018-11-07 8:12 a.m., Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Nov 07, 2018 at 10:36:12AM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > >> The Cygnus architecture use a Kona PWM. This is already present
> > >> in the device tree but can't be built actually. Hence, allow the
> > >> Kona PWM to be built for Cygnus arch.
> > >>
> > >> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > >> ---
> > >>   drivers/pwm/Kconfig | 3 ++-
> > >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > >> index 763ee50ea57d..76d56fc8b1b7 100644
> > >> --- a/drivers/pwm/Kconfig
> > >> +++ b/drivers/pwm/Kconfig
> > >> @@ -88,7 +88,8 @@ config PWM_BCM_IPROC
> > >>
> > >>   config PWM_BCM_KONA
> > >>      tristate "Kona PWM support"
> > >> -    depends on ARCH_BCM_MOBILE
> > >> +    depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
> > >> +    default ARCH_BCM_CYGNUS
> > > Is it possible to build this driver also on other arches? Then you mi=
ght
> > > want to consider
> > >
> > >       depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
> > good idea to add the COMPILE_TEST just to increase compile coverage
>=20
> Will Do.

This is known to potentially break builds on things like UM where we
have !HAS_IOMEM. Please make sure you thoroughly build-test before you
switch on COMPILE_TEST.

Thierry

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvkKpYACgkQ3SOs138+
s6F7oA/9EjJkBQQRIgfAYs0biyk/VGIMo9UkStI+h7X7tYOvLBx0AMnpBLftJVuZ
e4/kZj3mrFA1ertrfo68AYqzxGY63p0xHVZVpiuJYx7k4GhpHBLhnLk5NzhOfYrC
Y1we4u0d4BjmSq0E4CxkHmN+vy8IYh70AFZ1OF+Bh0l5FasYkdrYqMTX2FKHzTIj
hyLLjFHH7lTYK7m/XOwU2ObKm3O6FA8BhlWysOfi+OlG9YmGkUE0OFN8CGwRe5Md
QNsIxXed6cS9gxic1bEqXocikJDujW6T5AJEOY/hAhtAR2hAaIYJy5pX32rarA5A
MfY7ER2SCCnna50VyT+D/LKoUa4H51elJkNOPGAhrhOgF7gYcQ8vJ3ZrWMt6PY8K
58f9VInywUEvr4c5XpuHO9669CKP1LxnwaxEDcwXJyh9eB93la3mp7yXImMzMm0Z
k2ZU7jZhpUUDhTmQRsRuBFM7Li9zmf9QDu2Tna2LfhjFJBBIT/zwZTkerFp8ghTn
gOBQKlcxiTp7lqDxIk+LwKlObvlYDunqI3vCIZIq9Phrdm9Z0ft7QPiRHgMTIGO2
/khnxh+Y0pe9WJJiuDYRcs7mCvaCgphPvooMD2xFTO7RAvxo2+3d3HQGZDeMcJ7d
G8EfyuB7xF9zVSy11WgEhuXvV8VcpVWic+o4vHuE/AetGaOG0wA=
=MiXc
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
