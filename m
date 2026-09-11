Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575F3E1D0B;
	Fri, 11 Sep 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123441; cv=none; b=HMTRvcNqMDBXOT6mdK41MFcZi8JdKoRHgpW76vTItf8I8IaaZaS3C035PR2X2kShLNgM9WG/wL4IG5GBcN9rbyy2CweUiADbkuIeorCoZidWC+FngVn1CE7WXq1FnzMd4/fGpbi3m8CP1y1PTCziiFeOifjrFTwGRptDJiNz7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123441; c=relaxed/simple;
	bh=hud/Tbt9aRS5KPUz2GN2KfL4IAztBRcIWvtaQhRh84c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVfIPDxeFy/URkk814z6/dPipFSkvyVFD8YuIEyugU10T2WoYitRjS0kZb436exXN70mrMAuEwKyVDt8kOYH+WA448zxzKgIvmvmqW0uDSCvAzVcNULZ0vDZThCFpDeGcyk1GIzGeDTFmrQ/S2V5DOROkpXMyR85lXQ9Tx/Rqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLg1rfxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLg1rfxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BCE1F000FF;
	Fri, 11 Sep 2026 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123440;
	bh=HxQQExHkuE1oYzumfiw6K9U+kS75S5w6Vc6QqvnhFMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLg1rfxROgLBk1FoYl0sCgseGEjl2GAZR6Qg4uAknhsevkla9NQ3eDLkxztx2unMF
	 xtW2rbSIyvD7KpAmFlaXfShPIQkMCPU0AAMOnOUul7DtgS4YvhLevZ7/PZqaukrMwf
	 MemhitB1a3l8W2g9L4l+q6CJQbOJbL1VSBjJFGz7x3bYWF4CLQFOW5UE5DMzjmgSjG
	 rnJ2vkuVyiEa8qu6bVDRImVLow2EWtgm2++arLxYdpKrdjYtL+6qutr/wu6box7g56
	 Q6iUfAQnyGXEE85yfMvaUyxVX4iL6PkNUGTG1ZdKiFW0aSF9USHiwfd0tlhuzFQCRM
	 /A3RuK/fmmTPg==
Date: Fri, 11 Sep 2026 12:43:57 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tegra: fail probe on reset deassert errors
Message-ID: <aqPaVTsO9ZvB1F_O@orome>
References: <20260830125843.99132-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bjhc64ygoldykpam"
Content-Disposition: inline
In-Reply-To: <20260830125843.99132-1-pengpeng@iscas.ac.cn>


--bjhc64ygoldykpam
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tegra: fail probe on reset deassert errors
MIME-Version: 1.0

On Sun, Aug 30, 2026 at 08:58:43PM +0800, Pengpeng Hou wrote:
> tegra_pwm_probe() registers the PWM provider after deasserting the reset
> control without checking whether the reset controller accepted the reques=
t.
>=20
> Propagate the failure through the existing runtime-PM cleanup path instead
> of publishing a PWM controller whose hardware may still be reset.
>=20
> Fixes: 5dfbd2bd5439 ("pwm: tegra: Add support for reset control")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/pwm/pwm-tegra.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This is probably purely cosmetic since I've never seen a reset fail to
assert or deassert on Tegra (old generations can only fail if the reset
ID is invalid, meaning it's a bug in the framework, and new generations
may fail if for some reason the BPMP is not operational, in which case
the boot will fail much earlier).

Anyway, not saying NAK because from an API point of view it's correct to
check this. However, the Fixes: tag is a bit overkill. This does not
need to be backported to 10 years' worth of stable kernels.

Acked-by: Thierry Reding <treding@nvidia.com>

--bjhc64ygoldykpam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqj220ACgkQ3SOs138+
s6FMvRAAlQAWmbVKhZlVuIWJqhzawLGjAHKaRHAbXFUmyDK34wYYEE9p+9GnSJLi
F0UyZxLDiKUZ+2ufpXbU0xuN0sme1b64OFuG+AJWoNxVeG7PGbl6pO9naqVJw5vK
Y9YN0+7O64EdToFcwgLiSijurLQwo+Lj22DZJ1bPsXcTpQb6kyvURbRvfAUachEK
DsfFrwE9mfMJEI2OxhiB/6rfOO3ADbUYP0oVKInzZcqz/Cpt7MQF5wefKiXyV468
IUjRp3C/XoLe9OfUOlHP5kRUkEs40bxT+oCBZAbPXq9YFg4lCj4T+7JSlw2AXF6r
omDSpoBebDrmhJO78bJUbiNnWHMaEEpQ9KQvd7NkEAd2GiCyiNjJc5eHtxm4TwY/
W3/U1P4KlZZL1YWtRnjyK872Tz/pTGStm8GLkKAJ5oCDaJE4WslB1UttewwxyS/k
uYEq5/LxGInfcDEQeCkTiWWwBH51TPweiveKW8riOJnkek65jkvAq0P1NwuY5dEV
zwcHPO4kvXW/wDMK7R60t5NRufZatTIte64aYfGtpbb16vYFq40/V0kAwi81By0s
YVsGJYpOpmolySvjY0diWRl/NqzLCxu/acdJi/zQaJqUqzSHvEsNUOX4evND0sV9
DT9aIZV0oi3jA6SFzs9i7YlqaZyMbdVnANiP3QN5vutp8d2mGh4=
=Pjdw
-----END PGP SIGNATURE-----

--bjhc64ygoldykpam--
