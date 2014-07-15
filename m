From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 12:43:02 +0200
Message-ID: <1645765.yCSTbHcZMC@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417324.PxofUz16v0@avalon> <20140715103718.GB6616@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1350475062=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140715103718.GB6616@ulmo>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org


--===============1350475062==
Content-Type: multipart/signed; boundary="nextPart6166125.pbvtJFaVzN"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart6166125.pbvtJFaVzN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Tuesday 15 July 2014 12:37:19 Thierry Reding wrote:
> On Tue, Jul 15, 2014 at 12:20:02PM +0200, Laurent Pinchart wrote:
> > On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> >> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> >>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> >>>> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoC=
s
> >>>> (i.e. at91sam9n12, at91sam9x5 family or sama5d3 family) provides=
 a
> >>>> display controller device.
> >>>>=20
> >>>> The HLCDC block provides a single RGB output port, and only supp=
orts
> >>>> LCD panels connection to LCD panels for now.
> >>>>=20
> >>>> The atmel,panel property link the HLCDC RGB output with the LCD
> >>>> panel connected on this port (note that the HLCDC RGB connector
> >>>> implementation makes use of the DRM panel framework).
> >>>>=20
> >>>> Connection to other external devices (DRM bridges) might be adde=
d
> >>>> later by mean of a new atmel,xxx (atmel,bridge) property.
> >>>>=20
> >>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.c=
om>
> >>>> ---
> >>>>=20
> >>>>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++++=
++++
> >>>>  1 file changed, 59 insertions(+)
> >>>>  create mode 100644
> >>>>  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> >=20
> > [snip]
> >=20
> >>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> >>>> +   The first cell is a phandle to a DRM panel device
> >>>> +   The second cell encodes the RGB mode, which can take the
> >>>> following values:
> >>>> +   * 0: RGB444
> >>>> +   * 1: RGB565
> >>>> +   * 2: RGB666
> >>>> +   * 3: RGB888
> >>>=20
> >>> These are properties of the panel and should be obtained from the=

> >>> panel directly rather than an additional cell in this specifier.
> >>=20
> >> Okay.
> >> What's the preferred way of doing this ?
> >> What about defining an rgb-mode property in the panel node.
> >=20
> > You could do that, but it won't help you much, as the HLCDC driver =
must
> > not parse properties from the panel node. You should instead extend=
 the
> > drm_panel API with a function to retrieve panel properties. The HLC=
DC
> > driver will then query the panel driver at runtime for the interfac=
e
> > type. The panel driver will get the information from hardcoded data=
 in
> > the driver, from DT or possibly in some cases by querying the panel=

> > hardware directly.
>=20
> My preference for this would be that we either add this to some exist=
ing
> structure (struct drm_display_info seems like a good candidate) or if=

> the number of parameters grows out of hands, then maybe even introduc=
e a
> new type of device that's specific for the interface. DRM panels are =
an
> abstraction for panels, that is, interface-agnostic, and if we start
> exposing interface specific parameters things will start to become ve=
ry
> unwieldy.

I agree with the goal of keeping drm_panel interface-agnostic. However,=
 one=20
way or another, interface parameters will need to be communicated betwe=
en the=20
panel driver and the controller driver. My preference, if we need to ex=
tend=20
the number and/or scope of parameters beyond what drm_display_info coul=
d=20
reasonably contain, would be to implement a new drm_panel operation to=20=

query/configure interface parameters, using a structure that contains t=
he=20
interface type and a union of type-specific structures. This would keep=
 the=20
API generic in the sense of not requiring explicit knowledge of all int=
erfaces=20
in the drivers, while offering the flexibility we need with a way to ea=
sily=20
detect the interface type at runtime and react on unknown/unsupported t=
ypes.

=2D-=20
Regards,

Laurent Pinchart

--nextPart6166125.pbvtJFaVzN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTxQW8AAoJEIkPb2GL7hl1LzwH/RUV9pwNoIE8Q/z+eWGb/NHJ
upGt2jmmfvhMq6WPvXbmHZPoYMIn6nqwsfKTJ3qPQHfV4QBXfc4IuwSmYSbOnd8X
28kWC/aodiMZ61o0Hlh72qmiWmIP48xZOvd/xZmdbOD/p92jJ4WEJPr5ROKX03ML
6vtjUAtDCmlmbZMlwaQCzld4P+r6COJdZ/tJdKSM/NAnYM3fnWkXaP1EsIxcu0pI
MKAln4gTcQqZx6gxXNzXEMlS8miqEo4aora1o0ubAy3A93HTKQO+a8H61Bn0BoC9
Qu1sPkFMvKe5XiV8SLLPoHnE07sbRGpGEOkOe63LKPzfUEyHZvLy7uatZ70QwiI=
=jpCw
-----END PGP SIGNATURE-----

--nextPart6166125.pbvtJFaVzN--


--===============1350475062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1350475062==--
