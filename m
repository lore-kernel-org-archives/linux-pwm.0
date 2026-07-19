Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D92D739B;
	Sun, 19 Jul 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784481057; cv=none; b=OmTDZIpiq2efl2bJxGNpcdrQj/QIlKM5Gg8b+4RslJQPyda5qhF/r32k+iu0PuKpIlWQhv/e9iTjVcQcSFq1jssr1eU1vSxh6EwR+hQh1wM0aNtBzsqHgZp66LOb7ZKajO9RvzjQKVtO9lwLd/od9GwOVFnsKPR85G69vKACB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784481057; c=relaxed/simple;
	bh=lJPjR+/xS8rHbB6RgYg7i2R0kEmui+UAZllLNvYfVBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYRGal2JrbEdOP+4A5GhndlMVxfmxhN4R1nWyhB1UUE5gETz+fojOIl7ROULM23GA6MsE/UoBXwMMYvUuvt31PVa2/vC+OAKF3B8m9h1fRpkgvBlFVwaXYhfi0ICZv16XIFWPcovU9OmofdWR+mjnbSayYR7ag3hKqvllyKa+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGUMfJgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGUMfJgq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 45ADA1F000E9;
	Sun, 19 Jul 2026 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784481056;
	bh=lJPjR+/xS8rHbB6RgYg7i2R0kEmui+UAZllLNvYfVBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGUMfJgqM2cjGfPWoTaFLg+DUwsJj41dQ4DbuxlFYek+HCUhaqQ6Cl21InfxXtf+h
	 cpsgBIjYJFZcyqvJURYexL8zCPHQSzF8v9BAAEjY/9svfV7ZEyVfVAVuH0leeEe7jF
	 t6iQIthwQxV+WUL9MMCRa4wvtbr8AGcZAQz+/uxJNyZ2pjMv4U907JP2+pEXAsrXaQ
	 5p2pK0JNVaBJZmR4RBVvL5PaHICdBQcHvFQDCYKSUS7Juv+aOrktDP+4AJG0XfL1Wa
	 3uc8CmAxBA3JWlKTxNX+p+3Nqh9vO2UInvzxK8N6VK69FW2IggU6ge0mOoBqWqK/V9
	 mo4uU2/G6+vIw==
Date: Sun, 19 Jul 2026 19:10:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: Use another seq_putc() call in pwm_dbg_show()
Message-ID: <al0FAtusWDkQJY2_@monoceros>
References: <3e9f9238-a0e4-4a29-8a5b-27e4a5a0e1e2@web.de>
 <aliLpfmKkkwlZhzF@monoceros>
 <03062fdb-cc4f-47c7-a007-4ac67ded6377@web.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vabxctytepjg3dqq"
Content-Disposition: inline
In-Reply-To: <03062fdb-cc4f-47c7-a007-4ac67ded6377@web.de>


--vabxctytepjg3dqq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Use another seq_putc() call in pwm_dbg_show()
MIME-Version: 1.0

On Fri, Jul 17, 2026 at 11:40:45AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 17 Jul 2026 11:33:55 +0200
>=20
> A single line break should be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>=20
> The source code was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I squashed this into the commit created from the original patch #2.

Thanks
Uwe

--vabxctytepjg3dqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpdBRoACgkQj4D7WH0S
/k5arAf9FScz0qpSSsdF81t2IUOAio6EsIwl4GSZ9Fw5hD5giUrinsAH0+6SRG5r
UAFwG4zfrfeaP7OXoGB0byveTBL7+rcAPUTKJeVDea5Z4hwBglS1alxhcQc+dDCO
Yy7c4iGA3Flaiz6mOEqS55r5/6GnOUGL4bJZv9qu5J+soxHMcYNqDcNQDB2DQHHf
tzqry3iZXGRKRydh/Zuf5/UqnMdv7Y63y7gx30VlrLm03vj0mlMbEdzc9jqaIzxe
/IskDX1bExgV3c/b7ZXKXiZFxTHpsjwhxBVFxzL96qRooA9s/gxZ4bMPzyBgyY6L
qdGJwRcyQPaYxmsInLq5VY55igmQ7Q==
=/Jkw
-----END PGP SIGNATURE-----

--vabxctytepjg3dqq--
