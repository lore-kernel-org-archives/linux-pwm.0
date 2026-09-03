Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8964F7995
	for <linux-pwm@vger.kernel.org>; Thu,  3 Sep 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456020; cv=none; b=SU4+pUluSgZmAuaHZi3ECZx5HfHUp7CT1K8LY6rKlyzrFSZWdewVq90yrZyQrVoX7A5djRetPdreWKK8AcvYQqI3fBa4jhymRxdKO3ks6uzbCT8XBtoiRZOWkasKkJLpHfbw/1VASp9IRTURMxOP1JmNQyOB3f9RTPG2Unztxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456020; c=relaxed/simple;
	bh=XckZyXRA0wdQ2t/rQ8UQFXAwi1VWzGG6EOxNNhqHRbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTEtW88Wfvjh1WMqnMOoGroMt11E2CKWHicFlAS/y3J6y4MaF4AZR5utLWq7gu4Sth/GyIH5vdhruIpava5WZG2gfB1y0WvL0dat4Pawkshegw26RR9jr/P1Pdaa8ZgSQ/c5lETfU76qAgV5L23fpzlJa+x/lvwNtIA8m3exrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdOT+MsS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnJZmp4w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdOT+MsS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnJZmp4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788456018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9SlpKBC41ZAAv9XrMQhlqWr3QRc3I1Zse/kq3Web2k=;
	b=SdOT+MsSQQMy5FjbfxtxofD5kUdPJvOWjgEjfmtZ1SpVAkChN356cAO9y5RyPBJm2ezW6q
	mY2k16RzgcCl24eFX51yQ72pTDg7sdNY3U5O/q5Ob49gCXGug88rlXQEX88CQ5ocSR+AQi
	ei8Cl0aVUbMSqiyUHDwp3PZzbQkZ59Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-WarEe2xFOyudsMiIusfrvg-1; Thu, 03 Sep 2026 13:20:14 -0400
X-MC-Unique: WarEe2xFOyudsMiIusfrvg-1
X-Mimecast-MFC-AGG-ID: WarEe2xFOyudsMiIusfrvg_1788456014
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52f9e903b02so16529311cf.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2026 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788456014; x=1789060814; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U9SlpKBC41ZAAv9XrMQhlqWr3QRc3I1Zse/kq3Web2k=;
        b=fnJZmp4wkDw1bZ6SG+5eSW+WBpsCBlKmL6KlcAIc+QVPCHxsnrATYEZLBTKcOP3SyQ
         4QCZTUrAJsz9gEgNbFEFSubbdv9nxDfICWY+QzC14zwDoWkck4kEUvxcgrTt0Roi9Pgy
         IXwxiRixSZ+BCYEEG2mYo6Q94iDdEdLoxJZZsnyrNfyb6NKeTm7fQeb3k9Y+0DAFyh9k
         XQmSGoC/prKzj+7+hLhG3HjKt5s80sT1ekoV8zEfM9RNTDwAMfWGe7oYMcAZZ8wcu9Xn
         aNbBGRKxOdZFAup0ZjZBhqDxDRpcdaXuXd4Ddn+ikpuxVE8nLO5F5tY3k3Y8zwsNpqDQ
         n0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788456014; x=1789060814;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9SlpKBC41ZAAv9XrMQhlqWr3QRc3I1Zse/kq3Web2k=;
        b=edD22VLLwJTmwuymRdCd1zUmNRmyzJtkzu4hXeO8yke9Hixe47fbt34udqjZYiljzN
         i4ATAGDrceZ+wCp6dl1ijv1nOe1FtShdfrJAx0koiD4xvfsJ/YUflK5BkMkcy4TWjWBv
         8+dkyMx35kSeyYH0TsfCFMShxCBNw2ooIjG16pWKZeH9IuO11kmxLkkrowzpRhvmSI1Y
         dPAqwWyVYMwkDkxPpeob01/Y4ZUa3gOWRBgcpjDSAzXivgZt1Au9lnXnYjz/KIX8IIFz
         sRGqX7uF2n6Ku7riQ3EE7FJYRZWHwO9q1AXL/o6yE4Q4WrFl/Ax4wWyDl7keDa6ss5Ib
         KMPQ==
