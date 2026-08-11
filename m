Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F1342CBA
	for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786482069; cv=pass; b=alweFj2vvISI0fPZlwOBA1K5Qpr6GQJSZ9FJ9Bts4FB28rM/vq8DisNRwum04R/uYQGsot+Q3F5FiqrSpAfoU1g5WQ1TtnayG94tRaHMYsSt2XRzODT2vzH8tUNf4VSuWX2TPhhAtVCYK2vLZSyvsRAae+lvbgUFLGA+uTSeiIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786482069; c=relaxed/simple;
	bh=xHSrXLJhSdTyK4h/bnRaFJZbZafnqYoCBbPsiMsKwg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oC+ZgIwHPVIXukyOpMQLMzhAKcZ80F1KmWNt6ztVSNT8ExU7xwHjXV/VFcdwlooEVF7cik1BaXR+5d/MTEv5rHbPMUvEDmFnG1a8WHXWLtB8FLHMqlPqFxjkRu/UDMM9vvxsMKlAsR6SPfHCvOfkRK+KX+Y0wHBF0sCoj40NsPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/4687u1; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/4687u1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccae46de39so710565ad.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2026 14:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786482067; cv=none;
        d=google.com; s=arc-20260327;
        b=ehkpSXtlwMGaheXGTanW2hxuvuy7q0FBPV+1byaDMC3jDyAtlPUHewAhpx89RlKy35
         Ztk7+aFnDGqrGNIRY+uipueqzanmhTZLCTF4xS9RnTyfFeQOhmhzvFuWDV9M3vX+Q/u8
         WUmFORZfg16DiYAxq/rJR7KvEMgZN4dxfGEBbB/Kbm8Cw7AfQrcWCLfTTgupMnz2jB8Z
         nclMF6MNa2D7PiFStBQXnsNkUdGc+ireJtNQ2QiXT/Bbs6RCghcK7SXe1A1C+WoWXpoc
         /9SkRsR6mWv1D4LaSGWcrDNhO4jDVu9HBpFGGXmyfqih5anSgHdvW1lUfOXrut43ig3E
         AWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xHSrXLJhSdTyK4h/bnRaFJZbZafnqYoCBbPsiMsKwg0=;
        fh=PsE/5DjixbsMwgcHDTf3AoWzJp08yL0Toxqa/mynt7A=;
        b=ezEWUAk1Ne5IvNy+ba9kp/yrM9DbD9ySM9UiTHyt4Lge2ztJ4MNezP1knEpU267f3w
         Wbtk2EGlQGU0nHfZpR1yqun+N69ahv1FfYV7I2rTuobUHBqsbIVjxzSiU97nrMS9ePCl
         MlHMOs1htBvrLS5+z15jGkuac3goKH7GgVY9PvJDRyXkr16239AyZ3nNpMPiXQhtszXQ
         Fc91LkZpCidMxR38tNOSaqSiJKZS6EB04JjnK1uNS+jG9RggKjXw47F3ZrK5lWRliIXK
         e3xsbW5Jz00f3KdZi58NSj7eJnF3WE6iD1uNOj82FxDQYtdweYU7a5kfC/hr4THeB2Ob
         nwFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786482067; x=1787086867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xHSrXLJhSdTyK4h/bnRaFJZbZafnqYoCBbPsiMsKwg0=;
        b=N/4687u1ohKPdWGsjFsobeYhob4QGxi96WNO84qD2XXJiKGHtyY4mHx5rpApVql1WF
         9FL5ufr8jGPSYzj6VYiDM19MDVUqWlyVB+o6USxJPbOHWdcdg2ukDXALWGXq2FlccPGS
         nvkQC7NFvyXwZp3BPJl9sh8RVz0WPRh5hm8QRaVmz0shjDcgODDe5ozix/W9i73xXreb
         cg8Vgp4mLbcKjkm+l+0VMTCKwaFNG8zqhLaklnKqndnUFc39LAYYvzrKxna0YdZO81O2
         NvyNI/VxDTebyzdBFqq3+Pau82ADwYpto0TbspeoevSJ0xZmOlXjilZ9gcvLUkuuskfN
         QP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786482067; x=1787086867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHSrXLJhSdTyK4h/bnRaFJZbZafnqYoCBbPsiMsKwg0=;
        b=QILVDyt2F+Z6l2VJm4n7I8kBg+0d6QBGwj66nwCWVxQX7AT3ZDGqwhG4/IIU5ho5fn
         LxdNTE8qNH8wCgwc8HZIrPMpnWO5TwhBfFSRx+VCEKTd0lQcPf1CBJBIyOLf59/09Id6
         F5y8VvwfJ9oq8kREpC7DJix//nmHrOf1kXYdg0aaoozvRXxj1DwXW46WWAu+0KFS7v+P
         yQO6hRCe14qdVZYqF9BJuXNlo+j9+7JJu53Qh59CIvkkqijEKih4lGFkcViOQHGPp/QV
         /iO8Nq0Z2tRvxJAX4Er2O8AzoOByVAxB9xbYX1xAYofq2ECvL/GKEPPTiQREg9ETX8oR
         KItw==
