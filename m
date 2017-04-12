From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Wed, 12 Apr 2017 19:21:58 +0200
Message-ID: <20170412172158.GF11964@ulmo.ba.sec>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170409180931.4884-2-ralph.sennhauser@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2017 at 08:09:27PM +0200, Ralph Sennhauser wrote:
> From: Andrew Lunn <andrew@lunn.ch>
>=20
> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
> and off period. This can be modelled as a PWM.
>=20
> However, there are only two sets of PWM configuration registers for
> all the GPIO lines. This driver simply allows a single GPIO line per
> GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>=20
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the GPIO driver. Thus the GPIO driver has been
> extended with a PWM driver.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * Port forward
>   * Merge PWM portion into gpio-mvebu.c
>   * Switch to atomic PWM API
>   * Add new compatible string marvell,armada-370-xp-gpio
>   * Update and merge documentation patch
>   * Update MAINTAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  32 ++
>  MAINTAINERS                                        |   2 +
>  drivers/gpio/gpio-mvebu.c                          | 324 +++++++++++++++=
+++++-
>  3 files changed, 346 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Docu=
mentation/devicetree/bindings/gpio/gpio-mvebu.txt
> index a6f3bec..fe49e9d 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -38,6 +38,24 @@ Required properties:
>  - #gpio-cells: Should be two. The first cell is the pin number. The
>    second cell is reserved for flags, unused at the moment.
> =20
> +Optional properties:
> +
> +In order to use the gpio lines in PWM mode, some additional optional
> +properties are required. Only Armada 370 and XP support these properties.
> +
> +- compatible: Must contain "marvell,armada-370-xp-gpio"
> +
> +- reg: an additional register set is needed, for the GPIO Blink
> +  Counter on/off registers.
> +
> +- reg-names: Must contain an entry "pwm" corresponding to the
> +  additional register range needed for pwm operation.
> +
> +- #pwm-cells: Should be two. The first cell is the GPIO line number. The
> +  second cell is the period in nanoseconds.
> +
> +- clocks: Must be a phandle to the clock for the gpio controller.

One other thing: there's a mix of pwm/PWM and gpio/GPIO in this hunk. In
prose, always use the all-uppercase variants because they are
abbreviations.

Thierry

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljuYjYACgkQ3SOs138+
s6FkgA//Ryn2pStMlaD7yTkQgTMaDoalwaL/OXPiz0BJr6Rn/cNbAgmtKmlDs1Q3
fpqxAhU4v/Y8Wojf8MaT3J64eQKQ0s7bC0hjx/MGsefNdL+XP5krfXLmZoyJ5OV7
ZjOoTSxzt9stVoEGgmdJF54miaCTc4B2Cj0HRn5Ygs8LLR3+rwHiaLNpTh34VBqB
tvHLRRF9G/xUNGpBqJ7hmO3VhLRkxUU8TAQq5gBuBTpbY1PKvwtrJf7pPTM3xcja
OWfwrIZ2EvSSQsFMAaHlUfZ9y0Zrv5mslTI0QVWCseEOHwY3x4CnqLwfYoaiI8+c
hk6wh732ea7FTUxJEbVwk/YeYl67DOpxsVfSpM1UqH1SC/u+9oNq8Mtb81mCtPJA
tVMjZbnRSrBFqhmgbg638SsjqQ+Z6QOy/SyGr30H0RUYEmz++DhGmXw0qPfwV7sl
VmOm89RlydVnGUEfFovATa3JX7Fe0yLEYO1V/ulMttLWiiT6+aMUwX580gmPqiL4
/UiIVhN9xnymJEntaqKn9+FEmj48wSNHW8eq9k5bPbGWJC+GqU7O20eUP3z+WXlh
lg1PBn8pSMdFHQt++qZeyD0uvE+KM9wLq0T+A+23PQ8jG6DNKJtMEfBo8WQVcAyR
FJJkYoG+MFr8VNwsQG+ttkqDudZHnN1CgdWaOb9rnVeGMe3+ehQ=
=e7yD
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
