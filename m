Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A3431484;
	Mon,  7 Sep 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768336; cv=none; b=ftTKNXUdp4TZRQkMgCUbJHfWiXVO0Dt1W62Ljoog+MTjib42C3HZpnEcO3y8gQKRPBL3cRjhShXAZ2B+uV1lGrJaOWnptY7nGTdlqkXGCIj4TAZmCpy+6iFREosflnXwG/zqKGSDY0GRvypEN3M9BQZHCuHFboeRdl04ctAgbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768336; c=relaxed/simple;
	bh=aPs8vOeOkDwA+cdOHEggTr5cgfZ4hBDA0b/o2U+3pmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX0bOT7Y2ghJtpN3CtpGo42VnVJmlTwSm5xGvHoc+0RJ8h5d4/0gH9f7ER32qyVgiwCSehjR8Dj9qO37P2+lWKLXpAfVwF3D2KiVnqX+61wNC4egvFuxzXWVuD4IIw7EGwappnMFsnZ/qpVNtmyae9bOkLB0hQrQcpzOPbwIf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdOFqkHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdOFqkHG"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 144241F00A3D;
	Mon,  7 Sep 2026 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788768334;
	bh=KFc3Q3n3ot5F3E+SE4+u2bsbzV+Be3EJmOfLOxeBnys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hdOFqkHGZtPx7BkOVcOTWt2Sl/nVdIQdVdxgmt1zB3lahFF4JDXllC2ynvYn4zw9Q
	 mjZmE/3kUbjazBQVc/GLRIAFMP6+OfZUx/MjpMwRFk+NYXd5wvM8+Ch8jdIqDAQiwh
	 Z8FRN0dAmcrFQveHk47pxbL0CJkOiFTESGSDZ/lOvRyuluONHQbkAZxK5A7fZPtdGP
	 YYdkkVSDi/lR05qKLUvdWvJP60vIOSbOUpi8yquGlQER3Q+EIGb48shl4VotcKBvCD
	 Ppy4/I8gbTD0EtD4Do4aDPKACYFeLRyh6Ixuam871cP5tTN0wSTlum9eUCSLnOl4yH
	 s3gaYdjNxuajg==
Date: Mon, 7 Sep 2026 10:05:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: fix typos in comments
Message-ID: <ap5v7IBBmroh4VZC@monoceros>
References: <20260907062659.15500-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="llupe44bve4w4fvk"
Content-Disposition: inline
In-Reply-To: <20260907062659.15500-1-hemanth.selam@gmail.com>


--llupe44bve4w4fvk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: fix typos in comments
MIME-Version: 1.0

Hello,

On Mon, Sep 07, 2026 at 11:56:58AM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Thanks, applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--llupe44bve4w4fvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqecEkACgkQj4D7WH0S
/k4KKgf/QTm2WVRrQALfoV9JLBdZorixC3WKwq5wW134IKXEizGfPMsfhkdNdJ3H
4gniCrvqedM1DLXGJD9AODV1zOYY7GOlnOxuieAScC4pfUebusv1B6r3CQWjYVwD
FkfTprdCUmHs8/NumPSyfzZ27JdSSa4gR0P66ZwdM1SJmfksFHLK5PDbRmQ2iEgs
u4eO9VNm4Il4wnbXGNTaPrCGknyJIdaMUZ2ghpC2GuEBg0REtDTpwErufGqk+3d3
Ufus4k+8X08wR2x7lPPG3hyt8C+r2JYeJ04xqiWNbnfjTJbfjFn/bqOiDFMwjMP3
0ATm0Fro1uwkd1vZ5ApMoAltUXBqgg==
=0rB7
-----END PGP SIGNATURE-----

--llupe44bve4w4fvk--
