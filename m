From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 11/11] ARM: at91/dt: enable the LCD panel on
 sama5d3xek boards
Date: Mon, 6 Oct 2014 13:01:43 +0200
Message-ID: <20141006110142.GI25202@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-12-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1609784641=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1412175188-28278-12-git-send-email-boris.brezillon@free-electrons.com>
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


--===============1609784641==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Content-Disposition: inline


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 04:53:08PM +0200, Boris Brezillon wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
>=20
> Enable LCD related nodes.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/boot/dts/sama5d31ek.dts | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sama5d33ek.dts | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sama5d34ek.dts | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sama5d36ek.dts | 20 ++++++++++++++++++++
>  4 files changed, 80 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d3=
1ek.dts
> index 04eec0d..6e605fe 100644
> --- a/arch/arm/boot/dts/sama5d31ek.dts
> +++ b/arch/arm/boot/dts/sama5d31ek.dts
> @@ -33,6 +33,10 @@
>  				status =3D "okay";
>  			};
> =20
> +			hlcdc: hlcdc@f0030000 {
> +				status =3D "okay";
> +			};
> +
>  			macb1: ethernet@f802c000 {
>  				status =3D "okay";
>  			};
> @@ -46,6 +50,22 @@
>  		};
>  	};
> =20
> +	bl_reg: backlight_regulator {

No need to repeat the labels if they're already in the .dtsi file.

Thierry

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMnaWAAoJEN0jrNd/PrOhqLQQAJ67GFu6Rg1ip1QQ1ZQ26b7C
QoQBfj0fTqI2Oxnfk88131BlNdAu6RkJV2rG4nYUKo/tOnf/+RSp3NF1XMNQelAC
NBnpYdq00/13HMPHepx6jKweJVLceT1q9WZu649Wiii8RKSnefefUq2VlfGCeLFW
ttKBQRXXqm90VmApN69AvyRb6hLAWCabZBYWerHKnUJ6hvIUcOMvVXBTNfWGX4O+
dkwYMXkVrOZAeB1DLwZx1ZSRin3hoInWH/7LqiOyBk2fKKl4Id056GYT2wgC1fIw
kIHxI548GqJstHEMipWl4sSWTUfeV9hn5pObPL8BsDGVo5Ax9XOg4cMpXMAbfqHm
/UOC1fhC9wIUfuZkrdlLzWKUAG73ar0qRDa1HK/pyNzL9FpG7SoucfW7oCNeGI0h
TJh+Hy4xSlcazN767f7ng5ViGOat2FfNgmBV00/DIYe502uv2Z2YquWqw45j5QfE
7Q2Izqnv1jJKNfxJq4vhA9czYOPgGUG9i4bS1kP3p3wFB1aLyu6MjzkRRjjHyjMq
vztfZiFZIeDSRg3BZ5wBbURLxayaNizcCMfcB19DjVLVMwUG/7BU+PNVA+BVS/59
m6iPjs+BqB/B8HoC+roZR41TaIOTPfR9hUeK6MzdsAry+eop/MlPwvvHyGDRgYmL
fKJF1ERoDy14oev9a6I2
=CONy
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--

--===============1609784641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1609784641==--
