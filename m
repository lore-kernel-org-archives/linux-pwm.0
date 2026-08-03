Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B213C400E1A
	for <linux-pwm@vger.kernel.org>; Mon,  3 Aug 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759593; cv=pass; b=M90yy7uGHIVcRGMP7/B1qr0gh+0WvZowbzt7rJpTZQMatACwJHwknaP+TlIYS2vVJvQbHzeyv94BT+qQZQoHADWkVvoXPpYcDG3NV2e47K7aQMofPyPObplsp+UPngLD6c/YXOhSJxOAIFQ47ODGDcaNZ4eq6z7IKbpT/VgbJ+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759593; c=relaxed/simple;
	bh=eXQ3VPWvadJYU5espprbYmMDOyZIYjhLr1ThgYip62E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVMI0cTJzXEoD89PZhbAlv8I7jPW0vmIfA4fk95VR2TbNwIjbOwZO492XZQ8LtjJqlNv+7aST+63ERZ1x51kOTNn9nh+9SkNrsC681zjDgSyWKHMund8YuFG+B7f3/ak2la72jvmBz3fMOG6bZh8VwZJDUiO2CA4ncQkpoEAZdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omPi4nFk; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omPi4nFk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cecc8a3dbfso3480025ad.0
        for <linux-pwm@vger.kernel.org>; Mon, 03 Aug 2026 05:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759587; cv=none;
        d=google.com; s=arc-20260327;
        b=RHzWFQMDYH2Gl1o41isi5TIRHYstOrwrCt7izr0IZP5TA/9tqPWaSAsbC/CSJV86dm
         kyqyX5+YInIJyxHqfQxOPtR3YrvshlPEkhxlPPEFPWb2hbHhM1u26rnnEZfKACmId4u5
         SG7juoxLPGDiLze331IXYtfwXk/I5IS55acI+nn1tlnXvkZj6KeGVihLJntNsi4yfR10
         FWZYgzgr1saqaNyzk++EzlHGie32oBC+vCqqZ2kPrxzQq9zrfp5xUJfTiQPJi+TfwtwF
         ClxdqjIOXs+q6NW69MyVsFB+xUgCbNmXGJ6Oh4dJXm1znmlwMcS/IxRs8YjAC7g/e8F6
         T7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXQ3VPWvadJYU5espprbYmMDOyZIYjhLr1ThgYip62E=;
        fh=+BUVnypW41f7PX001ePsZtelEVtX+sjzVslYSJL3Hxk=;
        b=e44QYXvPT9RUCajnv7M44GpohQx1qOgzda+rKqaCkLvMYaOicNCRV4MoZGQTzPZJpJ
         yBcJSPN/pesxZ56nz/fxTanc26q7Jjj0JeCbpvziTCjV1VuyxPsK/0VTiSni5vyevWM8
         KOs9iqtAgCuOtcMHb1kGKnGY2Jh0Sw5V1pHnur7HcdVjn6H+YBixCaaXkaLlQfra0cl4
         pEJ7zdCw5YIBeRPKLEIX/oqT8mrOnskzBTqVNSqpxrOeHEykvI1ScjmXBpUPJYtqPWwx
         KInkAsW9RnZHbGPg87UuAcKTO9MTAvISNTeS6e0ZFgqdX8zPr+tc/PHvkZokLzfil4ob
         B7+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759587; x=1786364387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXQ3VPWvadJYU5espprbYmMDOyZIYjhLr1ThgYip62E=;
        b=omPi4nFknQhc2Wj1/4MQr+2xTg5poqCW7SrazDUphJ8Bnjdv7pGAvjVC/rJnKTcEt2
         HrZ6EqxW+t1ND2DjIuLOuA+fvrBb0AwgSTQ7fXW+AlH77sCuRIM80JNYcqSt3JPsFXj6
         ielhCSnoJxWpzbJSXbhed4AB4DdJh/8yl69NmlAgShqBxOq4d0J+k//XPDcjsdMY56e4
         PQnuSStsyNE6VE5QuJLqk/mkVAKBojFH0U2w/u3ycjwXXzC7hGRhB8Z4TUpd713q2g1B
         QdqVPAR/UYLegldWNlYFOT4/umrNZRc0Y8HuvER1mCFLqExcpSOkFpMwCI+bg4tZWC53
         9uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759587; x=1786364387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXQ3VPWvadJYU5espprbYmMDOyZIYjhLr1ThgYip62E=;
        b=Jz5PaaY/TUmtlkRTrem9z3Uq2Uo1jwO5IpPNfoqbsPIbmblvQ7sVn1x4ajMmIA6SSJ
         8YTM0ldMGC+g0Vx0uVTrHhqGa6H40NZsgewslKRo3ClGpd4XS6/T3MoM5AcXzkLDO1OE
         lx7qbgNoycIozPNiPrk7MXmHmADWMk9+Kc+7g4+iBGtsOU/vi/1qc2FMUU65ZW0MluZW
         nxFwU88UqqAAkpVODhOPW2V9C+YmhkEyjJbzhbGZs7VtwTwVXZ8IMpSCuGXkPaB3DH+6
         9V8NdknsMnf9kUYhMDQWoz1W7CVTg02DBZA7GFoxEM0nCE5JoQkaEMWFJmgBSEstyC2C
         GsXg==
