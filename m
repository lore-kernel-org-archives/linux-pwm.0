Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001843D647C;
	Fri, 11 Sep 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111952; cv=none; b=LuYX3yhy1pW5/i/5cr+iB7cPen+8Ju6fd6FiI7sTDr+mJzEmdnXw36BgKjlXrIxfagyaAWrvoz4u9FspcJRG+nymK8jA3j3GfiYASBbxkF5HJ2MT2BxxnOqDGnqZeoQ13R3rpqPN/mU9NRP5QMM+FsQqiEirKwDhLXx1LATUeAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111952; c=relaxed/simple;
	bh=8xJ5Ga1qjvb/g+qh9y49zkiEcKW9V67qWAwQ7eAiGNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvXkwzjh4rrZKAkxs+ErwzJXD2PO1tD0W7Y1JL1C7h0iJVZi1tHXZRWsNLuDN3Usvy1IsOo933fFg1kQtd3P6n2adW9HH4s+BoQns7CDnJ3c/tLb0kEi7FX56zJLpE5GnZD+HpuLpJsOKASYxb+tIElCZXPMzYz4m39lx5FGLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTZXVftu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTZXVftu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4ABD51F000FF;
	Fri, 11 Sep 2026 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111950;
	bh=+U1Pz8fAB/65/jotNNqvI/uO7lQqgo0VqiZVUcHIrCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PTZXVftuo9441qDbAVKVulB1Thkq0wK+HLSdINejlCEE6fyKIEzId7AGigl+IgO7a
	 c1UvSdiD24hU4i013iO21jgzIfjoRp7Jg3pOzSMtZyMJIdcMDNRtJ8bJsfqE0+0UlM
	 MYOgegckpvlgu6dRTxaO+N5BhsU3QXneRFpAKIoMd4A/tABiKtRkaDy39PORviU9/4
	 Yrnk9ASvBtvfq7VzPUSPFqJh25GoDvgy8Kd++DzryruE5lxpaUGKFFZz0UjTqJxxpS
	 5h5OxeCA2no4hkk4AiAASsHoXVAsO+XsTbeimm4AqDzTieqWSrCUulDM/F06UzD6Hf
	 VIT8X1v1JHlgA==
Date: Fri, 11 Sep 2026 09:32:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: fsl-ftm: Unwind resume failures
Message-ID: <aqOo-XbIvbDRDCH7@monoceros>
References: <20260828092014.9211-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xp6r6gvdbrbmxpop"
Content-Disposition: inline
In-Reply-To: <20260828092014.9211-1-pengpeng@iscas.ac.cn>


--xp6r6gvdbrbmxpop
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: fsl-ftm: Unwind resume failures
MIME-Version: 1.0

On Fri, Aug 28, 2026 at 05:20:14PM +0800, Pengpeng Hou wrote:
> fsl_pwm_resume() ignores all clock-enable and register-cache replay
> failures.  A failure can leave a prefix of requested PWM channels
> holding clocks while runtime PM reports the chip resumed.
>=20
> Check each acquisition and regcache_sync(), then unwind completed
> channels in the reverse of the suspend order.  Restore cache-only and
> dirty state when the register replay fails.
>=20
> The issue was identified via static analysis and manually reviewed.
>=20
> Fixes: 97d0b42e39a7 ("pwm: ftm: Add Power Management support for FTM PWM")
>=20

This empty line should be dropped.

> Assisted-by: LLM
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 44 +++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index 35406b2e1925..7a61ccb75963 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -501,7 +501,7 @@ static int fsl_pwm_resume(struct device *dev)
>  {
>  	struct pwm_chip *chip =3D dev_get_drvdata(dev);
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> -	int i;
> +	int i, ret;
> =20
>  	for (i =3D 0; i < chip->npwm; i++) {
>  		struct pwm_device *pwm =3D &chip->pwms[i];
> @@ -509,20 +509,52 @@ static int fsl_pwm_resume(struct device *dev)
>  		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>  			continue;
> =20
> -		clk_prepare_enable(fpc->ipg_clk);
> +		ret =3D clk_prepare_enable(fpc->ipg_clk);
> +		if (ret)
> +			goto unwind;
> =20
>  		if (!pwm_is_enabled(pwm))
>  			continue;
> =20
> -		clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
> -		clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
> +		ret =3D clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
> +		if (ret) {
> +			clk_disable_unprepare(fpc->ipg_clk);
> +			goto unwind;
> +		}
> +
> +		ret =3D clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
> +		if (ret) {
> +			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
> +			clk_disable_unprepare(fpc->ipg_clk);
> +			goto unwind;
> +		}
>  	}
> =20
>  	/* restore all registers from cache */
>  	regcache_cache_only(fpc->regmap, false);
> -	regcache_sync(fpc->regmap);
> +	ret =3D regcache_sync(fpc->regmap);
> +	if (!ret)
> +		return 0;

I think this is semantically right, but still surprising as it looks
like error handling.

> =20
> -	return 0;
> +	regcache_cache_only(fpc->regmap, true);
> +	regcache_mark_dirty(fpc->regmap);
> +
> +unwind:
> +	while (i--) {
> +		struct pwm_device *pwm =3D &chip->pwms[i];
> +
> +		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
> +			continue;
> +
> +		if (pwm_is_enabled(pwm)) {
> +			clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
> +			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
> +		}
> +
> +		clk_disable_unprepare(fpc->ipg_clk);
> +	}
> +
> +	return ret;
>  }
>  #endif

Best regards
Uwe

--xp6r6gvdbrbmxpop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqjroEACgkQj4D7WH0S
/k6HOgf/aPOLhAAxyrgk5BiKxkhbOpnJM1gdNlLVJVSGV0zUkTdSqbi7EQKmjCaO
sjBPRn5Wr8cBfTsHqZStX2PUJ1wy7fHOGwUjkk7elginigVgTPDQU/4vD+zJV2yq
w1GrNHXseoixz4MTn0U5dD20NS68deTxGRgJV2fvrF5pYd/2EqnDS6QKLUeHzdV2
erkEr1tcKNd34YjfDhXPsylQn4ZiKarX0uaVppboPvwFxJVthFdhohMg1OsJUbdu
ND7++56FZuVlRtjJUKg260HC57XJgyuZgUU3JyVdHhFLru4uKzkhjTqHpyDgG48+
CW/65fJYvf1I51xsXxREYdhLm+IEjQ==
=g3Zk
-----END PGP SIGNATURE-----

--xp6r6gvdbrbmxpop--