X-Forwarded-Encrypted: i=1; AHgh+RpPyubK3yrVpTMSTQ6v4spK2bh1shSG+W7A1jPQEAmc3q/WFiQcfiKE+Z+K4j4NsoGLdL9VThrA+6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8q+TIl6r6xxb7iKbI2oW2t+inIpwwxt+LKUDq0xh5tJj2J1M
	2wVucihUksTAbzuWVbyF/OiQsEyBs86eIZauQ9f/QPCfxQQy6gqQJUsT4sdu3PzRKT89OqHaj/X
	9aGkVdvqgIqCAVAb3II4TRVk+Fr2xC1Q=
X-Gm-Gg: AR+sD12hS/1YmHwGbSZF6Z9Cx7w7r+O6O7UP+cXJV6hhztwIkctw5u7nt91358CVC1k
	jryHyS11sMkFFg7FfnfbaGK4DEx+MB0OXi0XQjkpm+YydmhExOZbKn7U3CRusprRycFSbhZF66a
	f7CIF0p46FpFCfJnDjHekna1fOTDlrdbZi2GNKyB9Py2nKMeqhqqxL1KXKbwGdn3pgBZZtIazwy
	Z+9cQf8cS5yd/R7q4SnbNkBMliGuUK7CKqcj3mEKRVRsJ32Vi7WcGH5JIZQG6PnOMVUdxG7tGu6
	mU2DCFjVGc2/oYZI0k07wJH0gt9ePyxEohSoKY2VAQAtUuw67LSfCF622ln5fRnam1r2pSBxfro
	h1RJd8FZIR2kICPah5/c7QGdWn+qPBgPHSHsS0cyJ1Iec09zJd91gmVnkNO2G
X-Received: by 2002:a17:902:d552:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d3456e7622mr1975195ad.4.1786482067126; Tue, 11 Aug 2026
 14:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
 <anqsTVj5QGYGiEQ9@monoceros> <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
In-Reply-To: <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Aug 2026 23:00:54 +0200
X-Gm-Features: AUfX_mx5xTNPSjPRZOiSX7b2JNTHPN7r0POqFAALJCuvChpsFwzRnqIauZY0U20
Message-ID: <CANiq72mb0RK=2Oaipzas9UZQiEy7FW331dosH0+cFKuVQNE6Hw@mail.gmail.com>
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

On Tue, Aug 11, 2026 at 10:54=E2=80=AFPM Konstantin Ryabitsev <mricon@kerne=
l.org> wrote:
>
> It was just Miguel responding with a suggestion how to better reorder
> trailers. Since we can't tell this case from the case when someone actual=
ly
> replies with a follow-up trailer, hence the error.
>
> I added a special case where we ignore trailers we find in the follow-up =
if
> these trailers already exist in the patch anyway, so, at least for this
> particular case, the problem shouldn't resurface.

Hmm... I usually indent with 2 or 4 spaces my "non-tags" to
distinguish them from actual tags; perhaps I should mark them
differently? Is there a "standard" prefix to ignore them instead of
several spaces?

Thanks!

Cheers,
Miguel
