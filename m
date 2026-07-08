Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B73F54B0;
	Wed,  8 Jul 2026 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496385; cv=none; b=P+BfUAl2ZUh+dd9M1Oio0zn3IH98rIlGD51HqFvHKELrAMPPS7hyTK7CKAoylurN8wWGQ6qRTtTNhQWUQt2gB+SX6ktDXnBdoPaoFRcez0LcZAeXfQchtP+aBL0KyopdvZwfkhMNaD2uAyyHxu/2dgPwImO1v85ZprAXu/MW7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496385; c=relaxed/simple;
	bh=hE80zLMucVCYhHzwDByDl4nPpyiOoITY4WrX5mG/B9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4h1KJ/j5RjjxHVltfMsSgwOZx+bf6AqRJqg/iLrHct1XQ5vTavC+7BTOXOoizFVKmQMUBBKrm7JqtkkRd5qEmjpHCJUNPa77aQYaFY0IodrHurwmBa0D9Cx/qgAQ71XuFczFDW4+df49GPJZJOseOPkv5qUVTgxSlL/6rWmETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 1183CF40CC8; Wed, 08 Jul 2026 09:39:25 +0200 (CEST)
Date: Wed, 8 Jul 2026 09:39:25 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] pwm: th1520: use vertical import style
Message-ID: <ak3-rU3IRYaLTCC5@luna>
References: <20260705-pwm-rust-vert-imp-v1-1-753dbbfc6061@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-pwm-rust-vert-imp-v1-1-753dbbfc6061@gurudas.dev>
Jabber-ID: linkmauve@linkmauve.fr

On Sun, Jul 05, 2026 at 07:52:05PM -0700, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Separating out patches per-subsystem as per the review feedback in [0].
> 
> Tested via:
> 
>     $ make LLVM=1 rustfmtcheck || echo "fail"
>     $
> 
> [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> ---
>  drivers/pwm/pwm_th1520.rs | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 3e3fa51ccef9..2a3b107157ac 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -23,15 +23,21 @@
>  use core::ops::Deref;
>  use kernel::{
>      clk::Clk,
> -    device::{Bound, Core, Device},
> +    device::{
> +        Bound,
> +        Core,
> +        Device, //
> +    },
>      devres,
>      io::{
>          mem::IoMem,
>          Io, //
>      },
> -    of, platform,
> +    of,
> +    platform, //

Same here, you just need the empty comment after time, not the one after
platform.

>      prelude::*,
> -    pwm, time,
> +    pwm,
> +    time, //
>  };
>  
>  const TH1520_MAX_PWM_NUM: u32 = 6;
> 
> ---
> base-commit: 1a4920940ebfd8d907858abd8f8dd09b13752946
> change-id: 20260705-pwm-rust-vert-imp-59a3d18bd0cf
> 
> Best regards,
> --  
> Guru Das Srinagesh <linux@gurudas.dev>
> 
> 

-- 
Link Mauve
