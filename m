Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB037F8DC
	for <linux-pwm@vger.kernel.org>; Thu,  7 May 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158261; cv=none; b=scaTH4NvYzd1rMGyx+5untlXD9BWlBS4vMR09wsC/nLMSLB9dslf5kpSc2bNHX6QuDeIl8fBjf/pxEhdwtCkwwTRaN+mmrOz9XlSfUdGLI4GHO01i9ma/FDMy543gHHH/7aprOksYsqbNJGNfqAXybJkkrLudVxg9kgtXtqP6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158261; c=relaxed/simple;
	bh=h3Vlkbk5sdnGg13yM94cBpckZTupKbTqjZZ6gANaolw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbRgMirf8lVcT8FHRUcX1IVH/DIzLjt1hsBVCvT6sZVXi4WyUXlCWcGd5c3vqQHAys+R3geH7GdrmC9D9kSAc5HlcNp3nQiEmwnDSkUWoBDqIpinsC3SxXPWvrvV7NETHbXIsVVIgoq7kAmKIKRvuV4lJuYYnxCRbS7R/CT0gxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRhZ5EgY; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRhZ5EgY"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso5891285e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 07 May 2026 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778158256; x=1778763056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8srcPUz2iRMxUgzpDjJPZ915RsxNlRqzvXbEly4DTQ=;
        b=NRhZ5EgYtpSzRPVKw3l4G+F0UKuwmoEJ5Cqd01cStGdfNg3xeNHV/Dt5UTswLPUXpK
         zkYls8UXWRP2uerd6G/MUIy6SvkquIO8r+Uakn1NTHvPDTj4/jQrhauhauWffyahmveA
         RC+5V9qIfE71z8J88pcokSzUHd71kmfH9umxOV4wv+8asM7gIUJ38foCb/E8yc6sv3Ol
         Yy4+IR8a7y3Uku9o10iwSRKy4FcAI57m4BZg3Jq7jWvjw0RSuAmP5ko8+6X1x1qOYO93
         L1hirrbNxq2cisiIPqONHljKPXjb1uL0y9CLakiJA6R/0SuS5gq3Ss+h2nJJ74C5A48D
         1cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158256; x=1778763056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8srcPUz2iRMxUgzpDjJPZ915RsxNlRqzvXbEly4DTQ=;
        b=r46eXmb6qYx5IbC4vmYPp48FXYxy2xKQLsUKaWMAKDslQKkssAOx8BThaAC7X/QamA
         nV1h8fDVgrOR/WWKgsgRP60+oVCNEFy71KMzB5mR1OJqXrwcYBkhBVofOhJiU6De3kaG
         f3MJBIZ2cHW/6TDZbj6u+/RopXfy9NXhgwWU2pwFSWEANB+dLObRYryIjpOV8TRj0O9S
         00btqQ0OW9cLO62N5OD0IJbniVAO2a8sKuTCGdlVRiDcgxELBPHYZ5aOJhYcwrUw3WUs
         LwzfW7IBZW1DiMzMZGi7UycyElTyIL5z8S+bU9mjzu07gba1XWvYjCO+cPvT0Rau6RAJ
         wQKA==
X-Forwarded-Encrypted: i=1; AFNElJ+uMQzZHFmiwsSTUAJSvAjRQLTBsvLZ7Egoi0giTmZg13p/T8FFMbYNZrgqcxu9JeICMf75RE3DpkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpVpOgPR18IikT3cRiHwS/TC0mWDUItSs6fiL6jfBKhD8j9Rg
	ermSIBZ/+7If0EggZfuteIp+tff/eG92jVqmiZfVYvkReZWF1yJkYiTNotLSipWZvKEh6FeNMCP
	EtqR/k0/DiZxUgDI1KQ==
X-Received: from wrpu17.prod.google.com ([2002:adf:f891:0:b0:43d:70b2:d297])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48e51e19668mr127556795e9.8.1778158255465;
 Thu, 07 May 2026 05:50:55 -0700 (PDT)
Date: Thu, 7 May 2026 12:50:51 +0000
In-Reply-To: <20260506215113.851360-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506215113.851360-1-dakr@kernel.org> <20260506215113.851360-4-dakr@kernel.org>
Message-ID: <afyKqwxDxu3cT7U9@google.com>
Subject: Re: [PATCH v2 03/25] rust: device: generalize drvdata methods over ForLt
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, May 06, 2026 at 11:50:39PM +0200, Danilo Krummrich wrote:
> -    /// The type of the driver's device private data.
> -    type DriverData;
> +    /// The [`ForLt`](trait@ForLt) encoding of the driver's device private data type.
> +    type DriverData: ForLt;

Associated types support ForLt natively.

    type DriverData<'bound>;

Alice
