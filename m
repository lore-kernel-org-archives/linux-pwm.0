From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 04/11] pwm: add DT bindings documentation for
 atmel-hlcdc-pwm driver
Date: Mon, 6 Oct 2014 12:13:51 +0200
Message-ID: <20141006101350.GD25202@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-5-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1955827258=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412175188-28278-5-git-send-email-boris.brezillon@free-electrons.com>
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


--===============1955827258==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 04:53:01PM +0200, Boris Brezillon wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
>=20
> The HLCDC IP available in some Atmel SoCs (i.e. sam9x5i.e. at91sam9n12,
> at91sam9x5 family or sama5d3 family) provide a PWM device.
>=20
> The DT bindings used for this PWM device is following the default 3 cells
> bindings described in Documentation/devicetree/bindings/pwm/pwm.txt.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    | 55 ++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt b/=
Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> new file mode 100644
> index 0000000..86ad3e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> @@ -0,0 +1,55 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) PWM driver
> +
> +The Atmel HLCDC PWM is subdevice of the HLCDC MFD device.
> +See ../mfd/atmel-hlcdc.txt for more details.
> +
> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,hlcdc-pwm"
> + - pinctr-names: the pin control state names. Should contain "default".
> + - pinctrl-0: should contain the pinctrl states described by pinctrl
> +   default.
> + - #pwm-cells: should be set to 3. This PWM chip use the default 3 cells
> +   bindings defined in Documentation/devicetree/bindings/pwm/pwm.txt.
> +   The first cell encodes the PWM id (0 is the only acceptable value her=
e,
> +   because the chip only provide one PWM).
> +   The second cell encodes the PWM period in nanoseconds.
> +   The third cell encodes the PWM flags (the only supported flag is
> +   PWM_POLARITY_INVERTED)

Given that this already refers to the default 3 cells binding it doesn't
need to repeat part of the contents of pwm.txt.

With that fixed and assuming you'd like this to be merged via the same
tree that the DRM and or MFD driver is, this patch:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

If you'd prefer this to go through the PWM tree just let me know.

Thierry

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMmteAAoJEN0jrNd/PrOhC4oQAI4tSfBT34didBBqN/ZgdU88
1k4T1dpWQ1RmssgsEZvEEfUom8vNOBiWK6ThiwWHYs72Md05EJPBfHngHmKpzCGC
w5iq28fsHCytOVmlMu3vlEnCof6GzvQH8ak+HMYkqubwvbD0fFrpzq5DeBN7sp8J
3Ve2iEnMPwmkCPmt+ysi5/LufkiOz2cAYX8BggyoEYjZh/+tusVNbgLUGPQb9mJz
qt6kGqntPuzHeN5cgJGGmwHBaFmWhtQRtLlwi2k1km3HcfQqV1tQO9OfjrY6vLqi
zrculfc0XMCPIDzfyzLY9sD3OuiNBgsEPsBFgJV1moHDWy4Q7buUMmwWHrToiYT1
EGH/UBj4Cv06VO0VAgdBT4K9U5+uqHcUzLudBeWlxUgetHbRX6adLhjzVbSw2+18
uvOClGgJ8Rx8Ck5VXvUUg82rEYlnZ1Sjq8X+amFE0XOjC/gfhGkZoF8d8MiJ547s
F+H2FJprmItdCHYmv0MrYTavaOHFlcelxLTO1VXi4vYaPb4BeetmsxoBS6Z5uE3D
ImHFKRTvIYPbgqcyet1G1PGRMzEF8X836HlvrYt456NBFSH2RWEflxxxgyRiIdtl
cKjC2QN9A5jqf6E/2R9QDi1fyTyZi7CeVj+KhI4CA559l0po1tS8DWredvQBGWh+
Z1f6R5mmtEQNaUYeJ8gn
=jT6l
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

--===============1955827258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1955827258==--
