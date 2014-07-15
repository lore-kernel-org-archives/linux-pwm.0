From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 13:07:58 +0200
Message-ID: <1484511.NijXCAc7Hx@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1645765.yCSTbHcZMC@avalon> <20140715105253.GE6616@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1554947283=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140715105253.GE6616@ulmo>
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


--===============1554947283==
Content-Type: multipart/signed; boundary="nextPart2571326.jt6PdmGK5u"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2571326.jt6PdmGK5u
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Tuesday 15 July 2014 12:52:54 Thierry Reding wrote:
> On Tue, Jul 15, 2014 at 12:43:02PM +0200, Laurent Pinchart wrote:
> > On Tuesday 15 July 2014 12:37:19 Thierry Reding wrote:
> >> On Tue, Jul 15, 2014 at 12:20:02PM +0200, Laurent Pinchart wrote:
> >>> On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> >>>> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> >>>>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote=
:
> >>>>>> The Atmel HLCDC (HLCD Controller) IP available on some Atmel S=
oCs
> >>>>>> (i.e. at91sam9n12, at91sam9x5 family or sama5d3 family) provid=
es a
> >>>>>> display controller device.
> >>>>>>=20
> >>>>>> The HLCDC block provides a single RGB output port, and only
> >>>>>> supports LCD panels connection to LCD panels for now.
> >>>>>>=20
> >>>>>> The atmel,panel property link the HLCDC RGB output with the LC=
D
> >>>>>> panel connected on this port (note that the HLCDC RGB connecto=
r
> >>>>>> implementation makes use of the DRM panel framework).
> >>>>>>=20
> >>>>>> Connection to other external devices (DRM bridges) might be ad=
ded
> >>>>>> later by mean of a new atmel,xxx (atmel,bridge) property.
> >>>>>>=20
> >>>>>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons=
.com>
> >>>>>> ---
> >>>>>>=20
> >>>>>>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++=
+++++
> >>>>>>  1 file changed, 59 insertions(+)
> >>>>>>  create mode 100644
> >>>>>>  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> >>>=20
> >>> [snip]
> >>>=20
> >>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> >>>>>> +   The first cell is a phandle to a DRM panel device
> >>>>>> +   The second cell encodes the RGB mode, which can take the
> >>>>>> following values:
> >>>>>> +   * 0: RGB444
> >>>>>> +   * 1: RGB565
> >>>>>> +   * 2: RGB666
> >>>>>> +   * 3: RGB888
> >>>>>=20
> >>>>> These are properties of the panel and should be obtained from t=
he
> >>>> panel directly rather than an additional cell in this specifier.=

> >>>>=20
> >>>> Okay.
> >>>> What's the preferred way of doing this ?
> >>>> What about defining an rgb-mode property in the panel node.
> >>>=20
> >>> You could do that, but it won't help you much, as the HLCDC drive=
r
> >>> must not parse properties from the panel node. You should instead=

> >>> extend the drm_panel API with a function to retrieve panel proper=
ties.
> >>> The HLCDC driver will then query the panel driver at runtime for =
the
> >>> interface type. The panel driver will get the information from
> >>> hardcoded data in the driver, from DT or possibly in some cases b=
y
> >>> querying the panel hardware directly.
> >>=20
> >> My preference for this would be that we either add this to some ex=
isting
> >> structure (struct drm_display_info seems like a good candidate) or=
 if
> >> the number of parameters grows out of hands, then maybe even intro=
duce a
> >> new type of device that's specific for the interface. DRM panels a=
re an
> >> abstraction for panels, that is, interface-agnostic, and if we sta=
rt
> >> exposing interface specific parameters things will start to become=
 very
> >> unwieldy.
> >=20
> > I agree with the goal of keeping drm_panel interface-agnostic. Howe=
ver,
> > one way or another, interface parameters will need to be communicat=
ed
> > between the panel driver and the controller driver. My preference, =
if we
> > need to extend the number and/or scope of parameters beyond what
> > drm_display_info could reasonably contain, would be to implement a =
new
> > drm_panel operation to query/configure interface parameters, using =
a
> > structure that contains the interface type and a union of type-spec=
ific
> > structures. This would keep the API generic in the sense of not req=
uiring
> > explicit knowledge of all interfaces in the drivers, while offering=
 the
> > flexibility we need with a way to easily detect the interface type =
at
> > runtime and react on unknown/unsupported types.
>
> That's exactly what I was hoping could be avoided. If instead we mode=
led
> the interface type as a bus, we could for example have an lvds_bus al=
ong
> with an lvds_device and then use that as the natural place to store
> these properties. Much like we do for DSI.

And I believe that's what we should avoid ;-) First of all, let's not f=
orget=20
that Linux models control busses, not data busses. DSI is a special cas=
e as it=20
combines the control and data busses, but in the general case the same=20=

implementation isn't possible. An LVDS panel controlled through I2C nee=
ds to=20
be an I2C device sitting on an I2C bus.

Then, I believe it would make all drivers simpler if we had a single ob=
ject=20
type to deal with, with proper abstractions for bus types. A drm_panel =
that=20
can model panels regardless of the data bus type, with one operation th=
at=20
conveys bus-specific information, makes storing the objects and communi=
cating=20
with them simpler than having to deal with different kind of devices.

=2D-=20
Regards,

Laurent Pinchart

--nextPart2571326.jt6PdmGK5u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTxQuOAAoJEIkPb2GL7hl1IKcH/27zUiG9x+SL71RDxmJoDlKt
vX7JbLA5i2zKBnsZeZH/jCLJMXHj/LBXsvnw+C5GLAxM6LSO97TyTz8GDAyCxnlg
+dE3WhGnFfRYrNpYNUtqTP9YHHu8/NRZC/zvqO1PUNddBVdovf9j6+WfceirQYX4
2YCmazGAyWCOJJjkF5MRlqfZNB7y/KEY8o43n+sT/6N7BQ+oSxRvA93RmUPUWUg8
0VXo0BlJznFe/DtXh2cVA3vdLdhLGR1dsbER+0/MLrCe5zkIV2gJ7TlBxbol5rei
B7T9QGa7L97748OFoPHRM8lfWG/JJHsvOB8UEaR7DBWpw5TkRi2aEyJhNc9meT0=
=UT4u
-----END PGP SIGNATURE-----

--nextPart2571326.jt6PdmGK5u--


--===============1554947283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1554947283==--
