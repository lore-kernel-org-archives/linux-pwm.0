From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] pwm: tegra: Add support for reset control
Date: Wed, 22 Jun 2016 14:40:19 +0200
Message-ID: <20160622124019.GF26943@ulmo.ba.sec>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
 <1466596043-27262-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466596043-27262-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Rohith Seelaboyina <rseelaboyina@nvidia.com>
List-Id: linux-pwm@vger.kernel.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 05:17:19PM +0530, Laxman Dewangan wrote:
> From: Rohith Seelaboyina <rseelaboyina@nvidia.com>
>=20
> Add reset control of the PWM controller to reset it before
> accessing the PWM register.
>=20
> Signed-off-by: Rohith Seelaboyina <rseelaboyina@nvidia.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index d4de060..71b9c4d 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -29,6 +29,7 @@
>  #include <linux/pwm.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/reset.h>
> =20
>  #define PWM_ENABLE	(1 << 31)
>  #define PWM_DUTY_WIDTH	8
> @@ -43,6 +44,7 @@ struct tegra_pwm_chip {
>  	struct device		*dev;
> =20
>  	struct clk		*clk;
> +	struct reset_control	*rstc;

Drop the 'c' at the end, for consistency with other drivers.

> =20
>  	void __iomem		*mmio_base;
>  };
> @@ -189,6 +191,14 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
> =20
> +	pwm->rstc =3D devm_reset_control_get(&pdev->dev, "pwm");
> +	if (IS_ERR(pwm->rstc)) {
> +		ret =3D PTR_ERR(pwm->rstc);
> +		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
> +		return ret;
> +	}
> +	reset_control_reset(pwm->rstc);

I think you want reset_control_deassert() here and the call its counter-
part, reset_control_assert(), in tegra_pwm_remove().

No particular need to respin, I can make those changes when I apply.

Thierry

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXaoczAAoJEN0jrNd/PrOhoNYP/iEf9BXZqwru/Q1JHimWsc8a
iSPeG5ejtYF7XruH2DzV6BUbwE/zEJtKSUtHt5Tm4Z/gqJDlBDifZKfikajdYmMB
CgKHpOENNW26XtQz/YqVd18rzC0fKaqEcQygp+2U5vekSoWI3yYjAPh5GtG3+4Ny
pPKgXiSatYjVERxbNnJ6kc2O0yRzTwVdqaDAAFRP+zmdnBvSRhz+zM2cFu+nrXia
gpKddID/5Kp9iKe8MiX+OnC4fiB7S5IhwjCSly1OJ5WSHeCZHGsq1LauPQas2OKI
/G+hAagTJsXWH08btCKdBG3QWntjMkKMBj8pPUZWEPHKEUg8K8p0aZZwJD4CVZWv
BGvboi2k8ilgk0qTS3c3wOURoG3F6YKG7s3g/+br40wa0nKNRyF7nTFDsWHcaBlc
mQRKPIc8i0OGPWcwXlzkZ8jouzUFHFX9LplexZmJsjt+wsoTVQBICFWwwA9b49IS
dn1iohmBEypp72D2ixrShA2O4DWjIfeu8ir7t/x94Af9nbV7NsbQO24bZnMIXYRq
2QTD8w/1p8oSHLHrrLMHEF3WJicHGqlSISGK8KT0RtnYbfG0+QVuIractcS5tZh9
Z2IR7dt+DBplhoBV+7ykuyfdhCd1I3809h6L3Ui2zSRZNlHQlRrzO0ejyTVKjci1
XonPXMOq9JXMBIU31GMm
=Kx13
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