X-Forwarded-Encrypted: i=1; AHgh+RqkSCSHg6vBdddnv5qZ3j3dCYa8sIhTxX1zMfYjEmwubAmsE9MIIgDn5eTzsoMDmZDHWsmup1VyXvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnSip+M4OO7YaKC9c136s3ZAbZSptCiwHiiYTrLDaEXQ6658JX
	0gr4qvkk7NJ0VGmUmU/bZti6n7Td4i8RyTtx9LZm0cjlrCp3enxulxaVbFT+Gj+jYJoUUU0gYuF
	56FGQTlR+IiI3J/3bZouj3nrZbxV/h7M=
X-Gm-Gg: AR+sD10i5bauwJAeQ0lN/d+w3uQ5Tsn8HfVrJlTGnZOBWH9wJnx5LAIpXwZg7OnH3s6
	LaEPHpg1nYam4ExCqvwY2MRZl+WFJFiU2LVePDaq6RAI+DdrAaLf4P68RPGcgQN+pV3NyegdRPS
	6XbELiVdy3ycg/USV5KQoDvZKzKT+XgMJETIf96Qt62nNjSGhAMvOfyLXdPe/5UyN6PPTmHyB4F
	rJMqfD6lgpFUceRG6I5xSClk5iMZhAvLwY0a914+/MK2CC+6EO+b3P8Laj6iW/snpOp72g23Gbi
	Di+Sq6KS/CSvuKFCLILo2OeQIuRc5VuXSwKQnwf2tNhFEyoQ96zWWW9f7EY7FbUMyEKpp+CTsa4
	TUR4cdgffQHbd5BnY54SsmZ64L/7rf3Mz8GrNYT7HWJvU6iSMyrhV4woqdpFB+g==
X-Received: by 2002:a17:902:da81:b0:2cc:d6de:d58e with SMTP id
 d9443c01a7336-2d05242299dmr147840255ad.4.1785759587288; Mon, 03 Aug 2026
 05:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net> <20260729-merge-init-v2-4-26adf47109e7@garyguo.net>
In-Reply-To: <20260729-merge-init-v2-4-26adf47109e7@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Aug 2026 14:19:33 +0200
X-Gm-Features: AUfX_mxggK0nYOD-1UFK_0KovZ5TNjx88JI-10YcKvyrfX-OouE93-BiJh0IJc0
Message-ID: <CANiq72=b0a0cG+yXY90w30esgx16ZxJ3KsPb+5pbuPrd_izpmQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] rust: treewide: replace `__pinned_init` with `ptr_[try_]init`
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:39=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> The `__init` method is not designed to be a public API (existence of "__"
> is a hint for this); replace users with `pin_init::ptr_[try_]init` which
> does the same thing.
>
> There are a few users of `__init` which are replaced as well.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Since you asked:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

But I obviously trust you to change this even treewide! :)

Thanks!

Cheers,
Miguel
