From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 1/9] pwm: core: Add support for PWM HW driver with pwm
 capture only
Date: Mon, 30 Apr 2018 11:51:59 +0200
Message-ID: <20180430095159.GD2476@ulmo>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajkumar Rampelli <rrajk@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
List-Id: linux-pwm@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 10:10:36AM +0530, Rajkumar Rampelli wrote:
> Add support for pwm HW driver which has only capture functionality.
> This helps to implement the PWM based Tachometer driver which reads
> the PWM output signals from electronic fans.
>=20
> PWM Tachometer captures the period and duty cycle of the PWM signal
>=20
> Add conditional checks for callabacks enable(), disable(), config()
> to check if they are supported by the client driver or not. Skip these
> callbacks if they are not supported.
>=20
> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> ---
>=20
> V2: Added if conditional checks for pwm callbacks since drivers may
>     implements only pwm capture functionality.
>=20
>  drivers/pwm/core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..f70fe68 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -246,6 +246,10 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
>  	if (ops->apply)
>  		return true;
> =20
> +	/* driver supports capture operation */
> +	if (ops->capture)
> +		return true;
> +
>  	return false;
>  }
> =20
> @@ -495,7 +499,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pw=
m_state *state)
>  			 * ->apply().
>  			 */
>  			if (pwm->state.enabled) {
> -				pwm->chip->ops->disable(pwm->chip, pwm);
> +				if (pwm->chip->ops->disable)
> +					pwm->chip->ops->disable(pwm->chip, pwm);

This is not a good idea. It means that you'll be able to successfully
configure a capture-only PWM channel for output. I think all of the
output configuration functions should return an error (-ENOSYS?) for
capture-only devices, much like we return -ENOSYS for pwm_capture() if
the driver doesn't implement capture support.

Thierry

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm5z8ACgkQ3SOs138+
s6GW/A/+MImm7BmQSd+UOQUP4N0vddntkXN9FGKsxb1wIZPQBPMKfmH5xpBzfb61
hz1s8KLWOpgqEZQVs7eVp2ICQEOXNgwKdCWbHPsHIU+FUf5zd1ESd7rNu9IrddhR
ZM2lU8YGaREnIFPt2dFpjLVuXA8ak7id02RdeoylpLRaTlgcdE3q1AEY5ewnTNRn
JLI4eEroYAfwtJVC5PSvdZvD5Diq2H+ASe+McYSAbTg8+rHQ3w4KMmTIKoEiv4Us
UCwF89+zCm3K+AVcvdCe2jBSc2OtZm6QXY9BrhIBnGf4D9fGWBTQ0cmZpHtcxHhf
YOqyb+tM1rFgZutFgcrJ2fmFRZp2wrJjGByilhwEWfrdM57zrCQSLPWdnELOIETM
4aGyI1cmKc2DIdXI4Ksv7PRN3LBvvxq8H0Revozmi1MfNWrcB2Qr7sgvBNYTHTfi
T5TWD8oWJ6rs9E+JUJd7SU2fimoDft7i7bbA26mKFN65Y+i7jgCi3d/lTDhVMMA0
nby4wCgKDGnTK9vXsNK93WhUB5R3d6jXAgOePb3UotYIcE2z4hUv8I0Rp24PJWh4
s4zL38OPugoEI0iPfTodURu1m7F1QK2wOdd48OzQBRiQ9nFXywm8KLVxVLZoSck6
xsY1+I848Lu/UNHULnbaCY163rDTcM9/PJwRFrnuCA2Lpr/9M/s=
=yusN
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
