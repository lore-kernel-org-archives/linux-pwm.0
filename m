From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 12:52:54 +0200
Message-ID: <20140715105253.GE6616@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417324.PxofUz16v0@avalon>
 <20140715103718.GB6616@ulmo>
 <1645765.yCSTbHcZMC@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:55811 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758104AbaGOKw6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Jul 2014 06:52:58 -0400
Content-Disposition: inline
In-Reply-To: <1645765.yCSTbHcZMC@avalon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience>


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2014 at 12:43:02PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Tuesday 15 July 2014 12:37:19 Thierry Reding wrote:
> > On Tue, Jul 15, 2014 at 12:20:02PM +0200, Laurent Pinchart wrote:
> > > On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> > >> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > >>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > >>>> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs
> > >>>> (i.e. at91sam9n12, at91sam9x5 family or sama5d3 family) provides a
> > >>>> display controller device.
> > >>>>=20
> > >>>> The HLCDC block provides a single RGB output port, and only suppor=
ts
> > >>>> LCD panels connection to LCD panels for now.
> > >>>>=20
> > >>>> The atmel,panel property link the HLCDC RGB output with the LCD
> > >>>> panel connected on this port (note that the HLCDC RGB connector
> > >>>> implementation makes use of the DRM panel framework).
> > >>>>=20
> > >>>> Connection to other external devices (DRM bridges) might be added
> > >>>> later by mean of a new atmel,xxx (atmel,bridge) property.
> > >>>>=20
> > >>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > >>>> ---
> > >>>>=20
> > >>>>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++++++=
++
> > >>>>  1 file changed, 59 insertions(+)
> > >>>>  create mode 100644
> > >>>>  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > >=20
> > > [snip]
> > >=20
> > >>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> > >>>> +   The first cell is a phandle to a DRM panel device
> > >>>> +   The second cell encodes the RGB mode, which can take the
> > >>>> following values:
> > >>>> +   * 0: RGB444
> > >>>> +   * 1: RGB565
> > >>>> +   * 2: RGB666
> > >>>> +   * 3: RGB888
> > >>>=20
> > >>> These are properties of the panel and should be obtained from the
> > >>> panel directly rather than an additional cell in this specifier.
> > >>=20
> > >> Okay.
> > >> What's the preferred way of doing this ?
> > >> What about defining an rgb-mode property in the panel node.
> > >=20
> > > You could do that, but it won't help you much, as the HLCDC driver mu=
st
> > > not parse properties from the panel node. You should instead extend t=
he
> > > drm_panel API with a function to retrieve panel properties. The HLCDC
> > > driver will then query the panel driver at runtime for the interface
> > > type. The panel driver will get the information from hardcoded data in
> > > the driver, from DT or possibly in some cases by querying the panel
> > > hardware directly.
> >=20
> > My preference for this would be that we either add this to some existing
> > structure (struct drm_display_info seems like a good candidate) or if
> > the number of parameters grows out of hands, then maybe even introduce a
> > new type of device that's specific for the interface. DRM panels are an
> > abstraction for panels, that is, interface-agnostic, and if we start
> > exposing interface specific parameters things will start to become very
> > unwieldy.
>=20
> I agree with the goal of keeping drm_panel interface-agnostic. However, o=
ne=20
> way or another, interface parameters will need to be communicated between=
 the=20
> panel driver and the controller driver. My preference, if we need to exte=
nd=20
> the number and/or scope of parameters beyond what drm_display_info could=
=20
> reasonably contain, would be to implement a new drm_panel operation to=20
> query/configure interface parameters, using a structure that contains the=
=20
> interface type and a union of type-specific structures. This would keep t=
he=20
> API generic in the sense of not requiring explicit knowledge of all inter=
faces=20
> in the drivers, while offering the flexibility we need with a way to easi=
ly=20
> detect the interface type at runtime and react on unknown/unsupported typ=
es.

That's exactly what I was hoping could be avoided. If instead we modeled
the interface type as a bus, we could for example have an lvds_bus along
with an lvds_device and then use that as the natural place to store
these properties. Much like we do for DSI.

Thierry

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxQgFAAoJEN0jrNd/PrOht2wP/3MPDQvvGQoVKk5J8Pp6DzJ9
tbK8dWvjeoyGJH0Y1Tzx9WVnJ7pg7SP6ERMtUEIe8/0xgoxcN35TsBDTIblF06Za
5DvjHk4ARmIdGCJGysKm+aqpe2TqCbBAIUyzsOMIds7iIhaNDY4OjIZcAiRhtNlC
STdQByrrgHIAuvYaWgfHeS2h6diuLtP3Tz5AuW/5iKNfOkLO5iWHObxdC75gex1D
ZTv3O/36BoG0VqlhTy3b5OiIfrFasph3qoOxyr9uhtXAz4k0TDqYP1oWOBs9qrMR
j5oy+Sg1BE7rDazjYbE87QigZ8Hu3v+T5ODUlq3hFfOxafMaDj5K4H4gFhl559kt
cDKclLC8DROfhuVXcjgZ9AoYMHjCPgAU5Zzt2xdul2UN3SGUXE9P+ANlGO30fYS1
VC51acwqdBXz+z578VwnyE8NnjeVqmKh1Vtjr+eqU8qJtfYNFoWyokQ7iIncE0rd
+0nipmz5FOhY+0TNfgr1RIh+R9dD8fEn0PWGbrokJsUY9Na9d6YfbyoK5urYx0pb
ThcBDKTJq0O/lgGfZ4PtkkzsBhL17j26Y2CFAl2wkVSqbwKpOuZK8PQP3b59yhbs
Oapd2S1WDiaP8Z+q0NsbxjJ7TXjf3KbGLZsyQgRaGA1kyG4X+Y0/yi3KxZDYh0S0
QscUuIEJeZVGdoIhjQY8
=y9zU
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
