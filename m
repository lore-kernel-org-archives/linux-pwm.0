Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA537A833
	for <linux-pwm@vger.kernel.org>; Tue, 18 Aug 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089016; cv=pass; b=pFREj/TP75X4emMD/ksC9boyH4V2JqBCc3xK/mFuuOKDsUAg0GdHNWfEJ6KOm+Wnoe7UHupHEHTnn0v+aKNW8GJJTbsL0xj/k+veBAGO6an6q6t0iPItawVumYrIsqmna6QcmxtoNyf/3W17MwoB+mCtcgtf5I0pptr9YCsV0hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089016; c=relaxed/simple;
	bh=AMUsfXmsN0KUu46E37mETANlAYAnT51+WK05Bfuu0ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIkSdwNEgf7a2k0on6VkRinb8wFoAZ5s5lKE/4i45M7W+PzSlHrLn+38F7dfu1WC4OejGdAgGKmf6g1FuMWg80WnJePXWFcZLA3/y8HhYXHmYcRIqrAiKwh5+rIvMnq53SbU3U7P4P2BDoij+vwi+ZgfOn+91mABP0FDeLQqSAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfKJivyY; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfKJivyY"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-738bcf9a573so151197137.2
        for <linux-pwm@vger.kernel.org>; Tue, 18 Aug 2026 14:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787089013; cv=none;
        d=google.com; s=arc-20260327;
        b=XpOad8S5pIoayDsMCt8wjfOVcc7U0YHW0LyxiWGEBMcaniA2gIK0yKcDbjsE9HNZ4z
         Og+j83drt/adtCW4ZnjJfXjQU9rV31tnugpFr82VXjS4LlVnA6Q/REm488xegEhvT8nV
         PEtgHPO/GqplxVrNF26g/pVRThfsRhAGWR+HJcygh8NstRld0mS0lTzzb2d9tRix0qVD
         TRGOkMCHjN0eF5zp5c6P3gqz9UWBNsWz/q9hCFXB2HIIpeGyV5bh4jupFA94pJ2tgUh9
         T5BG2NAZyQ4dfPhxE6Mdi9ESBkQoG68gI+ETM1emwk0Tstfiq6zy+hj0OjjyC3SWb6kB
         TE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AMUsfXmsN0KUu46E37mETANlAYAnT51+WK05Bfuu0ns=;
        fh=dJXJUtZsS9BPRHRmxI4imNjES5cwj3QKbsi2L2FhPA8=;
        b=QEWADFdAg0EKU7oKzvRO6Uq/hrKy/21JDZfa3lJrwRuk5i3zRRNQBAxhKcVBHl3hcP
         zf0TwQEjqFykIHXCNy3dm4HufIZqj6DYlyyG/CjQief5qd+c3tYt6qYYE9RyBDfrk+xr
         MeMZhW6LirTAxCL6QR3Lbnf/ISXXXVB3rlUr9bkgaBWFf+Y39T8KWpK6wMkfxBQw8n10
         mtdJwLusQ3Gn3p68Q04v7IKv4iei6GN+uFiij7gh668kLQduxdg8cYI3M/UdhP3AcaQM
         iSQ7WKlwsdSfj4519Ot7EW9hoqfhL9RMeqhK/XjlJBlNJlTK7OVzmfmrOgzSevcI/zzc
         kHWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089013; x=1787693813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMUsfXmsN0KUu46E37mETANlAYAnT51+WK05Bfuu0ns=;
        b=EfKJivyY3Zsxyw3NllYkg2PF9zayhDDLARkVvR4uSf9RSc7ixt6ZxlN9boKTDJaxnP
         1YG+EIxNIt6kLWZ3Xz4p/5umB1MA43ySl/0qOlDbMR/ehTct6Yg0ct4HQofUmLZLlQgF
         NnSx09CX3dfDmxYlFKPKWFPbf5H8Gww4iJ3MCnXWrYOYS0rJJOtsSonGsxKciNDgzrEA
         xOa4I1VkhiLRDwD66O0SP5BwwnVYPfZWk9NGFA4+HbjclwdpifFJG0My4wHpwEizJaOL
         /F6Y/lqL+5il+WlOHzdPWKfYVB5h0UOVZ8eTRknB6JVLCvUOfknsqCcyXyclnWmXVZcQ
         TVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089013; x=1787693813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMUsfXmsN0KUu46E37mETANlAYAnT51+WK05Bfuu0ns=;
        b=tIAIfOu8XIAkew/WZ/VZHocQBW0W12CQ5Vw/FBZxxmVS4k8E+UMeiM3kyE97EwxdD8
         K6TDjA6VWn0BCi0ppVC2nrzrFblZbma04ipsT0zCFk+S2Bx8h+I5DMC3tpGY8TIvoQxo
         m83hyBsfaUQxoChZHY/LOZt/JGQK1eFtueCU+p4DDJcAm9ytCi2qamNnoDwL11UMGb8J
         6Z0a7WbdTo75GUIPqVoVVETXaqCXn8vbGABYT6lhK0xVISS3VyQkzjs9mrJ5CyMRiQ3Z
         ObUbqbzX8lfbngMiIqa+3gtnY2aGc+RLYXkbWqc6VbKGaun5UkOYC7uC29UYYyK4TmNz
         fI8A==
