Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610E34FF79;
	Mon,  7 Sep 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773596; cv=none; b=jF36RtgGdg1149czypvxYEyxjEFq6yrGbMA/XMFZIR/Sfw1sDs1w474gaW2tinmr62XEIdbQdrXrU/ArZbwqRmjgAs2cBUI+wqFdeMc8zoojbHWegJ3SaDWAKJ+f3nclCXDPAFd/51Su0C0cazyLJd0yHJzMZb/PlGOxqwhCkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773596; c=relaxed/simple;
	bh=AHjeCFmYBxHdHEPrEKQFH/feY1b2GEhVhJo7GqPVOYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHf3diFC/4NRgifavpOIbdIZGG7S74oSXvxVZyPFxpP7mKwdjeGBlZE8427z1mm8uLkotk0nWajO5NKtRnoAMcvo6M3LWND36r2oRKLwy7jEfbU8Yx1ckcDI7fv1bkY6QEzkxHcJsxE+LENYHr0hAk7Vxk5bSPUdbVGC9deR/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlhTK/+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlhTK/+W"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5995F1F00A3A;
	Mon,  7 Sep 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788773594;
	bh=Wzs8DrPEGFCXwJXU+nh4bapGECdgti+Wxe4GTHknDDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YlhTK/+WjY1i5M/wvWpl+8TTbcjqYYl6U8+mzmpEccHLgmV+6dOTC7qUdxd3ZzXrR
	 lfJxk8jBCt3uDmJfqaA02a+KY7iU5orfU1aDB+7a25LM5bU1EbXmqQ0J8B2h5u46TG
	 GqFWvGJhTnr3R1ktf4zPPeB0T4fRzDJupOu/ar+OhaNHeOlWCmQD0wkPgSVfRTPF1Z
	 RF8P2ZDeNY4XZBgLJ/4pdNVft799prPYfdP7s53Ta70e2m88Iw1q1DqrQqG5c9SfUw
	 rxG/L8ghNCk+YEZrS3ATvJ/+4qfjAZsOXDTyP35dY7jMQaGkmj4+/MFFwk2IDl3REW
	 qiWDZr5R1k+qA==
Date: Mon, 7 Sep 2026 11:33:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: keguang.zhang@gmail.com
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
Message-ID: <ap6Ciw_sMALvlROd@monoceros>
References: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
 <20260715-pwm-loongson-fix-v3-2-0aab2847eaa7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mmeammfw2xz6qra2"
Content-Disposition: inline
In-Reply-To: <20260715-pwm-loongson-fix-v3-2-0aab2847eaa7@gmail.com>


--mmeammfw2xz6qra2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
MIME-Version: 1.0

On Wed, Jul 15, 2026 at 07:05:24PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> The Loongson PWM controller latches the LOW and PERIOD registers only at
> the start of each PWM period. After disabling and re-enabling the PWM,
> the controller resumes from the previous counter value and completes the
> current period before re-latching the updated LOW and PERIOD values.
>=20
> Reset the PWM counter when disabling the PWM and release it when
> enabling the PWM so that the updated LOW and PERIOD values are latched
> before the PWM starts running again.
>=20
> Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/pwm/pwm-loongson.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> index e703217a6d5e..c317d62fe813 100644
> --- a/drivers/pwm/pwm-loongson.c
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -103,6 +103,7 @@ static void pwm_loongson_disable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> =20
>  	val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	val |=3D LOONGSON_PWM_CTRL_REG_RST;
>  	val &=3D ~LOONGSON_PWM_CTRL_REG_EN;
>  	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
>  }
> @@ -113,6 +114,7 @@ static int pwm_loongson_enable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> =20
>  	val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	val &=3D ~LOONGSON_PWM_CTRL_REG_RST;
>  	val |=3D LOONGSON_PWM_CTRL_REG_EN;
>  	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);

I applied this patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

, but I wonder if the fix is incomplete. If at driver bind time
LOONGSON_PWM_CTRL_REG_RST isn't set and there are still wrong values in
the shadowed LOW and PERIOD registers the first period will be wrong.

This would need:

 	val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
+
+	/*
+	 * Ensure that the values of LOW and PERIOD are sampled into
+	 * the shadow register when the hardware starts running.
+	 */
+	if (!(val & LOONGSON_PWM_CTRL_REG_RST))
+		pwm_loongson_writel(ddata, val | LOONGSON_PWM_CTRL_REG_RST, LOONGSON_PWM=
_REG_CTRL);
+
 	val &=3D ~LOONGSON_PWM_CTRL_REG_RST;
 	val |=3D LOONGSON_PWM_CTRL_REG_EN;
 	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);

I think.

Best regards
Uwe

--mmeammfw2xz6qra2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqehNYACgkQj4D7WH0S
/k6zBwf/doGudXjVnCi3NKQpUL7OoqhwW35IGsE0qmUlILk3TaCBcz8omPS3fwio
4hnNk51/AzGWU0zu85c9qByuo7qZz01zQ7+8VWmXBvqqEegakFqcQgchyemI/kJA
2hkVMWhuDaNa+brhoriEK+IRrXUnYLJUOsfanJzy9Zm0Wm61i+mNEDJg+PaXVBRV
M3P0uu2VIFhFc4ZqySnWwQuLz4MWrZNFmyKSUn3XcwEFJzoFlrz2akOJQ69t55Bf
5KFEoJzD5zfm6HFl+F2jm7taE0jgfoaO4zEM2mrEEPj1uhLJQD8wAuVcCFybP1LP
NZrobe1nAUKI5IwEmJ8C7+u+BjhObg==
=N9fN
-----END PGP SIGNATURE-----

--mmeammfw2xz6qra2--
