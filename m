From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 12:37:19 +0200
Message-ID: <20140715103718.GB6616@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo>
 <20140715120619.7f29c458@bbrezillon>
 <1417324.PxofUz16v0@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:39729 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190AbaGOKhX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Jul 2014 06:37:23 -0400
Content-Disposition: inline
In-Reply-To: <1417324.PxofUz16v0@avalon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2014 at 12:20:02PM +0200, Laurent Pinchart wrote:
> Hi Boris,
>=20
> On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> > On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > > > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (=
i.e.
> > > > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> > > > controller device.
> > > >=20
> > > > The HLCDC block provides a single RGB output port, and only support=
s LCD
> > > > panels connection to LCD panels for now.
> > > >=20
> > > > The atmel,panel property link the HLCDC RGB output with the LCD pan=
el
> > > > connected on this port (note that the HLCDC RGB connector implement=
ation
> > > > makes use of the DRM panel framework).
> > > >=20
> > > > Connection to other external devices (DRM bridges) might be added l=
ater
> > > > by mean of a new atmel,xxx (atmel,bridge) property.
> > > >=20
> > > > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > > ---
> > > >=20
> > > >  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 ++++++++++=
+++++
> > > >  1 file changed, 59 insertions(+)
> > > >  create mode 100644
> > > >  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
>=20
> [snip]
>=20
> > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > +   The first cell is a phandle to a DRM panel device
> > > > +   The second cell encodes the RGB mode, which can take the follow=
ing
> > > > values: +   * 0: RGB444
> > > > +   * 1: RGB565
> > > > +   * 2: RGB666
> > > > +   * 3: RGB888
> > >=20
> > > These are properties of the panel and should be obtained from the pan=
el
> > > directly rather than an additional cell in this specifier.
> >=20
> > Okay.
> > What's the preferred way of doing this ?
> > What about defining an rgb-mode property in the panel node.
>=20
> You could do that, but it won't help you much, as the HLCDC driver must n=
ot=20
> parse properties from the panel node. You should instead extend the drm_p=
anel=20
> API with a function to retrieve panel properties. The HLCDC driver will t=
hen=20
> query the panel driver at runtime for the interface type. The panel drive=
r=20
> will get the information from hardcoded data in the driver, from DT or=20
> possibly in some cases by querying the panel hardware directly.

My preference for this would be that we either add this to some existing
structure (struct drm_display_info seems like a good candidate) or if
the number of parameters grows out of hands, then maybe even introduce a
new type of device that's specific for the interface. DRM panels are an
abstraction for panels, that is, interface-agnostic, and if we start
exposing interface specific parameters things will start to become very
unwieldy.

Thierry

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxQReAAoJEN0jrNd/PrOhUb0QAK6owMSdhlwuQf/A7ff+hSIW
VOjjs7Ndpcbq5rSvVunvTp/DHUzs2X3HU9uKRvf+zRR8cL6kXhHrwYSgRlEisFwP
51OUO4e3ThnWoH8n+uGcZUmg8yZf6hKrqKWNoCT29qGyGpJ8FOFHNgQq7fRajPwa
TntI9hmcbt3rimOcVQC7opdUU8N78YbpSA9qQ1gKEBJKiPIC5hAfbh30tIydMFAE
E7TWCcLmitY9sVf4ap1OQVpJFG3vuVP46WKMyZvUEnMGBsl6MfGqzFFqUCA1iSCs
w3Gj5pGwgwP0LBHZ60tz9QXhRIgPm/XKPgNKgDW7DCxC37Zb/VFE/wHvuDFl7EXX
Rhd1NkWmJoMviArGll2Cbx6kSILMdQwEIOyBZhrjDSt2J+Y80sH8EEwoNXreULxL
S9OhGOLfZr+Lh8HmnbtL7EX9Z4HZP3VPFl4AhMdpVbAWONng0ghgoMit8I0Y+xUZ
GRd06zJqatdTu/hiIxtIqVJgAnHQolGzUTtFgw/z1L26ggNsuqWBqAuQO5tuvO0/
UNEV0AgjT3c81DM8WjDQzmVrWdpVEr7FYgYXJgeRBei3a7t2eJVmhJVYpsH5+ATc
X5NWlePSn2iqCih/JP+DatnHkou6ZyRuu4lk2PvgPopuuJqR/jPJ7WSm0Zxyqy7q
2Na4P7ymWn7ROc5WpY0o
=ID3q
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
