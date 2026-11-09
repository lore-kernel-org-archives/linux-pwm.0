Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224075;
	b=msFrPnLwIpWpY8+wohxki5VWNxI2KZupoPklL4lwMsq+4l0upWMcDu3wIGwH6U3AOpEq
	 CcKasiy/PtIk5KPZ8828aQH5WjcZ/fr3QcpuL3sJUtIaG466IE0YdMj67PQc5w4CnZwLd
	 ddA4/NTq82AS6nk3yWWFhTKooyPczWqb2+nOnhABrGfQRVE2TG4rCOtg8Ttr+tVZETBjX
	 jdYl47yR83meAubh9FCB9bysmGAJWI2RMZV5cmZ4gbcPE5qvIy8ugdlXC7yfk3HIwyTKU
	 hoJ3mMnbCkq1hmAMYAP0Ns3TdxiFB6w9H1k+zQBbZOquvNLWJBkjOWgc/7J28N169uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224075;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=cMSBSauqbPIE/ZS7qOVOkPsVpLXl08SzTSg0ECffbco=;
	b=S+I+e+MgaOQAzAhC+8fi+5SXUPNXZ45ceLsEKzMzTjNrhpqHKdjzk+SxZDzCwomLiqb+
	 AbdH0iVUYvLKvR2ZGvdc0KkuZSuVITZ0TP/MmDnka9zfo1GZMt7ij9XrLQjP6KxPwBagf
	 3HHNvvDp6moM4QIYvdvwb4fENOKzAl8dzf70ZqaNn1asnfjtnJ0UMDUgkYzvsF7A8yVr4
	 Wvfj8FsjKGGHfQPUOGfGMiS4h0fQvmfQa6dLExTFo9kyD/zkjZswofL+d6RLRQYhbnudx
	 nGUFFNKrl0WFeHM9cTr/weLL8Cse39CMC1OWW+t+KeeXLMU3+TcYOKwGcjMSpKSdH+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QOsdKTOv;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E97606A321
	for <linux-pwm@vger.kernel.org>; Mon,  9 Nov 2026 11:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E97606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QOsdKTOv
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261109113425euoutp011e33da4c14a112953cb2f27561ddd65b~mXUgQfZzT2502625026euoutp01C
	for <linux-pwm@vger.kernel.org>; Mon,  9 Nov 2026 11:34:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261109113425euoutp011e33da4c14a112953cb2f27561ddd65b~mXUgQfZzT2502625026euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794224065;
	bh=cMSBSauqbPIE/ZS7qOVOkPsVpLXl08SzTSg0ECffbco=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QOsdKTOvcEXJjFIVPtBXVB7EkA7Ikgde4s4uRTLilHEFAE/r/EC+evymPeqfY/VPN
	 nQ1TKx2DddFAJNF45VwroaRECbJSigX+8a/jHR8cAivTxUYaCtehmY36ryp3+VnBwN
	 ZRcqoTptiZleuWijLhncsvJm3oLfP9aT/qkTwSTM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261109113424eucas1p108cb7261add005a44da39d455ce78c8b~mXUfeJBUJ1552515525eucas1p1e;
	Mon,  9 Nov 2026 11:34:24 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261109113423eusmtip1f076461a2dfd87689abe6a70506e3d63~mXUeio9gN1550415504eusmtip1U;
	Mon,  9 Nov 2026 11:34:23 +0000 (GMT)
Message-ID: <529993dc-343e-40ff-af88-aa1a91cab25f@samsung.com>
Date: Mon, 9 Nov 2026 12:34:23 +0100
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
Subject: Re: [PATCH 1/1] rust: pwm: track the owner module when registering
 `Chip`
To: Priya Bala Govindasamy <pgovind2@uci.edu>, fustini@kernel.org,
	guoren@kernel.org, wefu@redhat.com, ukleinek@kernel.org
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
	work@onurozkan.dev, elle@weathered-steel.dev,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu,
	dzueck@uci.edu
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <f9cf8f0d897f22888134b2b17f1b0f86bcda311a.1793150685.git.pgovind2@uci.edu>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261109113424eucas1p108cb7261add005a44da39d455ce78c8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261028222851eucas1p160ae9a88fe903d5947ab6b7a75078ced
X-EPHeader: CA
X-CMS-RootMailID: 20261028222851eucas1p160ae9a88fe903d5947ab6b7a75078ced
References: <cover.1793150685.git.pgovind2@uci.edu>
	<CGME20261028222851eucas1p160ae9a88fe903d5947ab6b7a75078ced@eucas1p1.samsung.com>
	<f9cf8f0d897f22888134b2b17f1b0f86bcda311a.1793150685.git.pgovind2@uci.edu>

Hi,

On 10/28/26 23:28, Priya Bala Govindasamy wrote:
> `UnregisteredChip::register` calls the C function `__pwmchip_add`
> to register a PWM chip with the PWM core.
> `__pwmchip_add` documents that its `owner` argument is supposed to
> be `THIS_MODULE`, but `UnregisteredChip::register` passes
> `core::ptr::null_mut()`. This is acceptable for built-in drivers.
> 
> However, for loadable drivers, registering the chip with a null owner
> prevents the PWM core from taking a reference to the owner module when
> a PWM is requested or its character device is opened.
> This means that the owner module can be unloaded while references to the
> chip remain. This can lead to use-after-free and
> kernel panic.
> 
> Fix this by marking PwmOps as a `#[vtable]` trait so each implementation
> exposes its actual OwnerModule, then pass that to `__pwmchip_add()`.
> 
> Fixes: d8046cd50879 ("rust: pwm: Add complete abstraction layer")
> Reported-by: Dylan Zueck <dzueck@uci.edu>
> Assisted-by: LLM
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  drivers/pwm/pwm_th1520.rs |  1 +
>  rust/kernel/pwm.rs        | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 728993998446..6a1f4219d6fa 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -94,6 +94,7 @@ struct Th1520PwmDriverData {
>      clk: Clk,
>  }
>  
> +#[vtable]
>  impl pwm::PwmOps for Th1520PwmDriverData {
>      type WfHw = Th1520WfHw;
>  
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 8aa47304bec3..ae7b449d67e4 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -12,6 +12,7 @@
>      device::{self, Bound},
>      devres,
>      error::{self, to_result},
> +    module::this_module,
>      prelude::*,
>      sync::aref::{ARef, AlwaysRefCounted},
>      types::Opaque, //
> @@ -175,6 +176,7 @@ pub struct RoundedWaveform<WfHw> {
>  }
>  
>  /// Trait defining the operations for a PWM driver.
> +#[vtable]
>  pub trait PwmOps: 'static + Send + Sync + Sized {
>      /// The driver-specific hardware representation of a waveform.
>      ///
> @@ -673,9 +675,14 @@ impl<T: PwmOps> UnregisteredChip<'_, T> {
>      pub fn register(self) -> Result<ARef<Chip<T>>> {
>          let c_chip_ptr = self.chip.as_raw();
>  
> -        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
> +        let owner = this_module::<T::OwnerModule>().as_ptr();
> +
> +        // SAFETY:
> +        // - `c_chip_ptr` points to a valid chip with its ops initialized.
> +        // - `owner` is the module implementing `PwmOps`. It is null for a built-in
> +        //   implementation or a valid module pointer for a loadable implementation.
>          // `__pwmchip_add` is the C function to register the chip with the PWM core.
> -        to_result(unsafe { bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()) })?;
> +        to_result(unsafe { bindings::__pwmchip_add(c_chip_ptr, owner) })?;
>  
>          let registration = Registration {
>              chip: ARef::clone(&self.chip),

I have managed to reproduce this issue and can confirm it's fixing the
problem.

Code wise seems OK.

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Tested-by: Michal Wilczynski <m.wilczynski@samsung.com>

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
