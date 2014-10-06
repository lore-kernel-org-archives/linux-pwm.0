From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v7 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
Date: Mon, 6 Oct 2014 15:30:59 +0200
Message-ID: <20141006133048.GE26921@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-11-git-send-email-boris.brezillon@free-electrons.com>
 <20141006110115.GH25202@ulmo> <20141006142538.76d2df29@bbrezillon>
 <20141006124014.GD26833@ulmo> <20141006151111.446ed7d6@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1077363403=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20141006151111.446ed7d6@bbrezillon>
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


--===============1077363403==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 03:11:11PM +0200, Boris Brezillon wrote:
> On Mon, 6 Oct 2014 14:40:15 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Mon, Oct 06, 2014 at 02:25:38PM +0200, Boris Brezillon wrote:
> > > On Mon, 6 Oct 2014 13:01:16 +0200 Thierry Reding <thierry.reding@gmai=
l.com> wrote:
> > > > On Wed, Oct 01, 2014 at 04:53:07PM +0200, Boris Brezillon wrote:
> > > > [...]
> > > > > diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dt=
s/sama5d3xdm.dtsi
> > [...]
> > > > > +		backlight =3D <&backlight>;
> > > > > +		power-supply =3D <&panel_reg>;
> > > > > +		#address-cells =3D <1>;
> > > > > +		#size-cells =3D <0>;
> > > > > +		status =3D "disabled";
> > > > > +
> > > > > +		port@0 {
> > > > > +			#address-cells =3D <1>;
> > > > > +			#size-cells =3D <0>;
> > > > > +
> > > > > +			panel_input: endpoint@0 {
> > > > > +				reg =3D <0>;
> > > > > +				remote-endpoint =3D <&hlcdc_panel_output>;
> > > > > +			};
> > > > >  		};
> > > >=20
> > > > There's no support for OF graphs in simple-panel, so this is unused,
> > > > isn't it?
> > >=20
> > > Actually I use it in my atmel_hlcdc_ouput implementation to figure out
> > > the link between a panel and a device connected on the RGB/DPI bus.=
=20
> >=20
> > That's kind of weird and one of the reasons why I can't make myself like
> > the OF graph bindings. It requires drivers for one device to reach into
> > the device tree node of some other device and look for content. Or put
> > another way, a DT node for a panel that works on one platform doesn't
> > work on another because the display controller needs additional DT
> > content that isn't required by the original binding for the panel.
>=20
> I also have a working POC of a DPI bus implementation (with DPI support
> in panel-simple driver).
>=20
> This is a solution I developed to provide a generic DPI implementation
> in my HLCDC driver and rely on generic external implementations for
> slave devices (panels, encoders, ...).
>=20
> But, IIRC, Laurent was not in favor of a bus approach because the DPI
> bus is just a data bus and not a control bus.
>=20
> Anyway, I'll clean it up and post an RFC.

According to the MIPI website there are also control signals and a
command set to control display behaviour. Does your implementation
handle any of that?

Thierry

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMpmIAAoJEN0jrNd/PrOh51YP/0kfP7SQppgCdVaCqJtq3oUw
1C7vEMfDrgGpZzrGkjkPIL600B6xvUsHeVu4zUZPhw14bEM6EBZhPi9KA7xoixDx
InbG+sMOTLX+jaQNTVvoJ9WnO6ikAgARKrZWmwUuxsAvFsia8TEJfNPRPYDB7kz6
R/XsA+LXzESjmvPlGtqeuzNKTh8c5o995pSj34WBZ1TeZsbwC8uee/o2Bo8Y9BDg
fpDh/lXEmzwWqTiJiE8vxJQOEXwhIsPo6fWrE9RjiTHu2BkEyQyd0ilVZUoedo39
ltbX9NUq4ztnGHKZ7jSNzuq+5yrOzxu2jsiqzvvXYgv3zSCg0snFTT6PjSTMtOE+
iNs7iqDHA3Fc8xZhwWO+FWoEI7S9p7E3TxbaK7axS17vqdDY5BtkBQvMBlW22UYj
ejbwMGp4BCv8VNy4kYeelSptr/ANpr/4tpqFS7oJF2cCmEoqzCul/NhdLAFIxn9q
ut0sYrdql9JkhqZziBOb7/APyA+ijQhpGxHkEe5TzApkecLRAlL73qlGYsxIBcIo
w5boyP1t2nac84UCR7NLy/n2MHTz3IIjsZqYnnxqrkf2+a+5xNyFiAMcbT7roN3M
EP0hrq+mCByKiFn4lOogZBxmgUihmJtXTCYnzZHZbOPLiPOKnvZC+9aVfAv3a0rL
HnMsg4anSaa6tHS03c9t
=yaay
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--

--===============1077363403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1077363403==--
