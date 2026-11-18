Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795035171;
	b=vpWPUU2N4FCI1wpSQFq4SLsFMT7wjPecSniv9d9sdg8ZJ3Bqbw/7+JHmaqokA4FXC3LL
	 gbtFuLOSJsv79WFWtEL27yiZ72mDSsAEJxoxwSmxIfuXqS2zseTlMGAWPaQiexKF1HXSL
	 aAGOQe8Dy9LcpHzDRdHNu/hnbxIJ0aGbYzFAN9em4ishfy2li1cLmxQfk5qDA1GsUss62
	 ZdGk9mbWwOonR1hDOFwpEP5+tPxJUIBvL99iTCvVgvGOQ0FgRkDOdwFMuzK7eSzODc4Eh
	 D2YUM+cW32RjCm5duXsbHaJMLyG8G1jZsNpzZk+TqgtNtxOLDinf1Ednv6PVFCPuDCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HD4w72rYSGuIKlDg9sIRSnAtItURqe6N66uwHCQ1Zhc=;
	b=bY3TraZShM3iW6FC93NWMfWCVNe/iA7+Z4/fT+g9Ihivvh6FiniDmkAHPGXtG/5W64rD
	 JMm07LHyp82YIGaJra1OCPFqTuDdB+BvVCqz6sKQUzi+xvMrUkxIlPrCkfiFTuHtn55Pm
	 iYUBHKtm4DH2Umkg/lhe4ahZf8JOLMSqJUMrd2vGls2p7dkhaW7mtelUMrXN6YCksanM+
	 xsY6IBRafTTdPoJ34O90B6Q9rXPGFI+Jwu0RgC5C7iSce7sHdGv1e1tAp/thQHiUePzN1
	 YlXBzmOTHQJ6+QNBBmXUuxA26JFv2GVWRY4c9SbBkZvGmSouqdg7aWKbjVL6Sc2QaxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="H2l/Eacw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A6606A337
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 279A6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H2l/Eacw
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49465892f7bso1159792f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 12:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795035169; cv=none;
        d=google.com; s=arc-20260327;
        b=CJ0Czx5NB2z4LzGd3WhvHJBuZ1ArgW/CW4la9g50YnAWyI8MA/Bmg4V+Ql9Ly2NajC
         pAvpJByGxlk2Frv5ydydaM7LYAAAdWela1ELQ00Nh1ZUWF1DQuUrubbHm8/yfUi1HwUx
         ssEDX1b6HRfjIsrem0Jhe8m7cJj2nWY4L3+qkKUYtsQxE/nr9V57HXobraLc4NBEQfZ7
         NTkzTPaHPn/DL/38W/TbRspF2JXCnxCXkqXnbvgS/w5EYTEh9t1D8PXL4EY6OeDa7ppm
         9T5kiTFML3sAEfj7cP4qxbt3QI6uH6sm+6a0WmS67saP5GP21mn7l8chMQMuYhzoA1Zk
         O1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HD4w72rYSGuIKlDg9sIRSnAtItURqe6N66uwHCQ1Zhc=;
        fh=mt+QlEf+Ltoxo0KrUcf2k/FCiTHyYjyBIbgc9leOlhs=;
        b=jBDLx2nu0lKxa9daRO2l7gUMLQxsSzLv+zVBzR3LvWkh371DGwDgJB9gK8f6L19vdo
         u2H0rle1RQQCqxfevBCpBwyxrGt0QHYb9ftDJJmPCMsVCI6Kkz1ZWDCSx6LVk3v1ZbD+
         IVzNWeTXIZLQJfWkMCmptdewPQ0EhDoJAeGHm0cpo/4TOr1qMymb6/Kn87IjQlSRJ192
         17foG0ov6ZqqiHUla7IniRmP2YEzoPiqIe0cN4PVrNeakzp6wlnnmZ0LbjHp3s13Qm8l
         HpU76SYCDo3t/IWDBDHsa8khnKiVeSaLy5ttUlZArTwS3rzKGsHYsNfpnz3kAzbLsJas
         cdtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795035169; x=1795639969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HD4w72rYSGuIKlDg9sIRSnAtItURqe6N66uwHCQ1Zhc=;
        b=H2l/Eacw6fDSJuRyagGbw4/RuWlMy5OepKWyxtVy2uJpy8juzf65wc3aYFnP9JMiEk
         /W7WDWIbJjzMMvaCdhsBmchp/SU8HNWaKJfbunQFgD7cUhH+RpjgIrGjj6Rk4C1G7xhk
         g65b/J6H+q3oEx+iq4+waukNpAXoBOXaRwlprIuBHdPtn4JlL+rg6EjtEVqjX6JhvAXN
         HrqkKJrtsSjzbNt1/wrNKyyrtGB3gs2csnnC09AbPa2QG4bB7U8GA8Pg2xbOydnpHoqy
         Q10bZuug4ffhFuMpehkbGHRw5r3IAz9oFrsz9+AtL4MZ59qukZ5GvBvtKwxKkhektZ1e
         Na8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035169; x=1795639969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HD4w72rYSGuIKlDg9sIRSnAtItURqe6N66uwHCQ1Zhc=;
        b=Ov57X/6gBph/ojfItgYNM9HkfQr1wbjSRuDd3WiAAQKEqWZJzeo8zo1CRi/HXpEO5t
         0sQMC8xDhj1NMYgpNw3LF9UPqQ7gCLP8koHEnsT1+VZGRKdUXn2KOL+oq+RcNF53m4E+
         rJBc4phX3sOgy8yZFv/uIS+dfdgQyNCi0H26SiH+q0NcITPuF3bp3S8VvPnyN0d6T1rH
         pqIX/v6X9JiLCFJZG9J7Gq62dvuHEFd4npHvb3pHX0oQV5wvqXLVUcKS/swMlxjEG9Wh
         OoErYfRbGWwf2kHoIlksWlHFiVsCXbDRR+8GHZWZpemR5XkvLsnFoMSfynLM3pTmDS0Z
         DRXQ==
