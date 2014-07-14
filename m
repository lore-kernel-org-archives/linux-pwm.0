From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 14 Jul 2014 12:05:43 +0200
Message-ID: <20140714100542.GB9870@ulmo>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1415375018=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
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


--===============1415375018==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> controller device.
>=20
> The HLCDC block provides a single RGB output port, and only supports LCD
> panels connection to LCD panels for now.
>=20
> The atmel,panel property link the HLCDC RGB output with the LCD panel
> connected on this port (note that the HLCDC RGB connector implementation
> makes use of the DRM panel framework).
>=20
> Connection to other external devices (DRM bridges) might be added later by
> mean of a new atmel,xxx (atmel,bridge) property.
>=20
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 ++++++++++++++++=
++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.=
txt

This is the wrong directory. Device tree bindings describe hardware, but
DRM is a Linux-specific framework. And yes, there are already files in
that directory, I know, but that doesn't make it any better.

I suggest either devicetree/bindings/gpu or devicetree/bindings/video.

> diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/D=
ocumentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
[...]
> +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more detai=
ls.

I think it's better to refer to these using relative filenames. When the
device tree bindings are moved out of the kernel tree, they may no
longer use the same hierarchy.

> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,hlcdc-dc"

There's only one value, so perhaps: should be "atmel,hlcdc-dc".

> + - atmel,panel: Should contain a phandle with 2 parameters.
> +   The first cell is a phandle to a DRM panel device
> +   The second cell encodes the RGB mode, which can take the following va=
lues:
> +   * 0: RGB444
> +   * 1: RGB565
> +   * 2: RGB666
> +   * 3: RGB888

These are properties of the panel and should be obtained from the panel
directly rather than an additional cell in this specifier.

> +   The third cell encodes specific flags describing LCD signals configur=
ation
> +   (see Atmel's datasheet for a full description of these fields):
> +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> +   * bit 4: DISPPOL: Display Signal Polarity
> +   * bit 7: DISPDLY: LCD Controller Display Power Signal Synchronization
> +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup =
Configuration
> +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold C=
onfiguration
> +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time

Similarly for most of these: HSPOL and VSPOL seem to correspond to the
DRM_MODE_FLAG_{{P,N},{H,V}}SYNC flags in struct drm_display_mode. And
VSPDLYS as well as VSPDLYE sound like they may be vsync_start and
vsync_end of the same structure.

As for the others, maybe if you could explain what exactly they are we
may be able to find a better fit.

Thierry

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTw6t2AAoJEN0jrNd/PrOh4gsP/1SHg7+qxWmieSCD5OhWvf7E
NXZrMnmu9/2lu7BGmPsUJNYLMWNYQVvFV4ja38irEzFTyCRgAwI/9S3VXTDYudmg
IhDlXS1ylqc98AGs8fdjkrmB6OFW3k3kLUhoANVylu6ZFNHxXXpvwXeBiVxEQwqW
Em0wClHOkgpIt5eE/Bz/Aj5M2wlBmzS3d2IGRLxVbVQTF9qo2Qtfh6erKPoPtaa6
PcewCE/7OeN+PFKI8jgWjKhXYnLPtHaIW+7vV9MfrGb+WZiT5rDB8aRoo0iueqDu
7i7cawPTOXdD3lEU66DnoICaa7tWtEkK/7uvg7WrHOSPk/YfQzrmpuCLZ0xYjcMu
2jWJMTUmsw/VXoVMcoYlkPoNms/8/UbM0z9xFjUZkz1nZKvdC9h0rHyEbcRRvZ0Y
2o3Qmpo36OF+ITu/DcSrqbpisUQOJYO3V1cYvNbb+5G5/STo1zcruUGZtx8VcYB1
I9IBT/nIP2MiKTefgIjGIXLucixJzw7RJbvb07RG9yp22dHiiYrOf0jR34zWwdFW
WzNkcOyv7kOpuJrlIgh3xBbH0vJYGmQTy5GMlnExUUDWW2zYxhULEiEKgbxOhnfb
JCz2kV4bANig+anccIzhgYf1Fj1ya7GBEjCUgL5QfLQxs4A21ycQvS/zpjqjQyZ/
2b3hc5YUCw4dsv2yZmtf
=Vm4+
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============1415375018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1415375018==--
