Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694436;
	b=IUKI0LxQMnh6VZAqX9tZjadfGwc2rvsHEX2O7YGkil0MwaxJTMAeiQ+BrscxfjmrCspS
	 rdQP3ArZQK+178xhHw1B1eWB23o5ZevlpJFpqi9reBQe3GtZuFuFhSW2nFx3aYlc6zrrL
	 f2x68giZnsSzmL2W1WCiZG+O9Zm0AvQtYIzil+snW1xMvqHBdbvIPbEPldpe9tn39vYcv
	 Dw+l28ZlxpKZm3u5Ki5PuHIzOZh3aCdxSi2EHMPWnF7jt3iIX6GspQ7XM8N45RVCbX7kG
	 gcbSibtrXjYuw+5kWXwqo3l3eOTvtX5CSvbdDRpq5vjif+DLIyfPNbkh3cFSFOOeQew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=NeVecizEzCgloQzgLcrNc914RsWbWV3K83+bGSP1TQo=;
	b=QhVH2k12TaR89zftRylnC32ZTFa9w+RZQjg0S5IxjksD1NlNhbzgLHARwJl7ZSXTRq95
	 KOpSjeJ6JYZtuYfnIdwq+aq8K26rIIC1DX+fAoOLU5iXez/m/Rh637dBKXD+JsICrNPWI
	 v55Y6LYRzK41JkWA6TlBZr3bRoQgnWvShChf81s9sZdPwxzrQO6pkRCRrEVra+zDxDPnJ
	 QF2HUCHbfFbljTLwrvhcc6khtoNJa9opilM3SqCphO4AZOEnpA1N6eAP0Wgm9wyNHe6va
	 LSyfSM8pN/cdg7KBedhWy71Ea1o4BZfy8EIaVH3STAngb59UaAvqrQJ+H2m/Y+CNIDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhzb80Ow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F5606A31C;
	Thu, 26 Nov 2026 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhzb80Ow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3661F000C0;
	Thu, 26 Nov 2026 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795694435;
	bh=NeVecizEzCgloQzgLcrNc914RsWbWV3K83+bGSP1TQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mhzb80Ow8ANuEJkPFj8CzgJRVsIWYnVzXqd8oLrrsF8pvo8myS301oBZOA21us39/
	 RTyya+8j73ldZgTXDL0mYjlsPqyMgEJs74f0OaucbmNqKPci/aDTFtAcr1M1qbCR14
	 MOPvXqs2XjR0WwZqLrcFFLUU4bhgctc3al5iQwx48T676s0dL84mTltDZ5N2rXzYlt
	 8c4WXDXfeBldPJSs4GFUaSF9EeT12FgH5TB00VhLyoIs3g5kQ05xlxkFfFdsPxvisX
	 5rQMFoRcaRnUIlfWZ5HnVGyIkJOZIft00roBs9MjjIK4/0DyYfyDUwJGA04voSXclc
	 vD80/3hjou/rQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <tomo@flapping.org>, fustini@kernel.org,
 guoren@kernel.org, ojeda@kernel.org, ukleinek@kernel.org, wefu@redhat.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, chenhan0017.work@gmail.com, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net,
 linux-riscv@lists.infradead.org, lossin@kernel.org,
 m.wilczynski@samsung.com, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, FUJITA Tomonori
 <fujita.tomonori@gmail.com>
Subject: Re: [PATCH v4 0/2] rust: add u64 division helpers and fix the
 pwm_th1520 32-bit build
In-Reply-To: <20261118224826.2491684-1-tomo@flapping.org>
References: <20261118224826.2491684-1-tomo@flapping.org>
Date: Thu, 26 Nov 2026 12:59:02 +0100
Message-ID: <87tsl3u7ll.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

FUJITA Tomonori <tomo@flapping.org> writes:

> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> This series fixes the 32-bit build of the TH1520 PWM driver with
> COMPILE_TEST.
>
> Patch 1 adds a math module to the kernel crate with Rust versions of
> div64_u64() and DIV64_U64_ROUND_UP(). Patch 2 uses them in the driver.
>
> The driver only needs u64 by u64 division. It does not need a 128-bit
> intermediate value like mul_u64_u64_div_u64().
>
> Miguel, Uwe acked patch 2 and is fine with this series going through
> the Rust tree.
>
> chenhan's patch [1] also adds rust/kernel/math.rs, with signed
> division helpers. Both use the same module header, so whichever
> is applied later needs only a small rebase.
>
> Tested with the doctests on x86_64 and 32-bit ARM QEMU.
>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg



