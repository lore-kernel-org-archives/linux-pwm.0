Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FD3EDAAE;
	Mon, 21 Sep 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985901; cv=none; b=qJsUBp1J/Gy6XwJSWnlTuFJiEFoPAxgSowMilZ34HhqmfS1DGGqpt5GbSqBK19FDUjnZOZLhtLPrN5UDd803YShjJyRlA8tvGQp2Wmzh9mtph+NYeUespc9D0So5J5KM94GAi5ncis85uqWrNMWwtAhCD3eJ9+eLGw4xguPHCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985901; c=relaxed/simple;
	bh=oV9W7zKG1FVTchPAg+VsPuGoC+/Z4CckXduW7vAJwA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4KJQAadjrbDq2Plz+Tsa8rWVewE+ansX+h61zE/2oqW16cbrVSWqf7E3Z9M78yJiC9K4SG6HfOA0KBuqWbzB8xlQkDngpuAk7rplxYQOpi/qLo1dBqEOA+QeLinVv630AAkyFZjz8Foduw1gTi88aYi52xWoNN1AlTosfxWH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXdih93X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXdih93X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE621F000FF;
	Mon, 21 Sep 2026 10:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985899;
	bh=R7zAw+aKxjmPCwTRJwO1TbeohTYiJ30UNMVpHS114N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NXdih93X83Zau3S9hBfuVrKOE9DXeqiwM7DGY4O5cunR8aWTxbDDlBe9w3lJrkk9V
	 ub6vLw6ffsRUqRmYp3IB34/ad4ObyXoyZqfvLab9HbXl2g2sKX1u3g2Bzy6ISkCIM2
	 r0/zKQ4wCnjREJiIcYWNn02pUG/MZDHOGsBzzIAdafKEv302br9bxumRY671EmLLGI
	 CrmezAmncTcFNGMWF2RwBWSi96b2EMDG7hmsJ43nd7Ilto9lkHUwBxAJ3H3oK9CKDw
	 ntioO70h194T4PUY+YKChfsBt7jRWZDc0QCpfopuja25A6dOos2qwGfsXpgKaoUU4z
	 aAXXc2CD2cHog==
Date: Mon, 21 Sep 2026 12:18:16 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
Message-ID: <arEAjOHU4rH5aGqb@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <b72b16cf704aa662a1b49805db284379d4fa4050.1789741839.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjqpevusxyvo2pna"
Content-Disposition: inline
In-Reply-To: <b72b16cf704aa662a1b49805db284379d4fa4050.1789741839.git.u.kleine-koenig@baylibre.com>


