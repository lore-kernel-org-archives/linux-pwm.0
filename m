From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/5] pwm: sun4i: simplify controller mapping
Date: Wed, 7 Mar 2018 08:44:25 +0100
Message-ID: <20180307074425.72s4zufhesxh3i6r@flea.lan>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-3-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8674248048013750601=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180307020719.6675-3-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============8674248048013750601==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aurcpak7v3r4mxbe"
Content-Disposition: inline


--aurcpak7v3r4mxbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 02:07:16AM +0000, Andre Przywara wrote:
> At the moment we assign our supported compatible strings to a respective
> instance of our sun4i_pwm_data structure, even though some of them
> are the same.
> To avoid further clutter, split out the three different combinations of
> features we have at the moment and name them accordingly.
> This should make it more obvious which compatible string to use for new
> SoCs.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--aurcpak7v3r4mxbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqfmFgACgkQ0rTAlCFN
r3TPfw//ZwL3Y4rcAcjZAJPKeY5PzlYHVyO1a17bwqvLTT3PPwJcvn86/QpCfgOz
JnB7PStFEF7TTBKjgI4FVuxtYOjInGUUNQTnRyC4oU7mBJUMN7FwRzuaBtPKZP0C
KwGtegqJMzRbpubPbqegHaMVVJo6yYBa2ZYeJDOQ/gS0ZgdwEGDC/7vDTHJxajB1
5pLSUvRBq2AFp/ZVuiVNi6/c0EtJPxL3pz05vyrIg1IgspBTWvxw9QTX5/hyMemW
mdrqmJwW+3l6x6w45vpf3UVgcvn4j5kucTdnvKWLmzE/J+6JvzhO5YJpXQjCD1Re
yGQjcjq8AIGwIgFDZhZUdZkDZXB2wN8pzyVlpDouYkqQBmxV2BA0kD0Lxk4o3yJJ
T2XljmGWiZ8q0e2WwuMoXzf/l28tfmZrVZuJkAbE8WgF7eIzPPd/yH0NljwJFXuB
/D3Jma+Y9dVz3JjfMkim4vv2+YysWideuifS5na5Zn9ucB0Xu0eWPn+NFCGXvDmQ
GeGCWdRGROVGSLPyeXmfxh0XEY+iI8lJIgFLnqlOp52gueM4Ii/onWtoI/44j1/S
oj9e7DWj3PzAyMHPEpj/LZrtOWuRCtizurfa/VUfMetsYpDWIYaF+sHHGdR5veL3
r0MrjjdK6A/NDyn9WiwV7nGQmHoUpvyMtEfcG8ac5SFVuvhhoy0=
=sDyF
-----END PGP SIGNATURE-----

--aurcpak7v3r4mxbe--


--===============8674248048013750601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8674248048013750601==--
