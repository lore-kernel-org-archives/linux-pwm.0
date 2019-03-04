From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 12/27] pwm: jz4740: Use regmap from TCU driver
Date: Mon, 4 Mar 2019 13:24:40 +0100
Message-ID: <20190304122440.GD9040@ulmo>
References: <20190302233413.14813-1-paul@crapouillou.net>
 <20190302233413.14813-13-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302233413.14813-13-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 08:33:58PM -0300, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
>=20
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>=20
> Notes:
>          v9: New patch
>    =20
>          v10: No change
>=20
>  drivers/pwm/Kconfig      |  1 +
>  drivers/pwm/pwm-jz4740.c | 74 +++++++++++++++++++++++++++++++-----------=
------
>  2 files changed, 49 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df0655a..ace8ea4b6247 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -204,6 +204,7 @@ config PWM_IMX
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	select REGMAP

Sounds to me like "depends INGENIC_TCU" would be more appropriate here.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9GQgACgkQ3SOs138+
s6EqgBAApqtLwQJHI/GgZOOEuKM55A51SUJMeror7RMH60J/w9WxQFlAONPb0A/z
P1u0SlMe/PlBiotrDJQ6gb8Dx8a9zt684HH8kZKqT3ki9lYnVB2zIVMyLlBWEAUN
+YQcGPb8R9Wkv4XbZ8jIQy+xxOeMkX2yh1vFS/0cQKvkAiDAs2oLsZEmyGoUrV1P
X3KW8K/iiedGY3aUE1kUBbGpm+oSW8YIbOPH2pgGXCIGuuzHR1zsNqYBg0BAt3r6
jDFv2W80cjFcZRmMOp0EeecYbxhZ8yaDamPuRq5MltkrFQ8538emCg2WSh/fpev2
kke1YD0t0E26KlvyP8ov2p4z+vtWhXfHTQEnnN8Ki0uaCwIRkQ3jBahgFdzSFAJw
ml4LHrke7e7tYCINGuzDnzDGmjT9XSMEjJekgTIEaksigLX8HVhSE6Oo4bUXZv8d
334rSUcuBMmSM9BHkthhW/WQ/XcpgVHpIKlV0O51P28aroCefkW/LzRTxsJfAo1s
cSycUnOwPfHOi/WeRlGR/69RMUV+Gb+Qtt7tLnBO/P1QtrCinyT521uPOdLeBN03
1/plYR7omAhFIZFP28pmF5BapAR1YX3vgKHAqFOcynG15MezUvm/m0gqH+/0Tr52
tFm02vy9CXOjgyNkwX3emvywJ0RZW/R7K1WqrTU57SE3sj/w7Y4=
=MVmX
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
