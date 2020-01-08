From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 0/6] Add support for H6 PWM
Date: Wed, 8 Jan 2020 13:42:25 +0100
Message-ID: <20200108124225.GD1993114@ulmo>
References: <20191124172908.10804-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191124172908.10804-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2019 at 06:29:02PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi,
>=20
> This is a rework of Jernej's previous work[1] taking account all the
> previous remarks.
>=20
> Bindings is still strict but probe in the driver are now optionnals.
>=20
> If someone could confirm that the PWM is not broken, as my board
> doesn't output it.
>=20
> Thanks,
> Cl=C3=A9ment
>=20
> Jernej's cover:
> Allwinner H6 SoC has PWM core which is basically the same as that found
> in A20, it's just depends on additional bus clock and reset line.
>=20
> This series adds support for it and extends PWM driver functionality in
> a way that it's now possible to bypass whole core and output PWM source
> clock directly as a PWM signal. This functionality is needed by AC200
> chip, which is bundled in same physical package as H6 SoC, to serve as a
> clock source of 24 MHz. AC200 clock input pin is bonded internally to
> the second PWM channel.
>=20
> I would be grateful if anyone can test this patch series for any kind of
> regression on other SoCs.
>=20
> [1]: https://patchwork.kernel.org/cover/11061737/
>=20
> Changes in v9:
>  - print error code in error message
>  - no capital letter to keep coherency
>=20
> Changes in v8:
>  - Display error return code
>  - split commit
>  - bypass is false if unsupported
>  - return instead of goto
>=20
> Changes in v7:
>  - Fix indent in Yaml bindings
>=20
> Changes in v6:
>  - Update git commit log
>  - Distinguish error message
>=20
> Changes in v5:
>  - Move bypass calculation to pwm_calculate
>  - Split mod_clock fallback from bus_clk probe  =20
>  - Update comment
>  - Move my SoB after acked-by/reviewed-by
>=20
> Changes in v4:
>  - item description in correct order and add a blank line
>  - use %pe for printing PTR_ERR
>  - don't print error when it's an EPROBE_DEFER
>  - change output clock bypass formula to match PWM policy
>=20
> Changes in v3:
>  - Documentation update to allow one clock without name
>  - Change reset optional to shared
>  - If reset probe failed return an error
>  - Remove old clock probe
>  - Update bypass enabled formula
>=20
> Changes in v2:
>  - Remove allOf in Documentation
>  - Add H6 example in Documentation
>  - Change clock name from "pwm" to "mod"
>  - Change reset quirk to optional probe
>  - Change bus_clock quirk to optional probe
>  - Add limitation comment about mod_clk_output
>  - Add quirk for mod_clk_output
>  - Change bypass formula
>=20
> Cl=C3=A9ment P=C3=A9ron (2):
>   pwm: sun4i: Prefer "mod" clock to unnamed
>   pwm: sun4i: Always calculate params when applying new parameters
>=20
> Jernej Skrabec (4):
>   pwm: sun4i: Add an optional probe for reset line
>   pwm: sun4i: Add an optional probe for bus clock
>   pwm: sun4i: Add support to output source clock directly
>   pwm: sun4i: Add support for H6 PWM
>=20
>  drivers/pwm/pwm-sun4i.c | 187 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 156 insertions(+), 31 deletions(-)

Applied, thanks.

Thierry

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4VzjEACgkQ3SOs138+
s6GRCw//fzLIOmnXcwHTbq33btuvCEB1rp9YfVj9gXCp/MAZB5jm0UBI6xImaD/H
dgrV/vrm7/xBSDuSHJXtEgioqcozjGB0cNdZxXrv7OZfoFo4xMLtiOC3FTjhJtLd
ERuVBETpNxkD8XDQMfzr3mwcqE2nyjB2Fd0M5n2hzGZ5LEYMOWMUZfSp9zWoQGu6
tm5Cg/W0l7FYV8IILR2cuKy7raMEWnPC3onUr0LUCSmm7U6L8JXewoXXp+qzSl5N
FOkT76MFuKCrnlK5t6g7qxb4q+LDKrRGe3dgLMGM/lobNBePTncypajgFE4JRg7x
0UTeTvM6USsBqCzq86cGOli/ZnyjQoGRvfXNR+jxM6NeAYJPbNg4NT2t/96IUMZH
A6Bwb1j/PvXZwdG6jdFb3Ca5MuEsG7OLz5INYZTcOhrt680wnM3SrCj7HuzmZ88R
4gaA2irjTO3d+aZeotvVj4x6sIkyHjbg97LoVfyDIaxKzJ5K5MPQf6kUjPMYJIux
fH2JTdzh6YB1Q+Ac4jaQrk8AXYMWT/EHvgwIQayJb6uqQ6iCuwFbGNnwg9UbRAYf
0aK7rL7rlolaqGkj5FlkzFmvKp80iE34RvC8Hrn6LfI6V8LI8CTVwdCHpum5FgDM
Ra4UqflyN317dwIbSM3+t6P6M5MQoFVWAUIS3DwOOCx6EN5IPis=
=slaW
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
