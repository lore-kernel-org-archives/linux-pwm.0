Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795210300;
	b=oHw9GU8wflabslX4Y6MXDrl6hlPoOuweXL16jMwSgn8gOJZmKavaabT+f3/t6zVk3mXk
	 mID25Y/c+xzJ9ySuAuTxWf7wj0hHtbIrUF5CVHogt3ERKlXOO5Szc8mHRrqwQxNHGvII+
	 GH8zdM5n8PKGOJ3ZriPmF6xndo/k+4hUVMbcu7fmzHvOSjqWf/q6Wx3F2oT33VMnpcDRB
	 cvIGUEzzusWBbvXxPFFSsiP99i0N1h1hTOD2FqjJZeGm+3tca1B5ddv6DjT12qwkwhTrD
	 eBQm4K5vCCVZYrwgJ+n68tosYlcVxiTeDBUIaeAws58nrSP01AQPyF41FLOxgG0ap2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
	b=zSmkXlqvLlX55r/jddSBcFuJyJiFfMZ9W+ImRjBuvsjRTvrAqcWodFezyOgiiM2s4+ih
	 Uf5ZWhu3DiaG25gMQX/v84JbECVfw44uT+YOqdX9diJ8dsWBBISiF8CnLzIZtw66FyzHA
	 Mi2ZfVsoGaVXi681eHURexw4uItXzzCoZml4C6+JzHnE6Op/MlrQ2qTL5aalhvWGqH5Nv
	 DlyNJcKJ8JK1a0oezIxMULAZgbkUZ86rjxI478Yi4mIkQx7bYBMIp2UOWr2S8j0mMQehQ
	 dBs6NEPb5gLHc3oo5VBJY5DhdX8jSaNEYP5v2JQtCBPHo4Pt6MSyCB2glS2yLXLqdSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owhm7wLl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052B606A6BF
	for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 21:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C052B606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owhm7wLl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adfe7a31dfso1047841fa.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 13:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795210297; cv=none;
        d=google.com; s=arc-20260327;
        b=OvTw5awe81u9/RnL2mFqVOAI7JUxZteUqX39V22t5OnA0VcBY2vhOTfUX+mdii6nhK
         B+0oCb5tJGRGWnFNl61uwWphggcj2G15eDFWkg976oVzM3EDB6aqnQB1S2YJCtYpRTQL
         GbRBynBA4UTwjdZXEcf9avouGlEVdtIRfplFDACvxWMl1MzUsbC96NOWpjPW1tCHsAoi
         /W4WkVATiCQ7tlU9Ur28F0DwL9qPEtmk6FemY4ojyPCkGGwFIZfmi1tNDnhZxmB4OILx
         Y6CHjbVdfaK4nJxQFjXJ/NtJrTg06CooJFq3JRKWQ9E0DttUZ2itHsZDdsE7tb0w24qG
         NiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
        fh=xw62P8Ekt22vWNoJVXdUk80DWbiYsq4x4TP2VF5Iw6A=;
        b=agQykksK/yZbQuBfO7RxWZAZSiJrMn2L0cxm7O69zP6Y4KZchSijkF3RrTMaU9S03L
         3A0kPTut+/96kEiYjw8Umg/7rHXs1NAdsj68F3ci4hXtOuN2FA2j28od1A2TcuH4TUmv
         NDtCz2ri726vGp+vtkSWWmN5pM78KEoN9C58JGOiA5qspkMNmbSOkvcScFW+nO54rTPV
         GEZqcZw4wnIruqGuJvShD45oyejo7KkO3eqaw0NBvPWstg8aS2TsdYsQEQaDjEwY2i56
         pqVkBlWFmjfp3CUeHDZQCUQ47XFL6FTo2Gz74+v90pSuNTyytChkEAyq+FGAqzZzzfq5
         amaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210297; x=1795815097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
        b=owhm7wLllg3l9s3Ng9CV1HrjwLj04k4mew4+Il/Z8w5k0GXizWUecYujWL4XpHDtMa
         eS9MRCtEBZwwC8OdUWFwKPDTIlDgdFLHLZUfue/yq/USkW8/TiW1ko9/CoxPtSxP1A9D
         D8MSFcWmlq6iHfxe/N4v0YRGxj23N85NQtLSVROCDnIzR4Uv318mpVWcVMo7jrrlABYt
         YjadBn6OUuNuIFRnWiaLZ5X/eKMo7W3sxO+bCCWoKuFkljemHmv/yxy6hv/IR4N1kz5O
         L3UPxcjApzNrfzj6wR8qTA9djgxz/M4AodemmINAcWB3TwhsliP53LE71qSquskMkxGi
         21ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210297; x=1795815097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
        b=1AQHPRq/aGX9cx1vK8zlf0iPuKNV5hofx06Kwgl0z1961orCfwGUE3dn3hQdVPITcY
         6MM8U9OfHfiUfaNc0czjIyLVoDEF//J8rSdt0mYZ2zMp34CM7cDS6G7a+TGqHJLz2W0L
         f1YOH0LtCs05F3Zoq7FJyj7DykJgUzRNzwg5aWkTjiFKZyXwzUbi7CWAr63lkkcRq+b0
         IjQi1IkbFcumxHGRuwv0zcbo8/pEh4YcMcX1adwIGJ6q7ZJgOCGWk1dc9jNKJ2FtNGdW
         gOYwEY+ymk77c3Vb4CKV0YTg9eL8FVDYA4x9QXcmRypwyomPXEoPY5Pd7cs8sB5IUYH2
         DRjg==
