Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA54313277;
	Tue, 11 Aug 2026 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424779; cv=none; b=kx9cIq09ZN09Zz8hEUhWHsYvK/uH13uygHFmHJ9ZnEeOAYiABHMfEkhvMqf+GeuzlsZ5akgG1p+ARM6AE7dkr8oLP0e0JjodnEJkbWYjzrjYGnekkps9jqrN4T0EVyGqOhHB9K9hyFXM/kyQQEQMuY1f1Y7BMAdfltahS5JkXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424779; c=relaxed/simple;
	bh=mpE2XB834h2X/hqFfK1kaOkERcyI2OalamXk7sof+D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN2GdVpboAllWmuIqILxVEcms95ukgsSwRBT12JneVsGsHDZKu5+txHwRdiR+AXXTSpcXEKGE6RUWHFhwlI7p1WQbl8W/glCxpvq4ucXWnDRX84y4j8P6Kmw2xkrEUcsVzqvWfZ7u/l+Y4TQ4mpXfmsClws6pudQvHnmHcAjjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOHWeplB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOHWeplB"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EE28A1F000E9;
	Tue, 11 Aug 2026 05:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786424777;
	bh=Nqy+J5LgCipC+94ySiuwoWjMwfZRvXtuneInmt6S518=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WOHWeplBFr7i8caT2T38Hz67fkTISy8BgAZrdlIPsFguZfNCN4lEgyw3mkTrwGLZj
	 mBJ8estR/x3ylZkv1CcN3fnko7gnDdLTHLIJM1VQWM7csZXYEeA/eklBZ3TquucO9I
	 VWbpwLfcmA6UKkXGxzLU+iGOHXaWFYizydOQ6+eE9ySl0gsJsF7SFxn4ddkcmDN9Vg
	 mDy/obyHwRrl+0jYcjzbxm6Ik73H8LF8fERyB5wNwA5auu7WBE3Xsy2V4AwUnnjk5u
	 QhVNa0xgQvJaen2FzPT3C0McLDz2TaXJavBnQJZybmKAeLdghOaXm7SrCzW7/ou3KF
	 PDYP6himFHGHQ==
Date: Tue, 11 Aug 2026 07:06:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Link Mauve <linkmauve@linkmauve.fr>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] pwm: th1520: use vertical import style
Message-ID: <anqtiNa76mzM9ZR3@monoceros>
References: <20260721-pwm-rust-vert-imp-v2-1-9f91547f5e07@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="suvxpmiughzydh4a"
Content-Disposition: inline
In-Reply-To: <20260721-pwm-rust-vert-imp-v2-1-9f91547f5e07@gurudas.dev>


--suvxpmiughzydh4a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: th1520: use vertical import style
MIME-Version: 1.0

Hello,

On Tue, Jul 21, 2026 at 12:49:27AM -0700, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
>=20
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>

Added to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

for the 7.3 merge window.

Best regards and thanks for your contribution,
Uwe

--suvxpmiughzydh4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp6rcQACgkQj4D7WH0S
/k40RAf8CGH9Be1+oMoVPq6/vqGqzDyBVxFWcA3aybqtevEH+VheNYdSMMLnpuVD
EvJcp3AnfnaSZJyK7wD/ag/8F2NxYp0Ihr4QgDUVGS8meuMxTk1UbNioIJjcgdg9
aTlvKw6nxsPea5l910KUCc1xkNRjpEVy2x9F4JFJva3W7oVowM6xYlU4AVfDdWsv
FhY15YPxfpnuxJQNkdr2NC0ue5wkRxJ8JBP9m5RvnQlewkGTp7R3XNpqV/o9txXn
lu69Ka0RjGJL+QGBLCfj9RyesudoQcHLOK5tEAxS79lCl18rjmKXQaAfDdrlOl20
9ox66Oaz/D4Uw+J8zBQJs8Lwk580mw==
=CJ/r
-----END PGP SIGNATURE-----

--suvxpmiughzydh4a--
