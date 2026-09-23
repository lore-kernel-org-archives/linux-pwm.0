Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FE576EB6
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194458; cv=pass; b=oRMBKti/Kcx5y5p+wynaVefO/xZK7TeLbEwxqdsprx3LcTql1w8Uyr3tKbHWSCglUhdKMoO2m+WTV/TViZzDtOQiJTP6OCShWVSAgqCDS/OPw5bkt8juDSjmR9CX20pGFvCX7qT9wPhDcY0zdqggms6bfYgF3CSo9p+tQv/8Ex8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194458; c=relaxed/simple;
	bh=qOYwtCPr1PxjrvDGfh2AOArCnIzBjh0iMMKj+uLMXjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXJCQW2Y2b4kHfC99A/6Km8X2WltAZviJ1yEATfwrLEAdxu7bZZBZcilZD8KyGLQmtyy4NfJy7la7eRZL9JycVJLg3vpMJWiQ3t26dMsYg42isUmQzEkl3i0QNYrxzCZVjhdGld/3/eOlrFqeLp26OHsV8TJdNbY/lz2M2mRCSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=saSnNjWQ; arc=pass smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saSnNjWQ"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so467274241.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 13:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790194440; cv=none;
        d=google.com; s=arc-20260327;
        b=KxH/3W5hjfXmKUMiqx+7H/yDPhOpxDwK+KsKLDNYWPlWJPTkpBf8UxQUhSgcjqGlAj
         w6zVajXqk5nWm4QPMutLSn42AidagxRZB40txabW3Jm0d4pbYJAeRYrY/F8EYjImBVdL
         tDHJvjncmt5FonIyZzMmJ6bl0WeZkHgeye8pYNgb2sVrKx3DocN9JLe9W+YFapjuipKy
         ZmPys0bcPmIhtBt6SAoQDU/PzH+hZ/vke3wFnkxuMiypVVDtNnvJMwDllmpz0FZtWsWw
         vUZG3r3AmFrE9tEGFAtG99KJsYTj/YDTc4dY3wQgv+3xMfO2jQAD2BwMsBZrwUjKNJt+
         7v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yYhzfOA6SCO7uTNbvN7IrLA5gsM9sl+9GrMf5cq1964=;
        fh=Q2T1NvblJZIcoCjXGNy7l9aTB9X6i97b8gxZyAIeMgE=;
        b=sKL0AawKSBeU5XGU/LXwOwdYNDYTuEkCzryk10YwmF1sF1BtkVM7V1EsEpiIL9tWlf
         byaitOWx6RE5loVlyAM++hB+ZMH1qy+3e6MI9nsIRRnjfYhZSQ3X4Ho4zB4c7HpaPo2k
         TCuvPXm+zxyAr2CTng9Mq6X+2pz8jv5TtyNjdEluGyH407EYeogPckU2Nam/pL6y4G5y
         rBXsOp/R2y+4vgwhGi/fmoGTmtxib+oRAfpq9b/pdT8pR9gzvettM3nBDQ52Okmv3D7x
         6S+HnT43vIfuNbYT7iKYDRAmGUWrZSWoG4OidgHsR7STkLf8aHn12KgzWQ/LRehqIKRt
         YoJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194440; x=1790799240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yYhzfOA6SCO7uTNbvN7IrLA5gsM9sl+9GrMf5cq1964=;
        b=saSnNjWQniJW2lT8LE9/W3Df2C1igopjCUZcnweu2hnNSFCjmSo9YjkPxILgLV9Vw2
         +c3F87QwQBrPQ/p5wq6bo5IkasgYRye/lmGoz+bosXL4ZqsgZtX2Yotbti4RgXMr6nMK
         WNt/AR5Wi46NelCfGZAvxniaWKCFDY8QvmnV8LgQtj79RL+oZZ2llbjMd17u1xvWBKDj
         Kwr7G/bT5qF07iofvMg2Vw9b6Tj37U7ybl78FyreZDOoAwI7n7MGXoC8+P5TgCwnE8WQ
         vlifTAoJCHCxO02zvxPRk4Oc6Zn6U46nGpWFJK5/0iLJPjuM1s/ou87hsMxVTZ/fybvK
         IG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194440; x=1790799240;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yYhzfOA6SCO7uTNbvN7IrLA5gsM9sl+9GrMf5cq1964=;
        b=jhMnax9JP7JaM8IIcqxkEOybzmCbnjoCDUYAU9ZiVI9T6cxLpANvIO5HMbfQpodPQF
         5Hlllo0Pwr8RGD6OTIEF8tAYls0IgDTb6aJ7ETg7kryI0MeHSV6ONVmHUY0+M9e7PvKE
         Cln3Ushac+fIBwGnKGBrKTOfa70UZARDaXDhI47LzdfM9EFhLng3YpavKKR/mIyUHEDq
         ISCSFn7YiQG3n+aD3TBJv5AqoIZboEz2f8vQ34xeKvsrD5fxLwHTkgahm8odxDBb5vyL
         ZortIpTT9bYmEKuo5uY6BQTndb/N75tqJxooWONehO4Mmg1ug8HT0F8RwY4Qbx3gLYlF
         TNuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRTwEbfYTvFUkvJAC2Owih5kiOpkYh9CeXIlyz8+r1Hd05JFrg4CTxidELxgHbAOW1/tcMjbjAIHM=@vger.kernel.org
