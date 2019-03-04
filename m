From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 13/27] pwm: jz4740: Use clocks from TCU driver
Date: Mon, 4 Mar 2019 13:30:03 +0100
Message-ID: <20190304123003.GE9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-14-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-14-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:33:59PM -0300, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with clocks, that can be
> (un)gated, reparented or reclocked from devicetree, instead of having
> these settings hardcoded in this driver.
>=20
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
>=20
> Note that the "select REGMAP" has been dropped because it's
> already enabled by the "select INGENIC_TIMER".
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>          v10: Explain in commit message why "select REGMAP" was dropped
>=20
>  drivers/pwm/Kconfig      |  3 ++-
>  drivers/pwm/pwm-jz4740.c | 39 ++++++++++++++++++++++++++-------------
>  2 files changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index ace8ea4b6247..4e201e970509 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -204,7 +204,8 @@ config PWM_IMX
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> -	select REGMAP
> +	depends on COMMON_CLK
> +	select INGENIC_TIMER

Okay... sounds like this would be okay. I'm assuming you go through that
extra step of selecting REGMAP in the prior patch and dropping it here
again so that you keep the series bisectible?

>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
>  	  machines.
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 8dfac5ffd71c..c6136bd4434b 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -28,7 +28,7 @@
> =20
>  struct jz4740_pwm_chip {
>  	struct pwm_chip chip;
> -	struct clk *clk;
> +	struct clk *clks[NUM_PWM];
>  	struct regmap *map;
>  };
> =20
> @@ -40,6 +40,9 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct =
pwm_chip *chip)
>  static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *=
pwm)
>  {
>  	struct jz4740_pwm_chip *jz =3D to_jz4740(chip);
> +	struct clk *clk;
> +	char clk_name[16];
> +	int ret;
> =20
>  	/*
>  	 * Timers 0 and 1 are used for system tasks, so they are unavailable
> @@ -48,16 +51,29 @@ static int jz4740_pwm_request(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	if (pwm->hwpwm < 2)
>  		return -EBUSY;
> =20
> -	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
> +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
> =20
> +	clk =3D clk_get(chip->dev, clk_name);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret =3D clk_prepare_enable(clk);
> +	if (ret) {
> +		clk_put(clk);
> +		return ret;
> +	}
> +
> +	jz->clks[pwm->hwpwm] =3D clk;
>  	return 0;
>  }

Since you're already using ->request(), why not add a per-PWM structure
that tracks the clock? There are a number of other PWMs that already do
something similar. You can use pwm_{set,get}_chip_data() to associate
chip-specific extra data with a PWM.

Thierry

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GksACgkQ3SOs138+
s6E+TBAAjG0S5ESNTVw1dLBpuxfE/NmCtzdpNdd7R9KmrD0XWaRkU6yNYjTX7LeQ
8httkW5MfGJW2KK2I5Z5E565idf5/HnlbioDq8Nw9a9ENYgaCDn6VvQE+Ua+u8gN
TZvMXZKy9ltzlV3Tfql4G+7OZ/FA97kKhA1BYyMn/T+bOFuUoGA8jUXTIjX0uSXS
aNfBlzgB52/a1BEXzPqTP0fdQC2+HonK3nY6UteIS6qK7Qgdp8RoiIwWVT8+bXSf
adzq4fT1IK5rTS5PexZ4pMraYZdckyNoQJuaBaG4j/gjkcNTFhNEON3LBVFggKFX
e0jvl4e6eknc9zEuaJ6G6FB9SAYIzi7vgXCguNm+6woJIx+mprU58hnSBuASxowy
U0gZ6fvcMu90q38q0rmRrFGRT5RbULDfpNPBhI/VeCrE/4hkw5/0ZsEMxDjmC9aG
p/Op5ym9x56XUsRx2pCg6zrKQUM9bpES7t6vIOpeVWRSVCPF47vtDIM/fmJhX/ZH
C+1D/Af2xA/vD0y3Qn5MqePW/pU34CsLGdS2DM5MX1V+hqqdrZerOleXdCxhIS3I
RU7wj4bY1wUvECx3hW1XydtghqHeLIiVadmusimZyTPT50UJBgzENWQ+p2msj2dh
0YaMWC6A08/g5NUdRn1gYORT9Gifk6aFTAvAbYOblC+ozjusUbc=
=HjwR
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
