Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52B32937A
	for <linux-pwm@vger.kernel.org>; Mon, 14 Sep 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353984; cv=pass; b=QAlUWn+jl8N0GkG9hmnhzZz6h+ikJn6EjuiYsTnYATrQEy1beOTKNoUb56+UybZ+4mWCWHJLlk1OL2oZDJY+rFArrYtm1iWm1eoIuI2A9kTxV5BTpUBsTKKDiKbmpaI4CIAryKWo6L+Qz/mvMWqO14mfcX2guF45EHZc/tG2t9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353984; c=relaxed/simple;
	bh=pdLJmeXyTQ9rHJgZF5UazEIfFtz1igLOQKfDmJfXugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhzNWB5F6dFMrsjbTTLAjJqwy8FMIxwx4Qq4JfTv3unChCfddeT823dzLkyTV5RoN0Z5tu86l+j9kY1lg5j734VhjDWQwz5SLKBqP8eYb1ilD9bGIjuDJiLSc22BNdAkHPOKg+OHAPkh4V7aVFkN3FLIfjrWIG/e76UGiCPsCSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHRNT0YN; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHRNT0YN"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b5e907853eso2867439e87.2
        for <linux-pwm@vger.kernel.org>; Sun, 13 Sep 2026 19:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789353981; cv=none;
        d=google.com; s=arc-20260327;
        b=bkB4KakRGVFmOSjeV1fQZaxa/Wy833OAy/TTRfvbYVl3t4oCTODJrL6+v/CRkyw26d
         ezlGUN7yLt2D7zX/VKWsa0m690AY/CWsLoj7RRfsikXHuI7CBumdxug2J7wXDtodKpbe
         rOuZkjs2pDR3hyikAfj24g5VBjKlP2Ol7QJdMYqjszE34ggkfxF3VNto01tAz2jVRx3Z
         ScnPHKdeDRNxcFIPrdBsS1U1gWvegBk4Cyr/Ls9T7bQk+SRbrEfFohCtR8p4nYHM36z6
         2EXi2xxu2YylG3qX5Po5ayCEH8EBbhEB6Qf7UrMnG1sNVnEjQ7FHAHhm7iaQz2U/rvye
         y4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1FuJzn/2R5Scc5m2lJpVpNzaSeSlPcbk/PD0ZHGJTnI=;
        fh=QY8886bR2PLKbEhxyuLU0KoyTk1KiVCLS1bg0bgTGv4=;
        b=cgOKp8MKPyAUX0iU7cw71t4cabdHMzbK/7FEu1t6fb6GK9nmgGRnuubcZf9bh4z//0
         MlQEq8X+5/5N07mXVfwUoy+eUo+oSbTdGZVkx8BLK0nuL/uBUu2O71hBEcFCpZhCHas4
         MKgJqZzlVPP/KqSRWS4RrEEnZ1SXzurayF4ma38xzt/RxH9G61JF1h/PpJUh27O/yQ3n
         V/qbyOSSpfnzVPvKMH4vtmu0H/t0ogHAFQiNdMNrcZqneAp3RE1UxlAPT16sppQQOAUy
         c3MU1JccTZ+E/0x41jmWxdnfGqOz4DrNdQHuyhxCFKd69Ktr24qpOH/qIu5ob1iUW0RH
         WnJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789353981; x=1789958781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FuJzn/2R5Scc5m2lJpVpNzaSeSlPcbk/PD0ZHGJTnI=;
        b=lHRNT0YN1yxjkrlAM1lPdc2WLMf399E6idNIwxJWsrTL6PTkAVQcvlyPCvl5nFYBK3
         AcyPn13QqKVVRrL1zipwxIuzpUn+hZQyrfLwU8vfxMlO1Sg+/Wc/b8ssKZIBikPTpW3o
         Qfhv5VYeyTDS4rgr3Y1crm9tbApDt3VgOUSmg4HGowYFcg2iQD6Atwm+T8mrtuzpDzdI
         FplW7jJahMK8c5NcaherFUGtK7yxNILDMASgehGniR15Q0fSqZ94oqBaNSuxDJMRDdPq
         P/0+TRgkg5jJVzXDicJjiIXLH2dlZUYYr2nDCwskIOBgCIztS2v9Y18IRTjj+Bd2PmH6
         vHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789353981; x=1789958781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FuJzn/2R5Scc5m2lJpVpNzaSeSlPcbk/PD0ZHGJTnI=;
        b=Rr9PymsW60b5P10XbXwjTC2j6bPIxvBiFpS7rBT6JEXUhrZp7P8Nb3BxHIodrFKkQo
         4qnCBdw8hqwli9Ho4Gstyuh1+RM3FwqsO3MkQiAxYAVdOTn6yelWXSNBBTEgHjK6vkzV
         ydtOUigbkP4zY6sZ3UABu7Oonh2QpR7XtAFBB/VwL8anI2oi9qG36EqgAlQMbIjKehRE
         P6+LMrAuppfXaRIdsScixfBxFEYnrmNK3jhoTFSxj2zpti5X2f4ZLefs821pFo7B4Tn2
         8gJsRY5SXnhTl0pWW/6QdZs9Ffqk0a4etPpz7qTMkMfIhtC3G6JnsZTtqkOpg67U1ZR9
         0Z0g==
