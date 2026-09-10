Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22B48A8D9;
	Thu, 10 Sep 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050858; cv=none; b=KFSTi4Yfkg6HU9pnwVZdf6xPDs64gQiu+8AgHrPw11NbYibWpMHqzvNUQsVWnqtN/njD8W7eOOCrAmVdyOp0EWKb0HfLyNejf8BeMTXU2T9G/ylqFeJOT4DUbu9cJ/R+OlsGM9knLygt8I9CWBxT87TpnvPYLllxq0DbzAo3JiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050858; c=relaxed/simple;
	bh=ytbFbGsFsPMRN15cnZnGQ+BVVT4omhd+u4UV7g+TRTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpCFJGd3ra+uE3hhxW6TTGWwIAK8g1IjbdDAXlSKICdJL0uoqyzI4m2tMrZBDUtYjdj+is4f08gP8V3MMiJAghZDrpZGnM7Q/WasHl5zgcsR6McUQ83IpeF2M/iLEweqnC3NNqco+CqJABAXfn1K5DSQQJVuE43/NIUWyymFpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdHM+gna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdHM+gna"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 971921F000FF;
	Thu, 10 Sep 2026 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050857;
	bh=kHpkKe+nPJNBGeOT8DGVr7Z58xbhCeUm9eb1dXLR9j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MdHM+gnaQHzb0Sjjo27rAv48N+jKElQ+tcp9TZX/Xksy/w9yGYALktm1zO43RQh8N
	 3x1FkmiUZUS7oOwcx8j7+CJC2LlNejThDAr0NZXw3I7kN0uGdV+wlkXg/2y1fixmBS
	 ile6oJvXxkJKkUuadH2ZWRElUYnT50Nk7C0o0SM4hTrU7Fsuf5fvLZyAFUsduo64Rp
	 26y22SdiIft3Z5gN9nTG5ORuoih8B75PRYSQbnLZhKxXjc+oSktsiNWHLzjBaekv7w
	 Bh5wSCschZdq7Z6XVkTRWS6LyrmGH+hSIYcjBkwy8oX+OdRHbzH9eChrxVqq7U9uR2
	 Bm8Z18DzI+Krw==
Date: Thu, 10 Sep 2026 16:34:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tegra: fail probe on reset deassert errors
Message-ID: <aqK_pBOW9xkY6iz4@monoceros>
References: <20260830125843.99132-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ee3c4izufh7z3jmg"
Content-Disposition: inline
In-Reply-To: <20260830125843.99132-1-pengpeng@iscas.ac.cn>


--ee3c4izufh7z3jmg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tegra: fail probe on reset deassert errors
MIME-Version: 1.0

Hello,

On Sun, Aug 30, 2026 at 08:58:43PM +0800, Pengpeng Hou wrote:
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 5cdbe120ba2d8..d9fa16a7b31f4 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -379,7 +379,9 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  		goto put_pm;
>  	}
> =20
> -	reset_control_deassert(pc->rst);
> +	ret =3D reset_control_deassert(pc->rst);
> +	if (ret)
> +		goto put_pm;

Alternatively use devm_reset_control_get_exclusive_deasserted() instead
of devm_reset_control_get_exclusive().

Best regards
Uwe

--ee3c4izufh7z3jmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqiv+QACgkQj4D7WH0S
/k7vtwf+Kg1/sorhO93TI7iyBrp6/hRS1Qfu6Qwgn2OwN1XP5omoVZP9bhcDIJ2I
mVLwz9B5OBR7HuyVe6+fHtOJCzAiiemAAJ/bNc85rRgX6KHBaqlXkGjWxAByDVtE
zFb4sAW8/q4dwtGMY2G3IZPjUNM/+9NNFAgXJzOTp6yl0F+oHctRytcZTdzqqyNw
t58KH2CUBv0kpaTGAClqSX+0hy1zoQ357uep/xoJoYNXEff/AQyyR7ERqY/oJCGZ
raeYltaK1VbdW+5790PYgB63pSB7oKUa4d2EfVBx70YYDJQy9ruUvPlEhDuXjhnn
uXmyBot2X1/mukxOj7aE/kOa0CzK2w==
=03u1
-----END PGP SIGNATURE-----

--ee3c4izufh7z3jmg--
