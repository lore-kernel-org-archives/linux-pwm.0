From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Date: Tue, 11 Jun 2019 12:28:51 +0200
Message-ID: <20190611102851.GA16611@ulmo>
References: <20190610233739.29477-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610233739.29477-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 04:37:38PM -0700, Matthias Kaehlcke wrote:
> Add an optional 'max-brightness' property, which is used to specify
> the number of brightness levels (max-brightness + 1) when the node
> has no 'brightness-levels' table.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlig=
ht.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 64fa2fbd98c9..98f4ba626054 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -27,6 +27,9 @@ Optional properties:
>                              resolution pwm duty cycle can be used without
>                              having to list out every possible value in t=
he
>                              brightness-level array.
> +  - max-brightness: Maximum brightness value. Used to specify the number=
 of
> +                    brightness levels (max-brightness + 1) when the node
> +                    has no 'brightness-levels' table.

Back at the time when these bindings were defined we specifically didn't
add this because it was deemed impractical. That is, no real hardware is
actually capable of achieving useful results with a simplified
description like this.

Besides, we already have the num-interpolated-steps property which
should allow you to achieve the same thing:

	brightness-levels =3D <0 255>;
	default-brightness-level =3D <1>;
	num-interpolated-steps =3D <255>;

Though given the original discussion that we had around how backlight
hardware behaves, that doesn't seem like a good choice.

Thierry

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz/gl4ACgkQ3SOs138+
s6GSfxAAwY+qUwKq+54LHTg+9GjvcE4Uq0lDCHIfRvxHcE9LkoP6hO+howgYknDN
8jhc8KUrHT4VgdE3gGokIwPssNaRzeEnGJ82WaIQ0s0PIhD1Vsa0gx81P+fDj4TT
ByA5QlRiF1aaVDQLBlXDhTTjzl0xL/8/Q+gANrZVezWsDUBBCEwofvEQMoj0MJ+g
NH+AdOPsjMZnY4QToqzPnEQ2WU3HrLB45MLKm+fxUdgEkN2h80tvjmXr5jgyBnQ1
/dk8aOxFteV0kyvDJt+ZprHTGFvp43hZ5uvQqTLVZyEiW3pyt4snu1jnv8p9GTEV
C3lP1/U3Xh+y+1CuZ4RCykHYBh1dr1YFrkbtebcAFFFuAI+qtbdPEym7IDOjKHhb
o9XwM7j4EOpLyoaWdOE4IbdPMCsoCyZzNQklw1CfS6F+8Ei6qbFUq2302/RTPcZv
NlgAHTQ0Ngh0rLBW5GaUE/Tb0zb3GksiVAnILi/lk2u+BhFxB8KCK0GgCVHY7I81
iP+DiCXDciGi6r8+WkdFsz0577IntMoOVPqQ2OliC4snRnp6SJ6fJEAT5zAMB3id
uc2LsElo8NT7VtTQzq6WRjtS2Yb+AexuVtpZDnwIWqO5U17Sdc9Li1YdV9s/p4eG
Zbj2CZoWVjHVlv/7Fk4dY/ofFOPPcpgK/Aengy3NmXjIL4DxmcI=
=qSIX
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