X-Forwarded-Encrypted: i=1; AKwUvBzKaR9Gj4VAvKzETAEXEaTymWYzIHV3Axv3y7LPAAogdprDvds1GT6zPNPHs6a7mzWUo+pqalM/UHk=@vger.kernel.org
X-Gm-Message-State: AFuF++nWF/E1JgDc12OF2obNdYyi2bLCDR1Or9Fux6YMoaVilsLBJQBm
	vsKtHCz0xmXvlwFf1P2QwYT5b7qC3v9N/EhiDNEMBf8DUNuQZeRrgPXxhychDHl5kObptFRi6QS
	ygsYLh85Z6xn668diJHgLmecWtjuRbROPRiMZRd0=
X-Gm-Gg: AYBFou1TU74XU319nw87o2oelumRmjtLAaRmVIT0qOSuAGVquF8YCokvMu4ha4hpsya
	BQIKenczmYogc4t9+oIvO+9rilxRb//sJkPlF4+RzLCjY03O3WBivfHSLiMgmteaxr9WBvc6tsJ
	CnqiSW8ZkQc6EQ9KU1/OeVU3XqBgMAOfxS4hQWifZJvgxDE3GTtfIkke2NrCxv5OYF2pfGPbtg4
	bgmK/sCkPzlMBMxQb+teVskI8RKSzQwUKasAxqHsm0tx3QeDbbQs9C2zYleI1LWzrLYuMiZlCAy
	iymuAh4BOU1rWubh5PBT80MWxV6ywPzq5BuPnxw6WiCelgdlIxOTu02U5KqihkaWM3lprf48bZ6
	3rGI515E4tJ7t8rvHNtLPTpqzUKvGOAOnZ2i2+C8a3g==
X-Received: by 2002:a05:6512:3042:b0:5b6:1a7c:59cc with SMTP id
 2adb3069b0e04-5b8ae69c885mr78058e87.38.1789353980592; Sun, 13 Sep 2026
 19:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
 <20260715-pwm-loongson-fix-v3-2-0aab2847eaa7@gmail.com> <ap6Ciw_sMALvlROd@monoceros>
 <CAJhJPsULo0S5c6GKQvRqLtVx3nixZLuqRrh7hi5yJ7C5BuwLUQ@mail.gmail.com> <aqK2R9HodI399ehb@monoceros>
In-Reply-To: <aqK2R9HodI399ehb@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 14 Sep 2026 10:45:43 +0800
X-Gm-Features: AcwNN1UbS5KoKs3oMsJvuOYqiNKtHepxzTF7RNhGPEaA55gBaJPAbm_T3WS7wqQ
Message-ID: <CAJhJPsUpefK7CQjHY+e9BQt90jQoTEf4ki258z4f--G-ATjKkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 9:54=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Thu, Sep 10, 2026 at 07:58:12PM +0800, Keguang Zhang wrote:
> > On Mon, Sep 7, 2026 at 5:33=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> > > [...] I wonder if the fix is incomplete. If at driver bind time
> > > LOONGSON_PWM_CTRL_REG_RST isn't set and there are still wrong values =
in
> > > the shadowed LOW and PERIOD registers the first period will be wrong.
> > >
> > > This would need:
> > >
> > >         val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > > +
> > > +       /*
> > > +        * Ensure that the values of LOW and PERIOD are sampled into
> > > +        * the shadow register when the hardware starts running.
> > > +        */
> > > +       if (!(val & LOONGSON_PWM_CTRL_REG_RST))
> > > +               pwm_loongson_writel(ddata, val | LOONGSON_PWM_CTRL_RE=
G_RST, LOONGSON_PWM_REG_CTRL);
> > > +
> > >         val &=3D ~LOONGSON_PWM_CTRL_REG_RST;
> > >         val |=3D LOONGSON_PWM_CTRL_REG_EN;
> > >         pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
> > >
> > > I think.
> >
> > You are right that this patch doesn't handle the initial hardware
> > state when the driver binds.
> > Would you prefer that I submit a follow-up patch to address this, or
> > are you planning to fix it yourself?
>
> I don't have the hardware, so if you do that and test it, that's very
> appreciated.
>
Sure. I'll add this fix in the next version.

> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang
