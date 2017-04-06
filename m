From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 1/4] pwm: tegra: Use DIV_ROUND_CLOSEST_ULL() instead
 of local implementation
Date: Thu, 6 Apr 2017 18:28:57 +0200
Message-ID: <20170406162857.GB24332@ulmo.ba.sec>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
 <1491488461-24621-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36432 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdDFQ3B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 12:29:01 -0400
Content-Disposition: inline
In-Reply-To: <1491488461-24621-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, jonathanh@nvidia.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 07:50:58PM +0530, Laxman Dewangan wrote:
> Use macro DIV_ROUND_CLOSEST_ULL() for 64bit division to closet one

"closest"

Thierry

> instead of implementing the same locally. This increase readability.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> None
>=20
>  drivers/pwm/pwm-tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index e464784..0a688da 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -85,8 +85,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	 * nearest integer during division.
>  	 */
>  	c *=3D (1 << PWM_DUTY_WIDTH);
> -	c +=3D period_ns / 2;
> -	do_div(c, period_ns);
> +	c =3D DIV_ROUND_CLOSEST_ULL(c, period_ns);
> =20
>  	val =3D (u32)c << PWM_DUTY_SHIFT;
> =20
> --=20
> 2.1.4
>=20

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmbMkACgkQ3SOs138+
s6H1LBAAlUSFL6piO1bq8oa/FomIm2vViPP8D+6orYj5pWz4BgIO1Kf7mZc4DD63
KCCUuNJYu5PWUxQKdW1zhdp8v0ZZqt+SEKB8QtvcKy4yoXSJ/MQKZjVcUJ8CrCcQ
3zUad0MAiZZB8MJiwKom1jVck/aKI4fjSgImeA4dlOipG1qgvZm0buvNLO8kWwY0
lsvL9zGY3cS0D+MB/mmvgZ2vrCOVJIG/OW1tJpNaKax9tIYiV+I/NIuPzQ82vfoz
05Jy0wSyM839FR19oADv/mU+wWGwkj6RmodtwsMjLBIMBZ3EK1DNhMmWK+2n7Id0
jzCwwarjNZxLWK1cjlfvXW/UQleta0InllaZuQQik7e66S7cKiTj073WWUxau1Df
XiPe7nQDWkGQYbBPiDGoiQ3QJjuh5HvlZqbqww/RqyFxAjzOoN3klVZh0FcfyMAt
LPr5VzK2Dwah4tV80dBjHfWErchji6gzuV8md8IMBxEPUVDwLCVs9TTYq3WIp2fO
TQJDq0QbqzmXBgBoiSafU0R+fKFxRJ40z6JxC0nohvn9RJIscEKaeujo7N9SWzrX
rvLusgjUJvzZ2ucwWZG7LrZsitgaIdT/zg+WOEdN8F65SQwW9J/5i6U/eOt4c+ki
IUG0KvluPj2pwOm9rYhUpb9ZIil32ZC/BLKgSwMlF3LCpIpbSS8=
=YX3a
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
