Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990221;
	b=SktosXE9mr08XV8ZxTf5zSx8LZXPBrSee0MQ17qo+6FaN7rGQ2Ml6cKgPVfbxpWiNSlj
	 XR4ZQ8zCVAMu/8RSobXhE3kGXMSKmhiccOhNZys9nPXLePIr1vSoft4fKrHyBhU0kGj2p
	 8TwpgpUykmtMmb+TCrd3vJHrB22YcG4xc/s0BzEjx8dVT4Sl6NNkQaid5AFmtegxz4bAw
	 Q/HFdFXHCZKQ5HZ5RY41jzzTtV9X2+3MJk9Q+zkykzVKHdkP0dDSTuhwOSBYMZo2C89mZ
	 dzvIxTyjOyiBEbNR5lSUbpH4H5geJKHJfSuTuej9gFKVxtT5lsD6jqXg36B+EwUS9IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XXD9tIfIeyyf1tgZA9qRzZVpi+ZbPumJ8KIZL1TcJBo=;
	b=Y/0XjQ408TW0A1C1hQYYt1we6ONRCjOf3Zh/icRXl9V91h/1G6CvJGEHCDXm2ei6q5lh
	 6Q4hVxIkqPSpQx4vD3CArrF8TBaKdWiJavUunuEhZyTIv5a0HPl0emneZtYawzNh6tfyn
	 BG7qT0iEb8f07CPwcvu1cAA92v+puxWMAP7UDW1+txpwEHKnL6w0o8xBiUbsE0+MWMY9u
	 yqh4Mpn0pZv6af3zSIk3j/iTYvzKlmPP5SPMTziTQe7BCycy788sxSiAZAQmBbZvMZVpK
	 t9PSN7mb3QwoqDIJF8/DQWaUiJyHX3EQjRB2AQuUnFAjPZEhGL4gYyvh5QJFwx4Rsug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JP6yeHxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 18AF0606A326;
	Fri,  6 Nov 2026 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JP6yeHxm
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A888B1F00904;
	Fri,  6 Nov 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990220;
	bh=XXD9tIfIeyyf1tgZA9qRzZVpi+ZbPumJ8KIZL1TcJBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JP6yeHxmQzRl5hfaLX5+I2lT3SyYTBGhNYkoVJ3v7G8tYwAX5YnJz4/yR2RLzU6p5
	 dyY+S9mRtfq3RtXpFzlRtNxJIQODDnmiIvrqTvMZBUyddA4H+AoMT7HIE9PjZ1n5Gh
	 kpPk7c8qekKzTxRGBdZgcniYKpIiNah6X3+S8+6NvTiFw6wP25AwjWIV1AKKzURFjn
	 PMFAdKiFHETWQEPItd/Xpy41tEJkfjvBp9XuIhI7b+vCTQh3hPXaDh4xcs+1kk53Eu
	 +ATMDnWpC4Qs7IaKVqlay7SJbrE6J18NQXtYwMh5FtAqf2hDbRahmX7p6c2VT5//dD
	 2nZa/uyHZxolQ==
Date: Fri, 6 Nov 2026 19:36:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sasha Finkelstein <k@chaosmail.tech>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
Message-ID: <au4eDk3-bAQ-EjlD@monoceros>
References: <20261104-apple-m5-initial-devicetrees-v2-0-fd727a82d380@cyberchaos.dev>
 <20261104-apple-m5-initial-devicetrees-v2-5-fd727a82d380@cyberchaos.dev>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpcwbv7z5gtj3ayx"
Content-Disposition: inline
In-Reply-To: <20261104-apple-m5-initial-devicetrees-v2-5-fd727a82d380@cyberchaos.dev>


--cpcwbv7z5gtj3ayx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8142
 compatible
MIME-Version: 1.0

On Wed, Nov 04, 2026 at 06:24:18PM +0100, Yureka Lilian wrote:
> The PWM controller on the Apple silicon t8142 (M5) SoC is compatible
> with t8103. Add "apple,t8142-fpwm" as SoC specific compatible under
> "apple,s5l-fpwm".
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>

Fine for me to let this go through apple-soc.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--cpcwbv7z5gtj3ayx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmruHkcACgkQj4D7WH0S
/k6/Mgf+MNkIvT5Osv2p9FD0hPlNyAR3xgH22Qg5GmwtX8sdRXqeW/pfzrRa0gxC
7KfnB3QUi973Kv/P/KotlgUNMyclAouMDla3PK9/qB154h/I2mAyYaxkMFxA6hiM
BcmpD9nehcFqa11ZbSyK7woPht/jT/p0lGV/zwWtF8e9xauuKUJACSdOC0ZqCQ7s
MEKrMqfFW1X0vkX7u1pIgM1/xOou1cM7QcCa7c5R3iH6Pikl0yNUE4orNB/C5DXm
0zNp2ZaGX9KJY6GdRk0Lmx/01kAcUXUPo3qed3VVwfvZBI24n3tXoq2j1k3LmMQf
OfVVqtR4am7GiKEOUkgkxdfS+ZLHxQ==
=jNQA
-----END PGP SIGNATURE-----

--cpcwbv7z5gtj3ayx--
