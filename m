Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC43AEF3A;
	Sat, 27 Jun 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568291; cv=none; b=go1VQqZBufjGtRX+Z/HXQo23KbeBRix76v7osrAMxbirBG9ZGCr/hWrHTndZ++aTRrdkB6tQMcUCZ5ed7uWYroyLCeHRYdT47z+LHnLdJOHMPZf9wi1LOPIsvi8Hhmbx7L0YfJaqdPvzQHzSNFdfvFp4Yu/rP7qVFg0NIwh4+lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568291; c=relaxed/simple;
	bh=Mp3HhFnT4Dn5tymA/irC+FaVJe06bKlOkR6goezdd/I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JA/ASURRJbw2H6Xc6ggFjiYk88QPq+CO1DXupRyGBk1USWmd4EF3HPpOqucV7JXpMXhLBhxKmejoTG9nQi32XEWGRJIuDUw44g1Fq06SZm1bZVtYgiKsJwjaUsNBLQ4AxAZskubl7NAxnYYpfhZWfXd936eG1XtnRfMeA1TxhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEuj47Vk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEuj47Vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D076D1F000E9;
	Sat, 27 Jun 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782568289;
	bh=sZ7kMHOM/UusQZj89sqfP5ZckFAGYTvVqUakUPkV1uQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=aEuj47VkimWwfxAw2ZHAEfGEMZKtEMZ6WNWLDw+s3570SNvTizAl0ILVOI17i2A7L
	 AYudOp4K9ZVQti0oj3sp0GHOY0v4wg9twuayqUoC0Jz8/xQZJVi+PWbRe1rcVUcme0
	 23YyTXp4+62dyWzGDNBhKH2kKEDhJpJ9iOPCebxN+YhIKYhKB+vSuhClJuLo0ZnDcP
	 r1yz3J+EducA4gN7IrvtGppM1/3YMfsdh7g816Lb13ia+OwEkpPtg4uviqtif2YGp2
	 jYR49KtLMnGOr/62DXdveI87ZGy85POyH0eHlU74bdr0niz5rL0MFYESyY7yLZ7OX6
	 2Vh7Ryq7ce8VA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 15:51:23 +0200
Message-Id: <DJJVPW8H183T.1927SIBS40Z40@kernel.org>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <acourbot@nvidia.com>, <ecourtney@nvidia.com>,
 <m.wilczynski@samsung.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <daniel.almeida@collabora.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-3-dakr@kernel.org>
 <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
In-Reply-To: <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>

On Sat Jun 27, 2026 at 2:26 PM CEST, Miguel Ojeda wrote:
> If this goes in at the same time as the move (as I assume), then am I
> understanding it right that if someone else was using `ForLt`
> (trait/macro) things would either break at compile-time (which is OK)
> or, in the covariant type case with no `cast_ref()`, it would build,
> but someone could in principle have relied on `ForLt` providing the
> covariance guarantee in unsafe code?

If someone would have unsafely asserted covariance for ForLt it would break=
 at
compile-time like this:

	error[E0199]: implementing the trait `types::for_lt::ForLt` is not unsafe
	   --> rust/kernel/pci/io.rs:158:1
	    |
	158 | unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    |
	help: remove `unsafe` from this trait implementation
	    |
	158 - unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	158 + impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
	    |
=09
	error: aborting due to 1 previous error

The only way this could silently break would be to use ForLt!(), but then d=
on't
use the explicitly provided safe cast_ref() method, and instead open-code i=
t
with an unsafe transmute() assuming covariance from ForLt!().

Even though very unlikely, I do however have an eye on whether another user=
 of
this API appears.

(The whole series also goes into a topic branch based on -rc1 anyway, so I =
can
also always provide a signed tag with just patch 1 and 2 based on -rc1 shou=
ld
the need arise.)

> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

> We could take the chance to add some missing intra-doc links, but I
> can add a good first issue.

I can add them on apply, or we leave them as good first issue, as you prefe=
r.

Thanks,
Danilo
