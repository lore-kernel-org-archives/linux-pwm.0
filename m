Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182324;
	b=0DIMW9Z0DatR0L6hD8btlq5s3bxQY+MofHxC1OAYRQppRboOeyDGF323tyN8CfDSSdFt
	 fnDh2G/Wuo5s9dNcoPKCUKJR04Pxoragg03ah8jMy0OyPFPKn2eeM5HDrK/Bax9K8D2Gx
	 tJLxDy0mmfnJaSKNxSlfohIIuq62L7DmvLL2IHGd4rDPIEtKGFVQn72L/5YSn3mTyfnf6
	 WrsOPYj6DgKixAC9+j4tKM4WSZK31AE2dHuy09q96zrMTTz5tDcLaIjQV6mcWf8uKDUwp
	 dWPFc+ma/lBQBsqgsvVqy3zEa+hB5RdgJCANqCV/fFxAtpOXRaPcNVpH56dV5dH4w4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182324;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=l2Yxm36V5tBhErrcCI/BN9DRDZoU36qNkjQdm2MUH7s=;
	b=jY1hP5YoBAfyHHk8M9dCQPqUGmhXfa7E8TEbI0qE3CVaQbEqbycoatw8HytKalHkOz1v
	 HDCt2rtxG1lk+AOnDvDltz+ZaEdu2yZSG/nz/M1pz9fET/h3fnWVMUblSnvyFNt1zjHOS
	 IrIoKJTe2qor9MHkQ0WWvAj1IF6CnEvf1UzJVkF8LUT/7YcT5VzvV1+5tgR9ej3nX10nZ
	 i823tfgz9PiBWL7NvDHax5+BWgu9AfESajtqAvZ4B6yLbU3vSgmXEI7xnBsZ4MD371EfT
	 TExhzInlBB9ww/+KZsOxMEOCOVDQw9/GJkCYnkB1cCPstgmlgYfq2aOHgEoCUOqmZ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=TLrltDMm;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD529606A32A
	for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 13:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD529606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=TLrltDMm
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261120134515euoutp016d3f7e80d340610be01e31e62f17238d~pxM3m2cc00862008620euoutp01Q
	for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 13:45:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261120134515euoutp016d3f7e80d340610be01e31e62f17238d~pxM3m2cc00862008620euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795182315;
	bh=l2Yxm36V5tBhErrcCI/BN9DRDZoU36qNkjQdm2MUH7s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TLrltDMm3kWaPUD7IXG44TYhRGqZc1YF0/gxHWAV41SY99aLCg5Lsv4ssabfNKPqm
	 WDURxLymCHkPe1ispED7y0ERYjfxR+aX6Ez7kZ4BVeANrZ5OYrnCqxn9sZzHKfPe0z
	 NnAI73XzSbG/Nq2A106Tg+luqWqWkzmD56LLJluU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261120134514eucas1p1b2acaadc0f7ee0c943442ea0a6a5a930~pxM3Fyaui2369923699eucas1p1_;
	Fri, 20 Nov 2026 13:45:14 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261120134513eusmtip195325329a5fb89c448a965ac7eab3801~pxM2Lxly-0213302133eusmtip1v;
	Fri, 20 Nov 2026 13:45:13 +0000 (GMT)
Message-ID: <bf228d28-c6a1-4bb0-b606-489f30eebda6@samsung.com>
Date: Fri, 20 Nov 2026 14:45:13 +0100
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
Subject: Re: [PATCH v3 2/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, FUJITA Tomonori
	<tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, ojeda@kernel.org,
	wefu@redhat.com, a.hindborg@kernel.org, acourbot@nvidia.com,
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
	chenhan0017.work@gmail.com, dakr@kernel.org, daniel.almeida@collabora.com,
	gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org,
	tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, FUJITA Tomonori
	<fujita.tomonori@gmail.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <avsZPKgzc9DIIsh8@monoceros>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261120134514eucas1p1b2acaadc0f7ee0c943442ea0a6a5a930
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261116145758eucas1p26d210030d9ab6b4a95fb048f061a8024
X-EPHeader: CA
X-CMS-RootMailID: 20261116145758eucas1p26d210030d9ab6b4a95fb048f061a8024
References: <20261030020209.3833766-1-tomo@flapping.org>
	<20261030020209.3833766-3-tomo@flapping.org>
	<CGME20261116145758eucas1p26d210030d9ab6b4a95fb048f061a8024@eucas1p2.samsung.com>
	<avsZPKgzc9DIIsh8@monoceros>



On 11/16/26 15:57, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Oct 30, 2026 at 11:02:09AM +0900, FUJITA Tomonori wrote:
>> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>
>> Fix the following build error on 32-bit ARM with COMPILE_TEST:
>>
>>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' undefined!
>>
>> The driver divides u64 values when it converts between nanoseconds and
>> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
>> __aeabi_uldivmod, which the kernel does not provide.
>>
>> Use div64_u64() and div64_u64_round_up() for these divisions, in the
>> same way as C drivers use div64_u64() and DIV64_U64_ROUND_UP(). The
>> results do not change.
>>
>> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
>> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
>> Suggested-by: Uwe Kleine-König <ukleinek@kernel.org>
>> Assisted-by: LLM
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  drivers/pwm/pwm_th1520.rs | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
>> index 728993998446..bd05fe49650e 100644
>> --- a/drivers/pwm/pwm_th1520.rs
>> +++ b/drivers/pwm/pwm_th1520.rs
>> @@ -31,6 +31,10 @@
>>          mem::DevresIoMem,
>>          Io, //
>>      },
>> +    math::{
>> +        div64_u64,
>> +        div64_u64_round_up, //
>> +    },
>>      of,
>>      platform,
>>      prelude::*,
>> @@ -68,13 +72,13 @@ const fn th1520_pwm_fp(n: u32) -> usize {
>>  fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
>>      const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
>>  
>> -    ns.saturating_mul(rate_hz) / NSEC_PER_SEC_U64
>> +    div64_u64(ns.saturating_mul(rate_hz), NSEC_PER_SEC_U64)
>>  }
>>  
>>  fn cycles_to_ns(cycles: u32, rate_hz: u64) -> u64 {
>>      const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
>>  
>> -    (u64::from(cycles) * NSEC_PER_SEC_U64).div_ceil(rate_hz)
>> +    div64_u64_round_up(u64::from(cycles) * NSEC_PER_SEC_U64, rate_hz)
>>  }
>>  
>>  /// Hardware-specific waveform representation for TH1520.
> 
> For me (being at most half-literate in Rust) it looks ok, and I'm fine
> to let this patch go in together with the first patch of this series via
> the Rust tree.
> 
> @Michal: If you have objections speak up quick!
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Best regards
> Uwe

I think the code is good. Thanks !

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

