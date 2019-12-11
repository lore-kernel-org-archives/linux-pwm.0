From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6
 example
Date: Wed, 11 Dec 2019 10:20:16 +0100
Message-ID: <20191211092016.2hhjw6mn7iefupql@gilmour.lan>
References: <20191210174710.10649-1-peron.clem@gmail.com>
 <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
 <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tt72ar2obv6t5rpi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--tt72ar2obv6t5rpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 04:33:19PM +0800, Chen-Yu Tsai wrote:
> On Wed, Dec 11, 2019 at 4:06 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Tue, Dec 10, 2019 at 06:47:10PM +0100, Cl=E9ment P=E9ron wrote:
> > > Latest linux-next doesn't build due to the following error:
> > >
> > > Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.=
example.dts:35.37-38
> > > syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a=
10-pwm.example.dt.yaml]
> > > Error 1
> > >
> > > This is due to missing header in the device-tree yaml example.
> > >
> > > Fix this by adding the missing headers.
> > >
> > > Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM descrip=
tion")
> > > Reported-by: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> >
> > Applied, thanks!
> > Maxime
>
> Maybe squash it instead? :)

Indeed, I just did.

Thanks!
Maxime

--tt72ar2obv6t5rpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfC00AAKCRDj7w1vZxhR
xaW5AQD69VlsGmpCynvOIn/zNXum5pWnY3SEEbx2GLYyZPdLZQD/TXS6GjJD2+MJ
MiEEHgbac/j7/sn/oCxDjRN5XAUaoQg=
=9JT0
-----END PGP SIGNATURE-----

--tt72ar2obv6t5rpi--
