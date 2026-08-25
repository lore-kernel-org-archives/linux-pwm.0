Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C2446049
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663447; cv=pass; b=OrxQhsPvCECMEwPnmXC6vXE4FybwOfMaZm3lSp4nqDf9iilUEUjmJjrQ8FZewWGGHMCVay+1uz6XGP4htQ7j9yO/H0vZJZMS8K8/TleEZFn0+/TKrudwIsttEdBNht5d7EJv6dt7g+wFX7kDtSCSyzwEPbdrqtcwMza44XJqwAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663447; c=relaxed/simple;
	bh=02FhfIBqMMvQXAFc8ywza3WsDbF2gi0rUDQddC21ZyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dba7UMW+HxeFFvIBVrFjiOGC4M5y0C/XP/NV9uVSAPIXxXNEgvMtX9FmkmoAs44F/z4E0oZ7S210H00yikj9QGOhOWnCn6hHWjCOQ1M2t5/F6eJqbyZE9/pzBwaD5OQqwmGSgZ7ujOcXKCt4Z80M/oVKm6XxSy9opFKOTMdZmSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTD27K8B; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTD27K8B"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so9068795a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 06:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663437; cv=none;
        d=google.com; s=arc-20260327;
        b=cTUVPXH24QyyHXIjkNFteWXZn224WwXBDOPLcd25VY94EgHp300xAAMr7epNAhPAyC
         qYxLO3+eD3y4/JrpeX2mjy/Im2nHKuDG3482sUfeb4L8w1T/nGGsIl2DXkMICpjTGiY5
         uCH8erLF20uVPrzPyl1tFADfO1cBn/R0PmLLIodCn3FqwkBTfxkl3uSKWt56FznNVayN
         iHq5lV5H/QnAk4AK18CwvJ7iT1A15fNY+ewts+dO0wpvnqaifZtM7i6rPO8Ns3bU1r28
         fCkPcIN2d/8IC5PqGf7EiHZKl5Tpqf1J47DYOoYe7vuQ1HerHAjUHUzqYrfC2f8kdJEy
         L0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iuMwj835HhD4A5CZXk1Hdm7IMcB4Kfutchy14lcyny8=;
        fh=fDRUDtf3stVwUklVZ26Mh04AQDNGjAKIvwJIYgSzvL0=;
        b=P9F5U1hJJJ5cjFYLykosElHzrQS6g3I2+YpMElmOVwSciOp7GbJt0ER/aBkzugnuqn
         eUkx/DEFXwT22KbMoZL7pvsVb+NtEy6I81WSNgMgfJd8Eby9FhJjAlytQHfBjcAzdXWw
         9AMpvYzVlUHCHky+pe4N9osx9vcLjjGjyfYgPNho3V8Ll0/hwUOBQI65uT5Aam40Ibnv
         a57n3Qb+pKD3E7rCe3Yzh041da65n9xopbIFLjpOMgg+wbfQDoioXLCa4l7lVXgijQWA
         QWrNyIGEz9ExtO+GNjKP9NIK5ltrQyXOt55LNsw4D75M57yZbC/S/O9tca+y92PMNuKo
         p1xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787663437; x=1788268237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iuMwj835HhD4A5CZXk1Hdm7IMcB4Kfutchy14lcyny8=;
        b=DTD27K8BmV9EEBv7J3uEHqthV0pcKxDfi6PXr0088Ii1HelBk73k5HExF7IhYM1wW0
         HSCnVozStEGbBPwAN2w7njqTN3d0QQVZvpwWSTjPvH6zTUugMCMlMA11hXGHR2YNGolL
         HOA5iBtA50AOSOv7Vm3+AT9y4DXHRty1NkWEM7siAtLcIYVJD5NlmdaM/zZMhTjUVh3o
         hDdWF12VxHFziW6A9gFvjRolb6/o4FP19w7c9e3lUm6KJYBwUPDxLOjSNC4SDTzltnGt
         2DbKqsp4iHwsbxPZ/2VhUa6DJ+xDyTN+GoWmWLIrQ7Wown7JS5pFv6d+ABtVTKg6oR6U
         77kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663437; x=1788268237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuMwj835HhD4A5CZXk1Hdm7IMcB4Kfutchy14lcyny8=;
        b=ibTMWB+ijkjBys1Vy/f10/B2+MfPdKudEj7KTPXYCp2fxrm7CkqfTsoRft2NeA/C+9
         5WMP1revC9MYg8usSQMkE4PRboLn836Pz8y+tLWuUhZkHa6enBkYy+H1L5YU7OzG58PX
         CuGjh1T5l+sENYG/cspzB6Lq/CYdLj7zh09scbdEBe42EUq5hOt7WC8rqg0fxojlDweY
         om2zpPSSnPuNm52nkILyQ17mMq0mGermnMbdvJ6rKSm/DkqcInx/Mqm3kfdIJegVmV2Z
         5D8jYAKRmWzosft25q9LgJ/Fflrwb/ioFkHe+/D25uW75BcAlTQ537/q5Loay6ztK2ca
         VfXg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4ebig1+SkicCSwcv7aANCVn8irRlIySdMJnQpLz3aU8U3HjN5xWLUTAn22qpUH7nDo/AwQAslQiw=@vger.kernel.org
