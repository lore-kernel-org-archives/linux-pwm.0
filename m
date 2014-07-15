From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 12:31:37 +0200
Message-ID: <20140715103136.GA6616@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo> <20140715120619.7f29c458@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0689415773=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140715120619.7f29c458@bbrezillon>
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


--===============0689415773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
[...]
> > > diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt=
 b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > [...]
> > > +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD dev=
ice.
> > > +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more d=
etails.
> >=20
> > I think it's better to refer to these using relative filenames. When the
> > device tree bindings are moved out of the kernel tree, they may no
> > longer use the same hierarchy.
>=20
> Sure.
> By relative path you mean ../../mfd/atmel-hlcdc.txt or just
> mfd/atmel-hlcdc.txt ?

I think the former is more explicit.

> > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > +   The first cell is a phandle to a DRM panel device
> > > +   The second cell encodes the RGB mode, which can take the followin=
g values:
> > > +   * 0: RGB444
> > > +   * 1: RGB565
> > > +   * 2: RGB666
> > > +   * 3: RGB888
> >=20
> > These are properties of the panel and should be obtained from the panel
> > directly rather than an additional cell in this specifier.
>=20
> Okay.
> What's the preferred way of doing this ?
> What about defining an rgb-mode property in the panel node.

There's .bpc in struct drm_display_info, I suspect that it could be used
for this. Alternatively, maybe we could extend the list of color formats
that go into drm_display_info.color_formats? RGB444 is already covered.

Also, like Laurent said, this shouldn't go into the device tree, since
it's already implied by the panel's compatible value, so we'd be
duplicating information.

> BTW, have you received this series [1] adding support for the LCD panel
> I'm testing this driver with.
>=20
> [1] https://lkml.org/lkml/2014/6/5/612

I don't think I've seen it in my inbox, let me check my archives.

> > > +   The third cell encodes specific flags describing LCD signals conf=
iguration
> > > +   (see Atmel's datasheet for a full description of these fields):
> > > +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> > > +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> > > +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> > > +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> > > +   * bit 4: DISPPOL: Display Signal Polarity
> > > +   * bit 7: DISPDLY: LCD Controller Display Power Signal Synchroniza=
tion
> > > +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Se=
tup Configuration
> > > +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Ho=
ld Configuration
> > > +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time
> >=20
> > Similarly for most of these: HSPOL and VSPOL seem to correspond to the
> > DRM_MODE_FLAG_{{P,N},{H,V}}SYNC flags in struct drm_display_mode. And
> > VSPDLYS as well as VSPDLYE sound like they may be vsync_start and
> > vsync_end of the same structure.
>=20
> I agree with HSPOL and VSPOL.
>=20
> >=20
> > As for the others, maybe if you could explain what exactly they are we
> > may be able to find a better fit.
>=20
> Atmel datasheets include several timing diagrams [2] (chapter "32.6.17
> Output Timing Generation" page 603), and I think you will get more
> informations from these diagrams than if I try to explain what I
> understood ;-).

These look like knobs to tune the signal in a very fine-grained manner.
To be honest, maybe the best way to solve this would be by omitting them
for now and choose some default that's likely to work on most devices.
Does the panel that you use specify how it expects HSYNC to be timed vs.
VSYNC?

Thierry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxQMIAAoJEN0jrNd/PrOhG1wP/2D/war7YM9nEJhi5vTN4RDe
QRDwO27UJyoZUHThISviuMxHYb6XHDBRuFmD9lo/kogDUxwA2u/+tLIup0l4p43u
eSqOo7MRQvA8Pewb97tuEIF0K5tuPA9Pq6z/Xl6rMPFSPmFvCBg0hJtFeV1RJf4b
bH4Z7ySxl4ctk1FcdxWC6g6ea6gsULhuA4SP58HGP0/AmvA12G1KlGcmC2ZzbwSj
tjvQle1Rowv82ckAdJGJshuVOJJS0ur0P1MfD5x7H1VaVQyOLTInYMPL1EsyMk4b
lNh4epbJDfeZxzrMEGr2l6742Opc1lx7G//swsRkmilaMMUb7X+FUtpBFf6Naakr
J8mlrIThmZL32m9cfsayK8OTOaThLaPXLoqq6eC15zokJLXEOf7t7pHcsnn31Tfn
UviVutEGNnftG80bsboFixHytI3w4lkPw/updsgWUxMX8jDJrQ6//psiVY8LHYIj
sWIb11CAJ2COgF8AEWqveTTa98PGKC4/8RUA9K90DypasLdZa1FP90SCP0I7QXb/
loZfRF+VLSkRxogB0sJ3YLDYBKndFrz0RxLucal+KudFZT+VgT2wBek3YD2dKmXU
xtwfVzCsgYWnvdw7lZNp1xpwh8ZJdqH2cgLNGBtm2sfTTGkLyR+6dxOYzsM2RAgY
5f6OWH7g7gybJG2WbCcD
=QU7x
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--===============0689415773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0689415773==--
