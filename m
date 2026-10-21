Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561939;
	b=PbUyqAIH4kIRzlMXE0wLOVH3f8NIMB8efxfT/ENdJnfnRXjvMPMkRsp93npHfnUan4bl
	 9trPYlFnNSXnUyCjMbsgp0+tgxahlYTja67Rs8VWvgxQFRIZOq1/J6goFmUmi4mcGxGoN
	 ORYZfibQnijnB1vbUVGDhxRtuUmfTkLGD4tlR8rujCt8oV+AuF1rVjG9SkHmeuGzmz9CR
	 CRdtE1uwjrwrsyQVR+PldFyYZmENB0yDhQP7XlB/rK3CAnFgvvJvvi6Yl9if21dc/rB/m
	 cMxLs01srvb/LVPTeqjfDeBrvieQ+/kcEtMX8IXQDjL770IQqxd2PEO85YEdRkoXRGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561939;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5OeiZ8L6d4vX+l8Io/5jcUBoP3Wnj3/+D42Y2ecgSAM=;
	b=QVOHjAornST/nx3MfBKY21zDGNhj51yYAS+S82lJtrGVJkoAt1FqnH8hNnp+Vwrw8QSr
	 UgoGRWY8p8kgFGeI9C9wq41Rb8x1N7S6rb27B5dD/oydzZk9eOOl0zS0EvbJ1pPDT9iIu
	 7hrnltyoQn2xZUd5sNZDgPLemdSegQjjX4dhFX6FbDKM2UrQ61qj7xFzOb5A9HE9bO6D0
	 c+jm5c0465cFEHH/hYKVcsHC8UMy7pZRoBmevEG4I9nXangKouyQ9mY4lqSMviVf33Tpz
	 1WYB8yBGTiiEQX+e6pfPflfBgPfrS598FhPAE4gb4hXAWRu4ot4TdapDQnCJ4DhDBRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjDJYkQB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C9282606A31A;
	Wed, 21 Oct 2026 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjDJYkQB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BA0201F000CA;
	Wed, 21 Oct 2026 05:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792561938;
	bh=5OeiZ8L6d4vX+l8Io/5jcUBoP3Wnj3/+D42Y2ecgSAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PjDJYkQBPUKVWb6J82o69/SAzYF2+ziRUPPW3POgQFvjioitwO2sCNuAsp5I9D1X2
	 EPNvo/oUi+q3pWcm92Q4WFIlhSVXTGB9EgoGq/xT/q6hNi7BbcEXlrikyxZUKbDQlQ
	 iPNk0PH6nLGijisS/cWVSozRC2uZt9s9qAnMblmQR094fsfUcdsk5eAGN6xEQ99uN5
	 oUBI/rFKIZgVUDy3qloqeiNtD8bukaE1CxL/tH/j2A2HjkIIRh+Rh8Ew3rDEXuQpta
	 THjL3WpqTkPaovJeHVIZoEQVzdeCsYw91mg1du+5uYGaXnAmBCsxtO8RzCtZIb53ZA
	 3GX3b/hHKOjFg==
Date: Wed, 21 Oct 2026 07:52:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Maurice Hieronymus <mhi@mailbox.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Brian Masney <bmasney@redhat.com>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Message-ID: <athSw4qQ0k76HCGB@monoceros>
References: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
 <atdlfNRiza3gA1iD@monoceros>
 <8625DA25-1F59-4175-81A6-BAA16C961557@collabora.com>
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
	protocol="application/pgp-signature"; boundary="d5taxqcx64zj5tfv"
Content-Disposition: inline
In-Reply-To: <8625DA25-1F59-4175-81A6-BAA16C961557@collabora.com>


--d5taxqcx64zj5tfv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
MIME-Version: 1.0

Hello Daniel,

On Tue, Oct 20, 2026 at 10:03:47AM -0300, Daniel Almeida wrote:
> > On 20 Oct 2026, at 09:59, Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrot=
e:
> > I didn't track these dependencies, but the change looks fine for me. Who
> > is supposed to merge it? I can take it via pwm, but I guess a rust tree
> > is more appropriate?!
>=20
> Please no,
>=20
> See [0] instead, which also includes a newer version of this patch.

OK, discarded the original thread from the pwm patchwork. Thanks for the
hint.

Best regards
Uwe

--d5taxqcx64zj5tfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrYUvEACgkQj4D7WH0S
/k5BPwf+Mub/CREsHBzcLJx7ot56RM02mFrhVHCqQ2zYrWrPQF5W/p2XGfJBgK4u
p2Z0UzftLcSU83u3FxMDwlkpZQvboFMcfVuV4bsMLavUcogQiz3N9yJ5TfOwUjzQ
xHL/mmYVCs8FUsPPIX/VMMwB7Y6E+Is8D3GCZ717rMwH9DpBKUqDy3XIvLVxyzZ0
KzvbWzYUNHuYsQlWq04o+GVOBMUe2V2qxXfldRjtflP1aN+uepE7rqfOyWaCAfY9
mJm4X7e8MCyFwSRCbtP+2LI4v8MgSP90UW5SXVezn2lpd6Rmp5LtRkqm4Atgcv41
HYJMY8t2pkKYmVOlfH4CSUG7oJm/YA==
=x355
-----END PGP SIGNATURE-----

--d5taxqcx64zj5tfv--
