From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 9 Jun 2020 18:29:54 +0100
Message-ID: <20200609172954.GM4583@sirena.org.uk>
References: <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609144201.GK4583@sirena.org.uk>
 <a2bae71634fe288f067d5e92090b7561@walle.cc>
 <20200609171520.GC1019634@bogus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pz/qqzCPDfGwIFOg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200609171520.GC1019634@bogus>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ranjani Sridharan <ranjani.sridharan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, david.m.ertman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shiraz.saleem-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--Pz/qqzCPDfGwIFOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 11:15:20AM -0600, Rob Herring wrote:

> Find another driver doing this already and rename it 'simple-mfd' (no=20
> relation to the DT binding) and add your compatible string to it.=20
> 'Generic' or 'simple' drivers don't require generic/simple DT bindings.

> Or extend the existing syscon driver to look up the bus_type and create=
=20
> the regmap based on the bus type?

You'd need a particular bus driver to instantiate for a given bus (or
I'm misunderstanding your proposal) so it wouldn't even need a lookup,
just per-bus ID tables (and ideally also data tables with the regmap
and child descriptions).

--Pz/qqzCPDfGwIFOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fxxEACgkQJNaLcl1U
h9DCLQf/bdNDdxW0Qpw6CjYiwGbdGhDPz2buR07hZ0HFwlLW/CCeJCk0naiEaRo1
P3qH84YQ2ka1vdYpGLWX6+vvXjU2ejaSPz9GmDxoUVkrxB8SjwVYWehydJkgE8Bs
/f9vdLsoac0TjNNro7gumcUGE6bIGFDUvuOJkjn+O4dOBz3cTqhYsY4Sz14cyTxW
maZmtiiVvFyP5Jrf0LTE2oQzqnTEKgoBY8Ku6f34K7EiNmIK/bgppdXsJvNGqZp9
tPbeGiW01Rg8XVNPYnjJf6TipJRvHLJh8hma6sFq5dqH0ZNDpFFW35xqWLPWL5Af
2Plbt+f89ibSJGeBNXMaaEPkfzTv7A==
=lKAA
-----END PGP SIGNATURE-----

--Pz/qqzCPDfGwIFOg--
