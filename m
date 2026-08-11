Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919747D445
	for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486424; cv=pass; b=f+5CLVFbMEbjC0wELle0vjPtNkDf+M9xbI2zStE1bdEpxmKWGsHT7KVyoqtQXJT0C/nRGtFc4gtAUx76EteLwCBw0d6lOB/vavloJM5V4EBak3r3MDwSjQQ38EpS2KURC2hM/3aOz+0/RmwT7/7Ha/wDzaZj1otwn3gNOjMScXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486424; c=relaxed/simple;
	bh=W2/6oU/E7SnoNmRzH/SDE6FA74XcSBsdOkPyd/Kh3so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHdc8XS7b2Oh0dy25ULnoXRP0WdhVWVWzjW921B/RVvKv5EtmJKkpQrHWMfQy43lrbaRqdUEVz8Ctt5i5MN/TEz4qHxxrUO86KNYF5ZoMkti2d0W9K15NvhkzqQMo9US749xP1MBaeyOu0JMev5q5zgPma7iXP+UE6lUtXJJrsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNhicO+3; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNhicO+3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdce28edeso809945ad.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2026 15:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786486422; cv=none;
        d=google.com; s=arc-20260327;
        b=AYWkrCaA/H9JKBTRdbbgZ9KNkBMiuE7rk6hNGUmdPY2Ed5JI28eu9vSu4dPxXc0rDw
         qBuq/yal6UyEJsUixNgpdaalpOT8yIPTjvAHuLc25jVPf1pUP4wSFbVbj4mm5tflidPU
         aFH7W3rS0dSJTjlnJ/ua6mCIem1UYrUXaRpuEBGhWB+nQlXo4OR9scp3gquW7wvkpEuA
         TVpAEknnOX+csod32fgI3i/CLS/xmxHn1HLZewg5rA5oYMO4Unl6JPdXZ0pdq6yPXPTe
         HqOV2QZSfbtS6H+rQckvuxNznTkFObDipK39fxwaAxcFrniQnDmn+zgsYtlwGIEhkk6r
         j5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2/6oU/E7SnoNmRzH/SDE6FA74XcSBsdOkPyd/Kh3so=;
        fh=ix+dMD9Fghb+48UXsh4buc2ZQmw0ZcIQ/rwk5Gsw3Ws=;
        b=pmbZKq/C8zbvTanGQX2FmFdX/wk6lvjVWGPljPqgSYmUhGoXT3IHkwu/mYaUc7gcMs
         EcfnLddiCGtnWJwxTADjj+SPNY2qL/cDUOePhjLwJ/m++XGJsVJdKZTccciH1eWJyfy2
         uH2Lr0jobvFNSJzS5eVcxQyW8jmyoiEVVIpc6wBtOOh6xfnyEIyNmzVWyn6q/McFdpao
         xPMF1FK2KPyhvXL52NiqtlB9ZzdCL4R/3XOVGRKYt/Wce6POAkK47frcC48gj3qLM63X
         Dmw0FTEACQD53qv3KIVxIivMHk8zkVMuZquI5RYctO9Dr1lYp04rZm1xwhxv9HjL6ptb
         I/Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786486422; x=1787091222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W2/6oU/E7SnoNmRzH/SDE6FA74XcSBsdOkPyd/Kh3so=;
        b=LNhicO+3kHWiujGdjf8vPH1NeNsXSAQnFr7C6Y5ZnQk/HbrpI2dggJFMXgn48Ozz8k
         HO2CMnrw6Y/jMNqS0mNYZ01ooBhwiBl1eweB9jCaZSPGU6esjB8YxHr4o0kWS1Mf+pju
         Dx7L37/fsR+K9BO+pw9y+nEiOELvrhnEOKQQekCsQ6MXnRLh3f8etKSHUwqpvfimcZfi
         rYPMEGcP7hV7Lz0/qLxHWq3jVKJbQRzjHk/cXIL0Y0+S9WPHUk6lGbwIftWmM9ynYFd6
         edEO9tNDjUhhJHGZ1mQHpJFP4cR8FNttD1FqSdRPxFiZ2hSRTDU73hfr3izCCpD5KsRu
         TzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786486422; x=1787091222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2/6oU/E7SnoNmRzH/SDE6FA74XcSBsdOkPyd/Kh3so=;
        b=hIouIMWbfLvfvqNOia78/hPikQCGgYev0YZUFYF5/eq7cGFNyVElIu0F9n55+lqBi9
         GOKYGdpezFw8dK8gJNlovFT/qfOIOP6u2NS6J7D8bjXV+Grp0gTqlK5i03/oPjRya5M5
         ouTZBpFAokK/Dti+9rSQQYVFAXjPKexSiUq3q4ABuqWSKS0WGoQk4YGjGK29tqTNnIWg
         G+3m3S0SY+xVPAcYKOCXErHaOPWWv9yphuE+uKtYbnoBDP+XhJynRB2xG6qbpEW+F5aI
         2o7m9an7QrtBhPrjRC+7XaD5Az0lZWvf+UCMaulXu281E+w/kgznBMGAkO5t3sQHwthx
         RaHw==
