Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E42D948D;
	Thu, 26 Mar 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517756; cv=none; b=PxZwv4Q+4ZM2P06Jlb3kjtYXh/XRaMv1ffkLOBn0v0eJRvhKKJbj7QMj+8WqjbW8Ni/m4RZ8gwBJ4AZPD/akeEb/OIqlsiFlxgKDX3BUi9BCy09a0pvvHMLiJxi6NGLGrZC6Iw0QaXaCOCGUKYlG8Q7pv5LiIsRGLx+/cFtP9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517756; c=relaxed/simple;
	bh=Ysu//SzXdYM6Ja+X6GEXyxKMAawC5e8zz4sEbazP0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeW7XaO9XrzQZ9BMMB/X94RcH7Yw+NAxp+rn7GmBfOxgkeCJ1ovQFaqvnpKcKJR6RZ16ZYzDydxa6h+3j6K0jw2fujdFwAFTJToA0JPrNalOlYgfzCNq+PsKQe+8o/K7x5U+Kf5FrCfmKGj7WM4DRtVSdbXP9RbYk2njF3+e6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH8Um9n/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH8Um9n/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12869C116C6;
	Thu, 26 Mar 2026 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774517755;
	bh=Ysu//SzXdYM6Ja+X6GEXyxKMAawC5e8zz4sEbazP0d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oH8Um9n/IJfBZbg973mfuAr9z2kYsZMM/BnlOSikR66gxhSLZf4n1lzFXGyMM9UfA
	 ymFvLZuTftEjpFlHHzZc2Jv9VB9ls5q0DiKt0bgktR5VMumPeasdXaO4mEf9sSUQe/
	 NaJDrY/mACV6K1Zeh51karwpyzkrl8OHHODXEDC3V3klyZP1+e2lbpKm8cFsa+Xarf
	 C0sYoQC02o54ubEXk7hoca/GXtX2Ab5viJEPQpTpGQcuxYkGq0D/18gLOwZ2dkGMKy
	 9K+iDAunkdWXD2NtX3etjbg3hZweJGGqnelkB1yFkA82p7GKvzE7nVJtvA01QwyIAZ
	 cjce83tWRd+cw==
Date: Thu, 26 Mar 2026 10:35:52 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <acT96Qh85krc6Hr_@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cusgvpbw2bgo3jwv"
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>


--cusgvpbw2bgo3jwv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 07:17:00PM +0900, Mikko Perttunen wrote:
> From: Yi-Wei Wang <yiweiw@nvidia.com>
>=20
> The clock driving the Tegra PWM IP can be sourced from different parent
> clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
> upon the current parent clock that can be specified via device-tree.
>=20
> After this, the Tegra194 SoC data becomes redundant, so get rid of it.
>=20
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--cusgvpbw2bgo3jwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnE/fUACgkQ3SOs138+
s6Ghaw/+MbnUxA9M8tV/mJdakaUIG3E26YQsPu2+2Ut0xwE6KWdQwuyQ9dnVN5c0
OgeVcWy3jW2kfogbfJ/X852hxp8YXAUTRLK8bKQxAdQUVtgNr64k29GXR28k6rpI
xCWZbrUUqYusjQPrb9bkoJh4LK9RmlaTbFZg2Jvs1HlQ60KXQHGxY4CoGGyJpIOW
AAMfTgV9kBsm1iBu0sIUxPHTyVJP++0JnfDFCDLlbAXApwSIjc/l6zCwbW99Z0FQ
3Xw4dQLVEqP3SiuExdkApNgHW9ABQpG3rBophOdTXehGyw7oYdJqDOIliOonv92a
ZdAI9ceYfDOlDypGKj5MoKTBZbx2rUon4/gprPxotKLzRTgY0WywWDX6M61uDn8Y
lxKk1a/a0m3mqYcYumfxBPRvPBh/JaaiM/w7qzNp7oo+oasopMAn607sgNdVvS3D
T4szrFHc8OMWf33ghWP4PCE0+UPCBLpeVnQoMbgF01Es78ZQBMhyga5AODEggTaV
K7QWewaQpK7Xdae2wjbuU4n3sQ4KFtkP5dCKVp5CO1eXnE47cbLdjEyjIGFSVDNu
7EcK8Mc1HwHr2XhSnqMQAHpV3xQ0zUAuf8BYmokkEyMWUa3CoplEs317Vos6lSzS
V/sp0lZsr5qNK4UyUMhykZaFW1QF58qYj1BC/3LLYVpyq4AHObQ=
=ZLda
-----END PGP SIGNATURE-----

--cusgvpbw2bgo3jwv--
