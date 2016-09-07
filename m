From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 3/4] pinctrl: sunxi: Remove unsupported PWM channel
 pinmux in H3
Date: Wed, 7 Sep 2016 21:54:53 +0200
Message-ID: <20160907195453.GE28134@lukather>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-4-woogyom.kim@gmail.com>
 <CACRpkdb7rr8Lpc6VZ4Ba=_YOwFDqVwwut1w_BDAfYHm6Qp=W_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1531566852405253900=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdb7rr8Lpc6VZ4Ba=_YOwFDqVwwut1w_BDAfYHm6Qp=W_g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Adamski <k@japko.eu>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>, Milo Kim <woogyom.kim@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jens Kuske <jenskuske@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--===============1531566852405253900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 07, 2016 at 09:41:19PM +0200, Linus Walleij wrote:
> On Wed, Aug 31, 2016 at 10:25 AM, Milo Kim <woogyom.kim@gmail.com> wrote:
>=20
> > H3 has single PWM channel. The second PWM channel is not supported,
> > so the pinctrl function should be removed.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Icenowy Zheng <icenowy@aosc.xyz>
> > Cc: Jens Kuske <jenskuske@gmail.com>
> > Cc: Krzysztof Adamski <k@japko.eu>
> > Cc: linux-gpio@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
>=20
> Maxime what is your opinion on this patch?

Chen-Yu is the Allwinner co-maintainer, so you can trust his Acked-by,
but you have mine too.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0HCNAAoJEBx+YmzsjxAgJ3oP/2wKE5mheG98smt4fsZgVCXa
sMsQEGtUfUfwhth9UWDweH/Eu3rRQoMq0VyZBbkGQaeoLp6whcdEi6pJQrl/VSNQ
rK6ynw/D6jz/UsZOuE6Ps3fiXMcXJP7LouSpZBP2TaFDYG2K//x6+qwJQERXLYg4
14HhhfIROpUVhv1PShYQl0KbYmr87STIVzyP5Yzx0XFVBcs++qKpbg2IYpdoyh6B
wiFHshNWWHFvhLc15uV170kferup+zUuA4sSIjWzpIYqWFiAXSADanPnY2PdLPU6
8P7izvF5jfl2o8oDN5MDJ9WWgRGTq0YqqvToMcQRrDVnLCOqYPeXv1DyK3QhCY9n
MHYTXNZW77UdOyLVgT8OQSNMU47pX1Vf3zGxPzTw+rnyuwVGju2qu5QGkmtZB0R0
KS4ov+fI27v8aUuTCgyKOyOOxqMclk6qx+dZK05EqM91vbzt3V2P3SH8YWti8a7b
Ms49U/oyn7YbkIEeUtRavlj6pL9kNwTT165xGLrn/TKt2Xb18GRigvHc7POtBCeN
X2b0cM2/U1nRx0tALj8gUhOHtyg1kqANCScF+nNh8wULHjT5pHzJxpMTRpv6Aprs
ItBNxCHxw204VJ5JJvOzXGgzCsT/qDY0f7IrB0wYYgNtTBOniMGJYChZXwyT3Z6i
0iGXa9Z0H8o5LF2UYgxl
=3lLA
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--


--===============1531566852405253900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1531566852405253900==--