X-Gm-Message-State: AFuF++nFYNd8mXNj8v030gkP79N3iZs8bYQ8gv8UenXd5KJDZtymX4yh
	h4CFSsiktV7J7Ht60Hk5B58nf+syTJDnyN9wuX9gDlkwH7gCw+D+iSoIP/3a4clSzgvLYwOvEkP
	8oUETG30TvRqqySKEBndRHyvhBw9+9yw=
X-Gm-Gg: AYBFou167s96y++MlMajqVjk3vHoce67ggjqgcUmhaoYrP4EX/XB90NtiZTUb6993oF
	q07g66cA1d9N/JHpXkS0CuYft1L0zSKvlvWMRm473v85TB3wRA75jkuBbMNjdeqLMvF2mzfd0Ck
	Vue+dcOWSazyOaU2g1NwkDnvPzMRHDe1dfR3PP3KQ70OKcpqfxFK+J/bL6xiwMOEJewd7M3gZ0W
	+pqGqqPMLUEfXBjXu8UeILfSUtr2vb1hRW9wOhOVHGgKaIqaJOklI+k1YM/Q5Ok0OdLrThyyXT1
	/m39EtcJuN4vvRadr04nBiygsr8be9lqwEWsCJQMulJ2fAIc8SBJoSdfj1CJaJ/f8oAF+fXS7Bs
	kP9mHGkK3qXyFIp9ploGBG061JxBhqa+ok+Gd1rykMHkSdvaQqm9I0f3gXtt6+ajTCB0xa1Iq8I
	ZIv5tFvLA7fkBitonyrkUld8iYwmKdMbN6z7WxzJaJgsfe
X-Received: by 2002:a05:6102:548b:b0:7a6:d11b:16ea with SMTP id
 ada2fe7eead31-7af1c7a036amr305798137.6.1790194439982; Wed, 23 Sep 2026
 13:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmail.com>
 <20260804-h616-pwm-v8-v8-2-db37ab8624ae@gmail.com> <arFMta6PPwmzSk86@monoceros>
 <CADvTj4r1sFjPko7G5DwrPUw9x1tPzQspJhCUmHSMtrudn7SXEQ@mail.gmail.com>
 <33e760ca-2bb4-4f1d-a736-7e74a97e60c4@bootlin.com> <CADvTj4rBUNF6EaKXbsy5t1cS0iakpWVdpQ5sQF2qLS4YyHM2aQ@mail.gmail.com>
 <58145d8f-dd16-4cc2-b2ea-d475462241ab@bootlin.com> <arOif-bN6JgLeWd3@monoceros>
In-Reply-To: <arOif-bN6JgLeWd3@monoceros>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 23 Sep 2026 14:13:48 -0600
X-Gm-Features: AclHuK9uNvVaV2VJoRguaZ7pkecy04Hwe0dR9Nt2OWuOrBNW9SpmIsO_os_jzFg
Message-ID: <CADvTj4q4G5doa-br_SvvcuSF0sMA6Vb3K8ogZL7xe=auEd_s+g@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] pwm: sun8i: Add H616 PWM support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Richard GENOUD <richard.genoud@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Paul Kocialkowski <paulk@sys-base.io>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, John Stultz <jstultz@google.com>, 
	Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:11=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> On Wed, Sep 23, 2026 at 09:16:28AM +0200, Richard GENOUD wrote:
> > Le 22/09/2026 =C3=A0 17:46, James Hilliard a =C3=A9crit :
> > > The resolution tradeoff is real, but the waveform API currently speci=
fies
> > > the ordering: choose the largest period not exceeding the request, th=
en
> > > the largest compatible duty length not exceeding the request, then th=
e
> > > offset. That's the ordering implemented in v9.
> >
> > The ordering stated by pwm_round_waveform_might_sleep() documentation i=
s
> > period_length_ns, duty_length_ns and then duty_offset_ns, but what abou=
t
> > duty steps?
> > It's not stated in there because it's not a user input, but still, it's=
 a
> > quite important value for a pulse width *modulator*.
>
> From my POV as someone who cares about many PWM lowlevel drivers, it
> would be ideal if there would be a generic function that only relies on
> conforming and ideally simple lowlevel drivers and work out a good
> period that makes the required amount of duty steps available.
>
> When I designed the requirements for the round-to-hw function I had in
> mind that it should be possible to find the next higher possible period
> for a given lower bound (and that works, only lacks implementation).
> Working out a period that has finegrained duty steps is harder but
> doable:
>
> But something like that should work:
>
>  - Pick a period P
>  - P*, D*, _ =3D round_to_hw(period=3DP, duty_cycle=3DP-1, duty_offset=3D=
0)
>  - Either take P* - D* as a measure for the finegrainedness, or continue
>    to research available steps using round_to_hw(period=3DP*,
>    duty_cycle=3DP*-1, duty_offset=3D0)
>  - If there are too little steps pick a different P and retry.

Thanks, that makes sense. A generic helper could build on the existing
rounding contract to select a period with the required duty resolution.

That looks fairly involved to get right across different controllers,
particularly defining the resolution requirement and keeping the search
bounded. I'd prefer to tackle it as a separate follow-up after the H616
series is merged, if that separation sounds reasonable to you.

For this series, I'll keep the driver following the existing period,
duty-length and offset rounding rules. Do you see any remaining issues
with v10 that need to be addressed before it can be merged?

>
> Best regards
> Uwe