X-Forwarded-Encrypted: i=1; AL+hErEfwT904c7VNYhH930wwkrdTxCUY6ITRp37xXmWGoZvyXfGgEhmjXINd6JNTCvwLjvp8R/WFojGQyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kMKghSBd9/iqRnbtuBmFcKYpcZiLwgHMvw0VbRhnQ1h7JKGLF
	aoroBijOQI5ZiWY9+y98A7dRlC3/7wX1pjDDlBwVsX7F1kdf+krCKTCQoLkjGlVsVkhwrxMnaid
	/80FWWT4mTsjlY0knejvvYQ4DLgSpV4Q=
X-Gm-Gg: AZFdTZdcp0qc5sMqlGuv0uSRVsxcJPL6HRBZQ4bFDYkXQiLHrnmBoAU3qrkkTkd2u97
	uYS676aRTNSo8Q/qCTKMy/ELLEvVdjmEFptgnwoTKUzbl3F3d9/nhpG+6e60tYAcYDX6MbrODWP
	i460l5uFEBW+OhOLot7XkVqLzpTImFWWQM/eDeRAUe4ZzBOxPJ5AAn1lmuKQQl0NpsUELN1Hgjy
	+3Lsf/G0ajoebSdprAdge5ozWGXi9bo4Yoc6LQSFwT5nEDvmAS0R5U4Ux4oHB5BDP639HpXcQ6e
	NKuS9zoaywmNdqu3pKYLsNRGr/Ly/9Be3cIT/WwAQzNCR9gzweKxtaSTPqO4MCmi64UPAV+bE2d
	Xyv1IlY5niR2H711ZOKiSomlVWkag9+LQgVaYulpDLq//GNz1SFFGXzoM9I0Wx2wD6rdgu01XfR
	lwJTFMqy57jf9HLRrNa01BYxKZa08dO9QDAaWQwlBKYIC9D9ZurVow48S/YdOSWNTPd9rvcaaUq
	MTC/tRFlgyRh/88BvdrVecWSCBp8gu0IGdsRxd+JCPpSddm/YOHf3Ae0vy9SVR8V4RgVqG7
X-Received: by 2002:a05:6512:1320:b0:5bf:cf6d:ef1 with SMTP id
 2adb3069b0e04-5c1bc5767fdmr1687437e87.0.1795210296624; Fri, 20 Nov 2026
 13:31:36 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com> <179519331840.3795820.8047048832159165355.b4-reply@b4>
In-Reply-To: <179519331840.3795820.8047048832159165355.b4-reply@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 22:31:25 +0100
X-Gm-Features: Aa3M54o4i_zALBjbkgtOxZes0dCWZ4jiHPCTwn8GOTMZ7mrp5N06gIycRXOv0PA
Message-ID: <CANiq72nOKrAtct_eb7tjc9JFFpOQrN0=5bOyOZo1p4C+4U5bsw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Clk improvements
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, linux-pm <linux-pm@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-pwm <linux-pwm@vger.kernel.org>, 
	linux-clk <linux-clk@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Maurice Hieronymus <mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 5:49=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> I was wondering how the rust folks expect these changes to be handled sin=
ce they
> touch the rust/ dir. Should the clock changes go through the clock tree o=
r the
> rust one ? it is fine with me either way.

The clock tree would be ideal, i.e. a lot of subfolders of `rust/`
belong to different subsystems (the file is already under "COMMON CLK
FRAMEWORK" in `MAINTAINERS`). The "treewide" Rust tree can act as a
fallback tree for files tracked elsewhere if needed, but it is meant
to be exceptional.

(The files will be able to move to e.g. `drivers/clk/` eventually,
when we lift the limitations of the build system regarding that.)

I hope that clarifies!

Cheers,
Miguel
