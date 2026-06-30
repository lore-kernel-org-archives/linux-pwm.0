Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F0416CFA
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jun 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824541; cv=pass; b=ZX79Wr8GNJBlpkuLmsqaxIX45rrztizEFqDlMkqwQNGL6IheKsb2xU5PgpQS7NTPPpNoGQnN+Yyt2fdOMtUBLZR9Zk8ke1GeByNg0pQ/3rvBxeiL/2bKilveAWbAAbnw2AgxHZvVOssZ326bOZAQOUCZ0u9NnzeQ7fntxu6bGtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824541; c=relaxed/simple;
	bh=zVGN+irJoRn6fLQWlrqbDrVdpoX5ulyKwx3V8NzpaKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHQZwN2IuwEBafYy32I0d4orh/3787fBucjh52JSGplWlWnycSY8QRDuT7tSAmS3XP38oBBvkImQJ/+wRC8Sgf8X1irYkeJwH2NyeM2c4+plUG4kxfw+Xlo3sbredGx+76HlmoDQrVn+CdS7neZ8YTPVt8ItxePRYgcN9PSP0LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/shVtnE; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/shVtnE"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bb87c90deso607983eec.3
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jun 2026 06:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782824540; cv=none;
        d=google.com; s=arc-20260327;
        b=UwVqcDjRcSrnhVl3h4uSwZTR4/Caw1zi51Llapcl+6RJEe+ro171h6jQjE1GSVNCzF
         FMmQHz0itXMfsA3nNMPWexJqc7cYYbe3jyFU79FYw+iUK5HOvNmGa4TtznE49L7wENp1
         h8mIy83A/6Y+s2oyMJbyxYqZ/JwvstshK+8ZaJ57N5BaDS2e5GlFhvzmMGTYh4ThpXvp
         5zDMnGD9/T+xZ1E5Nb8TXPkfN2hxM+HH37ESGCqGjaFA6minoKlOFpUJcyBGGLw04kL5
         t72X0nuZtQGVTaX4jUcycobpd7gIdwa6k8uV4f8aLeD2UOd81XrbjRoeiFj661+hPeDK
         clRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
        fh=0+R0BGLLNp5StbZ50rzPyyCCOWzvx/eK/Qh2CQ+rDWo=;
        b=UE16sGH2weBNtI2NAH2pTOXDvZTkFaeOnYzscU2VkEWoc4KNrcjmIV+scKvBY8Zwhl
         ZpfJueAyRrbKqXRtxBlhedKZptfOYdk6hOcCPkMMnaeeGeVDPFr0OqHe895SnthCnlkT
         FsfHczitro6TsyeGKqeLjRLpy0ENxi/XDcB6JXzHID9AnuW4/iVPnIDrLZXDthhPo3CS
         4Jv9giTJ2EakZ7Tty1oq8CfvipDdizzBiKNyH9QWx8vO1ToZW4JOdd+bjIN9yjSEtDg7
         IgxRIiKjKXfrfNRvyXPYnrBLFf5ZByhNfxtBHsqb0qg0t956oOp4tOxQTWjnQFUIccB6
         fJ+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824540; x=1783429340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
        b=W/shVtnEjxIbeiLPvQZbnxVOAB1dEYpDvCixFFIZJDBWOb4YeKK2YBLQSJvJzVitJL
         djy3i2wYpeQm8rHpOyhRnPY4N3PLr1/oEDzYV5LRc5SPi2EfG4v+SrOSA6ZBxiwBTtFl
         nOpmMb0+BOa1hpM3X+NFuTmBCxyureOfewIJp0/oyLy43E7glJkSgFLLFC2ds4c0kvAN
         ZodmwbAvora6LNjydB1rmz+skrYoTbeRNUyhx6R8TbO599/OsmAwFwEupvfsmkXw7XX0
         vSM8uNCTaJtk4CUwsnb84ayRMxMWujVsNSExdKrALitmXBXxX2k4RZqcajm1KRloqRHm
         3dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824540; x=1783429340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32JdvvqJTtjWcr4BtrKwmZqPpf2cS3llz4s7uLQdovU=;
        b=loX1m0rVc9W199eQA/Lgn3HLUSz3eAGLOrCkPwEf0t8e4nPwVcb2Bika33KwQVipy/
         GiYUXuRTjamA/9n2e3NunnaCh9b6A/XGf56Souapw079tAjLZ3Dr3qHB5xTx7bJB8nMt
         WH8mxT9MR5T3KY3JlIxxcaKvXDMWQahT/0D8xSQzBv/SG2uR27/hD+Btw3PMj/0KscDy
         VLu+Rack8oK4zVLsSwpeKjMgi42lwOGTnV3OAmijb6R6nlCzP44CXkBZ7/ixSYNQW1d8
         2aDVroanuzgM1fFU1p0fCjCAvZxYaUQN0wM2akknwB8mhV8IiPVa6lOc5C4JRKwjZqGb
         YEtA==
