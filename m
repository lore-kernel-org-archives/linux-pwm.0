From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] gpio: mvebu: Add limited PWM support
Date: Mon, 20 Mar 2017 14:44:40 +0100
Message-ID: <20170320134440.GN22463@ulmo.ba.sec>
References: <20170316064218.9169-1-ralph.sennhauser@gmail.com>
 <20170316064218.9169-2-ralph.sennhauser@gmail.com>
 <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ=bor380ic_X36M7vVbopDCZe9Yb9TxkmOHyO75gdAnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ralph Sennhauser <ralph.sennhauser@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Imre Kaloz <kaloz@openwrt.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Mauro Carvalho Chehab <mchehab@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 05:03:05PM +0100, Linus Walleij wrote:
> On Thu, Mar 16, 2017 at 7:42 AM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
>=20
> > From: Andrew Lunn <andrew@lunn.ch>
> >
> > Armada 370/XP devices can 'blink' gpio lines with a configurable on
> > and off period. This can be modelled as a PWM.
> >
> > However, there are only two sets of PWM configuration registers for
> > all the gpio lines. This driver simply allows a single gpio line per
> > gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> > EBUSY.
> >
> > Due to the interleaving of registers it is not simple to separate the
> > PWM driver from the gpio driver. Thus the gpio driver has been
> > extended with a PWM driver.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > URL: https://patchwork.ozlabs.org/patch/427287/
> > URL: https://patchwork.ozlabs.org/patch/427295/
> > [Ralph Sennhauser:
> >   * port forward
> >   * merge pwm portion into gpio-mvebu.c
> >   * merge doc patch
> >   * update MAINAINERS]
> > Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>=20
> In essence I am very positive of this patch set and happy to merge
> it as a PWM driver inside of GPIO if Thierry is OK with it.

No objections to the concept of making a GPIO driver implement a PWM
chip when it makes sense.

Thierry

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljP3MgACgkQ3SOs138+
s6HXwhAAk7F5OVxOoRVqzMxZJ1EDc5pOgWJjfIlxkQKT1FUCBu446QLU+HNfXgsm
xKKVlSvRF83nR1VHhG5qB9m+rNhh2H5Uc4x74xXOwC8od5XflN/+ejUaNlT/BqUN
LkcIT7Y76kb0qYaMcLFGrJJFK0CZjB7LUVkUDneB+97bRZTH5qmKER3sgzfBxOBL
87nrlwNhgCYbjPdRwxdsCloEDGXfOE71bn+CHKzARj/TqdQh96FBvvst4XlgSDJN
/CLcnt/TPXbVlkaOq2k4Flfm3HM29GSKarz3andDacas8LooVMXLiD9X/AlAzZ5D
X0cYDx7xec2B9eQUja/ecG4RauuvFlodRkWKUEK4PobFkCUc/QiBG8D40xLWdsng
8FyEj5bUHwfTkZdJ8dEuNVBEEYoHrY0QyJNeoRMJQKaz1c3Sh1E8NK9EpwjzPYza
HXVl8STRC3PYQ+W2pZaXERht7ZMHKB2AvnvKioJiKzwo0CQAALg9x5tnn5Z4gSYz
487xF7fTf32TkLOYJB1zZJpr5V+OhojG8ZshS+mLJJ6GC8KlrtTPHUAKEvythr72
NSCD09MTYGbSMoJcp08B24Jb55L6V45Cg2B7A21lUfHg8ZlQMQoqP2fKRf2BZITw
ZuasdbcOsB8USXnXUYhU+Gur3i9z6hKDxF0ilDUMK+xf7iyBne8=
=OBHh
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
