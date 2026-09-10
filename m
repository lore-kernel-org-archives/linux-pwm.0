Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF847A87E
	for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041533; cv=pass; b=SPkp+M4LDWFKf30a5JQzW+AsO7kDBuBIMY3T0kjjYZCz+SCqkWjY9pAXfg1sncUMd2ZpHRFLJ6uGPL97uowIEWeQLm6n7Zg7Cd+oxpvBcvtEkYa+I1P78jye8fYMC1c+Xpyd1XjQJIJ2gLRMHWzufpumP02D4+l5eH8HXKiPF+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041533; c=relaxed/simple;
	bh=Oz1LulEoZCmAxqUQgT4oDLzqt525f0rp9poj1VjkB2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZs4ZOHWsHluvSHHkOpnQcpPWXwP4WNToUvC4kSkFA9a/hJnoHOxT3oTFXgS4JQFXUzRHdkxPu8uBI/ESXQeE3dkKyElbirrI4kUG+JG5D6qXM86uPVk7auG+XGpQjLcCy7Uw8KEPJqdUg3xcCxpvyktF7LEUHB5uCMWN7T2nQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo38h6a0; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo38h6a0"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b7a9882e19so1737736e87.0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2026 04:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789041530; cv=none;
        d=google.com; s=arc-20260327;
        b=hc9LoxR1TfEFXKXIJWNGH+mbK8sEn6sa845gLX8/MPyCGB/dBexw1hlLt1CD/u4+su
         76rxxk3PnLP1rY+GkCGHXURTGhv2KBHZ3XMAO80LCKFoiXVh02TCEhBHOMiANMnwyORX
         C44cbfecejZtaWyLqUihl6eJVgmmdG7mUlx9oPeO3cfbRzniDyzpsJXyT5QIG2vAUirW
         qXFPlenXRoj75pLGXfV5DEqXodwWZYR0/5JKydO0+S/TNGT/0m3RrCzNkH0uX+rxz4sR
         vwH6YwHe7v2khwlAaNA6TqzkSAUvoR9eh0z60D8TvCYs0flNq+odM64Q6ugsfn9iOcPo
         mA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CdCq+JZDbLIOXTO7pq6t6EN3rk5eBziqfXX3TMvHcq0=;
        fh=UbvAfNJmkXqqpJpUBYRDWZIhchEQuh8XpL7TgvSBH4Q=;
        b=cmMUwPPnziDY/PU1VVCOrGiFQ4b1l5C6DNufMzAzH3b65x26o0HStWpfkmFNr+Sp4x
         wp7SWzteWloJOVoSW2kFKwf/uM7MXMnh8vP0dbpFkyhaESyyYchCdAm+HoXKQdZ1V0Yh
         MAisj01Gitu+xAtcX51MaRLRBkVgyBd5odZcXX1X8S96uOelJsEP0wfNEhwZ0iMvjAZt
         rhwBhGEY+GSTnus3w69VAKojLSY3YuNVI95ZdoMQq74fcb7o8j/wMgRxNkrIKS00PQeU
         NZsqhYbGB43MYFjNovtBHUystXog8u2HppOHBFSr5u4ANyr14/+V6C54HY0oB1xRZmQn
         OZkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789041530; x=1789646330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CdCq+JZDbLIOXTO7pq6t6EN3rk5eBziqfXX3TMvHcq0=;
        b=Fo38h6a0r7iI7X0QMd1FPpIj0gwze4yJeSaE0RJqAz6t1N+UEM/w+ry/7IFot56JOe
         XirarPsDCG7ENDd9C65Uc/dc01REHh+wbiBPz6tLPZ2dvX0FqU3LJkCmi9VXrFgF93M5
         UilItQfssXvSdyBkRdO6nL8BeFUplLahyOnmFphrXUPI25sSuePZhIutXP3oQ+2riJWm
         vYCJuNOrswKRlzCzcEqAgriQ1XyzDipYIYcgUswFM0FQjHaoOoaLKzAJKYJU2QQ/cZZL
         oAshEpQDNY5ggLonBybzrF5O0AYkQnl+SwnGzZ52AAD/lAPWzaoT/04MP3UoUXj+IqVL
         /iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789041530; x=1789646330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CdCq+JZDbLIOXTO7pq6t6EN3rk5eBziqfXX3TMvHcq0=;
        b=UDxnQgVZKYK/49ZNmFhi62g988nUm1ynpDXHlwFruyB5C2TRNWEh5+93JBsun+le7f
         /ZkBVyB5HSwPjqLsEVUT5uqkZU2tJSWPoqvnVxUj/o0/LgNF+FHBHu08JFNdTehZUWHh
         qAsxBVQucgarM1urjHAERqpo624P1aRS977xmckqw69JJA16IHVunFcZL5aCerZw5cpv
         /fzqkhSLhHvGNiiTkCySvCZRyPM5xqNcHTWqgvRjv5ZjYgoDQxZTbE/4cDASE1Qq8Oxx
         mRU4DqV0VTJp6o5LVS2v+hSlaHH0tbGCCDwlPY7Zr4TliyjAGK/y7fVwew+23QK1B3RY
         E+rg==
