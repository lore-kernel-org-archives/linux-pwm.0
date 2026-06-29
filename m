Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A637C906
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2026 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782707975; cv=none; b=JSFex+R9ZDRkMkwQA+7f45ES2Ee8MhDSob5n7Bl/a/cjeesURQEnN2nBUmRpnyyPBh5ku9lZf8pA/wRwzaOvzOur1gWQ+B4ADEtkmdjk3JVIc//XNeyrN4QYFeeGb2n4xkq7VLw9hmuBdrwkRa6sydEHNcpFkRUPp8uNAx6GzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782707975; c=relaxed/simple;
	bh=1eU+2bDqdzNluinyylphYvQVh/IYBb3LxR6xoSyK7UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk7Gt215LEoJMK4CjWdLUx4DcDMLEz9bhmc9Sm/IISYcUDu5yjkBa3OeT50gD8AkCF8CFGwhROo2Ad19OrdytvNAgeLOqATPCRo/48334GNgJ7Sy9N0KCL6aG8ZFSuIAfjHHVKGNJTnbao0u+pbkSj4vFF7R8RwqEZibfpHlMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hn+E1MsJ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hn+E1MsJ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30e18c3e0b8so1381663eec.0
        for <linux-pwm@vger.kernel.org>; Sun, 28 Jun 2026 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782707973; x=1783312773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
        b=hn+E1MsJrcDHw4L7JMBDRGaEVWJGa0ETOsmQqVkAezoHqRNCzAOGRuGGIvFIzzgKAj
         5WbmJiHasrXBsw2nHoHF1trp0cS9knpAh085FbvxF1XlG/DPaHrEmcR5qOONpWipekTI
         b2pmR3DACgvrHz+t5K24F1Klul23PedHMKZDFVxRkjraR01Q2lZwnkB4VEOAS38x302C
         RZiSAD2L8UPyAhNhq9GeEbgcAxM6bpc8M18GprrNeMR9TQXwcNyYWNbEZe2Iplh0nXwf
         JkyvAD/bQHrPjowwEaqS8/fiHVxRV9+9F+3y+wWGAbHlMLR/ZbracNqgYEj3tkzGnPPZ
         Cm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782707973; x=1783312773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
        b=E6X4+jZeWYgfPXPCc8K5fUQwLUDkF2AQJeCgTBT+mmCy87sl1b+IBjhqJjqxV7JzxV
         1lwDxjMTDj9Q9uHNtVpC9IDpzVEMR+4ms5PHbtUuKcJGjSQakey/oscEI3xtBoA6I6Iw
         XO03pekhsRvVBmVPSq5BMOFcjmAYoq+0GrJsJJ8+CG9M1prmagLZV05W6ZEl8AdDjuCR
         riiCgqWDwJVKLQLatLvua/pc4RAhA93e/rJjl8gKMXxhKode3vh2KqTSTYKOEkM1UcNE
         H06IqbuvngGUZviswuiz1ilKA8oDMMf8NMfhMOvkLnwDy75VZVVeIIXHSIE6QawLdgxe
         xyXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYTP4qXmDW/54jxmIaejJoiGcwQMCZBYLov5pAtT7iL9WW2cTpe5jdDu2vgDBPIezrWqlUI2bJC4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn98MTEhUfCA32DpT6Cq4oCKhbSOhagATsCCTTVFrnQlXA5uai
	0vS1W+h15T75CLokKeGxlm/GzMIJpmbBMwCMuW1lZWBMxyGHOkJAzetANy9Zqy7iRW8=
X-Gm-Gg: AfdE7cllV+SpaQhLkAmI6jugNpIxoJV9XWuAHkxgg49xFBf2jXkgnJzRDmrkgCv38f2
	q2+V+LzRJhil0LyBqqA4i9B8w1HVT55YdBSnswJ38yI/SR1333SLaVRgQQEYlsePsItZm4Bk9UI
	KLJ1jsoYU3wCS+ann5z3cfENOinl+ZY3k8J1BBeePogPoUiyhYoNUiZYtcJivKAN8QDoVF5UInm
	0R5YAZ9+98iGZhLmoP1Q1J2be8X0tYJJFcoy8tMkB+ioujZg6g9mTPb14m+UkLcxJwk4g9Ua1Q7
	zKaWrFXWlZM+kl4daulNZemkOm34BSUOtVMZe5/ysMTAAT5DYDzevep4Hqb8M78PvtVK/CX4vOR
	MwiFLKYu+kCgWqxj63m2eLJ8dQalRRHKeNIqE2Is+ijbxqR1s95mPzjvUZubG9kjT2PfpC+HUvj
	JLWk/sU0RCyofY
X-Received: by 2002:a05:7300:5341:b0:307:d4e7:b177 with SMTP id 5a478bee46e88-30c84f3cb8emr16773092eec.16.1782707972936;
        Sun, 28 Jun 2026 21:39:32 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30cac1b9751sm23319860eec.3.2026.06.28.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:39:31 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:09:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Trevor Chan <trev@trevrosa.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	ojeda@kernel.org, a.hindborg@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	m.wilczynski@samsung.com, boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk, 
	daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, 
	lossin@kernel.org, acourbot@nvidia.com, markus.probst@posteo.de, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, ljs@kernel.org, 
	liam@infradead.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	ptikhomirov@virtuozzo.com
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Message-ID: <xak7wil2w2wdnmkfh4e4ijhlgnudzuh5y3ltlo72454e52tocv@434kdjz2eupv>
References: <20260628100731.64885-1-trev@trevrosa.dev>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>

On 28-06-26, 18:07, Trevor Chan wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 62e44676125d..84802f22b652 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -1043,9 +1043,9 @@ unsafe impl Sync for OPP {}
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
>  unsafe impl AlwaysRefCounted for OPP {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> -        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> +        unsafe { bindings::dev_pm_opp_get(obj.0.get()) };
>      }
>  
>      #[inline]

For OPP:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
