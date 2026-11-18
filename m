Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009669;
	b=OL4zz2p+mnV0kMio7GW/QfOGpgpmCFcsHcYxTzHZkGjKwwdDqOGpOvbS15+przIPeS+E
	 38BhNBWUVkvPuDoZIdZFmw48sSOJNfSkbn3b74GKO1XeuRvvlNiMZ+V4qDRSJwKRlq41r
	 WqrGAfCdKCrSIyjucyqfpSJiYuKoT4osLgLLwWQjWjl/0qwL2slMdSIrqv718rvX80B73
	 3RungfjTpNSjUqYEmUqyRA6YVFYAeb44tbm6pWGr0FWSax3A62vtwei+qELdKj12yXufY
	 l1PmbcYK+tYOPVDpqN+54rg4LwqMHuVlA3AE71bLXjmZpNKgyWQuJcRyDT/v1AMkuRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=GdCVP+3hsbqBtwLfEed4MNYxez46hHZZfSVgWwld1kE=;
	b=fUk3xPLdHVpBXkHVA+YKE6ipJq7pGwXuP4P2In3R58fUaXWDR9nMNOJ7qjHGYWpgzx82
	 XXa8ticIH44jEdsudHAbIt0BWQ6SIGoT7b8x0jfgIHKxyVy/MklUsV1n1HDHAZ8hbEcjL
	 ZV81gP2vHdEljjOjWs3ze/v86wt2VO8d1evuw0rYJipb0RUrN74g0qZHT2dCKMwFFFeHZ
	 tSOIE1kDrs2qOVs0aCh4fNY6Vq7UmSrIx3HX6wB6cku4zd2XjykGMbsQhEnDWvjts9A5s
	 VDTxpswTrL47VJDtVoOo87+JKJcJgXWpO72h9aJGYfUDMQgH7cxJpmViGgmqvbOphuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DAy9W+My;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606F606A32A
	for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 13:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4606F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DAy9W+My
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso681585f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2026 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795009667; x=1795614467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GdCVP+3hsbqBtwLfEed4MNYxez46hHZZfSVgWwld1kE=;
        b=DAy9W+MyLFOASqeDRMgU3N3wKGWRUF2lqjNfoYn5YqYxH89hN0R+MYyUTkfDyErHV5
         /VziCW3cpm+rGUwRE+OXFKdSdLDd/Qt/biwFO1m1oEgc+kxkDX+1LToArvbC1B6L3dk5
         SORGGouRJtO8f5kmzGptUaYuTVg89+eN4JoEg0DoUz/TRfvASsawDuGYgzS+VRSLXKCJ
         E45NTS1/rG98Wv6QwT7qFplx26MY+3yW7z3I5hT2/HxbopUJyrdF5Y8yjsv5DPPggjLa
         OAhj8wCuLpBdvCphYE9WeLbuI+poRimRB6+u38RPBEUcevYIPzb55kYZARdeenzsgS6I
         a+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009667; x=1795614467;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdCVP+3hsbqBtwLfEed4MNYxez46hHZZfSVgWwld1kE=;
        b=jLiuXAjQKJZrnAP467Gpq//cSS1lJ2nHt3Q61cEcfq7kanDkW8iLmGzktRo+MCX+ni
         /W+I2+tkUt2nmFJIMmCL+4GOgIYGdtzarWPoufvKfMrzaZwynieCS8PAOtF8ZZFQUkRc
         Yx8kAeRyYQJA7xB3/WvyNlYtFHsD/KW8Ll3D+wvrdCUpI5Dh70YGcPOQQur6tsRwHaho
         LPy8GGVzKQsxWpk13zDKkRuDcQqQYRnMnPjJYjjYWeuar9HtQrQWrVPIc3hNiW2IenGy
         O+oXjPOJSYpHJF0PZtxB46/KfveQPFprLwl3LVLDKSsNg2B2txxRDsgrqpDPX5qKdlUt
         ulCg==
X-Forwarded-Encrypted: i=1; AL+hErGAcvLjt3AQJt4TpEU5EDZhQl0p294oCVvjCLBiDmOnNyIZiTyTPyzEdhP6J9h+3LIBUUsy4NoeZNA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tvMtpKAql2otuXABwN4Y5Nx8H9+ySCdfJvANxoeX+NgIy9v77
	T+f4a6WGEGu6SYtPVGDDvzqZ3XWaD8RKOJSrtSF33pyAMUWNun47TLGACmVBmPAFFk6lD6hoQAu
	PO9PZiLY+OJ4IlHLl0Q==
X-Received: from wrtc5.prod.google.com ([2002:a5d:4cc5:0:b0:4a7:85c3:7bf9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e009:0:20b0:490:1881:80ec with SMTP id ffacd0b85a97d-4a63a895742mr4177613f8f.36.1795009666290;
 Wed, 18 Nov 2026 05:47:46 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:44 +0000
In-Reply-To: <20261013-clk-type-state-v6-1-a5e9977b3509@collabora.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com> <20261013-clk-type-state-v6-1-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134745.657917-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 1/7] rust: clk: use 'kernel vertical style' for imports
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
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 02:07:40PM -0300, Daniel Almeida wrote:
> Convert all imports to use the new import style. This will make it easier
> to land new changes in the future. Drop the `Result` import, which the
> prelude already provides.
>
> No change of functionality implied.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
