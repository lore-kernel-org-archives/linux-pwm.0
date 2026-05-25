Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F528313D;
	Mon, 25 May 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724302; cv=none; b=JA5Edhg/tOWzYIhoMmKfbnJ9/qok9VffCyb1xEbeikPolvjma56Ej35vP2jsppW/2pUmlHkDp8rcpAQVzYNFT+q+XgyIhbId1mSQsvbBnkByH2DRpM7+3lXRSR2lrXSWe0hnL1A97gyI/g0omvZXES8QzDx4IaBFujTM6rCcQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724302; c=relaxed/simple;
	bh=5RdoKRVA0x+8aY6CRCa2zCHTLS3bM8eE7lJ8vvT0HdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmPnZyK4QjGx1Y6XEA9DP+2N1fEENoEu0ZVyHrXmwlqpNrlRsWeUlToocUt4aO2PKlgLyf8YUDAbtLfQzQCCA0Z5UgfZIn4FoTurNl7r3XV0pYWrhNo9vg5PzRTlapMqBTvkNO8PIafkxLpsB+DDF9dHni1976fEUH9EVNWzKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Xtn6Tjah; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xtn6Tjah"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gPL365gBbz9tVg;
	Mon, 25 May 2026 17:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779724290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RdoKRVA0x+8aY6CRCa2zCHTLS3bM8eE7lJ8vvT0HdQ=;
	b=Xtn6Tjah3hYLA/WGRvRXSLCa7rRkeRKodfO+c2pfCdDn3E5Dl4nwc3MLlcxUGNC5W/15ZG
	KdtGzKShoyCBeCRBX5O7yQ317VfoMzZOq2M5aw6ng6G9wSccgOve2GHwCbkQAPWxc5/kmF
	9B22dbd/3yeZt9dHOKDmXg2i0eI3GetzroqMxK35lFrJiRxq6Vbg7CogNZZ/KZNrR8MRzi
	/71ZdwR72XWeeF7W5JxbYoU8o5/DnckjUMT3yOwmXBTGbnYu7fYam9JvT9RBYMu+QkBmWm
	1ShmqQwhFHu/PS7eiYSncde5wu5U4L6OOJaPmgcfn+35+oOdKIT4o9LUcie55g==
Message-ID: <1f550af5b8d1fa2aaa9936d5b0010c156e0cb455.camel@mailbox.org>
Subject: Re: [PATCH RESEND] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
From: Maurice Hieronymus <mhi@mailbox.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini	
 <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Mon, 25 May 2026 17:51:23 +0200
In-Reply-To: <8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com>
References: 
	<CGME20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec@eucas1p1.samsung.com>
		<20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
	 <8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 8c55d0b8313bfffa87e
X-MBO-RS-META: owyy74by9dsuncukaxyh5xfh3b4yw1k4

On Mon, 2026-05-25 at 16:36 +0200, Michal Wilczynski wrote:
>=20
> To move forward, we should fix this by implementing the proper
> generic
> 64-bit math helper in the Rust abstractions, rather than narrowing
> the
> types here. Are you open to looking into adding the Rust equivalent
> for
> mul_u64_u64_div_u64_roundup instead?

I would be definitely down, to help with that.

Before I start working on it, a couple of clarification questions.

Should I implement this as a thin FFI wrapper calling the C-Functions?
Or do you prefer to have a re-implementation in Rust.

Since mul_u64_u64_div_u64_roundup is a macro: Is it okay if this will
be a small Rust function or should it be a macro as well?

Thanks a lot,

Maurice
