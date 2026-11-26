Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694430;
	b=Fn7IKccdlIeZF02LXzd8Ix9987tZeu0ouu52UBpArIh/S+vMcF7zaomeUY3j7FL0z6/y
	 r5DDfdUWyysFOj8V8PxWqI72bUXIcXAJMqfY5jpnNjpUa9L35hhH2YieS2I4sl06blGOQ
	 ec0Zt5NysrXxEWHwyEhDLpCfkzYFE94qAkT6tCeADKZDJKGs3JVJFydRRsdzW0ACq01Bq
	 BdLEEC2vwQsFYxlIXG+y5z+Dui3PJw/iBzSjad3s6wTGYE09XbmjnBqFKgXLSoM4iETJF
	 EiCx9ZFmyLgelMUc1Zf5IjhzzqW6G7VTlrZqSOirqrCtcBRv3BTTi0CLCTrOi20SxlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/ONWCrPy0RVOfGMWQBZS7df1LPK5ZtI/y925do3hgoU=;
	b=dm42MVIGxhfBMgbFtCuIAaLY3qdeqWmLfltV4KXciyxToDwV4kl3I7XENUlSAVYb4jnQ
	 CDJ9uyzGjKw7GKdW4btSluGKYa+MhjOOHGGowxi8sdzqVt4o1cs5L153cro1t4tGQYTdK
	 FJm2Wm0vJhdcfpN2EGqzJZRaRj61Q0GbSPveg9utXDLPloSchiebCVngaqJGymDYugz+k
	 Vslzuo1wLgOeFPG9/7nUsovKkAlmLFF9mOgXTLBgfNY7fk5NH1Qwn86iD1FXtMTjNhe/l
	 heNHGo+e+vowgrwF8vxUuE9djuA3qAJQZWDIHyTgMHTkrjwMocrVN1vVQ7p8WNe15Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1QTUOxC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA6606A31C;
	Thu, 26 Nov 2026 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1QTUOxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68481F000CA;
	Thu, 26 Nov 2026 12:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795694430;
	bh=/ONWCrPy0RVOfGMWQBZS7df1LPK5ZtI/y925do3hgoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=R1QTUOxCmZ8uOQuqv3c3CjIhrB4japHBCOwZwCdQr/x54ft6K0ism6knpz8M/zXWc
	 v8PYU0KCFUmIkRFVTM1IxNhVKHl1Rnbq1xJbKTfLNE30PLlfHaOfo0NxHlXW+XlqM6
	 A5rAtepGXCL6LR1z+7L66EYLk4pDuU94we59R17AzVBd6oO/c3+FA6cf/9ejqil72K
	 +z+28qGgPoiVXDRoE0K4ZuKrKD6aTtzChXeVBDJvC9E9+o0hnZtQ7NcE5/c8q9iK9s
	 5WNckbShpku2UW2kIsdAuSaRHh8t0Yw8LQOTE7XN3eQOnglg0ClnFyVC5Cd6VIowB6
	 M5ZxTNcsODgHw==
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
 <fujita.tomonori@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 2/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
In-Reply-To: <20261118224826.2491684-3-tomo@flapping.org>
References: <20261118224826.2491684-1-tomo@flapping.org>
 <20261118224826.2491684-3-tomo@flapping.org>
Date: Thu, 26 Nov 2026 13:00:18 +0100
Message-ID: <87qzg7u7jh.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

FUJITA Tomonori <tomo@flapping.org> writes:

> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' un=
defined!
>
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
>
> Use div64_u64() and div64_u64_round_up() for these divisions, in the
> same way as C drivers use div64_u64() and DIV64_U64_ROUND_UP(). The
> results do not change.
>
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/=
topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Suggested-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


