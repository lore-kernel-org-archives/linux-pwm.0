Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240793F88A8
	for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150925; cv=none; b=OBAjaYhNW+KWkqyiWVLTNeBL+pmRbxcNZcei3CUg+yx5v4DJvFPNZcRkcEhVrDTVSuqU7yDVC+HF2ytoDt/YZoGLz+zWWjiKHS0e5OrQ2b4g5lFiSDjZ2nYDLHx3SzDAKWHbxDjYOG+dg0npl8lMMpmtDG01AIoxn3ajrsWVceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150925; c=relaxed/simple;
	bh=FSGGFdDhWSnb8CCbvnx3/qBrQn+EJBu2CTO1ACrdCv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OOM1bWs0OetQPSfWBlUMFjApxY95AVL+hbmWT3bZHIgYMPcyvHGhV/c+YwGHAGTj2t7pONdWmLAkRGFUmMPbiAaj+pe+4DevI97F2kZe69VK8LYBXLvZDdCmkJ8NNq8ovaT5dMyBeD8MKkbfNYNqbDnZXPu/X25iuSbf48ZOZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DHCNX6Tf; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DHCNX6Tf"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260727111515euoutp01f763d9f3712ad50e2fa4d9cd31e00328~GIUyo0xG11356513565euoutp01f
	for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2026 11:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260727111515euoutp01f763d9f3712ad50e2fa4d9cd31e00328~GIUyo0xG11356513565euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785150915;
	bh=A7ERjbMk+yFZshthB0sp+/tIp9yvMUlmWK307gnlUbA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=DHCNX6TfMMrrGLGiAogKgGrGc54pm9hMLZKxN+f/DROTose/ZDPN8wxFiG3goWpFU
	 ufonCu65Wo8Tak70rsiBGeA34I93TtVspvt7flyfWmooFrgHzvudOkXemzB2Ikl6A7
	 k2mCVnU7JPaztIcGsAIfxak6PPDNDnD1ylSQQeuo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260727111515eucas1p27222fc8db945ebaa9fbdb982273ba8c5~GIUyZ5zFn0254302543eucas1p2-;
	Mon, 27 Jul 2026 11:15:15 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260727111514eusmtip139c438f59f7bb6c2db48ab040612e603~GIUxyucU80770907709eusmtip1v;
	Mon, 27 Jul 2026 11:15:14 +0000 (GMT)
Message-ID: <d9f17866-cc79-4f6c-9b4b-236128bebe69@samsung.com>
Date: Mon, 27 Jul 2026 13:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
To: Francis Laniel <laniel_francis@privacyrequired.com>, Miguel Ojeda
	<ojeda@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260727111515eucas1p27222fc8db945ebaa9fbdb982273ba8c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260603160927eucas1p1ae24e871a8ef0771d72fae6462d96318
X-EPHeader: CA
X-CMS-RootMailID: 20260603160927eucas1p1ae24e871a8ef0771d72fae6462d96318
References: <CGME20260603160927eucas1p1ae24e871a8ef0771d72fae6462d96318@eucas1p1.samsung.com>
	<20260603160910.159307-1-laniel_francis@privacyrequired.com>

Hi Uwe,

On 6/3/26 18:09, Francis Laniel wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://protect2.fireeye.com/v1/url?k=851847ef-eca32f5d-8519cca0-905a08a8515a-5adce8ef7cc40eb1&q=1&e=6c6d6a32-0f0e-4805-8882-718eae7641a8&u=https%3A%2F%2Fgithub.com%2FRust-for-Linux%2Flinux%2Fissues%2F1189
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  rust/kernel/pwm.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 6c9d667009ef..3427b7d93a03 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -494,9 +494,7 @@ pub(crate) fn as_raw(&self) -> *const bindings::pwm_ops {
>  /// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
>  /// expected by the kernel.
>  pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
> -    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all fields are
> -    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern (None/0) is valid initially.
> -    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
> +    let mut ops: bindings::pwm_ops = pin_init::zeroed();
>  
>      ops.request = Some(Adapter::<T>::request_callback);
>      ops.capture = Some(Adapter::<T>::capture_callback);

I believe this commit is good to go, if you could take it through your
tree it would be great.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
