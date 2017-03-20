From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Mon, 20 Mar 2017 14:51:31 +0100
Message-ID: <20170320135131.GP22463@ulmo.ba.sec>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
 <20170317101747.67a09ccd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317101747.67a09ccd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 10:17:47AM +0100, Ralph Sennhauser wrote:
> On Thu, 16 Mar 2017 17:03:05 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
[...]
> > > +static void mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
> > > +static void mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
> >=20
> > I think both of these need to be tagged __maybe_unused to not give
> > noise in randconfig builds.
>=20
> I haven't seen any warnings with CONFIG_PWM disabled. Which
> configuration you expect to trigger a warning? mvebu_pwm_probe should
> be the same, right?

It's got nothing to do with CONFIG_PWM and as far as I can tell your
usage of IS_ENABLED() is fine here. However, if you try building the
driver with a !PM configuration, both *_suspend() and *_resume() end
up being unused and giving you a warning.

Thierry

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljP3mMACgkQ3SOs138+
s6HzvBAAghBQOT1/tVK3+wouBS6rHP2zZSJoX6EYTqYCzY7M1m5yaCeiqnVrZ1jh
oD0Z556a+GxjxOIFAyN2hP6+72GZkBGVpkPnGAZ+y9PK25ShJyQM8yCoDu2rtf0w
K1h2fIX2IVgH+q+08yvKPthu/pgCmni8EIv5Li1BN2ckZD3oOC6wQOWobLE980CE
nGQaXaKrGbUX1WTPiTN384jTyaVnF0PGlzhMipQDBLNp+VXstjcZhj1nbT6dtb7a
bkZ3nb9ht+MlWF5rFEw785fFjUtAoCJ0RN7vZ1/BBi1QVHo/pcN1NETZ05tPCraR
8O1m8/G2dz5661ulEFY31amE6Wa5+tDbLXv2ml5ff2ggnyrrB7jnDEiLTVDN13BE
wvARhlqScLCtVTLNGYsDkDeRST25MYvgf/v9o6GsIeTJyGGAhpae5EmRKEG9AEFk
967u17Z1tdj9QLKkUznvceksg2ciP05v0xASPwVWqHygXUoXLhBQrpfWUn/c50PN
Lb7EU6ABW/l3qq3a3ZPT/TVNvK2dmSnb9d2/TVep/xRql/iQglNWD6tDcH6DCMO1
ohcGpKAqRcZI5+bUZdEZsXS/SRwNrPvEIEBXGBX6EaP37+qg77bxO/AdINqL4tH8
uiE3PqMqRzck3DYKkilaB3RZ5ZxoUTnsJBl+rzXSS07KoKZJlt0=
=bj05
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--
