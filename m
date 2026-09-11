Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D647ECC6
	for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134213; cv=pass; b=UqRjdQh4IFLbErEcRvj65ZluC6jiE8z3/yVarx/G5OSQwWua0GGFe3m1RjnsqoEGpedkyMKfF/CTHoYpjYQxnvELUVmIZkHLx1TdTNdtz2l+JQ7XQABKfyn66Ua4JxT8FYw+hlDycVTRbOXVPg6feK6qzasR3WxPH4GwJt/KHWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134213; c=relaxed/simple;
	bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTKzp99AJBvLVC5U3WuPWhm9K27gfT4+rwSM7lSrJdwc/11vToIc+44MfOfopEgmtHhYfoPQW9mR5r37rMze4P9u1tGe7a78QYe9Be0DaK2PD5guPgyMIcxj9EyzI1oZ3ayNJFIr6imgBhOSoNWhhkloz2p0DYj8uF45v1VxtK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehf9dS9K; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehf9dS9K"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso12271315e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
        d=google.com; s=arc-20260327;
        b=VOniU0vUPeuTAOc01oW0XaoauIbnCUtw2Od/UfgJFToNdHwAtdlw6bHV9uI6whw9VL
         rus6LpZw4siUo3hi2VvdeoSCmpeeqvIlGFUNGzzjJXoSKwgjPhbMo6Vk1Sg/z9lYJMK2
         iJ7PVDLsVPMmjkX8EbsG9ha/q81oqyLmfO5FP9dT8Rr3LeLm8vi5ZrKETxKgQSp2SUBO
         qqMB48L/UMRS9SMd9eReU+vGqIOPFcfWYW56DPj90N+d+ZB8ocIN1BsM0WEVzonRlGTE
         YQeEuPq6inU3kG2sivdvr5NRxSdt/9jbZvy9qC1qqMuUKujyfsDZbWiS5beMqZXZMAkV
         DyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        fh=HEtr+jwP7I1tDuvCmcQiLtGodRpewLrwuYxUY+mfgSY=;
        b=nH89+eI+yHtEA9KUH8DTkvCN0MvH8/Ew5vDOvfTsitFMiSZjVAunkI3JsPCUn160t5
         +pr3W/NRvX3AM68aD15E5qrjWsKy6gnhfvkEoIoKIGcEjjXiTWX6rQyNzJT2fVbXIbPk
         MdOW1Z4na4dDjKv2hNjxdpvAGqAkw8RqvQ4LRc27uaWq/zRZbjcTmF1ey1Cqr8GqDQux
         fSu+EMfBtQOcPZ5FhnpET9hNu1sNViSXoKKjFAP2nsZ9KW1iOCfLb7LUuCClSA6i4k/c
         USVQhRvuaLydl43gFyQdNAWnZHXuLdCWqCdTyrwyKOEzePdhX3N5AgEq/rxgXaD75Pv4
         xpzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134210; x=1789739010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=ehf9dS9KBtz8dLPV1eOtxc8kmJv+fOyIVW2ZdO06596kBMMRx/tyUK2lDgVQgI5M/c
         SSpBMb7uUs4G1u34797nfCD7P+9zLvxXZxAHnuR56Buv7tbMHFhU+KXC31bwb8LxfuHW
         8rSFo0UCiOxET6/EGYFoQmdn13E7BSnpGDUmtBh5eTd4sQzXsa+4KMiX2L2pwFInQmBd
         XbtYZ8PflSCvO08pB5VAXZaYQ3wTj5HZ2Hp+yRGmtaYxRkpKM8QUHwvM09P+tJQDQK9v
         QG0xK00MrU/0875Gy+xMQiBhNe3qdsPJOLSKMbDDhT7ODGKOfLVFvcBzJ0WilrEwQq0E
         IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134210; x=1789739010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=LAwHBiduCRCKS3AV9ATibKLtrIEehBItPcspgyN8iUwJf/HD+KgOKBKrpnLL74KmRv
         Axqn6WzHJO02CG/2bjxa7QJlR6d0P1/b7rKEN3FnIkXNN/pHHR4cXjjQrDppy+PGrNqM
         IA20NldDFKn/mvDLYEYqibesNGIIkYmfsb0AY6raZYnVq6n6a6IJqVfmUEorj1oXpRme
         jDaMIb3r3Z3qTMIDFlQWux4MEUJ+azN9znuvFVC2an7xi4QR1QgtjUG8u8fj+l+2k5J+
         Sm2dtMdst6wXAwjtZDMoibTLfxF7Ujf1u1my8Wk6uP2ec5keABVuMRi/6NtGh6nBB9AA
         I0Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxTKseSNjtG3eJQV8hXxhxlLs5KSmE5qwrHTeZtZySEPBYdh7Kz7wficZ3dlyHOeURB2z3zu44rWT4=@vger.kernel.org
X-Gm-Message-State: AFuF++mKxodou/F0SaBc5XO13rHyjtKjfesn+ZboMxP2TAj0KuFbi8sV
	xO3gWEX6o+RYnm5Lz1A0I8XCKEzlTZuihuJ35mDuG/VaFhlKLuTkrUISopOUyXoxty+L+9U9Nsm
	SpNpLsNmRT0b0acH9FVLtlEVwNA8JqGc6PhD0JXUq
X-Gm-Gg: AYBFou37MpXSXtrKxfmFvNPlMFLvecyOdarZJBNYYHFA/EdmbWs1jby1PBvY4OcvZ1R
	kHPD8lIVvaIuPXxHoPLvM4YJSSXCMgfNYNAss8mGN7lsYAdMjfewHIeM5ZAsqIF+2+wdHyoTp6W
	MJcB7Ylfz2eoao1XPN2XyARW2iVN84BWVhq/+q1r/bJXqVNJ/YyEk5u0enic/LBfrxR9ZStntEv
	SNHg4TFYt0g+8YtGMYt0BwxCaIF+Mk0O/xRsUXpBxNSaSyMmK4rVJIwlg9DFn2Yv7HAUWMyXl8p
	TWl8rEu6mqNRY8QmsUowSqA/vUFgTBHGm5igl1i0T4iDaI4cdmt7qaIYdPY9pfPBQE1G6/gfTQ8
	6WjrLbnl8+zH0HnZtFyAznS+e/Ycz+AMpwiYtzcOOKyRUVGduhZPe
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
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
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
