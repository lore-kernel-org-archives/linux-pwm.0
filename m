From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
Date: Mon, 8 Jan 2018 16:46:36 +0100
Message-ID: <20180108154636.vqwcyb4cznqyclip@flea>
References: <20171213144748.GA18267@arx-s1>
 <20171213154549.5zn4uxhsssqw3pb7@flea.lan>
 <CAJeuY79_w+8Gv=jRxK4tajiecNSAZkMGYY_d7PJmsjyOZHPkJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="smfllbht5q2nnop2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56662 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeAHPqk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jan 2018 10:46:40 -0500
Content-Disposition: inline
In-Reply-To: <CAJeuY79_w+8Gv=jRxK4tajiecNSAZkMGYY_d7PJmsjyOZHPkJw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hao Zhang <hao5781286@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org


--smfllbht5q2nnop2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 07:08:53PM +0800, Hao Zhang wrote:
> 2017-12-13 23:45 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.co=
m>:
> > Hi,
> >
> > Thanks for your patch!
> >
> > On Wed, Dec 13, 2017 at 10:47:48PM +0800, hao_zhang wrote:
> >> Pin function can not be match correctly when SUNXI_PIN describe with
> >> mutiple variant and same function.
> >>
> >> such as:
> >> on pinctrl-sun4i-a10.c
> >>
> >> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
> >>               SUNXI_FUNCTION(0x0, "gpio_in"),
> >>               SUNXI_FUNCTION(0x1, "gpio_out"),
> >>               SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
> >>                       PINCTRL_SUN4I_A10 |
> >>                       PINCTRL_SUN7I_A20),
> >>               SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
> >>                       PINCTRL_SUN8I_R40)),
> >>
> >> it would always match to the first variant function
> >> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
> >>
> >> so we should add variant compare on it.
> >>
> >> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> >> ---
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/s=
unxi/pinctrl-sunxi.c
> >> index 4b6cb25..f23e74e 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> @@ -83,9 +83,11 @@ sunxi_pinctrl_desc_find_function_by_name(struct sun=
xi_pinctrl *pctl,
> >>                       struct sunxi_desc_function *func =3D pin->functi=
ons;
> >>
> >>                       while (func->name) {
> >> -                             if (!strcmp(func->name, func_name))
> >> +                             if (!strcmp(func->name, func_name)) {
> >> +                                     if (!(func->variant) ||
> >> +                                        (func->variant & pctl->varian=
t))
> >
> > I guess it would be better to have:
> >         if (!strcmp(func->name, func_name) &&
> >             (!func->variant || (func->variant & pctl->variant)))
>=20
> It would over 80 characters, can i change it by this ?
> if (!strcmp(func->name, func_name) &&
>          (func->variant & pctl->variant ||
>           !func->variant))

It feels more natural to have !func->variant first, but feel free to
have it split that way yes.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--smfllbht5q2nnop2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpTklsACgkQ0rTAlCFN
r3RwxhAAjWqcU+len+EEdYH75LkzkI4KQAdOJVxV7QeX/8lY8xPr4kPCg3wSvy+9
I4U5+/MMIVyr9jP5oVSnQnhOaMLtecGKImQfgGkM9BbcvR+04JngWUYnCH0vpu8A
4WBDEv7fdPD4KQXQ18nUC1dHPmpbY46rJS5AihtBNbFJfHTu5pUqzCWxQd2y08in
KFnkmngZ2DiuXSzzM84PC/hgJocT8D+t0NOD5m2iIgKLrqtjP02ZzzQnFRJL9qFu
Z+8gLtWPRsGhYGWnDLk5bsoUOn239bmryNr4NYhKHniWp50R7HrDeJdtMvcbfRB5
svW3BJl/h9EDRecOIPml/OzdhsV6cU3kLnbFy6xnAONQByxLWPy8bsDMzrOmhQ/S
i6L6biIWoVOV/k7XhRjyuKcEPATUwl7s1PyNWInfTWrfvr3nNwt2EqYSA1LiMd9E
+Az02lpXHuJo132xwtKpTMHggyeWIqb0RxOsvPgUilIBFzthCGmrXjjchpv2SDaE
51feRdyEp+0yvQXRmVOxZrTSeKyIYsRbrDdBPY2qxvTDI8BIQ0Jdj4PsXvTBJSb+
uGethP0BAgo9oHqGCGLEUM6JtYcSkF8Yglfbd+VG+YL2BrmmivPrQakwucLHLP9d
W+By68rVaW3JbrKqCLLEboEQJ0Z3jXB3CDYmBnQKI8xWclsC8OE=
=JdF4
-----END PGP SIGNATURE-----

--smfllbht5q2nnop2--
