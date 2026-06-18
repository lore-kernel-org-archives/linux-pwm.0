Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F03E5591
	for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779233; cv=pass; b=AyRDech+py4KcbKZ4btadGhfFdyZzuUkOUyUFwOSZ5E7TDS1IeDeI1mH2EGD7/xyTpk7sTXgrtH66y0Be+RjMCfCJuz6+n5g2hWUhizXY2j5UNh7wWEe4wtQEKU8f1kMlKgNPngfBDMqNa48BWeHZrKjOJ8Zz0DzicvIcjXkc0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779233; c=relaxed/simple;
	bh=yhUtjbZV53eJ33+I5WWMx1PK7EZ98q+cI9GUW0pweEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhsd63EU4C5/bJ+RGSCKDM7CB+Zot7bWdj2TG7iebH3A0jNKuG+gP6ug5CjPOjJJ9fCe2RX9dcnzwluprkU3snph28RR+s9/GKhj3uqlVqSe/xv53mvwhTIwS9KvCApTnnxMoD52EuGSUPAXBq0mnLnfTuE7AFq+3IT9xshU8NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDW4jrkf; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDW4jrkf"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bc5fa5a2aso97744eec.0
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 03:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779227; cv=none;
        d=google.com; s=arc-20240605;
        b=ZzwUUYy2FKMQY6Ra5Fl42N85PLrzmOcfMfgcIRQYoU9PU55cOO9F5Uak1veCFEp9FQ
         eOrICa9z6qF5zMXsIUWkkBpFHNvUBBbWt72LvyzRR8fjDW+n1//e59XHl6vC+WqCXR8G
         w1oLdmdmXyEkuqdO8pgHSsKsuAObWY3PlWD0nzVf/2oiS7ipGT3hpysgc6Ic3oJsF0m+
         48KSC9CoTSWaIOk2KnWpml7ZrjE6ssMEqH80HO2Ze0Z2C5gb0J8EnH4OzpoyGN2j2UdK
         zuAzktd18gqTV8NBehPx/TfeH2nB2u/JmnkNFmfHtJagtq0pN7OV4L9NK0EXBmySkrbv
         z/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        fh=818X+b4FTY1dwz8Emtqj0zLAUXffOryZiHpMJvoSiNk=;
        b=SsVBSEjgqiyMffff0RElhgItPqxTC1BV/hNZ0Mtlz2EnWbFnx2uSvVxKW08j9AHCRl
         KylL7baqYsRFoHBoXp6kXOVXWCWFWUZ/PKn2byIM4W4kvyjA3BwS8dtQlgWDkADvS4cZ
         yZj6acjLTd9q8mIq6tZQGOvJblhroW3oe4korbUD1TEELdtPTUte8qUay/z5Boa9yuPX
         v3eTw/5BG5eGFRV3FW2kiH7omxcYfE1iTtP7K0lSrKKHwAJ407BkgoUJYII8EC6f+pb4
         gtF6nnqfeUmJlSpppwnnr5ZSFSUi0jyga08t9nLgh5i5Y5OFlCAfD2frUq7+nNd6fTbe
         cVJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779227; x=1782384027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        b=ZDW4jrkfk3387CIo4fAM4NOExN7ZA+JSUepXfBLmjVA+9FSYPSR+jjJ6jViBSqlURM
         S9V6LCLaqgcwgr9YDdt1Mgl6rSrPgLi8WYmsdwGZtGJJHr8fYYLDPOoydPJz4Ej2woKa
         VGi8nER7rddQjktBGGDNpeu/TaA3SWCVmWzCouZBHU0fSB6Sdk7+0DOLfMz5Xd9t+1tq
         4PPNM8eij0R9Mi9C35+amzk2T60DWvpon7MBlHRKPr54i4XVSTz2ulaIiuYX181sHbxm
         yTzCEmnhvbEtgMB/vBKfM7I3+8rtXvucGfl2SYuH7oSYFK02IzPvqvDmqj2hgddxeFNX
         K+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779227; x=1782384027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        b=I8F3FKnG4teQbD65J65gaAvQl3W2SCUsSkgppsPnmaoI69xWl3d0TOsPH7nJlW5rGq
         F1CxMhKgIFypGNAxHjweymncATw/gQ6ItE97e0NO559yMsT1sR5ZKoDatQ3u+YDUtzdG
         eJeTFWLzh32RdFkcyefr37U4XH9Z2DBU2qmmVWmUxoCQUarDfCYDO5OJPkLTVwuq6Mws
         eE54p/YqH3fTlH+n1GSsfsUjnfpRfIvIKGMYpN36+rEuP8A2nm2927S2abrXcEilwBqs
         gYwkSgy3Qj1HEpLBrSXRmApfYT2KkugZKi9CZmyImKtwddzO/ibUxpEIqms1WWLRpa5H
         DgIw==
X-Forwarded-Encrypted: i=1; AFNElJ+6VfE4wpHc6LqdKLcxGEZJeWiglAcuCuKgaaxL+v+yqkgwoNV7cP+oSxm0SAxlMe+q3nlKITJVXZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8qjLpD7YS++BBFNhhkZYswQ+XMPViEn0CpLj056ldZ611uQr
	mZ4niBeu5icr24tMufQ8Ci2D4euePPcHOK6U9HU6kepFNtSFJK7m46p/Gui8S9ijTexl1Z6G7M8
	FhIJ6ks0OnYBOol/TvWNGgN8l7XtxLxI=
X-Gm-Gg: AfdE7cknXyG5Wt12Yv42wO22K2EJ2WsKsfymuexnjdGLNUzGh3rTWS6xlL50pg2KcNH
	5UICYeqJfOwA+TCHtx85YYQKQZll31kO/8nUukaUbTZUDbCt7aNJ5O3QEJOcbsd53VUUggCIHgi
	uum9gn7B6L1dmUptwulbPJVBLdm/gC6fjjKGZ31rUH3z5esAFLAh4SFMsHBt7hz5YjFINsrcfBu
	ly8P13AnxjtfkoE+mN4J/l4LbAt6l+Mua7He0KT3tgoW8MyWQPqr0eoQnDkrPwFwQBk8yH3Wx5E
	2EgO6NQhKnKVAmkUyACbe0jObqz0vyU2H37njEO5qDbBPSEbsGnN/ACTmliX1Vjb7H5Y7yRxLsH
	WNpSZKobzgLqh
X-Received: by 2002:a05:7300:ed85:b0:30b:c021:5045 with SMTP id
 5a478bee46e88-30bf09c4416mr1020403eec.5.1781779227291; Thu, 18 Jun 2026
 03:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com> <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 18 Jun 2026 12:40:14 +0200
X-Gm-Features: AVVi8CcKkRQ8t8MfiUD4gXtI1Y4DMiQAI7JLxiiYKqJ_3SsG98lF2VyIrlJ2k1o
Message-ID: <CANiq72myoVT9npyaB0pVvbJ1v9ELzw68uAvSoAkdJJX2MJQ=kA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:48=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> +            Result, //

Since you import the prelude, I think you can take the change to
remove e.g. this one.

>          /// use kernel::error::Result;

>      /// use kernel::error::Result;

>      /// use kernel::error::Result;

>          /// use kernel::error::Result;

Similarly, the prelude is imported in doctests by default.

Cheers,
Miguel
