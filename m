Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009671;
	b=b4xP03c4Bqp4AH0MEpsCqh2uGN+aZhU3gRn8mJc1rr/EZkOePVRK+yXm4BD1GuCNAX7E
	 URp8kBKwWVnPfYkG95d83oeUIGTt8/U6fGBW4oW1TDXtDoEyA7D/2zHJAiwypOJTnXhOd
	 JI12E6DJ+F+B5X2R5LdWXcDtGquUgPCzydHE8fS57BvlDj+eq6K4xiGP23jDQNmpmc3sp
	 VJN9tDhz65iV5hL2UZZPF0ptpTxg3Te6mukhwya1uainM2qn/TaQktm2QqxRvcarNX9NN
	 lAafc5byR2Ik9zkXF4KhZ435sGsD2TPGCcxd6P3l38wRcHFZtAvF3L2sul2c1M5rdZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
	b=IMux77yW5ShjAyiardKpkU9xGJ4KCk1/iwcjZrPpOvgVzs6PWP+8mx07NkSB2FD3qhJN
	 GYdloAcfYk9as3b0KnwSwwmvN6c04pqGxGEpJfTS+JDuvxgmUAYZ7cwHlWfpwwSu5dv1c
	 rW9JRNkrG0OnvN+cTirQeMPcSYNz6Vg/Wbu7T62mZFeXPEw/lyHTj4/FZdyEka6d/s0vL
	 IVYv7Xh/sxKp3uQP7DHKYU/gWcfnJg207NVug+0pGgdePzdZ+1m6+Z/7h16n9aPCNM+Kw
	 cfLxbilDwZV5f6Odas3KRsCTM8fKS7urfGUQAMuIrfXEVpt/IhdQrb049bcYMxN75gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JbPHYrLm;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC5606A330
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 13:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCC5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JbPHYrLm
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-490c1867460so605383f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009669; x=1795614469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
        b=JbPHYrLmilie8tim6UMjJw3y4D2agEMcgJhzkH6d6H1xauaURr5MM7N+XZPWoQN1V9
         JOVnnVBHfON5uLr4iZ9N29pvVyHIP3Zp2uTXc8nIU26s4mf3KUa3WUwkP2/r7ww570sn
         6eY4B7G0Ar8vsyDOhjyN/mj7Od4s+NY0Z87HQVmNXVvlITGAOSIGyasPji3a5NDM11rc
         S1HC55SFRG1U3OddKseqb2KQCT4uIdFOWnfZFC/dC9kyymV5AZsvwe6mFs8p4YRDGlPs
         7wHZSTU/8Vym+5q/IqfvTVUgOux1W3DtW7lkAeOl9hLxiGo7NaT2G1q78jA4gGWQxwqK
         78nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009669; x=1795614469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
        b=lY8IJ8vfV0/371TUUTnls2Np2qFBUGaiszkHaPAlc+2BxBL9jc/VUkzA9hnZrr5UWS
         +VMrAdUWnX+Lc2lqeMU7aS9uDUp4tKLg8j7BNznfCr5iruUJrNm9iTJ6k3O7Ezss698R
         JWU54SciUeJygfZvE7mcTFVduzrDqaes/x686vNNK3JTaxSOqg+FO+aX3UIKrYAjm4yf
         SsVA9CrovPBvF49BmezTdaYB6WpgeWNmu4W5pMIS+dzpYCqm8xuvy0TdKzAErSvGEmk8
         p3GWBSzxJ4TpUHmv9Ka23IOskC4QjdmPQfQQNzOHFjr/56XZuaCKxvyofNb84gLUL2rb
         jLvw==
X-Forwarded-Encrypted: i=1; AL+hErHdUKxUGdFh5aAeVLBngNVtJCX9qpiPcFPNJ0nuu06ISWpFQ9knGGGuM2T1fL3UP4EZbvoHGxZ3IOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HEanJVVCj0U+I+hNYbHIuFhs7HP7fckOpebQTvcncDnRscJuP
	9IkHvfDiuA6v64Cw+7K/NXM/pfyry+/V0zgyYt6UoKp5HmOmUL8EyuESv2O6daDqfLnbkEXxhLT
	rJzc5QCr1YABncv1YXA==
X-Received: from wrop10.prod.google.com ([2002:adf:f20a:0:b0:4a7:5aab:c222])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c9:b0:492:b1c5:6db4 with SMTP id ffacd0b85a97d-4a63bbc379bmr5187806f8f.26.1795009668616;
 Wed, 18 Nov 2026 05:47:48 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:47 +0000
In-Reply-To: <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134747.658063-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 2/7] rust: clk: replace `OptionalClk` with `Clk::get_optional()`
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, Maurice Hieronymus <mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 13, 2026 at 02:07:41PM -0300, Daniel Almeida wrote:
> +        /// Behaves the same as [`Self::get`], except when there is no clock
> +        /// producer. In this case, instead of returning [`ENOENT`], it returns
> +        /// a dummy [`Clk`].
> +        ///
> +        /// Equivalent to the kernel's [`clk_get_optional`] API.
> +        ///
> +        /// [`clk_get_optional`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
> +        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result<Self> {

rustdoc appears broken here (putting the URL on the same line as
`[`clk_get_optional`]:` avoids splitting the link definition).

Otherwise LGTM:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
