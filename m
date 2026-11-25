Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621354;
	b=zIVvnj4/qskkLlSo+IxtlJBUy60eUU301/DP4flHfoQ3hlr24F8qNhvmN3iFdb/BqlW2
	 JtE6UA733gM3cEcv9F33hsKtLJ95tIufDG9d+6lA2fT9WO7uNWIdYQe2V2a4AVV1N0dVy
	 joVmxKMsxBoPuhqhi5F+pwzJDgHq0/akwqr3mbrVCNDGK1jT7ltWzbv2P+OEClEBqqbMB
	 YYXBmpAWqXIVE4trpvqkEr6W7iOQesTdI7YQ4s+YIezTwnIq9fArxDQkKE/hXcV8NzbHN
	 I4buIa9VTokGIbsX++t0rgx8woepIjClQtkoNqwG5DwpXWvU1b529KtCMPQNHIVdxOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621354;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Content-Language:
	 From:In-Reply-To:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:X-CMS-RootMailID:
	 References;
	bh=DVToFZ4noNwAfFmk4Pg3FQNdpYcFEOtOpvG47xqhnd0=;
	b=kYvp8zVoVOl8tHteAmW5pfRVHhkYK7ZZG3Jz8u3iS9JevvaH1hEWukEHn5EiaeF865Fo
	 sAi5xnyC661aW/mwObyjhzrQxeeSg0/8ZhT1Vo/uNHb1mYgqKgO0OKSFEXuTf7ZmqS02C
	 I6iqHFlOPMQPGEDd2TvHt4SC4UnKc8fPKnrg5ZFOYb1NqA9PdX4pRQxa7gfbL7AqQF9NY
	 Z8frQTq3GXVDM8v8v2o18QccOKZv+gW/DXEDIyIi+My/EfYfq6b+fFjsC5qUO87kuYT/E
	 6tWG86z+7mn7mbniwXrhnuPrk0g+zI9bCzDmLn/d5c40969CaCqhStc4ErUASjvhEFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=q9xWH1KP;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F94606A693
	for <linux-pwm@vger.kernel.org>; Wed, 25 Nov 2026 15:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F94606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=q9xWH1KP
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261125154230euoutp02650b78612ecf53d0f69cec58458c9609~rVBrZkArc2435324353euoutp02X
	for <linux-pwm@vger.kernel.org>; Wed, 25 Nov 2026 15:42:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261125154230euoutp02650b78612ecf53d0f69cec58458c9609~rVBrZkArc2435324353euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795621350;
	bh=DVToFZ4noNwAfFmk4Pg3FQNdpYcFEOtOpvG47xqhnd0=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=q9xWH1KPn436Mc2TOd3WHEaPFPmwCYF6PsMq4jeNi9zkj9F76jT4KdwdivLc6gFt9
	 SlakkD/DHsnYJoGkKe/ZJWmNmQq1KG95Po4Tw5KJ4MuRFk6TfmDvQi6tlthZZoA2+g
	 2lKmAcPfam5VXZ0uhESgrJUaIgssziKF4r/Rvzc8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261125154229eucas1p184619db373dca30c733061f864fdd83b~rVBqn70C_2988129881eucas1p1w;
	Wed, 25 Nov 2026 15:42:29 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261125154228eusmtip1349d5b40386cc690a4e81970b54ecdf8~rVBpyKmj43082430824eusmtip1v;
	Wed, 25 Nov 2026 15:42:28 +0000 (GMT)
Message-ID: <9ee41556-4a24-47b2-9db3-9665048658eb@samsung.com>
Date: Wed, 25 Nov 2026 16:42:28 +0100
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
Subject: Re: [PATCH 1/1] rust: pwm: reject over-aligned driver data in
 `Chip::new()`