X-Forwarded-Encrypted: i=1; AHgh+RpcOwwdQQYDlKFDR2LXz4eE8jL6O6AEGD8Efy7P2RZEOjkXHJu4Bp0YJvLNYJ40yhhtXOecqulLP8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkscQvh3co5tEL2hh0QA4APljreYGgOa5w1zCvOVIua7zAVGd
	ZuKEUyzZ9gmJQ5ZKVZLIPhbxWIL7aOVOIOT46HwdUjf+LuPHj8XoSUANOkzmtPJpYaVXLcAHfnz
	WFSv+p9PXzlzdUvdffDFB6Z8h8w68xD6HMI92
X-Gm-Gg: AR+sD13iOKb4H8h1im/svkZ61CC8UBpA3/Kq31IctRb+V0zE0YT3RaeReTOSjby90wA
	sGNSQb48n4KJvAQZu69tFLzXTTLQOpa6OGmBzxKBBoB1orqGH7iGbIGxC822ZGXSv3xe5W8MKUo
	iiuloPOjZO7jXgWlX9XEE1MZAOm0AxXI0kKeA1miVK0JAiu0x9cEXbdoZF8GxDS7lwhgESLLzmB
	p+7qhWHwrpG2UxjthNHJKSfGZZlNtwFQz+p/Y3o0e8hP093f4Us7x34MJIEGAB3MqjqldJxj4BT
	IDNh6eeaTMMYUwBhvczHklDpac9psTxTEnFo1kGamsnb0SOb965YB+KE1yeVwKkXF0oSFonH0mT
	Sq/4u/q4z9V4f5jzY8upmSOL9EdxM1hSaODTyhdRKFOE6q5999NLMBfzY+APE
X-Received: by 2002:a17:902:ef0c:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d3456ccb29mr5130705ad.2.1786486422513; Tue, 11 Aug 2026
 15:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
 <anqsTVj5QGYGiEQ9@monoceros> <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
 <CANiq72mb0RK=2Oaipzas9UZQiEy7FW331dosH0+cFKuVQNE6Hw@mail.gmail.com> <20260811-famous-convivial-iguana-d4b104@meerkat>
In-Reply-To: <20260811-famous-convivial-iguana-d4b104@meerkat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Aug 2026 00:13:28 +0200
X-Gm-Features: AUfX_mxmO2Kt_BTUTcV2EXxHGCyIy663HbvVAP9RurhqTTrI3f50J2EGAHSXNPM
Message-ID: <CANiq72mcieV_SmvraqcNNYVOQOppzrjRtkNdpvdv5hOKfZkuJw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Francis Laniel <laniel_francis@privacyrequired.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tools@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:17=E2=80=AFPM Konstantin Ryabitsev <mricon@kerne=
l.org> wrote:
>
> Unfortunately, some prominent maintainers indent their code review traile=
rs,
> which is why we have to pay attention to those.
>
> I generally recommend using "|" when adding trailers that aren't part of
> actual code review, e.g.:
>
> | Fixes: abcde12345 ("Foo bar baz")
> | Reviewed-by: Alex Dev <adev@example.com>
>
> These are guaranteed to be ignored.

Sounds good, thanks! I will try to adapt :)

Cheers,
Miguel
