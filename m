Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044226;
	b=1zQG2z4xCnfFYdclrAZuAy9h2Rc1GmhdgViCV2jY/E1hAj1dxtozUmahop9KWitsKZU4
	 nWJgaKrc/OD7trFFdkNGiRgwTnZFNMQ1AUULoo5PAWY0Cfq2aAnuQs0UQO/v29IyKCTNI
	 H3E9hMfN9bi8ommHDHNjplQBDoYgL4HKIwaOB5quWzmp1d1KZcaivlOJiJCsH41EmoDeU
	 7NrBEq24/z+R9Rnqig5Ew8/dNZAcStFKLHpg0iX3mVEjw7w3vtCjblAXSsXn9BV/NVI2F
	 IFST18npoZ7Yh4ifrS8BwX8nTnmgmmEnrWSixeBFe8x3nrqSGIRb9D15Sd5ZeFlU8uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aE/1e9kDFCI5UrrvURSWVQtRLJVIirbU018865i3928=;
	b=R5MI0bU3I/5lc59OCoDd/GHTd55sIbA6glZwNHh6Xv4jynpyNldtoNeYazATFPkGDwBq
	 ICoR6ae2wOJzN4WejGFg7cd99l9nQU1l9aFOXZFQoMgi9JWytP1jgrrV7pKM5XcE8dmsb
	 bbzsVg9PlE/M9rh+oHGOIYF3AtpoqCq47zPPg97jHiFi00y73vD2LDRoHQNsGrVlfO32e
	 8p3RnUU+CHDuiH7j0ZBWfrxiKb68+uebqQO9S4aUHaOkPIMQouGpMM4PwFBrt3pwuYbFa
	 zrzJA5Jt7ZyDCCjgpOw1s/LoabF53lzGvZbxd5SM32ihFkwkPFPO3noCP1WsQotVgXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a9HksISE;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74205606A32C
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 23:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74205606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a9HksISE
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so11788565e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795044225; x=1795649025; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aE/1e9kDFCI5UrrvURSWVQtRLJVIirbU018865i3928=;
        b=a9HksISE9rfhaoQ5TxsP3bxk5acfY07yxEHGn/Tm6Fh5Y30CRwbzLQ4t5UjpUxsqty
         MmQjSYYTUA3/KlUIAb/XinwZtxXGXbHZWNwlA3h54eu4/4ek4WV7QESPlGC/3vVP81vB
         a7X1ErUOe8LVZkoQFIz3cc5mqlm/9aN3g7Bomow9No+jFPfvD8OqdIbLC+LInodSZAYN
         0bXa6DdaEMUs/Kxfmub+7fB4bypdrYgoatOVfOUbLkRfxDs08LmOMiMxHtwR42nL3xiP
         fYtv665mscjfAXrjsOZHjxM5wtfhRj8SV6ypb6kAyC5ZjdbqhtP+pa1eVqhFwmnoU9er
         2erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044225; x=1795649025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aE/1e9kDFCI5UrrvURSWVQtRLJVIirbU018865i3928=;
        b=d4zfgA/dTQW/2tm5mSa0ABO7kwYx8CD2lPLFdx37SLjZWEzBFSb09L4o0JvXa9DtvR
         wvbXjiIVB8mlnpJJIB+bgni3rYofDY/GC0RRIItiPrgejRbIEL9JC6s+s6soRmEuuiSW
         5fC0ZykNJNmeqSxA7KQWbdF+tm16GuzyYPH7UcQQ1XYQSYtkPPwiFb6EXnwH4RAk9CQ1
         FOVexJmFAddvPY3aqqHcbyAWV5CtI74+OljSbB2GeVsBNTNZKjVXQrQj0VU+WVXE3Uwg
         ea9pJVt32nuk148hUOQrQkszK2pN5vXFdY5NLUSCHa1KtNhMRLdpsWxtZsxz1098lbaj
         PZxg==
X-Forwarded-Encrypted: i=1; AL+hErGLFdY5K05soJXiNvW6H9mpbBZBw5A8I9180RubX9WR1G/FttcN+eWEdXvQA40zHk7D8AaUrE2fFG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z83S0Xgxnjq2MIW9MRWaxgClowRZzlT8Syk05yY7V9gjoWFnDzp
	bX3+3x7+fiFB+iJAhIR9IB6Y69R/mS3gpzKGsFMxuXjKLDegoZJi0jynKuClaNo8YV+YeOzg23i
	pLEAz2GQ++opxPZ9Cig==
X-Received: from wmbid15.prod.google.com ([2002:a05:600c:a18f:b0:4a2:966:8982])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b99:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4bb7da1aa22mr80985015e9.14.1795044224485;
 Wed, 18 Nov 2026 15:23:44 -0800 (PST)
Date: Wed, 18 Nov 2026 23:23:43 +0000
In-Reply-To: <20261118224826.2491684-2-tomo@flapping.org>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118224826.2491684-1-tomo@flapping.org> <20261118224826.2491684-2-tomo@flapping.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118232343.1511291-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 1/2] rust: math: add div64_u64() and div64_u64_round_up()
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: Alice Ryhl <aliceryhl@google.com>, fustini@kernel.org, guoren@kernel.org, 
	ojeda@kernel.org, ukleinek@kernel.org, wefu@redhat.com, a.hindborg@kernel.org, 
	acourbot@nvidia.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	chenhan0017.work@gmail.com, dakr@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org, 
	m.wilczynski@samsung.com, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 19, 2026 at 07:48:25AM +0900, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> On 32-bit architectures, dividing a u64 by a u64 with the `/` operator
> makes the compiler emit a call to a compiler runtime function, such as
> __aeabi_uldivmod() on arm. The kernel does not provide these functions,
> so the build fails when Rust code that is also built for 32-bit
> architectures uses `/` on u64.
>
> C code uses the helpers in include/linux/math64.h instead. Add a math
> module with Rust versions of two of them:
>
> - div64_u64(), the same as div64_u64() in C.
> - div64_u64_round_up(), the same as DIV64_U64_ROUND_UP() in C.
>
> On 64-bit architectures, both use `/`. On 32-bit architectures,
> div64_u64() calls the C function. Both panic if the divisor is zero,
> as `/` does.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
