From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 13:55:30 +0200
Message-ID: <20141007115529.GA17434@ulmo>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007094427.GW25331@lee--X1> <20141007094727.GA12631@ulmo>
 <20141007095932.GY25331@lee--X1> <20141007100632.GA31575@ulmo>
 <20141007101743.GA25331@lee--X1> <20141007111304.GA1539@ulmo>
 <20141007113814.GA3693@lee--X1>
 <20141007134112.40179e8a@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0775918928=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141007134112.40179e8a@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org


--===============0775918928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 01:41:12PM +0200, Boris Brezillon wrote:
> On Tue, 7 Oct 2014 12:38:14 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
>=20
> > On Tue, 07 Oct 2014, Thierry Reding wrote:
> >=20
> > > On Tue, Oct 07, 2014 at 11:17:43AM +0100, Lee Jones wrote:
> > > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > > >=20
> > > > > On Tue, Oct 07, 2014 at 10:59:32AM +0100, Lee Jones wrote:
> > > > > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > > > > >=20
> > > > > > > On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
> > > > > > > > On Mon, 06 Oct 2014, Boris Brezillon wrote:
> > > > > > > >=20
> > > > > > > > > The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n=
12, at91sam9x5
> > > > > > > > > family or sama5d3 family) exposes 2 subdevices:
> > > > > > > > > - a display controller (controlled by a DRM driver)
> > > > > > > > > - a PWM chip
> > > > > > > > >=20
> > > > > > > > > The MFD device provides a regmap and several clocks (thos=
e connected
> > > > > > > > > to this hardware block) to its subdevices.
> > > > > > > > >=20
> > > > > > > > > This way concurrent accesses to the iomem range are handl=
ed by the regmap
> > > > > > > > > framework, and each subdevice can safely access HLCDC reg=
isters.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-elec=
trons.com>
> > > > > > > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > > > > > > > > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/mfd/Kconfig             |   6 ++
> > > > > > > > >  drivers/mfd/Makefile            |   1 +
> > > > > > > > >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++=
++++++++++++++++++++++
> > > > > > > > >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++=
++++++++++
> > > > > > > > >  4 files changed, 214 insertions(+)
> > > > > > > > >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> > > > > > > > >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> > > > > > > >=20
> > > > > > > > Applied for v3.19.
> > > > > > >=20
> > > > > > > Will you provide a stable branch that I can pull into the PWM=
 tree?
> > > > > >=20
> > > > > > I hadn't planned on it.  What do you need that for?
> > > > >=20
> > > > > Because the PWM driver depends on this series. But if you prefer =
you
> > > > > could also take the PWM driver through your tree.
> > > >=20
> > > > Probably better to deal with that via Kconfig.
> > >=20
> > > Do you have any suggestions? The PWM driver currently selects the
> > > MFD_ATMEL_HLCDC symbol, which as I understand will cause a Kconfig er=
ror
> > > if the latter isn't defined.
> >=20
> > s/select/depends on/ for the desired effect.
> >=20
>=20
> Don't forget the atmel-hlcdc.h header file which is referenced by both
> the DRM and the PWM drivers.

The depends on will prevent the PWM driver from being built until MFD
becomes available, so the missing header file shouldn't be a problem.

That said, Nicolas Ferre (Cc'ing) at some point requested this to become
a select (or at least for the DRM driver, but I guess the same applies
to PWM) on the grounds that a depends on will make it more difficult to
enable the driver.

So we have two options here: 1) turn the select into a depends on here
and allow the dependency to be resolved that way, or 2) solve the
dependency by making sure the MFD part is merged first (either by
pulling the MFD tree into the PWM and DRM trees or waiting for a full
cycle for the MFD changes to land).

I don't mind either way.

Thierry

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM9SxAAoJEN0jrNd/PrOhIXwP+gIVySCtmuEOHCfggonSXtpN
pOsXMBuJ6QVRIv3byvDhF2S6pIxYJurkSesJ5ISLBLM7rFQpQTsx9Bz8MLhjheyh
AOpqak83D/OP6g7sI9z9Cn+lbmCQv+EmqYX8T9XasSc4M/Dva1P3epIjBUErpqI5
w5ndL47cwzwxiwALE4TkXL28Kq9U08DOfwxjYwSXq1OY7dIo68GDtKHB0gEGRzhF
EbmGfIV6op8Hdz4odmTvn9IzwvvOcis2Gj1Qie2pkkYbI5Nk3K7NM75ShdjgjdS1
CM1k6rjyo9gxYVBLtcYS85+ekl6BzTIVmkx0+XSBpZoKk98ow6JROFV5ZN86G3Md
nRFZ4VBifTCBqAnVaQd8FT2muV0GEQg2DwKQOIxQy/zuEU/Q35kyBucSIDYHr+om
gT4LATzBdSiGWjwz+ZDwBGB5B9oIh3Tssin2r7C7UGelcgXzUSyXocNtL/LDac2H
o4sn0yW1kJQOgvRHJfpYrDujQbjFRKg5dhPDW6ePCkbCzFPGpl+LziicGr+WSANY
8FRwfAWuAh/h/EWy/54Dhnn9xsC4C/XjJZOTbX9qISaYMofLH7vvNbn7xOAKG8tH
9CioWxGSffH0G3nLizfZskvoaH27x1v7WMsvsym254X1XIB7H2XlGctAUOFnctQG
fzwZhad1f5LLhe0Nx/Lv
=b2Ry
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

--===============0775918928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0775918928==--
