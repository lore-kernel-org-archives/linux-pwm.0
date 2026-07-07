Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8D24B28
	for <linux-pwm@vger.kernel.org>; Tue,  7 Jul 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429503; cv=pass; b=uPnAxNDwINxqRIfZd+nMGNQ7gXASDEUOh6vRfw87n6fOEzdciAee6U2rDraSo1YpJPkKER3SxeLWFTRw5WtQBvMudhIZ8C5p4ZVWy0TCamMKzovIBfFvwzeIS7vYP25TXkYJMVh842d55gHLRxm/z5WCebVUfpe1+5GvwpJg6bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429503; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+z4JM7Rm4w+y4Y2KK6srp6+69CkmCiZxdE1f5CXJ6zxE0ivYxmSVF0g3H274/4+slL7y5WD3jQpenQH7UhjnkxAVycglxPIL3CHFg/qG9/vdbjKrByg22SK+BdUSxZV1Ink6RMDF4yKAFzYowA6XXty9dzMzOiks+ohlha/hSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFuoGDO1; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFuoGDO1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c7902f47so25664385e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2026 06:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429500; cv=none;
        d=google.com; s=arc-20260327;
        b=s24xvaiviEfqywgX2lH0c5dy6gRysZi+u42wjsTdgSGazQMZuqOxmNb+kPCuUz2raj
         fpiejMHNuzhgHc7Vfl8ONpm+5Gf3Ma+y64HZteWK/IAkPHfmx1k5vsUmra0WG8FIR3f9
         3mxtZNdWaH/viwVj5ROUFfoZcfaOLYEBzLnDobtPvSxigQvR2TPVNJwyjt7nbIYGFFxl
         CI7OXE4g83nJmUmsgEGZ5jAzYSGWXHp+jhTcY51QnLyikoO7Usia8WCpeP0slxKSo6o1
         eQtfCbdsPrdjKnax3gY/5lrjGV6OWwT40O39Hvu3ywjn6duKS3mETkvWdg2Ytry5wQlp
         tMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=4izJQ+j3B1drGVyyJWEv+5G3a2KZapYRZohngaB98/4=;
        b=Cu5JGF/tVYE6ZLlogy+NvAPW7bs3+wMj/KoqEqmQz3wLEZ6TChqZ1OrtpvFCYY7T1A
         Z4vqYhcWTbnAbnXkeewQ82Xj1+4DKZmHNUQOm2GKChJOMrSBbX0QowBndg44BQcL6VO/
         WdAAhJYSiFl9PyFf+HQXofesJaAIf5QhRwANBiqOXJA9DvR11JHscpAE1bbvpRlaO2Ln
         lu+TkYdH3VK9Nh1+lZ2cba7EeN5itVdWaF1h1loxjFtuk/gzmQKuP507wqHB1cCiwEqz
         5d/KyyiYU8d3+FQtumFe60V+r41Pm1JcFhhwwiAzDgPngjC+my/gNtN8DBB5rItBW1lO
         nBLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429500; x=1784034300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nFuoGDO1XVGBMA2elJau60FW1YO9XoQWxecIiAhwpEOINYiWTEOvFYt9hryXEB1WFp
         +QpoHqW9prtXfUsoH9gorM2w2zbESlVhTgBwWgFdBoQW9ffxpI9Ftbj6KmIlr2kWa6Jt
         NEPjLGQmB/DlSSegsKGXACj8uniH8D+auFU3m9gfLKcnrWuuR7QuZ805cCIl2qBjA3h8
         4/C46UWq7/jViq9R3oxUB2NVe67Bo4SZB+0PtDp/OKTiKwcSYsSFdJgFbeUvRSF49jgc
         HgxxGmEIvlQrVRqPxxghfaYKwpTlJqLnq5f9qbYOax8CC466Yf8yNEGgUn06r4R/wM8g
         nqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429500; x=1784034300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=tPNCFNq14GFoj2hGn3d/UMAr4RvPoAGaGX3Sf7oVdMuxWlhhiAJbL26NXCZxOGzwOA
         vpbOvoCmuHNXWxjCp8OqF/NQ3WpEFnhmtUoNGLx2hMoHrX8JxhUy0JeCJjPRmeUY8PtN
         AWioM5e0CpphmvlaigzGXlIGFlPiOhz7psDwjw1Ad/uIoePc/8aZ25mX+Gim/7mY7V0E
         yBvrKgwyUBlxzOnD1euixvosgsSA58hF6SBuybhLDuMiRnYngHJAcBs3Q4QdqSxuPqcG
         xZTdPdf1sLxX6+YGJZ/7c8Ve661pTrKGduJ1hhjGD6vhoVzY8QP2pB0mYfHjMK1DMeXq
         gq0A==
X-Forwarded-Encrypted: i=1; AHgh+RqvMeST7t3qNjZV60544Tjyx7zzNR142QKqkBxAvf+BRghnqFARucFUxLuIFy/G4zo0+ZvmB8ex+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eHCrFT264t3yafCwN2A9uyYBGlEsTT3HD+th65pvb25MmUqn
	8Lpis+196pxIMYxJrGOYmlS3oGsosRm3AvZKnBoL1ZULENZ7n2QbT00UUCc1ezuZDBQ9yeFqH2I
	FODRSN9Kfl1oDXgT41ERILbTsFoVE7zHkTgnm3+oU
X-Gm-Gg: AfdE7cmFuUlVd6l5IPhC7OwQw72503hktdZ/UOcy/R7F5E55QuIxhXPwsiRMYn/2JGb
	cNu4SYG7RX/+vW9yZSCmYv5+wRAZcWepxBXq4NDOespNmQ9VoL4+V/alS8VXNqkNSFbAyfrHA44
	RaH2KngRAh3NIA2imKbO7Up6UhoFwuR3Xx8W/0a4ouWvyCbpHsvw3e6wTmt9aJLCnVnZ29+ylps
	fa2crnhuRJ4J/LvPKUANzEFM9TxOtUBu1/Ay1HKoX0uBpyC9y1NuFWeQRflUrfwqyf/EzaZKvR5
	kxhtHMFr3cAO37+ukVnzKQsbj2I=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
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
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
