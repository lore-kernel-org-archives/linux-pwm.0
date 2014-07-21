From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 15:26:12 +0200
Message-ID: <2273675.A51UonkrgF@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140721143321.5bda6ea9@bbrezillon> <20140721125624.GF15238@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0475406756=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140721125624.GF15238@ulmo>
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


--===============0475406756==
Content-Type: multipart/signed; boundary="nextPart3588957.OQjje9jzoQ"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3588957.OQjje9jzoQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Monday 21 July 2014 14:56:26 Thierry Reding wrote:
> On Mon, Jul 21, 2014 at 02:33:21PM +0200, Boris BREZILLON wrote:
> > On Mon, 21 Jul 2014 14:15:16 +0200 Thierry Reding wrote:
> >> On Fri, Jul 18, 2014 at 04:51:52PM +0200, Boris BREZILLON wrote:
> >>> On Tue, 15 Jul 2014 12:31:37 +0200 Thierry Reding wrote:
> >>>> On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:=

> >>>>> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> >>>>>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrot=
e:

[snip]

> >>>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> >>>>>>> +   The first cell is a phandle to a DRM panel device
> >>>>>>> +   The second cell encodes the RGB mode, which can take the
> >>>>>>> following values: +   * 0: RGB444
> >>>>>>> +   * 1: RGB565
> >>>>>>> +   * 2: RGB666
> >>>>>>> +   * 3: RGB888
> >>>>>>=20
> >>>>>> These are properties of the panel and should be obtained from
> >>>>>> the panel directly rather than an additional cell in this
> >>>>>> specifier.
> >>>>>=20
> >>>>> Okay.
> >>>>> What's the preferred way of doing this ?
> >>>>> What about defining an rgb-mode property in the panel node.

[snip]

> >>>> Also, like Laurent said, this shouldn't go into the device tree,=

> >>>> since it's already implied by the panel's compatible value, so w=
e'd
> >>>> be duplicating information.
> >>>=20
> >>> Again, this is not necessarily true (depending on your board desi=
gn).
> >>> One can decide to connect an RGB888 panel on an RGB666 bus and co=
nnect
> >>> the missing pins to ground.
> >>=20
> >> I think in that case the board design itself could be considered a=
s an
> >> RGB888 to RGB666 bridge, and I think that's what the device tree s=
hould
> >> be describing rather than a panel with a variable number of input
> >> formats.
> >=20
> > So, you're suggesting to add an RGB to RGB drm_bridge driver (and
> > the appropriate DT bindings) to handle this case, right ?
>=20
> Yes, exactly.

Wouldn't it be possible to implement RGB666 -> RGB888 support in a less=
=20
complex way ? A standalone driver to describe signal routing seems like=
 an=20
overly complex solution to me. I would prefer making the routing a prop=
erly of=20
the link instead of a separate device.

=2D-=20
Regards,

Laurent Pinchart

--nextPart3588957.OQjje9jzoQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTzRT0AAoJEIkPb2GL7hl1f3gH+wUUwsZqOTwdYRHYLdJneW0L
LHHxTztWlbK+YuZ/p+gGjpbLf6dJydVrSg0ngTlOcp1XE6TMeIb33hBPDWEriu0o
36txqOFNFXRuWjWgHQQ8XddkOEKvMOKk926ERpqlmPIccV42yBDUJUHbpaguPid1
Uki2paXO/3V4sQ5lP8O43tjpNpdi5SwYGHs7vbl5EAp0CpaKPBGOWA28JzqG58gz
Hdpa2uezQu8fENL+pI45BdW8QSZu6kx7Nis9vvBbNUgIuUYcXKjW+YPSb2cqAogm
i3Nx0V1gqIP40aoqtTtNWxpDc/PJ8FeR/mqR4TIELnPT4mXPW6/iO1p6YgXM8Lk=
=/Zms
-----END PGP SIGNATURE-----

--nextPart3588957.OQjje9jzoQ--


--===============0475406756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0475406756==--
