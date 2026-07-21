Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF7435A83;
	Tue, 21 Jul 2026 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620234; cv=none; b=cgk7iMWAYbeNwC5HRE679D8/0Kict9nPjFaMi4Tre7dJ946yOIAl67Ac2Tm3voec3WOFzdHSunzGJcu7iUHWFZimNDlV6OE4a01ol7AMRsS//INqECXcf7exc5E+JX64uNvB9THnR676MWkpyd0iUCFMJ8z+NAZVGFe70yfceKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620234; c=relaxed/simple;
	bh=Y/RQvv9LaQgt95iibZZ4uufhSLgFPy8tTOyXYtrR7yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjFYk+z4thZWhuvLFtB9stUN7e1He0l0hxy77P6Xcs4RLMkgEUujE7JdEmhcg/ylDBbUClVU41uwdhg1miE6Jk2T9dmiBHsz9GaxThtYGSg+bz1c3MHQhe/qeeyqKitc6kq7KK7Mn1g+AYSfbG/28SNtrPocZblm67Y+2MBgM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=gY0rYPpn; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="gY0rYPpn"
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4h48gp578vz2x9B;
	Tue, 21 Jul 2026 07:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1784620231;
	bh=zA2cPnAA92Xrj4Tj9D0WkWnQLAGKwGz9kgEDoAwbDH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gY0rYPpnmzdJfsPD+BFHyAgFbaXKuWK/yCorZvKAFcnCZAx3QvuPvJOvlAUrHKEHB
	 uunmuUMC/dKZ1q8ft7CZZKRpIxsKX/sLjXGIe+bjcSvYJEoqF+9Zqv5wAuXV7+7Gpq
	 uDfq0s0iuyPyyqiJVo1EZOCoUFC+YbkrbhZ9iNgL7DCK3E9y4ihvBy6+yO2JueK7EQ
	 i7KElcIMkKAMfqewjI5TWt6yYHS9fWSPAXcWE3NmycI038uJxnnQmtr3cTXitnG0+g
	 2oqt3ylO5PDkUbDurg/+Vj8/a++nH3DlXuG109IdpflgHY1Mhp3bkemzykQDcE/uMn
	 SpMDWS2IxFfFQ==
Date: Tue, 21 Jul 2026 00:50:28 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Link Mauve <linkmauve@linkmauve.fr>
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
Message-ID: <al8kxC4y3rviugTh@gurudas.dev>
Mail-Followup-To: Link Mauve <linkmauve@linkmauve.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
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
References: <20260705-pwm-rust-vert-imp-v1-1-753dbbfc6061@gurudas.dev>
 <ak3-rU3IRYaLTCC5@luna>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3-rU3IRYaLTCC5@luna>
X-Envelope-From: linux@gurudas.dev

On Wed, Jul 08, 2026 at 09:39:25AM +0200, Link Mauve wrote:
> On Sun, Jul 05, 2026 at 07:52:05PM -0700, Guru Das Srinagesh wrote:
> > Convert `use` imports to vertical layout for better readability and
> > maintainability.
> > 
> > Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> > ---
> > Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> > vertical import style") and found a few more locations that could
> > benefit from this cleanup. No functional changes.
> > 
> > Separating out patches per-subsystem as per the review feedback in [0].
> > 
> > Tested via:
> > 
> >     $ make LLVM=1 rustfmtcheck || echo "fail"
> >     $
> > 
> > [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> > ---
> >  drivers/pwm/pwm_th1520.rs | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> > index 3e3fa51ccef9..2a3b107157ac 100644
> > --- a/drivers/pwm/pwm_th1520.rs
> > +++ b/drivers/pwm/pwm_th1520.rs
> > @@ -23,15 +23,21 @@
> >  use core::ops::Deref;
> >  use kernel::{
> >      clk::Clk,
> > -    device::{Bound, Core, Device},
> > +    device::{
> > +        Bound,
> > +        Core,
> > +        Device, //
> > +    },
> >      devres,
> >      io::{
> >          mem::IoMem,
> >          Io, //
> >      },
> > -    of, platform,
> > +    of,
> > +    platform, //
> 
> Same here, you just need the empty comment after time, not the one after
> platform.

Done, thank you for the review.
