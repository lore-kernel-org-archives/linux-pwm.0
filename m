From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: tegra: Set maximum pwm clock source per SoC
 tapeout
Date: Thu, 13 Apr 2017 17:27:38 +0200
Message-ID: <20170413152738.GB27388@ulmo.ba.sec>
References: <1492092628-843-1-git-send-email-ldewangan@nvidia.com>
 <1492092628-843-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492092628-843-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: jonathanh@nvidia.com, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 07:40:28PM +0530, Laxman Dewangan wrote:
> The PWM hardware IP is taped-out with different maximum frequency
> on different SoCs.
>=20
> From HW team:
> 	For Tegra210, it is 38.4MHz.
> 	For Tegra186, it is 102MHz.
>=20
> Add support to limit the clock source frequency to the maximum IP
> supported frequency. Provide these values via SoC chipdata.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 8c6ed55..7016c08 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -41,6 +41,9 @@
> =20
>  struct tegra_pwm_soc {
>  	unsigned int num_channels;
> +
> +	/* Maximum IP frequency for given SoCs */
> +	unsigned long max_frequency;
>  };
> =20
>  struct tegra_pwm_chip {
> @@ -204,6 +207,24 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  	/* Read PWM clock rate from source */
>  	pwm->clk_rate =3D clk_get_rate(pwm->clk);
> =20
> +	/* Make sure clock source freqeuncy must less than IP supported */
> +	if (pwm->soc->max_frequency &&
> +	    (pwm->soc->max_frequency < pwm->clk_rate)) {
> +		ret =3D clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "Failed to set max frequency: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		/*
> +		 * The requested and configured frequency may differ due to
> +		 * clock register resolutions. Get the configured frequency
> +		 * so that PWM period can be calculated more accurately.
> +		 */
> +		 pwm->clk_rate =3D clk_get_rate(pwm->clk);
> +	}

Is there a reason to conditionalize this? Couldn't we simply set the
clock to the maximum frequency in all cases? Higher frequency means
higher precision, right? So just something like this perhaps:

	ret =3D clk_set_rate(pwm->clk, pwm->soc->max_frequency);
	if (ret < 0) {
		...
	}

	pwm->clk_rate =3D clk_get_rate(pwm->clk);

That of course means that we'd need to define a maximum frequency for
SoCs prior to Tegra210. Any chance we can get at them?

> +
>  	pwm->rst =3D devm_reset_control_get(&pdev->dev, "pwm");
>  	if (IS_ERR(pwm->rst)) {
>  		ret =3D PTR_ERR(pwm->rst);
> @@ -275,12 +296,19 @@ static const struct tegra_pwm_soc tegra20_pwm_soc =
=3D {
>  	.num_channels =3D 4,
>  };
> =20
> +static const struct tegra_pwm_soc tegra210_pwm_soc =3D {
> +	.num_channels =3D 4,
> +	.max_frequency =3D 38400000UL, /* 38.4MHz */
> +};
> +
>  static const struct tegra_pwm_soc tegra186_pwm_soc =3D {
>  	.num_channels =3D 1,
> +	.max_frequency =3D 102000000UL, /* 102MHz */

I don't think we need these comments, it's fairly obvious what
frequencies you're specifying there. =3D)

Thierry

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljvmOoACgkQ3SOs138+
s6GTYw//dAlhx4UMwz9mYj85dtGMre4ZHOJ7yw1bAavo6yJipm9aj9bOIA0RtV5B
IT86aSOwoUm+HULHN4zx+HbbiMcTAhbFdcRa+sXy8cisXybj0ioWWzYoWG3YXqmL
OPIgznc5lEQDY48XAjBAjLfean6B5nZfvBh2CZU6ESSuK4zkaBfj9XbIAxiFHF++
AKs+yMSZp2t1pKGzI2fIzYTat+MBu96s/PMF043p4+UTesveaDI7ikMzra2MfVrF
7gqkGA4wYGsNUKQT1Z4CKtGI12ItaLgFO9Aa8rU+N7IgHX0FQcODML36xI3mKrnr
CyafBxwFWqkwk65oxt0WmLaHf8+SGy/uojCH63SOnkAt2kGL85+KXzPBbE+nrgs9
0Q18FijZqRFNDinxIGJQD12gOUfAG4AajrvreLdV4+tNK6XpA1WUkfBFJpPWfdFQ
Ji+ESIxBYKCk0sppaJUc5kNCezUi+E8tLaMix4Y/8aW0LFQpM75ZbHTUN/b/jsCf
jho4cHhgrDulNkWOHuYoRhLXlkHJpuEuqjf1jcO7wbCm1WiOzEeCIxwHTvdFcqIa
JviqbfdbilF37/PpY6RYIPnanRKGYWUQKbIv7YlhWuRgLRkz+zP8C96LVaUTEaZP
c3npQUgsy6/uXfE0PHs10kHTcKA0BpCyG6KG+J3GUWpjS8Z592I=
=KOmy
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
