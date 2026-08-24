Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB240F72E
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571399; cv=pass; b=kZvcp738JFmEsUtlLJ8AIN1PhyoC7Mn7pt3lRfo1qoMfBJ596MXgkFQfGWEj7QFJYHxvPhGpzIa9m7NjCvPZhGZgsuvXTiByHR2FE0m1XJPKcjS+gnf6veMKdBXVNCZQ3yJEmuOpu+NeoW9MGveTbgTixbkJ69QGOoCm25vV+iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571399; c=relaxed/simple;
	bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eA2pelepkskKMQnHFWKyDFYaF+XR1gME84Mi5UsRz2w6YMnScWT2TsORFXPHCY+b4EqFhPidGKzqWfeNAjUA89YvzAt19V63rQGOqFj26eQes0/E1PQYjwchF0lcgsA6pHCyBDjicHFaUTRZhQocHcmKYZjMmsB6PKHNgwSI6JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt7WRk9; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt7WRk9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cffd93cdedso2806885ad.3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
        d=google.com; s=arc-20260327;
        b=JnaK45h1xJZyJCYgcd5WSx3qlPoG9UYFE+NUH9d4kcOdbR5wKGv2vjzRwtM6+tR+1r
         6/nFVdzkBq73USkS50B6y6UY+ddKCjiWFw0IrVOhgRkdw6JldQG6Cax1hhigsiZ1+fUn
         fyIAGtIPzIFUcylXE5FOEY04bFm8aVsYVz/lJja33cceqIDGaUmcV3psZPbqryAykCaH
         dJL1rxiq2ooMZL9k30s1nzjFifHUJ9FfKQg6X28en9O1ANF2D7uyLicBKxE/Xtbarh7C
         eGvC5WzA5pErBHLXMWNvDjv+ODBeB3YV76UJr3sO1ONrtBXj/p31U3G8Ej4TgQx7fMZt
         Wasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        fh=3zKx8nHw3zQmJR5ajg+PFxgxxPEzhO2SRp0y7tg/dIM=;
        b=bh/kYnOdcWVUTWPPO6gqFOpWVat0nKiQQzuiL/Rg36PPZtQXPV8ra0KFEOTENbS4Px
         +B49trHjzdS9IeM+FWvA4V+cHcjblVCgjWrqJ7pt3QcXyPj2FGa+NrJ3s3ihGk+ANDVs
         BE1+FmVtakclD57MVcJc1yUfXUap8Z4exiZZWJXywxhdUm6uFtKXVYxw6O5ZbzCB8nbZ
         f1GSa+5+j3z7luk4mJkTm1E+VhUku+g/cEtcJ66rAE4E8qVvWIW9U0J3+o2JsjF9LGxO
         gfoP6RicTWeykbZL2U37LNtxKqV96/MktG1SUCdL101IJ0Jhnfi8MKln26v5V26JxT4z
         2LdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=YFt7WRk9Nw5n+i/byMsiEaa4pUCFMwIOshTiaBYfmARkFAcX/qqf8idooFji7JpJ4V
         8I34V5VPE/KG8FVWrMOwRcHp0UY7rjPa7LnUR+B2rG5woJ3E9vuC/Eh2yg/2usdoBvp/
         sgDBOYdtWrBqrUWgwPwBFa0oDvKfFJLzefi2in5uq4x8w4fS8H4cBSKU8F9Y2M+WR8RF
         QkcAvfYl7OjkWvMO/Tb3tcOzaneE014I+i3hMlZOBVF9dLsLPSrerORIU6H1VrLq3Jh1
         krdI/j7GbiJT+hC7CSjdD2Uv42ryCAzdRaCZFoOZqJ9FlvCJBlxcPbPAHtRNv4k09cv3
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571396; x=1788176196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=DIh4hb2OMRcEV1s8brKhBJ2pp+K7U7cDfAknQk3KaFVCinoAPBqHSOwCLmV8aaKdXV
         xQYM05CAru+BZcjvuS+C/chf9bUr6Lvqb847kBZrV50FTinO+gQCBdQ5yIRj4CTXSYro
         pfkV0Mi0/sy9tuuitlpHnOh3z5XLgFCFYNKHumzeHuBYauIaqTDm+dRtlKTZeaMQiVmK
         DjotGML5a2l/jYLzzpxtJxE1kEzw1Y3VMQcjUJU3fM2pCInh4Im1G1iuax/g3t8tcyT+
         i8mgeBjs6u0+DKBZondLuFp3VDkOwflGq1TAxuvob/mPZiba0L30zChy633Jjdcl9K48
         jIiA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0FpmrU/yE8RwmvsigBnFxncgL+MymC2IPpPtlHuG6OIRgdBc2QJ0Dm7CzrpHurbnKX1E76SIDMrc=@vger.kernel.org
X-Gm-Message-State: AFuF++n3afM+iUqOAM+xB6As78LPiY6PEaXhC16sGjOptmQvQWkgVWWp
	zT1D0JKoDTAxgyrtrHIukTi0miXd5ZJerBZuajxYK3ORkMo66EqYUzGUQeunfQrJATVfprL54IS
	ByRK+lXL/id3ScmbQvtc8cUwVpI/uhlU=
X-Gm-Gg: AR+sD1247iC0aXPiP+TYJS1a8nrlaWX+30Hoc5PS0epoQzqcjr6QhkmM6FkIt4xxxVA
	wyKdyoV3hDG/6pNlKNujhBRQIz9GttAcNvagq8JxwYTi0YBdT2DDQ3J35rppoPKkPQRIt7NpGKq
	UzmGuJp4TFjoCfAElodAQlkEuXdHKfuDtqWdZ3Y9p1mYwBZxx5eDwV8icvFnRkKpIazykKJgeNd
	HtSsG0fn980kxEJkoc9ulYpyAjjJLlCLaReMzeawc0DSZ+MAGvnR6fKCw9Q6qW9nLGv+s8gbKL5
	Z1LjYN+w2jDSGMxR/4kki2hn5WKX25/zKHSjp/csQQCursvw0rP+yg1l2KYk+T+OMO88r4zHXZe
	KZ3G96HfEHTzuC1aLYnqfSSJ1nIoJBB14wUq5EoxQrAcAKaRxXleQTR1a4TBXOXkTnR1Iy/w=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel
