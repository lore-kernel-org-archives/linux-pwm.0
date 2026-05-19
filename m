Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1B477E31;
	Tue, 19 May 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185034; cv=none; b=dzEEddU7RZke63lsjkmGVgnhNZF2wDoWTRP7HLYPpDvQxpf5k1WjGqp6m+5r0q3GGggwcMG6bqGZmRnXxSDDv8llFg8eUadk0xIWQrNhHTYJw5GR82LwzuKxe1JsKmOma/fVV+VmZEjlTbMmU9ClptyvUzK9wT4ZhusxENKi7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185034; c=relaxed/simple;
	bh=5QWinO9Xjw92NFX2pfVE5o/B55ZoWiLgM/PylmeqNxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZTFAEgSAHgJ5bGsi/AZUq3GijtGlKGQ7Cw4JRs38wQNfsyfGBHNRq5nfVJUD7p3Nkrg0+GgBrHBL+Rd4nRBm60QRwnhTByj+u24iqklg2BUcWmibeYczqc4kH5h0JtpmkLjrL0oX/HnxUKkkg6GY0jp4ss17/MaBCdH1qNBEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmxNproE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmxNproE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A0C2BCB3;
	Tue, 19 May 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779185033;
	bh=5QWinO9Xjw92NFX2pfVE5o/B55ZoWiLgM/PylmeqNxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmxNproEEopPjAbb2zBeyvfCuA7MgGuISv+HsareXD0X3JS0PpGL2WmKBE32KnWHi
	 o9neWelgGRGO0B3F0yUsYCqi9XOAEXYQfgUpMa39plQJIJ9fL19VIdcl5z7Secnxzk
	 FULpwYAOWtLMQD1hfpTTbQz6LRgKqsLKbCqxFwW7kCBQJW0N8Y5dkBF6R6kxldP7ny
	 K7FJTq3KCH89mA1eEPW/hqAiMZCDSIN4XrGm3jACgprQXUEaI80nXssDtXh60ujfms
	 E/Uy+4+U50EN2PwEDq00noVpQzLGsB/qTyBagMMjW/RD0zz5Gx3gnpzaSgJaH19T/K
	 690+ib8PUBBLw==
Date: Tue, 19 May 2026 12:03:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: pca9685: Use named initializers for struct
 i2c_device_id
Message-ID: <agw1WE4xLKY_Uv_Z@monoceros>
References: <20260518172323.932774-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="brsjvhmpj6rzdtgf"
Content-Disposition: inline
In-Reply-To: <20260518172323.932774-2-u.kleine-koenig@baylibre.com>


--brsjvhmpj6rzdtgf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] pwm: pca9685: Use named initializers for struct
 i2c_device_id
MIME-Version: 1.0

On Mon, May 18, 2026 at 07:23:22PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

as merge window material.

Best regards
Uwe

--brsjvhmpj6rzdtgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoMNYQACgkQj4D7WH0S
/k42AAf+IBLsqxDF4Bsmhlaxpthxnf8UO96IRW06T0G2cdm1cJHkh4RzcRziCPHn
XZytjZYY+J50BWgn1Y4q4r1v3y4eI6gjL+0HbOCLd9DbCkmaprBsyaI30FMb0Wk+
JxU8ggQhgI3VTuqdf1eHbSNyjCfgdmWFw+COI2/YiwSR/9tX7dcsIt1HnMn390il
f3AAJ5YgVMqJLEkZWo5vKxeHYpyAa0VJZgC61xWmZOXxPzn2xYBX3S5mG57uCqAq
yB+YJrtnYMY1Cd/vnLXYse3VAAn3NsPXc3kPBNsrH/ZNp7pJ3v9dHTD2MMmRaHU1
CYlbRWraIxRBIc9lLq5e5hziPQJyNg==
=EnNZ
-----END PGP SIGNATURE-----

--brsjvhmpj6rzdtgf--
