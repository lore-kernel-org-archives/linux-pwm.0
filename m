From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 6 Oct 2014 12:54:34 +0200
Message-ID: <20141006105433.GG25202@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-7-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2123503361=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412175188-28278-7-git-send-email-boris.brezillon@free-electrons.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Mark Yao <mark.yao@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org


--===============2123503361==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 04:53:03PM +0200, Boris Brezillon wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
>=20
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
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 53 ++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/D=
ocumentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> new file mode 100644
> index 0000000..ebc1a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> @@ -0,0 +1,53 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
> +
> +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> +See ../mfd/atmel-hlcdc.txt for more details.
> +
> +Required properties:
> + - compatible: value should be "atmel,hlcdc-display-controller"
> + - pinctrl-names: the pin control state names. Should contain "default".
> + - pinctrl-0: should contain the default pinctrl states.
> + - #address-cells: should be set to 1.
> + - #size-cells: should be set to 0.
> +
> +Required children nodes:
> + Children nodes are encoding available output ports and their connections
> + to external devices using the OF graph reprensentation (see ../graph.tx=
t).
> + At least one port node is required.

Are the connections configurable at runtime? Does the SoC have IP blocks
for HDMI or other types of outputs or does it provide only RGB output to
external blocks?

When you say "at least one port", how are multiple ports going to work
if you have only a single display controller?

Thierry

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMnTpAAoJEN0jrNd/PrOhUn0P/A2lojPJ+gPloP7KlZqjKsUs
kbB5o0sCvIThRWB5lCw+md/C1tvir+dCVrqBE69r6kB8NiInOUdfHRZON+PZiyDc
KBDAffKPzXNz4wl9LJwdpdm0AWqivZpxvL/n3abvfsZsUt6Sw0svt9yWW6NeStzJ
AWNLghyx8pVNnZggiYgoA502Xhcd2nwtYab72PS54LRXZoOBIVHifJgaVBgScvvf
Y9bxJYQ/Clyf2AOm3Rb4CoUsmJTACOIoDDwIDdsZK+tIf3MlUub27O76+/fiZ2uv
2LbYuT+rB9Jg0e7haF5RcsQhyoNg5/KO6gIsEp/YyYu0lesFwR2A8g2XIHLU9OzA
MyZhMX3byve4+myNYWqwvWrBfUHjxYtB3U4M6vkPiR11OpzxRJteglCAw7EDtX/V
tiMpITZk6DcwIzjU4WF5pXkrJn732AhgrOaQrdGc/nY/WGCB1obOYHZusNrJQWFj
SEWSKtFhPp54cUGu/DHOhr1v6CqPZ1jHXPSz+4stmjdrgZ0oG30SWWrYTVKzWG9b
t8ECQAT+POBBp2VyArUHTwEIlH9+r8RuZ9kEqWLbxvhnqLQmCbKO8AN8bhW/jeUR
KznMESMh0uZWjzTNxas+ruG2gt789C7lBaFTh04xwS1nrWT0AsL6FmOPaNHn7Tbr
FrrKOJswUV94UJJOihQz
=LgoW
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--

--===============2123503361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============2123503361==--