X-Forwarded-Encrypted: i=1; AHgh+Rq5MDCZ+SwzotV49wnRjNIL/wOWPu4AhMcuUv8wt9ahbXfUYjRCbACRRlL8TLKhl3eCWzRZiStJS6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0eqYKMT7705oriKulWqp1KnirBUS3Cc7YN4G1bJNqX/a2Utf
	G0KdMEGOQ8tfj3QnBu9ORtAyrNsKEW7KR+N7Rh1cNbxzGHrr2LLHiAbKQ7Ts6ZEJL+dhB4kTYWM
	t/2IsxmvaCwEsYsvtS2U0b2c3hFZAE/A=
X-Gm-Gg: AR+sD13OXmYThbHhQ6IHwv/o6sk5nobm7LHohcjlavvq+XWSW2XEPinXfeoJXm49ONG
	xxpF+mGS/DvisjJSWB22FOtdyyryqkYnZA28/e+fNK7Jx4635lnd86V/8FxqwGb3z8+319z1mPn
	hVMSd8jzPTnFzluM3SxuqdaYpAh6czQBfrHGk4Mzu4FIiRsNaLYo6F1Gz5FTKnNo02W98Gx5Ix4
	Rq4rBFG4ZeLU4ga7bAQlYGqRz31ogMRZ9UOP8DavXtlxfu8qNEZfifVvqz5fYQHGaPTUWD2WOjZ
	HbG5iUrYzhSJSas+8Jp/gWB2u+exA+ukOSJS9co/KhNnqLe2zunELE09Tc9hjrF+vjqdHeOStN7
	rRPFO/tBX2jB46CGXChergUgFqcy4x73bvQ2VmQfGFoTY9y3C5m6F2/awQe+VnxnXKKA8kX1HZ2
	Im6wGVLNohJsY5LChTeUj23+ts5EbTnRl/B6jb
X-Received: by 2002:a05:6102:3fa6:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-777b89f4818mr417941137.14.1787089013591; Tue, 18 Aug 2026
 14:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703152215.192859-1-richard.genoud@bootlin.com>
 <20260703152215.192859-3-richard.genoud@bootlin.com> <aoQibj7sCd6o8W6h@monoceros>
 <CADvTj4r=uBJyJdmK3T+jD_Nitg2NBs7fZgtE5p6wt9zwWgj6DQ@mail.gmail.com> <aoTMMAGbWelnjJTo@monoceros>
In-Reply-To: <aoTMMAGbWelnjJTo@monoceros>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 18 Aug 2026 15:36:42 -0600
X-Gm-Features: AcwNN1WNCOQhs7S_JPB6wAilK0gfWlIi5mTrdxNK2MAHoPVv5VHOpQRIxBhuAGs
Message-ID: <CADvTj4ovVmY-TN7u_yj6me88qNEzr_0xbuC9DerPguFGdgOEBA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] pwm: sun8i: Add H616 PWM support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:26=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Tue, Aug 18, 2026 at 08:12:43AM -0600, James Hilliard wrote:
> > On Tue, Aug 18, 2026 at 5:00=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek=
@kernel.org> wrote:
> > > I didn't look at Sashiko's feedback
> > > (https://lore.kernel.org/all/20260703153337.B5AFF1F000E9@smtp.kernel.=
org)
> > > but I would expect that not all 9 high-severity issues identified are
> > > slop. Please look through these for the next revision.
> >
> > I sent a v8 that should have fixed all the sashiko issues along with a
> > bunch of other issues:
> > https://lore.kernel.org/all/20260804-h616-pwm-v8-v8-0-db37ab8624ae@gmai=
l.com/T/
>
> Damn, I missed that because my usual check for newer revisions is using
> the sender as key (because subjects occasionally change). You didn't
> write about your patch series being coordinated with Richard, I hope it
> is.

Richard was working on this for the same project/board.

> Just looking at your changelog I think most of my manual feedback still
> needs addressing. Can you (or Richard?) please go through my feedback
> and address the things still relevant for your v8 please?

From what I could tell most of the v7 review is either already fixed or
inapplicable to the v8. Probably it needs to be reviewed separately.
