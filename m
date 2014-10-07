From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 12:06:33 +0200
Message-ID: <20141007100632.GA31575@ulmo>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007094427.GW25331@lee--X1> <20141007094727.GA12631@ulmo>
 <20141007095932.GY25331@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2099080702=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141007095932.GY25331@lee--X1>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============2099080702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 10:59:32AM +0100, Lee Jones wrote:
> On Tue, 07 Oct 2014, Thierry Reding wrote:
>=20
> > On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
> > > On Mon, 06 Oct 2014, Boris Brezillon wrote:
> > >=20
> > > > The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sa=
m9x5
> > > > family or sama5d3 family) exposes 2 subdevices:
> > > > - a display controller (controlled by a DRM driver)
> > > > - a PWM chip
> > > >=20
> > > > The MFD device provides a regmap and several clocks (those connected
> > > > to this hardware block) to its subdevices.
> > > >=20
> > > > This way concurrent accesses to the iomem range are handled by the =
regmap
> > > > framework, and each subdevice can safely access HLCDC registers.
> > > >=20
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > > > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > ---
> > > >  drivers/mfd/Kconfig             |   6 ++
> > > >  drivers/mfd/Makefile            |   1 +
> > > >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++++++=
++++++++++++
> > > >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++++++
> > > >  4 files changed, 214 insertions(+)
> > > >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> > > >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> > >=20
> > > Applied for v3.19.
> >=20
> > Will you provide a stable branch that I can pull into the PWM tree?
>=20
> I hadn't planned on it.  What do you need that for?

Because the PWM driver depends on this series. But if you prefer you
could also take the PWM driver through your tree.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM7soAAoJEN0jrNd/PrOhr9cP/0J7sGcdtFFskYk0knK+Fdhz
YTEugdzuRo+1x+qtadXRRYKeM4vivpNla4uOCERernDwa9xhWvZPu0br9E+59fAf
Ke40mO3ahNXnvUlCd7EC/4mWMYJpkCdYVuDD9DQ4w70tcy+uzQrCvXojJGSs/ITN
tDrPsPmanO36eHfYtfUf/8XjdkzgSvFIZKMRGGvdaG4XohUntdOOD/ujhtUMRr2O
I4eQXS7onqwrgVkNSeW1iIVQSw6WqKvUqZwja6XNeGUewzo2j8WyLSnSgxVb5zca
hTBiZQApV8c7M/GUtWNMrUsb2mFltglw2Zykr+tdXqGz36vtTqTf4t4My2qEtvzB
9E/euV0KWeJL24n9Trjq7kvyILWgFjXJxdhM2q50r4ExZs5qF+rVLrUbZiiR0a9p
WKqQ5gtin3CHVxsTkgmTDhyhsx4o1cMFT0VuaGb0qTRwDpvqShsMYvHenssgJisY
RUYo1j1ubaEFEGnlidlUIww5hlGvorBUtGbCzp7t5JBg9Zzdo8z8VAqxuf1ZjvL2
LVa/rU7dz2wR0U3OPlFNm9DkexR7gQHDOo7rU9SVjqd5zJuBnT4qPOiA85fd+jm3
kbSyyPqqj4EzE+1LAI8KDiO5j0OA0LBO2uChybdD7FQKXiH/YuZ7gH+aaJ7Y7gwo
K9yZ0ExEsQvDj97a9bBh
=dFf7
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

--===============2099080702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============2099080702==--
