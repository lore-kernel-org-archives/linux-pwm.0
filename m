From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 14:56:26 +0200
Message-ID: <20140721125624.GF15238@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo> <20140715120619.7f29c458@bbrezillon>
 <20140715103136.GA6616@ulmo> <20140718165152.0a9fde09@bbrezillon>
 <20140721121513.GB15238@ulmo> <20140721143321.5bda6ea9@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0261748964=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140721143321.5bda6ea9@bbrezillon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============0261748964==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 02:33:21PM +0200, Boris BREZILLON wrote:
> On Mon, 21 Jul 2014 14:15:16 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Fri, Jul 18, 2014 at 04:51:52PM +0200, Boris BREZILLON wrote:
> > > Hi Thierry,
> > >=20
> > > Oops, I missed this reply.
> > >=20
> > > On Tue, 15 Jul 2014 12:31:37 +0200
> > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >=20
> > > > On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> > > > > On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding <thierry.reding=
@gmail.com> wrote:
> > > > > > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > > > [...]
> > > > > > > diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcd=
c-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > > > [...]
> > > > > > > +The Atmel HLCDC Display Controller is subdevice of the HLCDC=
 MFD device.
> > > > > > > +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt fo=
r more details.
> > > > > >=20
> > > > > > I think it's better to refer to these using relative filenames.=
 When the
> > > > > > device tree bindings are moved out of the kernel tree, they may=
 no
> > > > > > longer use the same hierarchy.
> > > > >=20
> > > > > Sure.
> > > > > By relative path you mean ../../mfd/atmel-hlcdc.txt or just
> > > > > mfd/atmel-hlcdc.txt ?
> > > >=20
> > > > I think the former is more explicit.
> > >=20
> > > Okay.
> > >=20
> > > >=20
> > > > > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > > > > +   The first cell is a phandle to a DRM panel device
> > > > > > > +   The second cell encodes the RGB mode, which can take the =
following values:
> > > > > > > +   * 0: RGB444
> > > > > > > +   * 1: RGB565
> > > > > > > +   * 2: RGB666
> > > > > > > +   * 3: RGB888
> > > > > >=20
> > > > > > These are properties of the panel and should be obtained from t=
he panel
> > > > > > directly rather than an additional cell in this specifier.
> > > > >=20
> > > > > Okay.
> > > > > What's the preferred way of doing this ?
> > > > > What about defining an rgb-mode property in the panel node.
> > > >=20
> > > > There's .bpc in struct drm_display_info, I suspect that it could be=
 used
> > > > for this. Alternatively, maybe we could extend the list of color fo=
rmats
> > > > that go into drm_display_info.color_formats? RGB444 is already cove=
red.
> > >=20
> > > I don't think this color_formats field is intended to represent data
> > > stream format going through the bus.
> > > Moreover, AFAIU, RGB444 in this definition represent RGB 4:4:4 (chroma
> > > subsampling rate) and not 12 bits signals (4 bits for each color).
> > >=20
> > > Anyway I'll propose a patch series adding a new field to
> > > drm_display_info to encode the mediabus format (as discussed with
> > > Laurent and you).
> > >=20
> > > >=20
> > > > Also, like Laurent said, this shouldn't go into the device tree, si=
nce
> > > > it's already implied by the panel's compatible value, so we'd be
> > > > duplicating information.
> > >=20
> > > Again, this is not necessarily true (depending on your board design).
> > > One can decide to connect an RGB888 panel on an RGB666 bus and connect
> > > the missing pins to ground.
> >=20
> > I think in that case the board design itself could be considered as an
> > RGB888 to RGB666 bridge, and I think that's what the device tree should
> > be describing rather than a panel with a variable number of input
> > formats.
>=20
> So, you're suggesting to add an RGB to RGB drm_bridge driver (and
> the appropriate DT bindings) to handle this case, right ?

Yes, exactly.

Thierry

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzQ34AAoJEN0jrNd/PrOhN1EP/20lQDIjPPUQj2DRQdvKtOeU
7zRyNlDQPismCfs1smIB3nqxkGpvA/tU4TcbHKbyr1fRgq2GZ+/1CloaZTgHy3Ly
ObGTd7MXZR8HydIYxwumbBvHaWgYVfa0z8/7A4slM46XQytT2unri6onjnTC+Lfn
C+xP5h4AZpyn/BAcezksV8WfIthZvjhrSu8sSYIQqruyBYIqWRU3vniYX+rWTthw
hMfRRr4AuKCInL4fQnJu1HLVZxdY9vvDLzOqYrwVsMBQa82t/mS/giC0r8eY7+MN
yQuJ4QhF11SZsCRpRji17dXLfHs+/X+lzKTwRkQoDk+H1kOqaDFLdPBEbXx6l8eL
GX+qfRvNKzPTzhIa2doqJuB3Dcpt4OfiVvHPhxi2zH7kGi5cfPpusK0xf55ZZO1I
49MzqYW8c6X3eWWv5QB0Tk4nEKMmXw0YdAIxNBEs7Y5VZo8QoKq2xWnF6QOUZVdV
L85QZuQFL+SW/XuG99eJn61ILBHMLuZX6wu2y3APCEoJVM1cTjy+oSOgxzDibLDF
G/ghkAfSYoyQ8Mx4U5gOnEWDcvnO0AE5JKfFqmIP0Pe5wD0vxyeUIDboDpQ9I0ol
Gzcnc5+e4R/oGQSQGdD4qhjjJUsyzQdS+Un0iqraI7ZEvP+CL6hnYYLNx406Clhg
01l7z8dvbIlTsFuWner3
=OWNM
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--

--===============0261748964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0261748964==--