--tjqpevusxyvo2pna
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 04:33:47PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The registers of the PWM IP are readable. Use that to implement the
> .get_state() callback.
>=20
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Tested-by: Ola Chr. Vaage <ola.christoffer.vage@scoutdi.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-tegra.c | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index b461d3877f43..0520d025c776 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -310,8 +310,56 @@ static int tegra_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	return err;
>  }
> =20
> +static int tegra_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> +	int rc;
> +	u32 val;
> +
> +	rc =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> +	if (rc)
> +		return rc;
> +
> +	val =3D tegra_pwm_readl(pwm, pc->soc->enable_reg);
> +	if (val & TEGRA_PWM_ENABLE) {
> +		u32 scale, pwm0;
> +
> +		if (pc->soc->enable_reg !=3D TEGRA_PWM_CSR_0)
> +			val =3D tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
> +
> +		scale =3D (val >> TEGRA_PWM_SCALE_SHIFT) & ((1 << pc->soc->scale_width=
) - 1);
> +		pwm0 =3D (val >> TEGRA_PWM_DUTY_SHIFT) & (2 * TEGRA_PWM_DEPTH - 1);
> +
> +		if (pwm0 > TEGRA_PWM_DEPTH)
> +			pwm0 =3D TEGRA_PWM_DEPTH;

It feels like this has too many assumptions built-in. That's mostly a
predefined issue, but I think if we want to get accurate hardware read-
out, we need to address this.

According to the register documentation, the PWM depth is 16 bits wide
(on generations where it can be programmed). The value defaults to 255
(which is n - 1 encoded, hence TEGRA_PWM_DEPTH), but it can technically
be reprogrammed to any 16-bit value, as far as I can tell.

So I think for this to be correct we'd need to read out the actual value
before overwriting with TEGRA_PWM_CSR_0 contents above. At that point I
think we'd need to either adjust the mask to be (2 * depth) - 1, or
maybe better yet, avoid masking it out arbitrarily based on the depth
and instead cap it at depth so we never exceed the 1:1 ratio for duty
cycle vs. period.

> +
> +		/*
> +		 * scale + 1 is at most 1 << 17, TEGRA_PWM_DEPTH is 256, so the
> +		 * multiplication for .period doesn't overflow a u64. With
> +		 * pwm0 =E2=89=A4 TEGRA_PWM_DEPTH, .duty_cycle is also fine.
> +		 */
> +		*state =3D (struct pwm_state){
> +			.period =3D DIV64_U64_ROUND_UP((u64)(scale + 1) * TEGRA_PWM_DEPTH * N=
SEC_PER_SEC, pc->clk_rate),
> +			.duty_cycle =3D DIV64_U64_ROUND_UP((u64)(scale + 1) * pwm0 * NSEC_PER=
_SEC, pc->clk_rate),

Maybe as part of the above this can be broken down a bit to make it
easier to read? Something like:

	u64 duty_cycle =3D (u64)(scale + 1) * pwm0 * NSEC_PER_SEC;
	u64 period =3D (u64)(scale + 1) * depth * NSEC_PER_SEC;

	...

	*state =3D (struct pwm_state) {
		.period =3D DIV64_U64_ROUND_UP(period, pc->clk_rate),
		.duty_cycle =3D DIV64_U64_ROUND_UP(duty_cycle, pc->clk_rate),
		...
	};

is a bit easier on the eye and would make checkpatch happy (or happier).

Thierry

> +			.polarity =3D PWM_POLARITY_NORMAL,
> +			.enabled =3D true,
> +		};
> +
> +	} else {
> +		*state =3D (struct pwm_state){
> +			.enabled =3D false,
> +		};
> +	}
> +
> +	pm_runtime_put(pwmchip_parent(chip));
> +
> +	return 0;
> +}
> +
>  static const struct pwm_ops tegra_pwm_ops =3D {
>  	.apply =3D tegra_pwm_apply,
> +	.get_state =3D tegra_pwm_get_state,
>  };
> =20
>  static int tegra_pwm_probe(struct platform_device *pdev)
> --=20
> 2.47.3
>=20

--tjqpevusxyvo2pna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqxBGQACgkQ3SOs138+
s6FjQhAAno72y8Mh3kahIuHev86HiVuW3DhP0Da5TWGtu5M78QSmbhU/+IqZgvB3
T+VSQNJGgpp/ksRfOhs60S/npl0eI4bO0APCU4ZldxHfHo1rpE7z7dEHO+A9GaLS
IAUSXdW1PWD4lrhM/1Gwa7miwUttoxF4LNd6D/jWib6dtNv7Lhq4dTLKBgCXjO73
WrMFrE7Xs5TWWuZpLgA7dxhilTYAQ3V76ViblKLSps6ouKYiJ8ajFuF+Gqd26XzM
RTaS6iq9XPYsiE5cW5lChp08y10HVNdVUeuyujk0QQuBPOCp59qWcMLdGZpoYYvO
y+sIIGV8++wJLQ1R53NFuMhlLOjm6hQ8FRrikN5q+jtkObsa2cIKe1NAvpvw5KvY
pPPdCOfCepzjRzVJahEK/b0LRgLUJcqlkk8+fNtZ/8AzRWQi/j5+/EE2HwhkPAhW
Ukm9h6LDVyW14r1woQrAYQ462+KYjmUFhea+vI/NE/fGYKiXMWxBuDRyiXbFh2WE
oVjegrc8tLAXzxaXTYm/JbMPrtkNPtfRW6aaHfwuz0ZXcxcWySvM0xEC3gqa7FW9
NwffocSwhYwYClBv2eMTmVsDqaJ5WDF1ib9etCackXcFBFe9YuMkhSJ7a75bWEvB
qD4Yps0At9yw5I5fnmaSwnssuuByTHYkWXojfU6jWdvEpV0bkek=
=KG7i
-----END PGP SIGNATURE-----

--tjqpevusxyvo2pna--