X-Forwarded-Encrypted: i=1; AKwUvByQKhvOJCMj6jWQoeytujGUcGUrtyzaIhQSs3ZRa8JYT81/l6F+vw4pxA4gdVpnhzb8k5cdiGocSpo=@vger.kernel.org
X-Gm-Message-State: AFuF++mqL2Xm5nMWNW8R2LzJXiIAuUtxyTpE1QLbRIfZiniqJiMNcRQC
	N1gJaVwEK+7mnQxaILZOUJQlbXCnLO+yXZNsGp2gHTQ7Jx5dXHsouNHhWkXUmFsmwztmZrzM7Z0
	u3GNbUymnm7gc45fnw80lVrwALmH+vbmSrvMJ5F3rYh1uUSsnTumYV0yTdXBglA==
X-Gm-Gg: AYBFou21MEgWz3vT6fiddMYt5Zt/Os3IId2++n0SIioPXUNFWEXkGWJPnhwOlAM8D8o
	8tT7IRh9Wo6XQnvhOKEJRXw453iCoEDBj5NEV5CoDLL0ITLigqPeTLVMnwppuIHeNTwwnTj8u8f
	mTduQdT/QFYMk/MK6g97FsbGiOH/nVXBEbFF7yXIA2SBbHUrh6S10qnqdUar1Ti+tI2QB6OJDng
	aOxVN2NW7VrfnQ5z6Tk/q/J9S+ov/UAmC2QeszbvNPIGCtHOMHC1Q5qN/vMeLHScgqH4isX3w45
	DiBXiBQG6MCyPeoqgPqrq5erE1Su5EZTgl4aEznvy/BG0kMPl4dP7RBiGB/shi56DOv4OL9fsyT
	vLNrMvSCynQFyGwXssHgf41pO+l8H2sXvG0E=
X-Received: by 2002:a05:622a:3d3:b0:516:82e2:7788 with SMTP id d75a77b69052e-53042f6ed28mr70698571cf.1.1788456013924;
        Thu, 03 Sep 2026 10:20:13 -0700 (PDT)
X-Received: by 2002:a05:622a:3d3:b0:516:82e2:7788 with SMTP id d75a77b69052e-53042f6ed28mr70697611cf.1.1788456013149;
        Thu, 03 Sep 2026 10:20:13 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541eab6csm1956071cf.26.2026.09.03.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:20:11 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:20:10 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	we =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [RFC/PATCH] clk: add lockdep_ignore_clk_prepare_lock cmdline
 option
Message-ID: <apmsSsXdc32Z09_f@redhat.com>
References: <CGME20260828131428eucas1p2cc2d9767d5ed62b8297c2cff0295226d@eucas1p2.samsung.com>
 <20260828131409.962825-1-m.szyprowski@samsung.com>
 <20260828133803.GT776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828133803.GT776954@noisy.programming.kicks-ass.net>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Peter,

On Fri, Aug 28, 2026 at 03:38:03PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 28, 2026 at 03:14:07PM +0200, Marek Szyprowski wrote:
> > The clock framework uses a single global re-entrant mutex, prepare_lock,
> 
> There is no such primitive in the kernel -- this means the clock people
> rolled their own. Why ?!
> 
> > to serialize all operations on the whole clock tree. It is taken by
> > nearly every clk API call and it is held while calling into the clock
> > providers, which in turn often take their own locks or trigger runtime
> > PM. As a result prepare_lock sits in the middle of a large number of
> > lock chains and lockdep frequently reports possible circular locking
> > dependencies involving it.
> > 
> > Such reports are often not real deadlocks, but once the first one is hit
> > lockdep turns itself off and all subsequent locking problems - including
> > the ones actually being investigated - are no longer reported.
> > 
> > Add a "lockdep_ignore_clk_prepare_lock" kernel command line parameter,
> > which marks the prepare_lock class as novalidate, so lockdep skips the
> > dependency tracking for it and keeps validating the rest of the system.
> > 
> > The option is only available when CONFIG_LOCKDEP is enabled and is meant
> > purely as a debugging aid.
> > 
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > The problems with clock framework's prepare_lock are well known and
> > there are machines that always report lockdep issues related to it. A
> > good example are Khadas VIM3/VIM3l boards, on which prepare_lock
> > interferes with locks used in PWM subsytem:
> > 
> > https://lore.kernel.org/all/adqtn6iljcguv3m3ovhltusbbf4mljzlwg73yklaudvjjtazxv@vyf5fvuzic6x/
> > 
> > This new cmdline option allows to hide prepare_lock related issues on
> > the test machines possibly enabling lockdep to catch other issues.
> 
> This is horrible. Why not fix the clock framework?

I'm one of the two new co-maintainers for the clk subsystem. Do you have
a suggestion for how you would change this locking in the core clk
framework? Long term I'd like to see more fine grained locking since I
see at boot up on my Thinkpad x13s laptop that it takes ~10ms in some
cases to acquire the prepare lock.

Brian

