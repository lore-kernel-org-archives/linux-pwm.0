Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193322;
	b=hKC35GNkT4Ikuu4gn2Nte05HbbX1kqUkgkbHNUwOyUjWjXbhaMeoDQMgLYgar2XaAt//
	 Vg85Np1GGEEnFJ4qThP0a96JPIpO0adBdzBog3VLq1+s5X1nZ9p884ktfroH13wtTH22m
	 gP7HoZxoH5jNtYuPcg4JUbF0BroGlp/Yj3YCqLpvObFP2usmJiscb0uk/3d6lg++lf1UZ
	 IL1x63cALR0IdUzanOo4cnFMU2GHsW969KOeHmfxv/LTOetQtHCy/ARbTY8mErS3cqPyk
	 MF1aPRPbfeiTQ7A5tX41uPLuIoWP2xI/1j6wY2QOfyMsPyRigcVOcG3iiEMyq2KlN9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
	b=Fge2TIKuWRRYPDY6Ey17QjKPTupNM15hvmoWB2S1r7/SufoSmNPWEKpxVH7LpnE7rqWk
	 b3TYd4C1F//4GJ/0zjw0wl0Uf3v4POdOIOAoK1SLKYF3VTU33LnouBcEkBh6f4aZppDyA
	 Mc3zg9Ozb8rzlVs9ZqiFIYuSTV+Xp80RStxIDyFPp4V+CcjQJ2Jrasbfx58lUZo81SRj1
	 3fTHTXqHwR+SkiaOrYKZq6bE6/b7iUMlaXlkILhOe06QGify+G375Im5dPIw9nHdH0MCb
	 RGXM8rQC50KWPcy4DRXqghDnAg6ILOec2k0CLaNeW38oaImBxVkSRMt2oeqWMcsnV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RNAMJ6sM;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915960A2603
	for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 16:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8915960A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RNAMJ6sM
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so839647f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 08:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795193320; x=1795798120; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
        b=RNAMJ6sMUpkWN4HrB0XYJTVcOtjWWEYhH6d3S9pj85lhBPRg5KkeaWo1USMBh8nDxJ
         w/2T2XYDMgVkyVrFeq/jl71c4n93hO/4Nc7iCIfX2OaYcsUU5pWUfNweZrU7lY4qEIxS
         4eh9dpGdnLaPp6u/BJuIaSUEM9sKLBQrNTbenH1nsZTez+0/KglhUPE3Mx537/pB4xRP
         8US4Tq4WX3HzsJOKtAtUGRlXjScW3SZXmw2uEC/7LSr2f9aIch+VfB/A7NqU30NL7hee
         0gL2JYNXK9f/Y2bCnqnXnDCx6SIjdqdoRXZ4BKvTX66tKXa7T7/hV4E9yjYAFoJPIXic
         WR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193320; x=1795798120;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfyjauXkdda14TZQkJmia5dShZ8rR0trlEvtPbJzkjU=;
        b=Pb/MJ/dMcdKUd/tDjZyLQddwRjx15FWqfvlLouvgVpPto/bnl2bEqjO9zGi4ZjdC8c
         wjrJPQs03hMKQBHkEW57g2lzIRj1PzL6h3apCbf2+FiAcJqibMk0jFfCRFsj+oAZClO9
         56O7lYuMuyaxKQaNWQBeLxsyU5nC7ddhqxYV+hRGusnFsZPmQvdRVJX6qqVoJmBE7E3P
         7bqDbj8MyintuOA7OrgjRGjId1i3TDuPjIZGJRAmSf4oM0YzTiIkrqWGSRFclwFKJx5d
         3ezZuxErnNmaq8MOxhMvVd/qJRhzB+FRJRGPIAhDYaEke2Q1NrEVFPbJqfvTRYpG58LO
         U1ug==
X-Forwarded-Encrypted: i=1; AL+hErHO2FQyAgclQlGaObFFQonFa+eVEhmedEn5W/gApiKLCvZp9pOIUE6gYFtkJBNZHXOEWQkD++OTaiI=@vger.kernel.org
X-Gm-Message-State: APuU4Z84jZj0ATKbM+8aeFeh3e2ZLhjV+O6ViDYX0mcdKiKJ13bWQw3H
	M+lSEUYOtKSBSaINrTA4vOOLcJESovG7QgW6yLpX/0clKPCNyZJ7cZKyE4TUQfqnbkg=
X-Gm-Gg: AYBFou3pJ7GHzJ5whWfaZopCRGuMyaGi1hs7CxlVFI3dDy1JRKfKRg1KU0H0wEjuNS5
	Jaw3hay0JbLfHrOBR5rNszq32ZA1n2Uc6FxnAbeMdFLiBuY8ZP0dVc4vc5MzIT8/tF5SvcItIqy
	0xpHJLW4+OzJJF4cBabHU66FBRRCHaOQKuycnsjT+vnEsOTyt/ull52Zso9vl8O40uHDV2T/PTo
	oF2rfNQuPbFHrgpQg5J+uU6xM8mr3hAtk7Y6LTOAVlNwc7ql/8QWByR7BTnmpc5SpbFRsbDUDaV
	+gPSHiMsaOBlMkM+8+kdTHAng3BZezmbRzOygGd7YSn+k69sZlYCg5yN5ZItZqLdbnUkvHECbAt
	BZ3bx2ut6B33r7SMYTQUQC6qSZhIEVLEFeY/wNxw2v6bFYskMMYtxLy4SrYI2zxcznbbUJ1rsJN
	6pz1AXT+7hakPR69yHMGJx0nSq/c+6HWn7Al1s0ObIBHYex0Yxge6k2FouKZHqgZfz+nCDGvlMH
	tHwr7HG3zd5w2NONCFcZ/cZNm1Jbk1MbRraz6b34/kdz2cf3UCHq+Sl17U68FAH5bEunlHehgvQ
	KCHsJAcsiHg22wdLPRaNpGargh+jnf1FFLrwaX3Lab8SjBva
X-Received: by 2002:a05:600c:848d:b0:4bb:6b6b:fbaa with SMTP id 5b1f17b1804b1-4bb8880fd0amr81601005e9.16.1795193319985;
        Fri, 20 Nov 2026 08:48:39 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm102415595e9.15.2026.11.20.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:39 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 0/7] Clk improvements
From: Jerome Brunet <jbrunet@baylibre.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 linux-pm <linux-pm@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 linux-riscv <linux-riscv@lists.infradead.org>, 
 linux-pwm <linux-pwm@vger.kernel.org>, 
 linux-clk <linux-clk@vger.kernel.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
Date: Fri, 20 Nov 2026 17:48:38 +0100
Message-Id: <179519331840.3795820.8047048832159165355.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=4z3/sdMgR1NP7DfsDZx0tYiu2dW9UOhvaq59u1rg0JU=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNkMlc+2Ksh+kZXIPh/3rDDW4Kn27hqR6Y15t/Vndc9nY
 JL6uuFhRykLgxgXg6yYIksNd7X4O0mtL7Om69yGmcPKBDKEgYtTACYSOYfhf77/s+M/3jXtP6oy
 5+cRhk+hnv9r4q4aztv7e7Xt8cINxx8zMkx3PJygYGn8ecrZdJeblhwduyRv7OkO5akz19EKybu
 wlhsA
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On 2026-11-11 13:54:01-03:00, Daniel Almeida wrote:
> Hi all,
> 
>  > This series contains a few improvements that simplify clock handling for
>  > drivers.
>  > 
>  > Patch 1 converts clk.rs to the kernel-vertical style for imports.
>  > 
>  > Patch 2 replaces OptionalClk with Clk::get_optional(). There is no struct
>  > optional_clk in C, and Clk already allows a NULL pointer.
>  > 
>  > Patch 3 implements the same typestate pattern that has been used
>  > successfully for Regulators. This is needed because otherwise drivers
>  > will be responsible for unpreparing and disabling clocks themselves and
>  > ultimately handling the reference counts on their own. This is
>  > undesirable. The patch automatically encodes this information using the
>  > type system so that no misuse can occur.
>  > 
>  > Patch 4 adds guards that prepare and/or enable a clock for the lifetime
>  > of the guard without consuming the Clk, so that a driver can keep a
>  > long-lived Clk<Prepared> and enable it for scoped sections.
>  > 
>  > Patch 5 makes things more convenient by offering devres-managed APIs. This
>  > lets drivers set clock parameters once and forget about lifetime
>  > management.
>  > 
>  > Patch 6 adds ExclusiveClk<T>, which holds rate exclusivity over a Clk<T>
>  > in any state until it is dropped.
>  > 
>  > Patch 7 uses it in pwm-th1520 to lock the clock rate for the lifetime of
>  > the driver data.

Hi there,

I was wondering how the rust folks expect these changes to be handled since they
touch the rust/ dir. Should the clock changes go through the clock tree or the
rust one ? it is fine with me either way.

I've added small comments on patch 3, with my understanding of what of what you
are trying to do. Please take them with a grain of salt. While I'm eager to help
rust grow in the kernel, I'm definetely very new to it. It is very likely I got
things wrong.

If there are pain points regarding clocks with Rust, please feel free to
reach me or Brian. We are happy to help if we can.

Cheers

-- 
Jerome

