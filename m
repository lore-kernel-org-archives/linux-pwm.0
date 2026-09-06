Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22539061D;
	Sun,  6 Sep 2026 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788676604; cv=none; b=Gcvc0I7aRsutJvv7ywrNgKhaM2RK5x2ILiXjZHw8GfSVmrxmt5sWCLLqQFaXJDYIlByAy6luIVgWHK7G0awOF5mbLz4YeZSsK+oDpMojj+CSF/ovjRhwvx148sF5sts+vSA1w1bC/sjGW3YfHRZYBGQjGGwI0YpP5t/3woAhL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788676604; c=relaxed/simple;
	bh=/AirJ6tOd91vdAeglXMq5aaNPSpBJ6WZ5BcXn/wKj4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLMYQQUhlRaUoO0YEEZziHAb3AyVOVC+pHtxmJRwECUGZTFsPFc3YmIi7q6LWEV/CW0a/gxr8zL2z5b+nf3FwdyoAkzeKrbbdQHitBg+yKvasGZjr6afj6xt1jCG8qJIHuhw8rKDDiccfIZmY2ZSOgUa5MSnIQKAKjVfvbYR8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONTeIOex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONTeIOex"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 50DE41F00A3A;
	Sun,  6 Sep 2026 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788676603;
	bh=br2SmmkItFf+R8nzs5W2tSXX6Zgok4hN5ar3hlQFqVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ONTeIOex16Da9II8uk9TOvglU7xOBLtQ3tzaME7KLjuVGTW1pfH8m5xARrgFeCNuz
	 l9WZHiCwNWGAOECEFRsrRacVfKe6PRb1QS7XLVK38IECdvBdEaG+DVippwWwfK1dGv
	 wvElClELP/WWAtbwgbCQrxfMKZGlQK9ZchPjAm1MeYqUgWfNT+IqVRYQSIBCWCJ1Du
	 IFH9wbJCb8pc4EsrOaKZOSq5ipPOmxi2V2iErTlYDOmoSaQYXAWYSrDUsqXFIJ8E9P
	 yq5mb0wtkC9otatb6hyotR5eVd28YZXJ7LFx3sgkdStA11ZSqvE5WSxPFVmRC+vRvz
	 128w+5cs/RqRQ==
Date: Sun, 6 Sep 2026 08:36:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert TI PWM Subsystem to DT
 schema
Message-ID: <ap0JtPmhKyEQJdnU@monoceros>
References: <20260815074817.2117916-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kx7azihvxjydwe54"
Content-Disposition: inline
In-Reply-To: <20260815074817.2117916-1-egbostina@gmail.com>


--kx7azihvxjydwe54
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert TI PWM Subsystem to DT
 schema
MIME-Version: 1.0

Hello,

On Sat, Aug 15, 2026 at 07:48:17AM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments SoC PWM Subsystem bindings
> to DT schema.
>=20
> During the conversion, the following updates were made:
> - 'counter' node was added to the allowed child nodes
>   list to resolve dtbs_check warnings. Some eqep nodes
>   use 'counter' instead of 'eqep'.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
> Changes in v3:
> - Completed the single example by adding the required 'clocks',
>   'clock-names' and 'interrupts' properties to the ECAP, EQEP and EHRPWM
>   child nodes, so the example passes a full dt_binding_check.
>=20
> Changes in v2:
> - Renamed the file to ti,am33xx-pwmss.yaml to match the base compatible.
> - Required a 'compatible' property in the child nodes.
> - Reduced the binding to a single example and included the PWM child
>   nodes (ECAP, EQEP, EHRPWM) in it.
>=20
> Link to v2: https://lore.kernel.org/all/20260812094420.1057067-1-egbostin=
a@gmail.com/
> Link to v1: https://lore.kernel.org/all/20260811092208.687731-1-egbostina=
@gmail.com/

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as 7.4-rc1 material.

Thanks for your contribution
Uwe

--kx7azihvxjydwe54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqdCfQACgkQj4D7WH0S
/k6QsQf/cRN+ectvVMGsVQMf8/kMP2xQmJposaUpxtakhfvjVnW0ciWi7SE3y8+6
WT/uq9STvCGccSvjH9DKFEkJktnBNLQPQDlMEDo7BVBGiBx78hO/OwMemarV4auz
6oOjQ1k3sdsL22ydfAPjCWLwmvB4mm8GquiI4UpWtjsEem+C3zHFx5gNKRXKqD6m
y+HWDl/6bke/GJP1Xq9nVX9bCJZjy1fUAUXBcxdbAPX4HU/FLb5qQBwIJNZEf5I6
LZDWVqHxEf0SvHL4y9bqPdQ7/2g7vchsgjoYCZ6omP/4K1R34xJYoDa3JIPJUWZT
U1AMwkSLaz0sY4z/7eiB9VWJ5bS3yg==
=2gV4
-----END PGP SIGNATURE-----

--kx7azihvxjydwe54--
