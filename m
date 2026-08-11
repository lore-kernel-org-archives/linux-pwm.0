Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDA3AE19D;
	Tue, 11 Aug 2026 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488971; cv=none; b=jd1kGTGjyinq5SuLF7+kcpvu1bJXSC0TVJB9yCVq/xTh72C7eiQE6YlTqfl48NazTOwktHYkqFGsPXvHbLF1q1jn9mfvwgxNJBdgdxrd8qyXmLoL86hXcBO+FCdMplMvwglo2UxivoDZD8yeJk2BsWWAXQabNmL5XtTJmlXyEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488971; c=relaxed/simple;
	bh=p4jlsu6cjARc2ZcDoFFiJ9cYXh9TAtex8iwJoaukAfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9t5m6mFFyWR4VQyFEaVj9s0NYhWa6xRkPWUHsMX4GpJkwwfrXeRoTo/5CR7Xa6rF6fZvhvByr37/QW/IA2sHs87hIYl7UPfEZaOjxh+8Ogoih1clUygui/3vXCPjdJgOgTjs8E4eWC78bQxxHx5rOubmDpQMZSS+5Sq1+Ypubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWTbvxTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWTbvxTv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 178291F000E9;
	Tue, 11 Aug 2026 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786488969;
	bh=p4jlsu6cjARc2ZcDoFFiJ9cYXh9TAtex8iwJoaukAfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NWTbvxTvJjfknGoU4BAwnqS/oz1zJYbf9FUCBWy/TA1dD3YPjA5dkWrhcB8bDYxlo
	 TqZjdPo+2WBNtxml/G8WdHoRy5X9hEAeVYRY3hgHyqmukzhyXJDJtWT5BQbKo4qyFC
	 65fLLv8KxVC589lxKcdXzZD/6C09lwXHdRKKUG+wALhKUvFJA0+99IthpZHVHRClOw
	 XsKmY0afMkAqLuvcD7Ma8KlZQ5pLJoCm7DYLSoaZ6EOBRJ7zuS8X+npG2ZwMyjIVDr
	 DKpof05+4lJlavKUzpQf9okPTvBFcwH4L4+EFWezKnxOsdYMjPr1Ma8bDcpAJWCDaf
	 aT5VlGYB/TXqA==
Date: Wed, 12 Aug 2026 00:56:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Message-ID: <anunw_qC23XMqye8@monoceros>
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
 <anqsTVj5QGYGiEQ9@monoceros>
 <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j24xm6n3lcpqpjtt"
Content-Disposition: inline
In-Reply-To: <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>


--j24xm6n3lcpqpjtt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
MIME-Version: 1.0

Hello Konstantin,

On Tue, Aug 11, 2026 at 04:54:47PM -0400, Konstantin Ryabitsev wrote:
> On Tue, Aug 11, 2026 at 07:04:49AM +0200, Uwe Kleine-K=F6nig wrote:
> > I didn't research what went wrong there and the trailer made it into the
> > patch anyhow and adding -S doesn't change the patch. I added the
> > tools@k.o mailing list to Cc:, maybe someone there wants to debug that.
>=20
> It was just Miguel responding with a suggestion how to better reorder
> trailers. Since we can't tell this case from the case when someone actual=
ly
> replies with a follow-up trailer, hence the error.

The strange thing from my POV is that before your mail Miguel didn't
participate in that thread according to
https://patch.msgid.link/20260603160910.159307-1-laniel_francis@privacyrequ=
ired.com .
I'm confused.

Best regards
Uwe

--j24xm6n3lcpqpjtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp7qGYACgkQj4D7WH0S
/k5qJwf+LjPwp+T1ryVaTmcadXiJExED87z1BYKbM5ZL3LrA45otGhiRVra0pk6z
Cbcye8wX4E7tPks8tEj7j7gMXTgBWw0gAtUGLh+TMKgjz74J1UzD1zXxZtQu714B
qINAAMJnces7UZ0ie8NYPoaetUomfWkXP7Kz3q1sSMjLozZYWy1npBKP5cuLX8Ap
EI0J8/Vm37risFS9W3G2ioBpdVIBVRdvDa9ja8kty5hARktGU+OYCoOGrAqkYN3Q
6WetyXWWTjtWpYDmQts+A8xYnl9EV+oZX8+2Pn3ZKdZs/a7WOcmmaxPyIqyqe3sk
BWw2Uz3F6/6ob0IrknrcFR+VANvNSA==
=Uoey
-----END PGP SIGNATURE-----

--j24xm6n3lcpqpjtt--