X-Forwarded-Encrypted: i=1; AHgh+RrSYjdQYmdgRgv33hdiG9MWsABPnGxkCuQBsfjmokBkXD34frmabVl/GS7iSIEQ8SSu1sPuwZeDq6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ri1584bONjVZKZRhvCwJWuAHtnhAq/fqKMzksZxPOz53qwOd
	alcDiGpIsDh0PVgPLBQRL4iwL6Vk51IeQ9HC1XrFrIv+Ry2hWzeHv/Q2Tq3sFR8+YXtVpmD+zMn
	oS+GqXWqvpYVGQ81c2WPYnn2LnZAtqZ0=
X-Gm-Gg: AfdE7ckiktWBsiPGuqMOKGhni9Ytg1lB+9IUtmZ/thJjQ3LMw46qpOCvJexJRWVfeRq
	N0/gsHu0fRA28J+4OGe6SMMlkLbWM4TmN7YEa9mVpbi9YRo5anp+g+CahVfltcs/yeed3qAPujZ
	XoWH639bqselV/+1JyOum4SgaH5bR1tEp6l8L3ICS0QmvL8k3/gaZZ9nkR2s77XEOa+G8TkIGVf
	iuJd5MT/10YyU3+iq7w1/sCaROlA/Vy1yf/N91iKBoKqOeBXyU/37Y2EiuwGyJBfSvMuMkx+1t/
	c3Pf7P8rKtBgEhC8Jiuxi5gLGRSiXkNtHRczxMiaC3eUtU6eEIwCz0jx4roZme5TLhIOh4xjmnk
	VVRwa5+sLtI4N
X-Received: by 2002:a05:7300:fd13:b0:30e:b3e5:cc43 with SMTP id
 5a478bee46e88-30ee13cd8b8mr1307107eec.4.1782824538764; Tue, 30 Jun 2026
 06:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org> <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
In-Reply-To: <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 15:02:06 +0200
X-Gm-Features: AVVi8CdlaW0HC3qcToqh7v3q0JT2Ai7s9vfzaVZXIxvGTDn0q6fiJzf_f2XS20c
Message-ID: <CANiq72==81FEfMxTnUCdrFBtj9fnCnhF6jXgx_eqE-VsLgW9Rw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] rust: I/O type generalization and projection
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:15=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Hmm, this looks like a false positive introduced in new version of rustdo=
c.
> I didn't get this with rustdoc 1.85, but do get it in latest rustc, howev=
er the
> generated link is correct despite the warning.
>
> This pattern is used by other code, I'm unsure why it doesn't trigger the=
re.
> Anyhow, the following diff seems to be able to work around the issue.

It seems to me that the issue is this line at the end:

  /// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)

should have been:

  /// [`include/linux/iosys-map.h`]: srctree/include/linux/iosys-map.h

i.e. not a false positive.

Or do you mean something else?

Cheers,
Miguel
