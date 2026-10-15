Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF716443AAF;
	Thu, 15 Oct 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059658; cv=none; b=Gg8WDTSsVlVAvcUSAvExmQxtpt4F0glWL3ILKXVRRRc3cbKpQ6U59FT7KrJIcKhWgPUJ3hUfT7VQGIHEF+prz8b1ynsdLOzzBlMWZznT2O43qxFuG5ECz+pzC52aML+Gwa8VcVlHJc/RU4PmScVaS6LKe6PM3IxjTiEj1GaQouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059658; c=relaxed/simple;
	bh=D0r+ZRTQkqkB0PvtjFaudvTYR8y4LWIG502oxgstgys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw2Js1FJbeHCImamy1TBxh0bHdsfnZJ+KWZgm27pYZPLfs/SGsAVDTxJyDHxvy0mptkf5LOtTfl3IuMnTpnWnFUD0wNS4YTZ6X1WrTkk5CDHxFPdgsviD3SRI3DEM4hoX7J/HsXaBbOysjnsm68WQxmK7MD/EFI46krgoLSxk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMAF15e9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMAF15e9"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B210D1F000C4;
	Thu, 15 Oct 2026 10:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059657;
	bh=D0r+ZRTQkqkB0PvtjFaudvTYR8y4LWIG502oxgstgys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YMAF15e9HpVx9rUV375qLDuLoocXihQTYbIsrAc+lCMJL63FTwCyUsRZ04WSYPjQX
	 zwtKLU2H2xJ8eLVzwusm2jmwae6eAR3Rat92Hl5XfjBYR3LFCvy0+S5gStDv/VhpZ4
	 eDQQswq5CKF4USUF1+KnqR92yHKUekHyyadsZwP7uMnTYLs/PBcc0yA3DygL6FJ26C
	 Cm8N//IvmVgTIu+AdQ87gwGjwsmv3NSILLI4gZg6zse0Az5NpJYtsd7DUcZWxWKWrt
	 IxZl4kgHkAs9W0wOFGQgNecN5/cHcVsltQI8JYrS06hLbggZH1xmdp1nIGqm5opllP
	 zj2f4K5uifOPw==
Date: Thu, 15 Oct 2026 12:20:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v23 1/2] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <atCos9UIaZoRs4N8@monoceros>
References: <20261014110429.52762-1-hal.feng@starfivetech.com>
 <20261014110429.52762-2-hal.feng@starfivetech.com>
 <9c0737d8-455d-4025-8482-950b64029f35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ql4e5cupjoadxutu"
Content-Disposition: inline
In-Reply-To: <9c0737d8-455d-4025-8482-950b64029f35@kernel.org>


--ql4e5cupjoadxutu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v23 1/2] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
MIME-Version: 1.0

Hello Krzysztof,

On Thu, Oct 15, 2026 at 11:01:29AM +0200, Krzysztof Kozlowski wrote:
> On 14/10/2026 13:04, Hal Feng wrote:
> > Remove the jh8100 compatible since the JH8100 SoC has been canceled and
> > will not be released.
> >=20
> > Change the register size in examples to 0x10, since an OpenCores PTC IP
> > has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
> >=20
> > I will maintain this pwm module in place of William.
> >=20
> > Tested-by: Maud Spierings <maud_spierings@hotmail.com>
>=20
> Drop, did not happen. Is it so tricky to respond to the one patch here,
> where the tag would be applicable, instead of replying to cover letter?

I don't know what Maud did, but if they checked that the various dt
linters are still happy, that doesn't deserve a Tested-by:?

Best regards
Uwe

--ql4e5cupjoadxutu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrQqQQACgkQj4D7WH0S
/k7PIAf/X0MuEBIxbZRh0F/FP9Rs7R2pI9OL9EjSVgE6YYJ7giZMWHvgau/wK+oQ
/1K2oRxxnBy1xHda1owC8LkERBHXpdZIPIWdDzgubjgzbE4TqHxsdWlPiNQ1znMO
rZ2hAJQGXRpsZeWhAGfvJUOgh+hoTyp0TUDgN2qbewauiMRzEH28gx1FF4X4XFIu
yUReIyoxZAa6yGVKNv17ygnWXx4WEpQEteGyQO9c4KMUXdEzDJIM6sa4fQAXP6OK
C/82CB2/AEvO60ZXiZR6n1WFblFqvUCp4eNUGNcw83hjcTWEg0U8jskNm1u/U/VK
q0n4iJMFE4bA4TYCgishZ6DTP/cdNA==
=wAh6
-----END PGP SIGNATURE-----

--ql4e5cupjoadxutu--
