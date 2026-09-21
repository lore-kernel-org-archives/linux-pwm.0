Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8314BF92;
	Mon, 21 Sep 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983525; cv=none; b=fNNIVA2ZKMmuW4hc4rSOAwFtiTgOqsmsXoIrvMhQTckZBCkvno0h0fSUhGlLUODTusxlqsOSGYqRnRfJIhV2chzF52RrDQZO9708sIcu/uEjD3mCSwoeq8fOe/5hhjNSXChK5Wwqe5PUr2WXc14A2d4mc+YtpeEnxZpu0idz5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983525; c=relaxed/simple;
	bh=a4aWbSBi5pfHCRpsQXHip3TjwJZO/ISpjVfTzOWb1yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czbUSaszGDbJXzQ6ScMLzdy38v0HvGQF4mLqLBU5IytoST9N4psPPA98afeXIRtDgi9hmKc5UB+QngHzPJoiSm4h9KfjXNXV6y5nV/Q64z07Kzz6n0XSyPE8LrLDvyKsC0ej8RLvfGBxVrGy72/BE2e9BG8wTxlgGtM7HWY1iVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/XMRZik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/XMRZik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408791F000FF;
	Mon, 21 Sep 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983523;
	bh=K8l1yXmQszKJYl69Ls8a64UGNFNzbHQ0+OMdqiFWot4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U/XMRZikJXA8dPUAvIdVUXtxgzEbeAgCr5TMpn4o/auBAq+4kryDn/NBjLN7Krf01
	 5IRFK2+zOj80Tm2ZhQ6a9J9XZlyDMjiJswSisaMpsRLMWkD/lNC42b4nUZaT39wZT0
	 9tSlWs2d+xQuryubUo5SiF3Yeizl7OfhrCF2oK3RnDFZ1NnRaBBj4ctRbXxXypHTpB
	 fIXj0Tj1tNjMNf/RKHyexuDPh/B6dYttCgHsJtpyDFsNZX97W1J821D0gwGS1pcANI
	 u3oCmHDGVfHN7zcdF4OO3RIDzw+b4gqDJ/T80A+5pFbcGHTAmYIdcLYt4aYS56D3TN
	 009XNcVX1Xd3A==
Date: Mon, 21 Sep 2026 11:38:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
Message-ID: <arD6ILv1sd8YBUXj@orome>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <641219a7d76bbcd8fe98b5955f2355ed45f55986.1789741839.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wf5ds5np2y5dhhlq"
Content-Disposition: inline
In-Reply-To: <641219a7d76bbcd8fe98b5955f2355ed45f55986.1789741839.git.u.kleine-koenig@baylibre.com>


--wf5ds5np2y5dhhlq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 04:33:45PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Usage of dev_err_probe() is more compact than dev_err()'s, emits the
> error code and handles -ENOMEM and -EPROBE_DEFER properly. Benefit from
> these improvements.
>=20
> Also add a few messages in error paths that lacked an output before.
>=20
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-tegra.c | 52 ++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 5cdbe120ba2d..efb7ab60f602 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -316,14 +316,15 @@ static const struct pwm_ops tegra_pwm_ops =3D {
> =20
>  static int tegra_pwm_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct pwm_chip *chip;
>  	struct tegra_pwm_chip *pc;
>  	const struct tegra_pwm_soc *soc;
>  	int ret;
> =20
> -	soc =3D of_device_get_match_data(&pdev->dev);
> +	soc =3D of_device_get_match_data(dev);
> =20
> -	chip =3D devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
> +	chip =3D devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  	pc =3D to_tegra_pwm_chip(chip);
> @@ -331,28 +332,39 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
>  	pc->soc =3D soc;
> =20
>  	pc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(pc->regs))
> +	if (IS_ERR(pc->regs)) {
> +		/*
> +		 * devm_platform_ioremap_resource() already emits an error
> +		 * message with CONFIG_HAS_IOMEM, so don't emit another message
> +		 * here.
> +		 */

Seems a bit counter-productive to leave comments like this. Function
comments should document what the function does and then people should
read those comments. Then we don't need to mention it every time we call
these functions.

>  		return PTR_ERR(pc->regs);
> +	}
> =20
>  	platform_set_drvdata(pdev, chip);
> =20
> -	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	pc->clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(pc->clk))
> -		return PTR_ERR(pc->clk);
> +		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
> =20
> -	ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> -	if (ret)
> +	ret =3D devm_tegra_core_dev_init_opp_table_common(dev);
> +	if (ret) {
> +		/*
> +		 * devm_tegra_core_dev_init_opp_table_common() emits an error
> +		 * message most of the time, so don't add another.
> +		 */

Same here.

> @@ -385,17 +395,17 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
> =20
>  	ret =3D pwmchip_add(chip);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		dev_err_probe(dev, ret, "Adding pwmchip failed\n");

This stands out as very different from other error messages, so maybe
change this to something like "Failed to add PWM chip" for consistency?

Thierry

--wf5ds5np2y5dhhlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqw+yEACgkQ3SOs138+
s6GwkRAAonBcUD7vKUZMfNieBBSv21tFj20mrz6132IzA2xfHdOk63xlPhjhmEIB
gYn39HL5yNdtbUDHd7SonUlkWf8/Ov298Ar+G4bGYgngyBqGP+HBWg4VMw0SRV/L
Eyhk2W7lN6o0mUt6iW7wIQYE0qEwUGsVPaFeY8hP2o/t+RF00qLz+mWPlP4TMgav
m3cMWJFm1u5In65pBhYAHOXUPQ+ZizuIy3HE1MWpfgB2SePvlIc4vsbxhK5d49d2
FBd8YNzWQuxq2kgBrtTrugpjHZy251jYTnKi8Hk5kOjkdDRwBgi/MuZjBxGWYHQP
RawRPXhAoMKu/KUPmWAvWWRHR+aqMOzDTqPpzS0IsyI3iYm+qff97AbfUlYiOiO+
IgIAKOISusjipetH39zxaiiZeD7lThIpZT0CafG97RnfzxP2qu+nIreE5b+kzqDu
88GO21HF6RjcBqQSfc+8rQbSM6ILRH/YmxEpljidNexN5yeaOwqAvfx8p2slTyjd
EBLiNhQP2RQNsZNIAwOv62ZZxsAhkNx5lHo5N7m+ocCq3H+OOEluClqNZbNXRJnI
GhehHTMMo9kIWAo9ZyIv/GIBDVPwArUmWgEK36G+PzBkKEZqphF48s88097YLIGd
yldq58pb8nggAbaFTlpGm+DpoRgYXQQ3E6IqmoPCJRAZtjhWcy8=
=KB2O
-----END PGP SIGNATURE-----

--wf5ds5np2y5dhhlq--
