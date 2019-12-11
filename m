From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6
 example
Date: Wed, 11 Dec 2019 09:06:33 +0100
Message-ID: <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
References: <20191210174710.10649-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="44tksmdnwrh2gezn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191210174710.10649-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--44tksmdnwrh2gezn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 06:47:10PM +0100, Cl=E9ment P=E9ron wrote:
> Latest linux-next doesn't build due to the following error:
>
> Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.exam=
ple.dts:35.37-38
> syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-p=
wm.example.dt.yaml]
> Error 1
>
> This is due to missing header in the device-tree yaml example.
>
> Fix this by adding the missing headers.
>
> Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM description=
")
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks!
Maxime

--44tksmdnwrh2gezn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfCjiQAKCRDj7w1vZxhR
xTcEAP9uGGmta1bRoVSRk92LUIUmW8iSPPITd+A+9/tLuXcG3QEAkBBswRhpwUQ9
IcmAHUp2Yo34CHA+/krrKKxL0JUADQc=
=UP4/
-----END PGP SIGNATURE-----

--44tksmdnwrh2gezn--