To: Priya Bala Govindasamy <pgovind2@uci.edu>, ojeda@kernel.org,
	ukleinek@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
	work@onurozkan.dev, elle@weathered-steel.dev, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu,
	dzueck@uci.edu
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261125154229eucas1p184619db373dca30c733061f864fdd83b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261113202542eucas1p27ba92593376041c476afa9c5286205cf
X-EPHeader: CA
X-CMS-RootMailID: 20261113202542eucas1p27ba92593376041c476afa9c5286205cf
References: <cover.1794600927.git.pgovind2@uci.edu>
	<CGME20261113202542eucas1p27ba92593376041c476afa9c5286205cf@eucas1p2.samsung.com>
	<caddec5478a0d39a73152247a60bc21b3c609cc7.1794600927.git.pgovind2@uci.edu>



On 11/13/26 21:25, Priya Bala Govindasamy wrote:
> `Chip::new()` does not check the alignment of the driver data type `T`.
> This allows a Rust kernel module to choose an arbitrary alignment for `T`.
> 
> `pwmchip_alloc()` reserves `size_of::<T>()` bytes for the driver's
> private data. `pwmchip_priv()` aligns this storage to `PWMCHIP_ALIGN`,
> which is defined as `ARCH_DMA_MINALIGN`. But, `PwmOps` does not restrict
> the alignment of `T`, so a caller may provide a `T` whose required
> alignment is greater than `ARCH_DMA_MINALIGN`.
> 
> This can result in `drvdata_ptr` pointing to misaligned storage for `T`
> in the underlying C allocation.
> If `drvdata_ptr` is misaligned for `T`, that breaks the safety
> requirements of `pin_init::raw_try_init()` which requires a valid,
> aligned pointer as an argument. This is undefined behavior.
> 
> Additionally, `Chip::drvdata()` can be called using the `Chip` produced by
> `Chip::new()`. It creates a reference to `T` from the misaligned storage
> which is also undefined behavior.
> 
> Reject over-aligned types at compile time by asserting that T's alignment
> does not exceed ARCH_DMA_MINALIGN.
> 
> This issue was detected by FerroLens, an LLM-assisted analysis tool, and
> was then manually analyzed and reproduced.
> 
> Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  rust/bindgen_parameters         | 1 +
>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/pwm.rs              | 5 +++++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 5bab3cf06336..59d0a6518032 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -49,6 +49,7 @@
>  # We use const helpers to aid bindgen, to avoid conflicts when constants are
>  # recognized, block generation of the non-helper constants.
>  --blocklist-item ARCH_SLAB_MINALIGN
> +--blocklist-item ARCH_DMA_MINALIGN
>  --blocklist-item ARCH_KMALLOC_MINALIGN
>  --blocklist-item VM_MERGEABLE
>  --blocklist-item VM_READ
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3791af0aadc7..4ffd714f9229 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -113,6 +113,7 @@
>  
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> +const size_t RUST_CONST_HELPER_ARCH_DMA_MINALIGN = ARCH_DMA_MINALIGN;
>  const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
>  const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
>  const size_t RUST_CONST_HELPER_GENLMSG_DEFAULT_SIZE = GENLMSG_DEFAULT_SIZE;
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 8aa47304bec3..7823bb56d17a 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -587,6 +587,11 @@ pub fn new<'a>(
>          data: impl pin_init::PinInit<T, Error>,
>      ) -> Result<UnregisteredChip<'a, T>> {
>          let sizeof_priv = core::mem::size_of::<T>();
> +        const_assert!(
> +            core::mem::align_of::<T>() <= bindings::ARCH_DMA_MINALIGN,
> +            "PWM driver data is over-aligned"
> +        );
> +
>          // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
>          let c_chip_ptr_raw =
>              unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), num_channels, sizeof_priv) };

Thanks, the fix makes sense. One thing:

The C layout uses PWMCHIP_ALIGN, which is private to core.c. If Uwe
agrees it might be a good idea to move it to include/linux/pwm.h and
assert against that, so the two can't drift apart.


Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