X-Gm-Message-State: AFuF++nFC7I7IyVV0nDUwjtO+v2cuAvo4omg/u64iniqEPZbKVEIVSpg
	BG/TOFj6CiKbaF7eaALaqh2b+Ab6JMSbqSuBvzEkHgVLgn4X24Q5un5Ma0Ogl0oCuV/bD4mzN/m
	bNqoyuTd1sEBoscKfcAPXbasJn0qQeMU=
X-Gm-Gg: AR+sD12DNyz0wa0e0HodVSLU8HztD3ugnGQkv3KjQXUDOONEqKFYj7Y1/FORRjvaYAE
	1tY7WXUfMl05jZRxqAb77B+22rZ51udzbxv9YcJeOsskY28mh6IsF1J25/uHunvvW226QQDQt2j
	aZDpnH2ZiLykCLgN6od9yHjve7qzQqEsjrmw8V527HC+CemkdbByjSrWR5iRaP/nhZnVzm2TfBW
	C5ZfNq3kNtnH6eqA5XXpun+1G3zmhmrUmJdTni/cxKC9yOWwxktIFUn0a13ZuKMpCrjsTbylnPc
	8Y7BwfE2oB7jWL36uwYhNZCaIHXGaVN5MjtOt/aJvKrNmus=
X-Received: by 2002:a17:907:60ca:b0:c24:6985:d7a1 with SMTP id
 a640c23a62f3a-c24924b79ebmr3067182966b.7.1787663436768; Tue, 25 Aug 2026
 06:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
 <20260824125523.131762-7-biju.das.jz@bp.renesas.com> <20260824130453.D03C01F000E9@smtp.kernel.org>
In-Reply-To: <20260824130453.D03C01F000E9@smtp.kernel.org>
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 25 Aug 2026 14:10:25 +0100
X-Gm-Features: AcwNN1Uq7B_OPhhUOfAGvmbEHdK5dtPV8yVIVtP8a8LSe8nf83A3g2sBuIV4qcY
Message-ID: <CADT+UeBsPrADZdx34qS4YLyDwmO9Lq9qJMYWzhw0HW7+f_yZCQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] dt-bindings: pwm: Document RZ/G3E GPT support
To: sashiko-reviews@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pwm@vger.kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sashiko,

pwm.yaml  already defines this property[1] as required.

[1]https://elixir.bootlin.com/linux/v6.0-rc4/source/Documentation/devicetre=
e/bindings/pwm/pwm.yaml#L23

On Mon, Aug 24, 2026 at 2:04=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Add `#pwm-cells` to the `required` list. The binding omits thi=
s mandatory property for PWM providers.
> --
>
> --- Patch [6]: [PATCH v7 6/9] dt-bindings: pwm: Document RZ/G3E GPT suppo=
rt ---
> commit 9a7d174b7aaab1e8640a8415696ce9830442c765
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>
> dt-bindings: pwm: Document RZ/G3E GPT support
>
> This commit documents the device tree bindings for the General PWM Timer
> (GPT) on the Renesas RZ/G3E SoC. It details properties for the 16-channel
> 32-bit timer, including interrupts, clocks, resets, and power domains.
>
> > diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.ya=
ml b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
> > new file mode 100644
> > index 0000000000000..cb4ffab5f47fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
>
> [ ... ]
>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +  - reset-names
>
> [Severity: Medium]
> Since this hardware is a PWM provider and defines #pwm-cells in its
> properties, should #pwm-cells be added to this required list?
>
> Leaving it out allows incomplete device tree nodes to pass schema validat=
ion.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125523.13=
1762-1-biju.das.jz@bp.renesas.com?part=3D6
