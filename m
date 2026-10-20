Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501193;
	b=1Wu/kyI8l5VRAvYhssBUMT+5iKWRH9M1s8iCdj7wLYIjSoTn8TXE61Int0KWxexRVHRq
	 TEG3Aea6hQn5r7fAI3UKaDHFlnDJPUdM160B3Whiq1PHBtIHfk0L458s5FDO9i6NCQvJW
	 6Czv7UcJaW5f3fK9fjcryP+TT4YRORfN27LnX4JsY238lFr8INAAYfGBGMJXdPlr4lpgb
	 lSob+v85i6rRlrPHstwftTWOxt5N9DTQMFiITeeya6LoWAej93Dbgom3EhRPKhiq/YFLF
	 /Op2oBB514NrdFulbQF5FulixzChEr7yP8Qs6HiXSjsnZ2uyY1HcUNNqw+ucuu7TiEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k0+4gEKlMvz76fZS5IB16e4OUeVhhk9lshGuR0b8QYw=;
	b=JvFnxV/Sh+dHFDNlYqqvURwHv6jjtxrtrPqGOZugwLoXpWdoEVzNx36WYTc9Mrylt6Q2
	 yoIDGlwfIBn0FFv2V0JPoMPJE1g9brWdvmsazkmq9M6MYZ61wrnYTjmJmmlKx3AnLxnVN
	 LjPMQZfz1vEdnRnZPVk9Y+BFqV+3PaPNhInmhIDccd9EhxjVpE+pt80tK3EkzIOd2kdXk
	 03t1ENr/wGiay/2omfp3JdwAOdPBYnEmIRkVsU6sXVBBrMgraI4l2hidCmFSpvENCyjIq
	 5UUVKMOUgNBRVXXPEv/S1R0OAW6gcyrZ+NPlhS6wiqcfxI3rfXPFse8fU687BFxjOPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDqzQ90E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 08EF8606A31F;
	Tue, 20 Oct 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDqzQ90E
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1CCBC1F000C4;
	Tue, 20 Oct 2026 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501192;
	bh=k0+4gEKlMvz76fZS5IB16e4OUeVhhk9lshGuR0b8QYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kDqzQ90E/2qjc/LA3bApPh8dVKMVfASrKa9PJMx9YGKFySr4hzgPpjrpQokFF4qHL
	 138dOc+99/D/l8ttbTE/vIbIbB+Fkn4wPl1RUtfvRir2zuGTqdcBnLbIByWFpsDJiy
	 KMmEGcPGRh2+brvL4UdzD0d7EhrEHTs7jgKDxbxGZL5TaSB1IYtEwM4JNdWnloH2/+
	 IGDKgZVp0AMZTrGUkMmTDDAjT2UEM6R+rKGk6m4jP0ltp1MuODqfmN6tibAElPAi23
	 IsWF0zqfl6FFjoA3cZtuGnGLDtKO27KCInu289v0qHAwhv5ejxnpEmi8BrX60t3uzd
	 mrNxfDGRu4mDg==
Date: Tue, 20 Oct 2026 14:59:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Brian Masney <bmasney@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Message-ID: <atdlfNRiza3gA1iD@monoceros>
References: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
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
	protocol="application/pgp-signature"; boundary="ltyb7jaz4sulinat"
Content-Disposition: inline
In-Reply-To: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>


--ltyb7jaz4sulinat
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
MIME-Version: 1.0

Hello,

On Sat, Jul 11, 2026 at 12:16:28PM +0200, Maurice Hieronymus wrote:
> Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
> and use it in pwm-th1520, which previously carried a TODO noting the
> missing binding.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
> [...]
> ---
> Maurice Hieronymus (2):
>       rust: clk: Add `ExclusiveClk` wrapper for `clk_rate_exclusive_get`
>       pwm: th1520: Lock clock rate with clk_rate_exclusive_get
>=20
>  drivers/pwm/pwm_th1520.rs | 18 ++++++++-----
>  rust/kernel/clk.rs        | 67 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 79 insertions(+), 6 deletions(-)
> ---
> base-commit: 92010229c4b38897f1319d260162d2f96925ed17
> change-id: 20260526-rate-exclusive-get-th1520-764a949de18e
> prerequisite-change-id: 20250909-clk-type-state-c01aa7dd551d:v5
> prerequisite-patch-id: 2d3dc45c241d9062a0d2546ec649eec7970fa50a
> prerequisite-patch-id: 67ad535fe110207ebc79045ba022ebb7137b0309
> prerequisite-patch-id: 3d1d8ee5c2a4957edd0807b7a5cb65dabab345b5
> prerequisite-patch-id: e2659037b8aaf51831da099cc568ad5b3c24a4dd

I didn't track these dependencies, but the change looks fine for me. Who
is supposed to merge it? I can take it via pwm, but I guess a rust tree
is more appropriate?!

Best regards
Uwe

--ltyb7jaz4sulinat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrXZcIACgkQj4D7WH0S
/k6GSAf/ZIk24DH451oQFcpRIj2PkQd/0y19KVGyJRbxLE9LvsxPZ0+1eE3hJEJo
jlYTi8hVShMbt8y719+jAapn7t4jiDMFdqZjNf6SJk6UMY7/OQQnN1lx2EVzBr77
VzzIbCXZvEKKeRWz2YXsjkKOf8q0ZKeXvpE/dePtg3/LM288hLmX5vpAO3Ckpkv+
xRoPRzUPd3SEd1pvacn8Eul3YMz59OjeI2kgSiQvEli8bC2CColR1kjbIpIOAyIa
JUBb3v5uGhp4E9dTEZMfuuOoTyauToZwVNTZLd1jLLwO/fL3Zdfr0N3srk/NZmrW
3WQkqT8ZE03oOjmuXTUZG8+Sc4oIMw==
=n9X5
-----END PGP SIGNATURE-----

--ltyb7jaz4sulinat--
