From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v1 4/4] ARM: dts: add pwm node for r40.
Date: Mon, 15 Jan 2018 09:38:13 +0100
Message-ID: <20180115083813.ad2yqdwnd2nskbhs@flea.lan>
References: <20180111113412.GA22008@arx-s1>
 <20180111124752.2ljspnaclwgz2s62@flea.lan>
 <CAJeuY78QLOYZUUS7ghakqqpdzigdvpdHCsw+6onkUCjgZMqTzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xi5fxeg7t5tmwzps"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJeuY78QLOYZUUS7ghakqqpdzigdvpdHCsw+6onkUCjgZMqTzA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hao Zhang <hao5781286@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--xi5fxeg7t5tmwzps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 14, 2018 at 02:43:39PM +0800, Hao Zhang wrote:
> 2018-01-11 20:47 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.co=
m>:
> > On Thu, Jan 11, 2018 at 07:34:12PM +0800, hao_zhang wrote:
> >> This patch add pwm node for r40.
> >>
> >> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8=
i-r40.dtsi
> >> index 173dcc1..84c963c 100644
> >> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> >> @@ -295,6 +295,11 @@
> >>                               bias-pull-up;
> >>                       };
> >>
> >> +                     pwm_pins: pwm-pins {
> >> +                             pins =3D "PB2", "PB3";
> >> +                             function =3D "pwm";
> >> +                     };
> >> +
> >
> > Is it the only combination of pins that is usable?
> >
> > If so, you can add the pinctrl-0 property directly in the pwm nodes.
> >
>=20
> There are 8 channel pwm of R40/V40/T3, the pins that can be configed
> to pwm are: PB2, PB3, PI20, PI21, PB20, PB21, PB9, PB10

And a single controller, or several of them?

> PB2, PB3 can be configed on bananapi-m2-ultra and on my T3 board,
> but the other pins is not exist on the board or some pin is confilct
> with other functions, so i just add PB2, PB3. but i think split it
> is better, just like this :
>=20
> pwm0_pin: pwm0-pin {
>     pins =3D "PB2";
>     function =3D "pwm";
> };
>=20
> pwm1_pin: pwm1-pin {
>     pins =3D "PB3";
>     function =3D "pwm";
> };

Yep, that would be better. If it's just a matter of channels, maybe we
can even name them pwm-ch0-pin and pwm-ch1-pin? That would be more
explicit.

> the node of pwm2~7 should also be added here?

If there's no users, no.

> On sun8i-r40-bananapi-m2-ultra.dts:
> because of the special customize board, i think just add pinctrl-0 =3D <&=
pwm0_pin>
> (PB3 I just use to test pwm channel 1)for bananapi-m2-ultra board is enou=
gh.
>=20
> &pwm {
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&pwm0_pin>;
>     status =3D "okay";
> };

It depends if that PWM is used as a PWM all the time (for example to
drive a backlight for a panel tied to the board), or if it's exported
through one of the generic pin headers, please leave it populated but
disabled (with a comment that it is exported on one of the pin of the
headers)

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--xi5fxeg7t5tmwzps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpcaHQACgkQ0rTAlCFN
r3Rw7A/9F7tvgat5QMbBVrzzAXuXFFWLRykj15WPc/JeuLlwkLXLjcfpe/XPeQ7J
N8VvN+UXd8xtb9fHFbZVLO9j0lJ7UGRbdTNUUgWfzCBFGAyEjop4LjVns6Pcu263
LorGoG6vf+ZNlKVG5BD58OjOg5IPFQK8XfpYKVfqqWK0dvkMxUbK7teQguq8PHun
X5FazfI06aBzNriv9fscyupVz6mxUOiqGeNgKzx9/1jp1M2qGqU2bLnd+5ilC1Uw
y5TdYWT3cr312hT9F28wxiu8acEOBmEm7E34x8xOihCpaaRYVIDcnwv1UC+68/hD
bAs0jmLfi+ft07tcNYiYM53WNV5zAVCFM+WKxOfOtBk9fSTkcIH4Cz5RYLHD7llk
nK45dUXS2ydErgbRu8r0jLqhYDhMqUU5hd6PB3+PpKiBXelOOEm4zug2OCPe4lx9
yktZ3bqF7ZNBdqWj9YrfMaaKBZX06ild6zhyCkH1gplZzO2LfrGTn1G+i3BDbBoa
iZUzDimQiLttQlEVMeu86dCNYeA+zKZumLVNBB6pLC3ndowgasMz7tn3Jslumazq
u4HobJhDNGG7yhlZhc4E5qYPISZNmNva8XN5dGp5hQXGszek3cAn2BppK6IwsuOH
aFnrJ4wf3k7eO+Dln4L2MIVIDOsRZ2mbptXy9or5DOl6XZBiXcA=
=JObA
-----END PGP SIGNATURE-----

--xi5fxeg7t5tmwzps--
