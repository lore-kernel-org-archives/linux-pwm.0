Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC74746DF;
	Tue, 11 Aug 2026 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481692; cv=none; b=Nn6WWaY45tefHjx3msuv/ALP2Pr34lVEoRhX+vxwXnSPe4lg6F9C7PQJ8YpD815eCG5p/04f/iZipZ3uPcHfI5poGSUN1iSFifS/5iReVhEnLLnGlPM+g4RaA+zHH9EYHzUrQhdpYRZZJ6Ki0bqMfVVniV1glADVNg81/6c0O7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481692; c=relaxed/simple;
	bh=mGwjceCenGbKeRTcvoOULQz/f+T1Vz+gjSaKZXH2FDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5TF8Gg/6DR/VeZXSUZ4gXbgdJQtcusfNI8ZiHeX3wZM3bXf8C4JPo5PTq2OFgkxrOXFbkGDt9s0xxBkBv3QV+zWb5lC2/UVQ/D918Ocq4ROWbWUtp0maXeLOoAYvJPV0AVrXWZm9xGDtU03lTJyhC5mpW2Mq02p0jEbCH07kGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0Ut8GjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Ut8GjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5FE1F000E9;
	Tue, 11 Aug 2026 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786481690;
	bh=Y/KpzGpsVQHvVxlVDtZ2lflaWXZ4428w8tPzgiEuVKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W0Ut8GjUyM0MUrVFU4vi4oAyy/h5DZ5nstiRJ818AZ+jLwNQlNEWSCDwoBNzmD0gz
	 BZAk9Nn3wyk2C92kxzVO/SAWmPPrPx59hq8AV44WMh0nuiJKlY6ePsOTsK/SUCRbcu
	 jQlWnfitKCMcW13Ul6HOql0lIJMyT/gEY1FapW41L1w8zeqBsyoEsdgaqHq8iUN3a9
	 YlNcRmO+xGT+dP75F09wR2HbfxTxIiT5sfFJ7eG9gJznIb0Bv3Rbs5BitWbfEi+Uhk
	 B+exGYnymkxorFDojn2Z0xrci+w/BrUANjJnYoW+aQch3g5bRhr3cN2D68eVBU10gT
	 bSXINVtHdIEaA==
Date: Tue, 11 Aug 2026 16:54:47 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Message-ID: <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
 <anqsTVj5QGYGiEQ9@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anqsTVj5QGYGiEQ9@monoceros>

On Tue, Aug 11, 2026 at 07:04:49AM +0200, Uwe Kleine-König wrote:
> Applied to
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> for the 7.3 merge window.
> 
> b4 behaved strange on that patch:
> 
> 	$ b4 am -s -l -t -3 20260603160910.159307-1-laniel_francis@privacyrequired.com
> 	Grabbing thread from lore.kernel.org/all/20260603160910.159307-1-laniel_francis@privacyrequired.com/t.mbox.gz
> 	Analyzing 2 messages in the thread
> 	Looking for additional code-review trailers on lore.kernel.org
> 	Analyzing 23 code-review messages
> 	Checking attestation on all messages, may take a moment...
> 	---
> 	  ✓ [PATCH v3] rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
> 	    + Link: https://patch.msgid.link/20260603160910.159307-1-laniel_francis@privacyrequired.com
> 	    + Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> 	  ---
> 	  ✓ Signed: DKIM/privacyrequired.com
> 	---
> 	Total patches: 1
> 	---
> 	NOTE: some trailers ignored due to from/email mismatches:
> 	    ! Trailer: Suggested-by: Benno Lossin <lossin@kernel.org>
> 	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 	    ! Trailer: Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
> 	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 	    ! Trailer: Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> 	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 	    ! Trailer: Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> 	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 	NOTE: Rerun with -S to apply them anyway
> 	Preparing fake-am for v3: rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
> 	  range: 2707b9df955d..81c3f2b030a1
> 	Preared a fake commit range for 3-way merge (2707b9df955d..81c3f2b030a1)
> 	---
> 	 Link: https://patch.msgid.link/20260603160910.159307-1-laniel_francis@privacyrequired.com
> 	 Base: applies clean to current tree
> 	       git checkout -b v3_20260603_laniel_francis_privacyrequired_com HEAD
> 	       git am -3 ./v3_20260603_laniel_francis_rust_pwm_replace_core_mem_zeroed_with_pin_init_zeroed.mbx
> 
> I didn't research what went wrong there and the trailer made it into the
> patch anyhow and adding -S doesn't change the patch. I added the
> tools@k.o mailing list to Cc:, maybe someone there wants to debug that.

It was just Miguel responding with a suggestion how to better reorder
trailers. Since we can't tell this case from the case when someone actually
replies with a follow-up trailer, hence the error.

I added a special case where we ignore trailers we find in the follow-up if
these trailers already exist in the patch anyway, so, at least for this
particular case, the problem shouldn't resurface.

-K
