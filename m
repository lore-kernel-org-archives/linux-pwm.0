Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49A399340;
	Sat, 30 May 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137689; cv=none; b=eW+UyEHER8zmRVfzjEVa4i2QjxJeAkOUjeEBz3yebzeqBAGt2Mb79lziHVrgwDt9qnoHxmP67fgHZhgjKZblT/HBQx4i9E5ZSgHOvAw74tRT9RP1qIs9FTV4WK5aJmgjQYwHDublJDQR2xDfW4iVAtLC4zL0H1R+EfoVtjjLtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137689; c=relaxed/simple;
	bh=8rLJAHarAeoUMg59HygnNpa2WBuECEEdnuMIXACLS/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPs5jiGXZS78mIEYmgAdknyzguEUgOHv61apatqhMOtHJUOmg4e2xqidDAZwA1Vh5zSfvYiEbt07lZ1TE9jPP22VwBRXo7x8DREHPd33KsLwUGz8g4svPb+Bx2ox1wVdeGxWoR6JbhApRMlCuX9HH3onzyQIOpLf30EIfaNLB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H0TpCUQp; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H0TpCUQp"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gSGws0fwFz9tpD;
	Sat, 30 May 2026 12:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780137677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rLJAHarAeoUMg59HygnNpa2WBuECEEdnuMIXACLS/w=;
	b=H0TpCUQpQ+Dr9Pvt+Ml8uhSOYfjX7mn/HBGzH+0yuyngapzV0xhIUrnYMAJdEkZKOPmlE6
	6bPrr74+kesJtiZhnCMR2utspDjmRTh0V+y5YUqlFI1v2Oao5U1EtfdABClzF15QtEJk1H
	gxs1yT4k1HqDfsZcZ5LF3UFqCT1yqPl0ZC1UssqQDoF3k+s/I20VrYyJ/NkIzAchOlA9Km
	+BHM0PmW/A4hu4H2wR5TS8zwNjY9QHaO6MUIZ5rSR7u6TxQzHjKTYedyOPfyNtpGWBOQR1
	aZiJ4vizjDVX1Ne/E9/IYcBGGe3xJzw3AnG3KrksPAaN8YGjmRcmZRr1ZX+vww==
Message-ID: <47062326dcf87b605cf4def9835394551645caa5.camel@mailbox.org>
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
Date: Sat, 30 May 2026 12:41:08 +0200
In-Reply-To: <58245ce0-7271-4b07-b866-0037ff68d92c@samsung.com>
References: 
	<CGME20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec@eucas1p1.samsung.com>
		<20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org>
		<8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com>
		<1f550af5b8d1fa2aaa9936d5b0010c156e0cb455.camel@mailbox.org>
	 <58245ce0-7271-4b07-b866-0037ff68d92c@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: w7y49kc766z4x146mxmm6op3a9e9kqhq
X-MBO-RS-ID: 66b95ce410648b2b261

>=20
> Apologies, I have to correct my statement from before after
> discussing
No worries!
> with Uwe. The reason the macro was used in the mentioned driver is
> NOT
> that PWM controllers have 64-bit registers - Uwe isn't aware of that
> being a real pattern either, and I was inferring it from the code
> rather
> than from hardware reality. The actual reason the macros get used
> isn't
> unified across drivers and we should pin that down separately rather
> than block your patch on it.
>=20
> So please hold off on the Rust helper for now - your initial patch
> might
> be the right direction.
>=20
Is there any further conclusion which direction is right? Can we merge
my patch, does it need some change or are we going down the road with
the Rust helpers?

Thanks!

Maurice
> >=20
> > Maurice
> >=20
>=20
> Best regards,
