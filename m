Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78933A7589
	for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856944; cv=none; b=JyWjj8I5RdLqhIcoCejElfcH5h5iv3GDjEp5XDKh8RTW0EfFXAWC6p1bDfKGrz5LPDv/UE2pUtUvs8NXYToHel4172gbJcrwaq1E25996AHQKQ7kkCjj773AQv0DDsAQ0MWgGrMIQALwqEdUgh48Ajjz7E7DPpf/AkA1nfVbNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856944; c=relaxed/simple;
	bh=tUf2hbPu+VAmkpzo0Ox+s3NifzZbHOn/kfum96IvTTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OhISh86goJE1u68lzAsUJ96kKFs9iV7Rvp9BMBrI1cKHPeJN4SmPkF5eyDZJAklb4895VF2gSHW38lz9tHs/uHcaVQ1fUJiP54vlror4kSF6RDA7MLaCaINl1wVXMUFHsR9BOvESG27az0h6YlydvIk/mHMEWWRu2tLYMnYz9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtsuNOlJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtsuNOlJ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso37669305e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Mar 2026 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774856941; x=1775461741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUf2hbPu+VAmkpzo0Ox+s3NifzZbHOn/kfum96IvTTA=;
        b=GtsuNOlJN2mxreugfRvICRvm2SNDSc3AeACEGkCMQQtcmRguwTXgUMlqCiLCEYq6ee
         mA2FB670VFaIzi/11nVShWOGPQyOBXa8NJ33H1RG/CtzJAJzY4Kzh4K6e5vrBBvoiauc
         UXSE0M+QqjYwkVzJsDUkJ9QgEojwxuioG7d5u83AWcaiwbPZdfOH1vF5T8nvP83qSATQ
         zIiFDkM1aOsZEFgtpimXRljN5XQXCOm9fsA5ZoweDB0mPjAAzPRlgCp5QR75nUaCM+Mw
         TcJqKIwLeoNMZvvWRpvUmaePT3BdoAEsnY3MHwNefXDa9C7z0O4DlyYGpI7KusO0iO5F
         2cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856941; x=1775461741;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUf2hbPu+VAmkpzo0Ox+s3NifzZbHOn/kfum96IvTTA=;
        b=T+k9Mzjfz5yozWR/GOX4FZgBS8tPcUuFWrytBHuzMinxfPYPrsX/Isp0P1uC3HuAq8
         9WYW4Y3SvPJWdE/P6b4GtZ+nXGiIUNtR1IWXdW563d7aYeU8vKEks8mGNOo1v0z9Osyi
         0hvmzgH+c5M0yKnYF+I3+1gRNXsFdDQSms8BuKKD980XTGDwYDneLuUYmD7ZEnoBnsrW
         TbwumaFwJ21kj4W8OH5Smlxj0q7meDspQoS3GdEW7A7kDr5gd9wWUIjK4/nJrkc8rose
         4whnTYQOqIqYhE9ZY+E9aEdayH8WCtLHPoPdEcI2hlDBDY9ZCkKyVazqsqfhjM0jQHnz
         NHNg==
X-Forwarded-Encrypted: i=1; AJvYcCXEVOjuXn5ukTtEGykdeKk0N+mG8V1j/UGgTrQb7vUXo9A9jlU7F+nyRT9SRn5iL5wy/VD7b8Nyz9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJKo5Hef4gKFyeHc3zrm9673G9yI8Lbj/n2iYkIMfKZk7wq4e
	LGMZTc0ZD5JTaNwzT3D80rtLEoxouM8vpnj8k13m3LJ17r85mXAv0nKIZjInETKD4wxCsFDYnhw
	MLfOSmaspw+WM++DJQA==
X-Received: from wmbd19.prod.google.com ([2002:a05:600c:58d3:b0:485:314d:637a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c5:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-487280a25c4mr203908425e9.31.1774856941203;
 Mon, 30 Mar 2026 00:49:01 -0700 (PDT)
Date: Mon, 30 Mar 2026 07:49:00 +0000
In-Reply-To: <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com> <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
Message-ID: <acoq7E8NH-ihCq1K@google.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Brian Masney <bmasney@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 04:00:17PM +0100, Miguel Ojeda wrote:
> On Fri, Mar 27, 2026 at 2:19=E2=80=AFPM Brian Masney <bmasney@redhat.com>=
 wrote:
> >
> > Stephen came on the list and started to merge this things this week. I
> > was going to collect up more patches for him if he wasn't around, and
> > intended to include this. However, since he's starting to collect
> > things, I'm not going to send him a clk pull today.
> >
> > It's up to you if you want to send this in via drm-rust or wait for Ste=
phen.
>=20
> I guess it depends if he plans to pick it up this cycle or not.
>=20
> If he doesn't, then it may be best to just go forward with your
> Acked-bys -- Danilo can pick it up if DRM needs it in their branch,
> otherwise I can pick it up.

The drm-rust-next branch has closed now that -rc6 is out. If we don't
hear from Stephen, do you mind picking it up Miguel?

Alice
