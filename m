Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248F345757;
	Sun, 10 May 2026 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425726; cv=none; b=F5hlPRjrV3vzZkDhKz8pNS6bNBuW0ntTSMBJ5k5L7y2zdroInQxeWLF0X1rnZ4k0yIQ+dwgTFIvjEr/hgfMTfDisYa6T1Kd90Bko0ujOsDfcJ8cDk9we0OoQu+pl/B8PN8c+5cvqPatImRi2SxwsxGOq1qruJPgMG37XRBzKFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425726; c=relaxed/simple;
	bh=SEic9x3cKocXqVW7AZjcSHS/VAZmCaR1KTqAllSiE2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdO0Pn2H92JOjd3sC0Qmb6wW+zp9N9fc4iE/lE4Kp2lwKuL6Uwd+b3Ne19UIU43ROpXfVRAthzMGSmeq+bCT2JFRcITZQbslQm8tEeujvyWiWOeTS4ia28t9rD93Tf+uoS7TIqSHsP9SgUc2qK+ijQfFZxBzGGyDAOzt8QrfBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFxAknxa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFxAknxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43827C2BCB8;
	Sun, 10 May 2026 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778425725;
	bh=SEic9x3cKocXqVW7AZjcSHS/VAZmCaR1KTqAllSiE2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFxAknxanHWXFWd8d9CruEGb8R7cEzBr1LZQOdsMTwjgyDgS396kzxfkSoHGKqEeG
	 AHph9nkWFyGG73gLPH5xbWRoMj8af38pT3yXoq78C9mke/1t0Q9a7k39pIZqGzJAXJ
	 zDbkG4w4FM+mZTIV/cQ+tzCtA+qAWdOpUH1xe8uKy7fbNcBtZ3vuS3rdWq0TMhwJwA
	 UqeCxWO++6GKc/j+0+RxnKHSG42TPVG58nEiiXBoqG6f6cDtjh52ZqtoQvRglEwiLR
	 YiBCNVml5I7sMzQCf2f7foxsDAvaVoPB5uGO8+jrIrAz5EzH358cAKnDXPzFC/NuKi
	 3bG1mrfoesCxA==
Date: Sun, 10 May 2026 17:08:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pwm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH] pwm: ipq: Add missing module description
Message-ID: <agCfNPxaO4WbORxY@monoceros>
References: <20260509023609.1007698-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgc4n2zzlvqtglfi"
Content-Disposition: inline
In-Reply-To: <20260509023609.1007698-1-rosenp@gmail.com>


--fgc4n2zzlvqtglfi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: ipq: Add missing module description
MIME-Version: 1.0

Hello,

On Fri, May 08, 2026 at 07:36:09PM -0700, Rosen Penev wrote:
> Add a MODULE_DESCRIPTION() entry to fix the modpost warning:
>=20
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-ipq.o
>=20
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

I added a Fixes: line and applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--fgc4n2zzlvqtglfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoAn3gACgkQj4D7WH0S
/k56lAf7BiueTGSMoQmOjYlYNIhj4cjK18cuB0iIOWhuhMK2Qn0HosEbMN+A4R47
8pnxaU2N40/riufwoNn5QJZmrCs+gtS82nMDp7WHetEs+498ahdMPMaXbKW6buMC
ylZ+7W4+kofmDQql6cze59ZapDvHfbZEA4JzCiX11ze8jLqQ5YU80+VwxGgz4WA3
d0PYIGlImVlEXfk14kBjDz/W485ol3xQCc1Geh8c1Ljt4L7Gj5FieFJBtJPqclnI
vxrwEfkoZWzsAq87cYxDXo5kB24oGqJtTlPYsHzj42y8dT5/NCanSNa1Pq8DYzs9
XFpA28OTxJYS1fN1RlQjb9UnBSCh9A==
=/bjp
-----END PGP SIGNATURE-----

--fgc4n2zzlvqtglfi--
