From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
Date: Mon, 6 Oct 2014 14:40:15 +0200
Message-ID: <20141006124014.GD26833@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-11-git-send-email-boris.brezillon@free-electrons.com>
 <20141006110115.GH25202@ulmo> <20141006142538.76d2df29@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1665842424=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141006142538.76d2df29@bbrezillon>
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


--===============1665842424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 02:25:38PM +0200, Boris Brezillon wrote:
> On Mon, 6 Oct 2014 13:01:16 +0200 Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> > On Wed, Oct 01, 2014 at 04:53:07PM +0200, Boris Brezillon wrote:
> > [...]
> > > diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sa=
ma5d3xdm.dtsi
[...]
> > > +		backlight =3D <&backlight>;
> > > +		power-supply =3D <&panel_reg>;
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> > > +		status =3D "disabled";
> > > +
> > > +		port@0 {
> > > +			#address-cells =3D <1>;
> > > +			#size-cells =3D <0>;
> > > +
> > > +			panel_input: endpoint@0 {
> > > +				reg =3D <0>;
> > > +				remote-endpoint =3D <&hlcdc_panel_output>;
> > > +			};
> > >  		};
> >=20
> > There's no support for OF graphs in simple-panel, so this is unused,
> > isn't it?
>=20
> Actually I use it in my atmel_hlcdc_ouput implementation to figure out
> the link between a panel and a device connected on the RGB/DPI bus.=20

That's kind of weird and one of the reasons why I can't make myself like
the OF graph bindings. It requires drivers for one device to reach into
the device tree node of some other device and look for content. Or put
another way, a DT node for a panel that works on one platform doesn't
work on another because the display controller needs additional DT
content that isn't required by the original binding for the panel.

Thierry

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMo2uAAoJEN0jrNd/PrOhev0QAIy54IWOvWGVgP6gPbnSqfNd
ERgjVfwptdHhpAK+IV3zBgK2lk/M9E3GMAgcqU33ThNgnKxfCDHngJndQpOf0g8w
GZFs1AqMvMOdF84Qf/phJ8i4ZuG2DdS8wdP6QG1ru13iwYcU3NsWfgU1ByVs92rG
hlo6OBXZ2HCXPlY+uC1nee56A2NHzxVumg2nr2QWwxItSTm15KNVRCobu3RqIQrg
s1w3dvoFGlSC+pSyuz3pkrIwL/7o3yQ+OA47mUadVWa6N7FX4RolPKEzaV1sMm+E
Y6LlDCxPl00hSxMek5WSf4zD/EhrkRIntfwUvUH7QzIUsB32Zd0xnGbCAqfUAPFd
PU1UC2XXi3wOdGo//fXwlFWL1xTlyzY/EpqANaApLFiAm17NNV7syjsn/i33oo1M
YXy9S9WIWhLX5vq4/5N1483x6ZQxAKrSML3aeHJUIiNlWXeHsJjsxT8R8r0EjXhU
j1eoIpXtC6sF9o71PhmMfLonGX3PZRaw0fhWF8hyuvrqZqzwm578cNlNKj3wME+L
aUpCcZvWgStmLm1S8gNsM3obiqpjnPnHQd2oe1n3utxjvv7rvsm/f/uvtpAj3Gtj
aIlKPK+5qB8DoU7rS4BNbcRy5JQ5HMcFsOEpimlSOLVwPhmPXybLc6gW0QMXsQV2
jL/jZlBd6Grnod1n/uog
=hwdk
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--

--===============1665842424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1665842424==--
