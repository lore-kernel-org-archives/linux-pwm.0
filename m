Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613071;
	b=LjSMz9iKWcqE8ocOegHTv2KdkiaW4NDASgZijOwiTNS4ItWEjKVabOcXx+ayksjwX8ry
	 2Z3dj0y9wAYYZuoJF05Sp1babRKfHm0c83WiZBX0WZUSSQxId3ku+l8PxeS7VuxG0XF5T
	 3zoZzaPGmd7XV8JU4bK6MPuZALDBMpnxGyYnbSxxtvpmuHi0zBBKPiJ49PD54nNwpJ2R1
	 1y57u8UPH1rY2NjN1TDOm94/T1gC2nsOYuQuqGW0OCNOAVYC6GzTkPkU3p7hLISjkeTd6
	 6kfBwZPZC3J4RUUwHiXhOuQmgfkwBuTRCR9tcctlKaZUanhJBelESLNHcQvMW1Qfopg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613071;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+qFXYocHYdsAX9utQO5shGFW1D2DEM9/Jf9Ir3i6qdk=;
	b=NmM0w6e6ABRYqVNZ24Ybfv5OqyvD7iIL44/tMnzeDRUfUP6tY4vnhInW0u8RjJ0eTOgB
	 AEmCp/5TrjK73ZXnvQTksz9qxcLaSjIwBxyPrgI4Azk0bHha6POUHSjpRQwSwDK0s3d0h
	 ZQBju83tmGBYM0lr9jA98UNT1nYfwcsm4zxmvjCaFIUKPb1dGf+NIhbsbGPUjoaYWTbS0
	 GkmyZQ4TjYoDEtpbUb6S21Loo6P/WbuJrUp4fPuzij2fN69uxQQKd+pEqp/x9cGAI4yac
	 W38hcvR2JvmtvCMSxhdeXgr+M4RzFzXPGRa0boAMZLOPmNWo/2riYFCsfQSq/uTM6Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mz5PzqH2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8020E606A333;
	Fri, 13 Nov 2026 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mz5PzqH2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 519081F000D1;
	Fri, 13 Nov 2026 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613071;
	bh=+qFXYocHYdsAX9utQO5shGFW1D2DEM9/Jf9Ir3i6qdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mz5PzqH26TN+EaycPvt49AgVW1tWaonOaZ59fDFn7Q2wGdeh8Mr9ZGoAYBci9C0G4
	 Uz/xx0d2z/yhaBi3TScOtcOPyQ2kzghK1RfpUDE5tJZGdQjWf2hnD5c48+/zDJ1P/C
	 0SgT/lfrCz7fM0AiFGG7lEGOTLBu1TxOg2LEby3MBm1VyKdtxHomjhA5lRmUXokdwN
	 CjmPRyy06EaWOXw28f4KMTpi5Id9Cs0jmCyCyO66pkNtJdmDOCu0oQ1UX40xk/+PFB
	 W2xBkp6oTwEKx+O9eDevB7FKakJvpf0dmXcWSPaY8rckBq6RA1aB+cTXqXJ/FO0foT
	 x+wyXTH/g701A==
Date: Sat, 14 Nov 2026 00:37:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	mfd@lists.linux.dev, Manush Prajwal <manushprajwal555@gmail.com>
Subject: Re: [PATCH] pwm: lp3943: Mark parent device's platform data as const
Message-ID: <avefIggyxsix6HQU@monoceros>
References: <20260908165341.1423611-2-u.kleine-koenig@baylibre.com>
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
	protocol="application/pgp-signature"; boundary="qvt5gkdy52q27cfb"
Content-Disposition: inline
In-Reply-To: <20260908165341.1423611-2-u.kleine-koenig@baylibre.com>


--qvt5gkdy52q27cfb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: lp3943: Mark parent device's platform data as const
MIME-Version: 1.0

On Tue, Sep 08, 2026 at 06:53:41PM +0200, Uwe Kleine-K=F6nig wrote:
> Platform data should never get modified by a driver. So add a respective
> `const` which makes it explicit that the pwm-lp3943 driver indeed
> doesn't modify platform data.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to=20

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--qvt5gkdy52q27cfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr3n0kACgkQj4D7WH0S
/k6KYAf/QpgbI2djnvETsWyY0tgHIeWRyM2jNxQpoRzIITWcv46zHYZMxLq9sOxc
2fsI8Xf2caeg7iUceXIK98dJVYocP5w4/sxi1I16/nnp3uSLnxlZkE+5aVJMJgO0
5IGxvq94G6d8vuAlKE84sXC4Z3M/7/X4xjJAXp4LEKGDrdDFKS+9V6NLznMj0Tzu
emYGtJlS3XU7NmsY5jgmTngRu+KGS+wJGGP34M+7xIlGRsL8CVyU1RC+VagW0PBh
Miwx1UiPjCzFVn1AN4RWTkOp2rfRuQ3Ir7rwRzwT1dJMh520jOT9lBSsnuNs7e4F
c2uEuGRg66ZVah9OxO8U3+uFo54D5Q==
=KUh7
-----END PGP SIGNATURE-----

--qvt5gkdy52q27cfb--
