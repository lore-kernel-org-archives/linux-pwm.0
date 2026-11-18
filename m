Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042416;
	b=wV6eClxDOqkq0/WZrNRXpRvuCQkwhFAPUnNHF8qdyHBeT1u/c6BiqiMzfZHP4KbgxO84
	 QWfGaHjKUfLxj3Knrci1x+bodjjQviS4JBLeVw4URl37MuAe4xD4Dxy8aHBF9x2wIsdOR
	 gAIDICi5HPpR9ELLxBWM6KjWI99/X6jrilyFV8lEntjbxfK7dO8lWTonoEbBkIa972TT+
	 SjbMZb7+lbAsptKj98V+DMAW+j0N59+9cFhRdmSFyoi5/iQ5zk3ryEVdPFMYsZC9k/Tmw
	 RVBLe082ZrTbOVSlC6WCSSr0O0CVFVIJGWiTa2x/+a6Z15KVk9hvVPB39jQZd2iqkEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042416;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ju41tYcaiYxL4W2/W44iKRoLMlO2PoKIBMEkIkLyQg4=;
	b=R83anHTF2t90P/YBNOwkXnwmRXjWULowOp2xUckalYFG52Zgg0dt+1udco8W/5rHu2f2
	 FYm9JViNRlL8VHbseoYd/hrDlAQy8YhsqfzaPQsV+m2OXwJymA5zvUgXTb7djB/Ee0xl0
	 icuG8Bje1BxzicGMeQqadUpF/5dJVHjXGz9gp5pK3UETUhNtWrluUJeAal9TDsovjp/uP
	 f5H01tl0+nNH1XgjPN5aR8gzi27k1aw5DnT7P7tTqHK2nbU/egRBVfC9LCth2etZ01ejC
	 pBIIOC9d+1BGblV+oLtD/dYvmMAhJM9sVcWOEFpzameQuvBcQNbym4NJIEMKSZYELwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEuWXSGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58F606A320
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEuWXSGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A91F000C5;
	Wed, 18 Nov 2026 22:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795042416;
	bh=ju41tYcaiYxL4W2/W44iKRoLMlO2PoKIBMEkIkLyQg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FEuWXSGrYrUQFlhOYDJ8RmqRs+UHxDca+SRQUjzDXuUFDIzfXsVMXV5QW5Nf2O6O2
	 yMfr+HxTUXuul8S/4nyXH3r2G+T3BUw17R2mKzbzKHGY+Uc9R9TDwQqHP1I07BZL1h
	 cg0702Dz8taE9mZDR3DpfRWO/zeJGCiWx+2rBpqpU54s60T8l+okiYjuAzmVobBvVi
	 dd6+0FS6i6GTPI2AAfPqebmA+dM3JxbnmqF0/BCeTJTRMszRnLVvcPbZzh9sXG+JFZ
	 o1ZEN2SyYFSeAyu5X1TmOKKyuatEEOc8sOmu7NRmXiEDhgDi/YfEZFhXIDZOJ8MUDW
	 4tZhNsWv93cTQ==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfauth.ams.internal (Postfix) with ESMTP id 3BFF5198004A;
	Wed, 18 Nov 2026 17:53:33 -0500 (EST)
Received: from ams-frontend-01 ([10.64.2.36])
  by ams-compute-01.internal (MEProxy); Wed, 18 Nov 2026 17:53:33 -0500
X-ME-Sender: <xms:bCz-ar165EtE8yP63F8I3TVUVbswPq0W28EX1eVCuvCspJSmMTa8Qw>
    <xme:bCz-atn1iwnmNoA5-0PrLDlvzW0ZTnKbz2GZQ3leKx2RlYhlnLVsT7tkReavmDM1A
    jprlM6e1waLYmBAPuXwhj1EENgq8pYksOaNPSQSin3YqtELmQ-f-YmW>
X-ME-Received: <xmr:bCz-akZKlmfegl2fqaxxh7n91phHwSKnWnj7jZR-kBiy9bXblJLgRgdUKFoWzQiz7xw>
X-ME-Proxy-Cause: dmFkZTGXIZczXO+q6nTDnnEDvnvxIDawn337UpYr9JBMhqxburbViiiOHKHwmc9THwyxsv
    mMtxYDhBKJUPw87BPTOS83rVPircW+IuGhNLyHPm29xrQfEd8oB5Y/vOrzLTevOMUpFKll
    x6IxlXfz5ayiB//GnmAE5vpQukAANDlGGhka8oOoolkp1fJj2KhhfFVrBEpsdxH4aHEJU1
    OJwIRH+T2juR5qFAkq6C4SQPuquCsk4qcYhWWw49en0FDrCDxplQwmW8234rugaEPwbMb9
    Vh6m6IDv4fxLik+a76NDGhtqmbm/EIy4mvvwoZjhveJtqosG6m/JLmF964oiBMF+FwXVQg
    7kxdPhylGkBNQU8VJT7JaepaX3P5UE0pQN6K46BLGwgxuheOetCjapOLVOAncSLUzv8KwQ
    Eppk1HzLr1HHlN5tseRUNdGBCagPDaIk+9n+oReBnHgypHForZWKDBYOA4YfSvdoEhPVWz
    jFm2+Il+Uidjg9JeFAfnEtYnL0na1GYilpa68Gj/GbWoXpur4L8d1jlk0+gTg443Oit12n
    RWtxb8mhnwkKPgWIvnmWHZbrpWTBEZ2aXGtbCO/fLnWrqIPSsnDPIsmOE5h+WH3W+vxpxO
    I2+wN0UFnaVordnO+YBO8eXixrynfqAIY8xDRpW4eP1pg9upxWW8NNvjnsjg
X-ME-Proxy: <xmx:bSz-ajogOxzQPsY1lIwvMLSM7QUOTTFOCc8ci-d4zb8D6EfXwkwQ9A>
    <xmx:bSz-aijI6Seva34_ycm_CItwANcssdiPxnlPJP4hvPVScJgtHVXd2g>
    <xmx:bSz-atw5apVr4qKkV6OArzTae8CUat8BRMflg8Yo1hrVh84gBP2JZA>
    <xmx:bSz-ao8aqTnFeyYzoJ7OXE1PVHjQLP9bAjSVEQk5S-E8WJSDn8Dd1Q>
    <xmx:bSz-aiAi-ZQEQAiZn3Ftu0If-6-NiFKB4AF0UJIc3cqgdSA2nnxOdUnt>
Feedback-ID: i78584a88:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:53:29 -0500 (EST)
Message-ID: <a7021c7d-4171-4961-b8b5-dea622fb9e9f@kernel.org>
Date: Wed, 18 Nov 2026 23:53:28 +0100
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] rust: math: add div64_u64() and
 div64_u64_round_up()
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, ojeda@kernel.org,
 ukleinek@kernel.org, wefu@redhat.com, a.hindborg@kernel.org,
 acourbot@nvidia.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, chenhan0017.work@gmail.com, daniel.almeida@collabora.com,
 gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org,
 m.wilczynski@samsung.com, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
References: <20261118224826.2491684-1-tomo@flapping.org>
 <20261118224826.2491684-2-tomo@flapping.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20261118224826.2491684-2-tomo@flapping.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 11:48 PM, FUJITA Tomonori wrote:
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
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