X-Forwarded-Encrypted: i=1; AL+hErELAnFXp2BaWVEfSyOeK1ALIXuGHPvW1KiQqD3W7EgVZ4kbvJzpHXY78oEFPkkhKqpvIcNd3hSU4Es=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C+jhUgiogcWPqW0yvA9w0ZWPqGdnXG83Y243QM/qxFbZ8TCti
	8XrUiBNMSkgFTjBL6K8utPOj1cX1X0bfh1bNUDk0FQDYV7hLlD/pZ+k2JA3Ol/f56bEGF0JQs8l
	UnyPuyt/nnFnwU+OJI1p5I17fAsbo/ZuSInsfodIY
X-Gm-Gg: AZFdTZfpQUl0kassBBikN+Ie66lZeAVhDLbEt/SfV+nLNayWNGoAAfV4jgCNL3zNyyZ
	6cwJM7XJgxK8yk/Kh8299X3vp/fzJH2KdeR7QA5GxdaikHcOowRWXJLX5gPi7mUod93ci4AOEdn
	rICsVe+cffzzI3wV13tiFx6pi0w0aDESBz5e73KieHfjtd3mGYN5i/5FdK2/PDpp841hz6RAV09
	EhnF7Ea94fPIYnbAgyPfgF4JU9/5ouZuQK54WIUbDRv+fGcP/T1Z6LCKKAWd/JfMVpnII3dW+8U
	Q4SRHLf7i6VpG819cU4IpiHHDS751A3EMh3hUycNjoDcVfDJM2oP+KLXv1I/xAMhososs28RazD
	Hgeik3G4gVZ6Pm4L9oe/r1UadfMKAB04Mz5XD0L7aLoXQq5KmOcYWXFTPlzPc2rul7Lwt+EXcBY
	0wl0SzY+XVGEFE
X-Received: by 2002:adf:e00d:0:10b0:491:d224:aa78 with SMTP id
 ffacd0b85a97d-4a63ab754cbmr5872872f8f.26.1795035169077; Wed, 18 Nov 2026
 12:52:49 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030020209.3833766-1-tomo@flapping.org> <20261030020209.3833766-2-tomo@flapping.org>
In-Reply-To: <20261030020209.3833766-2-tomo@flapping.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Nov 2026 21:52:36 +0100
X-Gm-Features: Aa3M54rngdCtBdUPlOnJq0DxmarMXtgp0TWIs8Xtsb-fHR_p2_LUOAVjCPSU0as
Message-ID: <CAH5fLghd2at_rzqi6YU2MWFHK-r7S0VfpxrJ-dFsu0P7=2egCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: math: add div64_u64() and div64_u64_round_up()
To: FUJITA Tomonori <tomo@flapping.org>
Cc: fustini@kernel.org, guoren@kernel.org, ojeda@kernel.org, 
	ukleinek@kernel.org, wefu@redhat.com, a.hindborg@kernel.org, 
	acourbot@nvidia.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	chenhan0017.work@gmail.com, dakr@kernel.org, daniel.almeida@collabora.com, 
	gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org, 
	m.wilczynski@samsung.com, tamird@kernel.org, tmgross@umich.edu, 
	work@onurozkan.dev, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM FUJITA Tomonori <tomo@flapping.org>=
 wrote:
> +#[inline]
> +pub fn div64_u64(dividend: u64, divisor: u64) -> u64 {

You're missing #[track_caller] on both functions.

> +    if divisor =3D=3D 0 {
> +        panic!("attempt to divide by zero");
> +    }

I suspect the panic built-in to the / operator may be more efficient,
so please move this panic inside #[cfg(not(CONFIG_64BIT))].

Alice
