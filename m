Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617AA46AA91
	for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117716; cv=pass; b=r6Tb+s+XR9crTsBEfwbvKLF5Lqs+XbRJYh9DtuxVOhmyhDK640wYtit8+91JzTXcjQ5eYOx0e2T9BzJECeeA1IaxFZ2gIjKUvxd+nAEM8KEKgQfxtYMmAh38+os4YH0nA/gkcY8sMxU0qwPehktUDR6b8AjHSi3tXqOuz0Q/BZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117716; c=relaxed/simple;
	bh=9AitBb1GHyxUD8itXAfWQrOndn4vr+DMbiE1kW67HMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ9GP2iGsQv25ZpuzelHIb2UhAqJ9wCmPmI1LMBYkyKxHd056m7NJqqfuF7F28Y9LI2/vc233hWR1I2hKNTXetKF/0KTNRvE6hSRdc8uYnxnpKltgTYFa6k6BPCmjKu36upDiJBQt+UbrYG6VmKaq84sBlg2Lrj2gfCeMTcFsdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntc0+0D2; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntc0+0D2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48586861639so277443f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
        d=google.com; s=arc-20260327;
        b=JjUZQKGPr7ru8phrXn16Ebm6+LDb6qBb3QAjngg5dW7wKEQCQS02YtwESofaIcs5yE
         NPD6zB+rLABOOym6whmdDjgioJyKzGOVnmmgulIbwfLKUM/7Q+AwF/OhfEpwEnYi5bF+
         UDhVLr75HSoiw0De+g7YU8+HVc1yfsK2/Y+amveYpMDVTwr0Clivt4F3mvRls8CjOWBB
         g32Bat/gkkKeBbJIdWRY07oOpuhpc3HKX/vaV7w6oHEmLIM1dwPEocH75YkgtMjnFyuR
         /SwGwb3If5Hjnpd9q0/nYaLnhHIzgVFhaq2JBtENJxs4RJ3rxsvcJMv0Uuzcny9l6Ptm
         DWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        fh=ya0Bml5RWvVks6/2PZEzjW4ffUi1uUGPNLhMdgqArgc=;
        b=UCKSfl3Cne9uRzDIUNQBSsM0UkCiZ9zTS946yc4QWT8Ioys1CzQut1WOIUOBp7bFDi
         vXeHBryYG5TIh/l+aBeA3yB+7io6Fa+GQyjEkm13FeH0zcfFKPmYDxcx1R1tjd5+WhSg
         tJ8/ms/nd5ktvTxbmXnDG52l1utDQHYS8fDY7B+hqOH7a33z0Tm6TE+8JO8eip0cMVq9
         dJ0HaxAd+Dj57r+dThOWfQBlKPFArIEMbVN4yrK233Jb33v1bM/q+s0huxWDGxPaDGbl
         BoX5ZYLy4xJaxvpLhHHSjZm5jcHrXuAbwwmArxnJf7zHy5qJK5YCSKmAFreMhU4jOQaA
         5q5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117711; x=1789722511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=Ntc0+0D23+YujkzMEy4eJ6nXRpHFOnm4AtVkxEhi5vnpCexhU7KW4PmGmKyNMt+kZa
         TPGlSB3IBPA9MiD4PQN6ttGdFWT2WqMR0/+bikrH32dyf3RHlyaDpdo24c0XMpHO5GJU
         lDTJahlTxAMonEnDUsydvsqrYYCX0kfnhBDCQrNCn+atyDFTDkDtjvAsv2M6xPLh4eMe
         a/AWqeYbYlOAESo9Wgc1GsNr33dNbudqVttD6Sl4VuL4rsbQ/aL6gINrZx4FRE2ZMT3U
         4K5dculSYJThgW463pZtuOMCZuRhxZHA32PPtyLFovJ2VLCOKrv7CixBauixl/iB/3rB
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117711; x=1789722511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=ATuf17Kf77LYzn5jxHuPWVb9dHpzpkCK2d4LSTsZtwWT/2Fs/grwU1ZErW1kRqJBRi
         JoMdJMFAesBTXdoUFKzzoz44K73wWXCHfxf0fbkwpx7Z/W6yqQv6DlIh8gDZPb8oSu+0
         j234Fjo/+7pP3FRfRWn+XQM3UAoc8G7+Cmp1IJFHWfpCarhv5K+0ow0OD3/9QnSiPOoo
         kkQsgGWsxUXylyF2jFaLixuU22qW5Jpn2KaPQGWjQdfVzTBO/VMpQbIVZWYS5pG9GqK1
         VtXV1jE22ne9rMB15kiiefNQe/ewt1rEIBQzdSDR2s9HmyzGlVWe6x6VqmVCq0ZOOODS
         K/aQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3iO1Vglki7ORE9xxKY6FrsH3wluZ7PvnBbbzSTA9N2RQPLj04ryuaOeXI9aDuAYr70jFiCbZ7SJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++kri29P1Uif76LqtxiE0zwu1K3JDITRvn/yOjustTQhsIeYfX6q
	l5esq3m4TKKi9uW4fNIRRivQB0HC0Pq38nJ0xxUXlB6gNpGvnoYVaQihBpKmbIsq1I/BtNoLtXo
	yLZp52PkhsSDguxhADLPZWhd3EUQITZdwvuQV9fqc
X-Gm-Gg: AYBFou36iIgXjOepEv4YNmHn3ZlUQ2sroAw+hxygey4v3GidJmFGgAfseWnSjek9G28
	0Wvfkxq0jcbhEtqFMHB1WbvILVtF+qfXXSo9klYla3T/xXAHEoDI4EfvDzesOcyM5gTZgGM2yKP
	jx/iqGXDpsEeajbiRIwHWP1tFwvwYAktW8soUkJ3Tm8HX9XgzjpQVC9AIZGll0XYOnJbictGSgv
	lxeMe09TR9Z0N7J7OGl367J8xdeTiZVJvimVQG3njxgnyZyEBgN861Uk2Qvk3lhtfso+GHEx4jh
	mjIk21s8ujOrtpu4soqGkp6IaLy5ivntZNOSnK7baTz+omlKXhSL3/zrCA42/qEVnaa+MrgwKuf
	TNbrpiDMI3DUMe/TqNmYV8PsZ+CjPvI76JOi5ntQF2aJ6E2MqR0gRj5SECG6N72af
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice
