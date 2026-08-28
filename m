Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576D3CB2DC;
	Fri, 28 Aug 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924295; cv=none; b=CesEETk2zwgLz36YYJXrrcGAClVH79jn7lYn2/kqTbJwfQiTiADl0U+aTDOrRtJlPlR0ejwS4hN8HHnNaM0mZ24wolVpPPSFdyNmzQ57NX28A6zn3WhJnPbnWBUf6+FQ2V85DhPFQb37iBoGufPTr4IGGwBZWul/tB+fM4iagiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924295; c=relaxed/simple;
	bh=Jhsym6f3hDxXMDYh7a5eB4zANqsZJSTbjH4B4uu0Bow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0PqtpI8rYaSaprUdZnFAYCFe//gYjyD2VcEwWCCggoPvXPdMmeZ5FhnbRDbiEPgD2JO1eAw2ZmMOrBs/aiju9Y/6ZmVgiZBU5D1LFfeZTkudTqhjxXkzHFbss60mPfgnLE82NDfeXswEmzCMuYsL4YHLTotwkmJ4C3f1AP+z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RNVQBmBZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNVQBmBZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CFJUxpvPlwOMp8n0DOd2ctpg3rwMBTHCSZGNAQKUeiQ=; b=RNVQBmBZGbxbkCUwoz+zkXUBZa
	BbWj3hLZO0Y5dlTUCdmG7B+pIbEmvL67VyDY0HA1zSotfOx3GTbrVPQRtQ3Z7HP3Q76Btk7I/UyKZ
	CFdLGZratNGxDyZffjdyq55//JzsIk/37FfXjC+vo11RukOZxJ4ulXLQnS6MpIV9Ow03+jpXvn89Q
	/LjZn0bw4usmt26PLpEV8aOriP+9qt0pJFAw3v7GXMl1YTuB05ERai9teG17b+UUVI67/yHe/pMYj
	D9x4LUXjNIL8aFVx9O4rTzav7wRoJ2dT7x0l2FlnBzs5SHRGATtb069jKtUFM/mRj9pgJXN632P6o
	d56TVi4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzwmS-00000008H5C-1wCW;
	Fri, 28 Aug 2026 13:38:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38D0C30030F; Fri, 28 Aug 2026 15:38:03 +0200 (CEST)
Date: Fri, 28 Aug 2026 15:38:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	we =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [RFC/PATCH] clk: add lockdep_ignore_clk_prepare_lock cmdline
 option
Message-ID: <20260828133803.GT776954@noisy.programming.kicks-ass.net>
References: <CGME20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d@eucas1p2.samsung.com>
 <20260828131409.962825-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828131409.962825-1-m.szyprowski@samsung.com>

On Fri, Aug 28, 2026 at 03:14:07PM +0200, Marek Szyprowski wrote:
> The clock framework uses a single global re-entrant mutex, prepare_lock,

There is no such primitive in the kernel -- this means the clock people
rolled their own. Why ?!

> to serialize all operations on the whole clock tree. It is taken by
> nearly every clk API call and it is held while calling into the clock
> providers, which in turn often take their own locks or trigger runtime
> PM. As a result prepare_lock sits in the middle of a large number of
> lock chains and lockdep frequently reports possible circular locking
> dependencies involving it.
> 
> Such reports are often not real deadlocks, but once the first one is hit
> lockdep turns itself off and all subsequent locking problems - including
> the ones actually being investigated - are no longer reported.
> 
> Add a "lockdep_ignore_clk_prepare_lock" kernel command line parameter,
> which marks the prepare_lock class as novalidate, so lockdep skips the
> dependency tracking for it and keeps validating the rest of the system.
> 
> The option is only available when CONFIG_LOCKDEP is enabled and is meant
> purely as a debugging aid.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> The problems with clock framework's prepare_lock are well known and
> there are machines that always report lockdep issues related to it. A
> good example are Khadas VIM3/VIM3l boards, on which prepare_lock
> interferes with locks used in PWM subsytem:
> 
> https://lore.kernel.org/all/adqtn6iljcguv3m3ovhltusbbf4mljzlwg73yklaudvjjtazxv@vyf5fvuzic6x/
> 
> This new cmdline option allows to hide prepare_lock related issues on
> the test machines possibly enabling lockdep to catch other issues.

This is horrible. Why not fix the clock framework?
