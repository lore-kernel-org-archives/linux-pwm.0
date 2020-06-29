From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/4] pwm: mediatek: Provide missing kerneldoc description
 for 'soc' arg
Date: Mon, 29 Jun 2020 21:47:14 +0200
Message-ID: <20200629194714.ghbxzwoi3mtahqvz@pengutronix.de>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-4-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7c7d6dluu6fljbvj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200629124752.1018358-4-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, John Crispin <blogic@openwrt.org>, Zhi Mao <zhi.mao@mediatek.com>, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--7c7d6dluu6fljbvj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Mon, Jun 29, 2020 at 01:47:51PM +0100, Lee Jones wrote:
> Kerneldoc syntax is used, but not complete.
>=20
> Descriptions are required for all arguments.
>=20
> Fixes the following W=3D1 build warning:
>=20
>  drivers/pwm/pwm-mediatek.c:57: warning: Function parameter or member 'so=
c' not described in 'pwm_mediatek_chip'
>=20
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Zhi Mao <zhi.mao@mediatek.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-mediatek.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index b94e0d09c300f..ab001ce55178e 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -46,6 +46,7 @@ struct pwm_mediatek_of_data {
>   * @clk_main: the clock used by PWM core
>   * @clk_pwms: the clock used by each PWM channel
>   * @clk_freq: the fix clock frequency of legacy MIPS SoC
> + * @soc: pointer to chip's platform data
>   */
>  struct pwm_mediatek_chip {
>  	struct pwm_chip chip;

LGTM:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7c7d6dluu6fljbvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76RUAACgkQwfwUeK3K
7An+ngf+Jlga9AaJKTihcMBmxrJi1R1xaaZaF6OJdVgbcu6obgMcHv4WGJ0GPLcL
287z0rdXVRztAM0GZfSZwCY3E/+OIw9kn9OoUsj9qovBhDw1aUp2xNvHtZ9pZ+r2
BJJbdZgr8fshM6pEDGw/pWaDI427REXKOAyR1Fwwq6uYPCLpn4vIrwu0m/cIlv83
EDqGaa94CeJkzospKoh0ClsFcDnWKtM4psI2FHaum8knktvMyKpx8PzYIPTkzg4W
1UW7qItd+KkU8yDrURYnlOvdHb6PeeL9NaEBuw7+CTAK27ap3wiafzyUJlHSHbkA
WQD60Tq7dOh3eI7Er8VGNxImjFs/BQ==
=BMmT
-----END PGP SIGNATURE-----

--7c7d6dluu6fljbvj--
