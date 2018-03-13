From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
Date: Tue, 13 Mar 2018 16:32:35 +0100
Message-ID: <20180313153235.zyuelfcmayc6s73z@flea>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-4-andre.przywara@arm.com>
 <20180307074516.dbak7ztkua4p7mr5@flea.lan>
 <f001134a-987d-2491-a22e-d1d634f7b024@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4868719150356676472=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f001134a-987d-2491-a22e-d1d634f7b024@arm.com>
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


--===============4868719150356676472==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brldrkr34ipq6igk"
Content-Disposition: inline


--brldrkr34ipq6igk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 02:05:34PM +0000, Andre Przywara wrote:
> Hi Maxime,
>=20
> thanks for looking into this and for the Acks!
>=20
> On 07/03/18 07:45, Maxime Ripard wrote:
> > On Wed, Mar 07, 2018 at 02:07:17AM +0000, Andre Przywara wrote:
> >> While the PWM IP in the Allwinner H6 SoC is fully compatible to those
> >> used in older SoCs (H3, A64), it features a dedicated reset line which
> >> needs to be de-asserted.
> >> Add support for an optional "resets" DT property in our pwm-sun4i probe
> >> routine, and assert and de-assert the reset line, where needed.
> >> This allows to enable PWM support on the H6.
> >=20
> > This isn't optional then. It's mandatory on the H6, and unneeded on
> > everything else. This is what we should have.
>=20
> So are you aiming at:
> 	if (of_device_is_compatible(np, "allwinner,sun50i-h6-pwm")) {
> 		... devm_reset_control_get() ...
>=20
> I guess this is preferable over coding something based on a new member
> in struct sun4i_pwm_data?

It's basically a long term vs short term debate :)

If we're thinking short term, then yes, sure it would make
sense. However, if we start having more and more SoCs, we'll have a
longer and longer condition.

Since we already have a structure available, I'd still prefer to go
for the structure flag. This is faster (no string comparison), it'll
be easier to extend, and the patch size is pretty much the same.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--brldrkr34ipq6igk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqn7xIACgkQ0rTAlCFN
r3SvEQ//U42v6hNTxLugEFv1QTsbpIwgqK9nr/AvEEIBZvoUVjtfh+WA7qNra0tF
GlJHvYIF/U+y3UHgUtMfRy9u7ElVTtzB3mdO+L26SW3MTaHyAwlmR58zBj8D1uO5
uNoVcWDPwBm9GvgUPntiKPAEM2PNh39VMYheadCQoeDc1YTCBpxxkzcN1Wpsg3x6
qBHoNnbrm32OxzTT0RY7FHeyNfIT+kSdVejeV2ycJDa5OVScswO0gdJ1gXmcLlru
SXcftKF3HcBQj+2YkUTDPTNMN6J6nM5wfJh1mIlg6kjzrLuLS2x2wRHrWdEsfl/f
kc9/yfCu4EhiI9N30ZKKNwl2iN5YTI6ziIUr9cVozC8iu13nj0V0p+eWBVIvq1So
v7xE9t4vGzDfqWShf8Fns0FHKe4a4jrpOxKct7gzKbSTDnV036kzBEVc0CCG+Qlg
8uIj9MLRGzP1sYTegzF5+BqBnEbR9A4b8pw4rg2QZf5NSgJd3LqWli63MqxVTKtP
Sx2YnjSH0dyZFxfYS+E5cy60Rb8scCzJS1gzQbadVkJcO2JZuJHyD/dasdV8JnG6
xb+1U+53yyeO5QYgxmhthKJrQkUFNvEJW1QufNt8dCyf0NT4U8g0shXn9fb7Jc89
kxvFXKb2HkLaOoUziFPEyUSC5+yoPN7vvSOmbWDt6uBW9fRSJKk=
=0o2Y
-----END PGP SIGNATURE-----

--brldrkr34ipq6igk--


--===============4868719150356676472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4868719150356676472==--