X-Forwarded-Encrypted: i=1; AKwUvBzBw1DgZZDErYbyxHaS4+BunbGo6cgSJjCp1TuPXLqgEtonJQKemIIYvRE9B6wJiGB3Ls3D9JgomiI=@vger.kernel.org
X-Gm-Message-State: AFuF++l0EGLug4oS/o3IckWXfCxDniLLBLUBuQ/JEMFWDExHmbO1Hq9Y
	N2RLvoHL8KdYBXJcCKCpBas7Kb1pY6ovL3XMexATL/+T/F5VcM1Ng9j4HAue5q/PDsIHAJ0nQRB
	/Ap8+aIv+KDiZn5u2aW3cLa/It+dJZklsfWBEIiI=
X-Gm-Gg: AYBFou2YFTMJ4g/tvgQQEFKSDMq5/ez5BOHsRiQLFkSmEHH8QiprH5DwqfKOFMa4FA/
	ctGbUqakZ+Y1pDKDgCkR9pn/ZskEPVYJYtIxvCnKpvx4X2SzU9Bp2ytgyU+GQu+ssg2Iod3d1Vk
	p1M3IP1GdLZdqFv46iHy5WIu1cBLXVVvKSFXTgDJ81VWf1P9oWieXZX3mgS0NIGvLEHjrvqYJps
	3o68Nl8j2Bs6T4tf4p7X+U06vIzny8bMjvfp0MyJwbNS26oD+RCQuIQVTrK+n9MUJaJnlmGXSQI
	4h/GpM/B7sVU/HfNJJc5qGX9IEG/RushumvpThahvYr7k3t6/mVaAaVKq7IA4y8NdaT5cULISOt
	YBmFtU54LeEx/UDjTEWKXtdjg5/gVYbGVTy5jdU4ixA==
X-Received: by 2002:a05:6512:39c2:b0:5b6:1a7c:aa0e with SMTP id
 2adb3069b0e04-5b61a7cac9bmr6765207e87.38.1789041529833; Thu, 10 Sep 2026
 04:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
 <20260715-pwm-loongson-fix-v3-2-0aab2847eaa7@gmail.com> <ap6Ciw_sMALvlROd@monoceros>
In-Reply-To: <ap6Ciw_sMALvlROd@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Thu, 10 Sep 2026 19:58:12 +0800
X-Gm-Features: AcwNN1WqM76-1CTCi4acvnKmIrksLRk8Bw3Ze42EYukAfTFF0nd55VZdBmlvKUE
Message-ID: <CAJhJPsULo0S5c6GKQvRqLtVx3nixZLuqRrh7hi5yJ7C5BuwLUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: loongson: Reload PWM configuration through
 counter reset
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 5:33=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@kern=
el.org> wrote:
>
> On Wed, Jul 15, 2026 at 07:05:24PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > The Loongson PWM controller latches the LOW and PERIOD registers only a=
t
> > the start of each PWM period. After disabling and re-enabling the PWM,
> > the controller resumes from the previous counter value and completes th=
e
> > current period before re-latching the updated LOW and PERIOD values.
> >
> > Reset the PWM counter when disabling the PWM and release it when
> > enabling the PWM so that the updated LOW and PERIOD values are latched
> > before the PWM starts running again.
> >
> > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  drivers/pwm/pwm-loongson.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > index e703217a6d5e..c317d62fe813 100644
> > --- a/drivers/pwm/pwm-loongson.c
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -103,6 +103,7 @@ static void pwm_loongson_disable(struct pwm_chip *c=
hip, struct pwm_device *pwm)
> >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> >
> >       val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > +     val |=3D LOONGSON_PWM_CTRL_REG_RST;
> >       val &=3D ~LOONGSON_PWM_CTRL_REG_EN;
> >       pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
> >  }
> > @@ -113,6 +114,7 @@ static int pwm_loongson_enable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
> >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> >
> >       val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > +     val &=3D ~LOONGSON_PWM_CTRL_REG_RST;
> >       val |=3D LOONGSON_PWM_CTRL_REG_EN;
> >       pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
>
> I applied this patch to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
>
> , but I wonder if the fix is incomplete. If at driver bind time
> LOONGSON_PWM_CTRL_REG_RST isn't set and there are still wrong values in
> the shadowed LOW and PERIOD registers the first period will be wrong.
>
> This would need:
>
>         val =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +
> +       /*
> +        * Ensure that the values of LOW and PERIOD are sampled into
> +        * the shadow register when the hardware starts running.
> +        */
> +       if (!(val & LOONGSON_PWM_CTRL_REG_RST))
> +               pwm_loongson_writel(ddata, val | LOONGSON_PWM_CTRL_REG_RS=
T, LOONGSON_PWM_REG_CTRL);
> +
>         val &=3D ~LOONGSON_PWM_CTRL_REG_RST;
>         val |=3D LOONGSON_PWM_CTRL_REG_EN;
>         pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
>
> I think.

You are right that this patch doesn't handle the initial hardware
state when the driver binds.
Would you prefer that I submit a follow-up patch to address this, or
are you planning to fix it yourself?
Thanks!

>
> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang
