Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193336;
	b=YGn1khe4ndCjWrZx5LwrAKiTB97D8R+cFgxkfI3M+XYtmaBVpLwZA25ZHW6X6zfsCS4F
	 SogGrrC8FPIjDTYRw1q1jEExYJmptMRzqnDReOPXH0bdEj22QQRU0gHw050qtO1x59jKQ
	 YAmhQAPU00ZiSteMDcWO8QtWbaeJ26UYmDdFZlhVnC+ek7KfMMCmvwDfeBVLQB6zd1skK
	 tHDfMdW3Fm5aqfgtbDTZ7lhIfZyqoXuIqj9qyU3EVsjNwTpfvgkMYYZcdLihmOrJIqG3v
	 k3zP6BOGftkPdJAq/HhRydMy7gYkk31qe8AGzbhkBf9A9Zm5F2jYZ2zkRRX29X3yeUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
	b=iY3C+bbFaA52mUp5a2Xflt7HU7+i9jthsDXBvGM5mlMOJAvVaIBuzKgNhNvNWwMuXxry
	 7UcbKLXAMNaLZsptCgST/YABa4CrNioSkgOQCIORTLLBIrNRkhuqjOiFX6nFXtDqA5r3s
	 yyV1Fa8xbpLJuwddGAp/FQvtPFCVoVxarup5PeyxDXimqfP+dI9Fkuzpz7A2j4byo47jf
	 /RE3mEaPLEMvdJre2mvFeFZzINjvsBVFv23Yzf6G5iMdjFB9t/EaNZNaKGl4xMhk5t+I6
	 zn3swEIMTT2NkCvXT8vQ1uJwN0ZR+GzEYvSh9fZcsoLrXVssyTrwJesUXddzroq2W+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ThqzXs9e;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9C606A335
	for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 16:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F9C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ThqzXs9e
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so453179f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2026 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795193334; x=1795798134; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
        b=ThqzXs9ebiZGDM31gPGl6udrq/rds0mEtWQp5ii2kuizKVYwjIt1mRHIaBc6Fzz0d2
         gZA+3ggV2soL3PWUUsf4dGrZlqtGT3N8dW9S0rzOvNQN+sX7aPjYnnjG8vMoBzwfpOwz
         tGsIJXI43jmP1C3DUXG6T02SB7eruboytZi8alvfqyxGspyzlXpROvgdj6SReMSKJXLK
         kDHyIrCBfTy88WmXKjhS4HGD4CbC9N1lhIR5d7S7XuHHH+BaFEQY+gThdDukbyRKw4qQ
         /zWnhCNKVVlyZbltXIvRV9hF2hZzKltNgnSRMcwh1bP3tRso+GxfXCMD6VYbl97yZMt/
         Dyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193334; x=1795798134;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6ErIQcXg/IQfSzNOukoWYAaLWArDLpy/6tOg0mzvho=;
        b=ySDVwM3HBej7kILPgRjtjL1EU/se8pUGnYbuXAF27az6x0h3OrFaOlRXIyXtcWwpuj
         1ZENm2jaX/REr7YILhHyVYw9O1+EGhsiGga7BVAkwT0FFx2hDRz9hipNFDOE109Z6B9V
         xed7YNG+1+0wZ20JAfASPgDTnChtNQXtv+U2LNvclmEsMYVjr1V7RCAYpeNNpK9qB13D
         ko+m70U7vmWDzw8xQaaWEMCt8DysT+ZWkZYbEGW/BaVAeP/Rxxlrpz7InQuAmQR5wFeQ
         ctFlgNcyL70Khd43v4zUHMTy1VNdDP1ho3Xts0vZiTgAcNhhhdht05I6BtOO8pAwoprs
         Vmzg==
X-Forwarded-Encrypted: i=1; AL+hErHnvLnunT6SvcjH91Wsp+QNdS+u7ziKHhOYb21EDgiRnb4RJzclWIyM0c7tNSd5kNaszuhgvbMZKzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/izV6hDpF3vVFL1shZgikrPhqzBSqcSjJlg0/GGcOXxgD131W2
	vs/fCrN0P+EiEm1ENjYkyOhpUw9wS7j0Xl04RbqlyMm6gKcFqkbFFaWLcZkSNIdD5+g=
X-Gm-Gg: AZFdTZcp2vCXZmSXRavtVP0e+UbBSHJ5pc1f17o1kTyTtAHRGexkls8LGhtJeNLJJxu
	1lW6l35TYRjG3vyW4SmLdVb2LK2BablDWJGbpMPMF7jNrSPq5NPDzKzn+kEop4M/wMlKOsJXGe7
	D02z+t6yAJo36zTMRvgI6hwuDpmfXxCS3vPMGe7ITVe6dyVFe8nYQ82fQ+2vANlRYBXcxdBk+J2
	bNO+gxzCLqXnpcX1U1Z74o/s35HolFYoQ0ZRomejCJxnPecuk/aln28+B/8MViPih8L5gqQmLDz
	6DUVyDKOC3fHu0X0h+og6w6J7AoTlXJSsVnSX5b9imR6eQQoKF1wbMiE8tEHOWtgLVBynEZQu3h
	coAwxIgHOCep+z6xQY1EYPrx4TulKz7Db6OsXw1AYFqZxEChsOLlVkGpX5QO8FJ41dW4otcDbUx
	JPVr7TGV+jFlbzz94NP2s9MuN5+K6NxhfxzwaZYrY5UjzwvfphumVNFKobDQKvEVSC96gNhLRdL
	L28KlSzkya73nl1CkH3kCgse+zvFNZzs5LPiVQgFIDudmzPEtKNz7Fob+tscN7T+rwEYngsOROM
	3RjSDduxrbrDMfvD0z/e7VU9aTN6ruZXomIDOId1trdhNia9
X-Received: by 2002:a05:6000:2c0e:b0:48c:58d5:30fb with SMTP id ffacd0b85a97d-4abad5ac62emr8227901f8f.5.1795193333959;
        Fri, 20 Nov 2026 08:48:53 -0800 (PST)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b5f6sm6034212f8f.34.2026.11.20.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:53 -0800 (PST)
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
Subject: Re: [PATCH v6 3/7] rust: clk: use the type-state pattern
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
 Alexandre Courbot <acourbot@nvidia.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
Date: Fri, 20 Nov 2026 17:48:51 +0100
Message-Id: <179519333138.3795820.61438010297111723.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vYLwHzMkZLjjbU0w6/Ec7PCJHgruiB342xDmGbUK7jQ=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDNkMlV+EGpr8GpuXL66eHBu5Y3mWWeFV4a/G+0oUxUrer
 RUIcefpKGVhEONikBVTZKnhrhZ/J6n1ZdZ0ndswc1iZQIYwcHEKwETm3mJk+BtiEpjsotk54bty
 cAsHW8fEZPaiNRy3p1XOeRy6T/PLD0aGzfPKGdIZvNz7xBo2Ljp/6Q+/laCNSwnzT95L3nMcLF+
 wAwA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> The current Clk abstraction can still be improved on the following issues:
> 
> a) It only keeps track of a count to clk_get(), which means that users have
> to manually call disable() and unprepare(), or a variation of those, like
> disable_unprepare().
> 
> b) It allows repeated calls to prepare() or enable(), but it keeps no track
> of how often these were called, i.e., it's currently legal to write the
> following:
> 
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();

This particular sequence is indeed allowed in C. I don't get why it should not
be ? (in general and/or in rust)

If you dis-allow this in rust, the 2 sides drift apart, don't they ?
I mean they start behaving differently. I suppose this is not something
desirable ?

> 
> And nothing gets undone on drop().
> 
> c) It does not let a user express the state of the clk through the
> type system. For example, there is currently no way to encode that a Clk is
> enabled via the type system alone.
> 
> Following the Regulator abstraction, switch this abstraction to use the
> type-state pattern instead. It solves both a) and b) by establishing a
> number of states and the valid ways to transition between them. It also
> automatically undoes any call to clk_get(), clk_prepare() and clk_enable()
> as applicable on drop(), so users do not have to do anything special
> before Clk goes out of scope.

So the point the is automatically clean-up (as in disable()) clock when they
go out of scope ? In C, the equivalent would be calling clk_put() with a non
NULL enable/prepare count. We do complain loudly when this happen. I don't
people should encouraged to not actively care for this.

-- 
Jerome

