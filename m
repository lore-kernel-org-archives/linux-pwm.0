Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936536;
	b=WF63gzLdXnozXhQnSek05NTT8dXPYd0M8DQkzBkYwT1b6UtsTj00OKL6VIBY7XOmWov3
	 q4E1N1FjEJABwHAdUhKZq1s/+L7S/PRQWkefDKE7BWyT6uxeCZAy35BlathUXuqikOjVo
	 eKV3oXDhyyRz02aWjPC+pDmIqfXFykFp5Rt6AkSknXBg1Vw3zXFmYWi3PYbWWXDUPNWYk
	 4NT9XFTupst/BDtQutC9BBnw7f/CIU2Oou3AxZrCVZsp+j/LRKhFjiAbMgWVXp6gnEGME
	 0qu9RDZg1J6WYVMZhRo8UUIibBHyTinWX7or1lfQtws1AdqAHXDEVkuXKFV1+IrHhHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936536;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wQcSUYQL3Pq5KKkb7/1z2kjXyCgi6wTpcgrI6k/1zug=;
	b=0Cr3K7HlLxIuFPPpNuJEOl+YwzrrDZDWwhDXrbQK/pSCR/NiOWmG5rOay8JyfcZ14VQX
	 KGGnKDHIR8XZ9SF3ULaPKlBLo2uGx1mMZob9UEvf3Meb1arKzYntic3Kf3fgeZukENe8E
	 /GYJ9uKabNb+UEKEsn2OQTQccoxer2Bg02jIBxLOius2MXiwL4CYYqEU4y76CChRSZw4X
	 lsjrBzeq88ykkH0IaMW3SHa/eK+rWkCYGQ9/+EdRIlnR1K3eQrxRM56UnZoPMjsAARCS+
	 J4agBd8JAVY7M5pLRA/NiaQeYgvj0/68a8dhjUBwqHJh6rYmw3ciR8SBcAY5SmULkuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nohL5RVb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A73606A31C;
	Tue, 17 Nov 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nohL5RVb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509DE1F000CC;
	Tue, 17 Nov 2026 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936535;
	bh=wQcSUYQL3Pq5KKkb7/1z2kjXyCgi6wTpcgrI6k/1zug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nohL5RVb23MA05VdY6Ds9sRm+y8bwpMFts8Ytzb5Mm4oA7RgSmNC8B7FVKCjLrgtW
	 bLP9Jx7rlXfe36QapiLVlrfpwkKtwgWLXTr3JXNtHNrpJ8StdWpCS/YnstgF6mZErC
	 oZ7bFwxA0miMFFX4qLJEB5pNllUbEktG0BI7ZlHvj5MTofLh9FInnThH4R06canHLr
	 q5F/asXaheKGALKxM27g1eZ98P0PvEOODD3vNS0RDEHt8gjEb/90g20QsuW9eSe4yA
	 wrFBEtVeMhQ50OqEAmgk2w2ocFsLgTwt+FiP6A/SvnflGGWuSbLc2WIrPFj8e6hA5b
	 M881GSI46N8JQ==
Date: Tue, 17 Nov 2026 17:28:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Hiago De Franco <hfranco@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 CV1800B
Message-ID: <20261117-impish-dipped-3177675d9ea8@spud>
References: <20261117-milkv-duo-pwm-v1-0-3f1786ea57b7@baylibre.com>
 <20261117-milkv-duo-pwm-v1-1-3f1786ea57b7@baylibre.com>
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
	protocol="application/pgp-signature"; boundary="TNXTGBunDxcfULCz"
Content-Disposition: inline
In-Reply-To: <20261117-milkv-duo-pwm-v1-1-3f1786ea57b7@baylibre.com>

--TNXTGBunDxcfULCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--TNXTGBunDxcfULCz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavyO0gAKCRB4tDGHoIJi
0gZ7AP9wGtq7rXQpu9xAty+Q78SmrK8DVsrvCJiTqcE24Y/G6gD/QsdJayxk263D
NDXQSKT4jV9QQiI3mvXrFjXlGy5zdAQ=
=+4yC
-----END PGP SIGNATURE-----

--TNXTGBunDxcfULCz--
