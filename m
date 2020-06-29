From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/2] Add PWM fan controller driver for LGM SoC
Date: Mon, 29 Jun 2020 21:58:46 +0200
Message-ID: <20200629195846.6fonhke5d2rs4mna@pengutronix.de>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
 <df22a642083474e71f9f8274c033a6ef9757af5f.1593420979.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjvrp6vjwce3kmbh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <df22a642083474e71f9f8274c033a6ef9757af5f.1593420979.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com
List-Id: linux-pwm@vger.kernel.org


--kjvrp6vjwce3kmbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 29, 2020 at 05:03:47PM +0800, Rahul Tanwar wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cb8d739067d2..a3303e22d5fa 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -232,6 +232,15 @@ config PWM_IMX_TPM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx-tpm.
> =20
> +config PWM_INTEL_LGM
> +	tristate "Intel LGM PWM support"
> +	depends on X86 || COMPILE_TEST

Another thing I just noticed: You're using regmap, so I think you should
have

	select REGMAP_MMIO

here.

> +	help
> +	  Generic PWM fan controller driver for LGM SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-intel-lgm.
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kjvrp6vjwce3kmbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76R/IACgkQwfwUeK3K
7AnSIwgAioBKgOURNuZlj2ZaOEbNv0Asga+afCAc5eCL1G1zoFg3nIUlLLtz0EUT
MGLMD63sjZHvB3kkMZYwA5DZFs6prNaWoI2HxN6LA2SCNalwjIQvbxQMvwUh9vwD
9sJfzQaubgGEawID/xOniJyuTOf66HFXQ9moU0VEf3NwTm2pfrapFrOzsKQP8a/K
8VPsgHGCWrIchyhSyw+zOM36XccSSl/TXLWEspAoPh5dOLKKxlcpPsgAe37v7JGJ
QXg09RtvP+ipfWdrPSrt/+2tOj2b5AgatzgBh0Gdt0JEO0SMprMwkl+8PIv7mqhF
LrDM55V72Emp+3WPOdTJUwrR7zN+iQ==
=J0cp
-----END PGP SIGNATURE-----

--kjvrp6vjwce3kmbh--
