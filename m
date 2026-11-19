Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795116454;
	b=D9iDvRVhi5NyOtE9FnRo8lwixH5ZbxvgYCxT46fyyYKAcrPoJYkDqPIH59t8wrfmrxww
	 cCd7g1ACLw3Mvd8J8Zop4ZRb6965Jm7qz771eOmPHQwpDHywLVUBbhbgfnIKFMPhevAaQ
	 lSCycG3cenKNrXTWmGXGMkiHfordd8fn49SFX//lTJv7iOHqV4NgKSaQd4OL67XzO7c7G
	 ofxPSji/gIMZVkCUQelpQMIJHYnz0ZaEuMMOFk6VUaqHbNQpm+fH49YyuQDaEWPyxIOgP
	 EJtuNCWoJMFFjnqmIjqcIscvOBHaX+0gi0ACjQHjBx/tQN8G/ssRQVN5lo9yYBiD6/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FPIyTZ2xa6J6Vt7L8hxmnU/vzE3cyAtAe0I7exZtDE8=;
	b=NiSGdTGcZsC6pJFDOwWCn1ub66a8xbiDOsSKmifuLaOTDLDw11zCDQtDOzh+6LYzOG2F
	 mmbcdqcJkZ1ivmMT6hYJ7zb6ZjSOBs1RPynZPceF5sFnNQ5y03wgPr0Q4YMFGJJbbRDbr
	 y7EbPe/xX0egAzXox62LRQJw68cfuDKdN54qNeAwYtc+i0pwGc5SG2YF6GBhwz9TcqCou
	 aTRQp0qTUpXZx2eIqin/BEBDdBWY6lfWX8AOEVl7cjWeaZvbFg3aZUZ/pOcaU4I1DhkWZ
	 ViyYtZCDx3JLrxSc+dFtVd1Rm3Tsyt5y5JeW7VTWk+hA7veBKrJuVBSawDgbdnuwFNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VkFFn/FB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A162606A325
	for <linux-pwm@vger.kernel.org>; Thu, 19 Nov 2026 19:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A162606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkFFn/FB
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so775175e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 19 Nov 2026 11:27:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795116452; cv=none;
        d=google.com; s=arc-20260327;
        b=IXyjyhCeiHuabA+y/Hw9IatkE73nD38N//N19u37WA4mUtANvwv1O0Sbzpgd5exJYs
         j2PFe/uURAzrj1KbRGl3hY3dtwuOViQLNIcH4ZTQGKfDZYbhqVD4yU0Uasn1IwkisKTB
         aQ9y/Gixgstvr8HrF/fhWYugJ+5Ob4DRsTnSki1LrTlKS0ZHpiGEZF4LMpYS06u0of4u
         WDi2Ez6afwccNZHNWOFvX4NteqxxQvFZK7CtCRQiFQkYlyE9nr47cAGt9Zg4D/x/UTYI
         /sdpOs4oI726MOBqHoGBpsPVg4Wj1cR1y1IH+o6xLeLRvgsqab6LZCnM1SlIUyIkJ8y6
         m98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPIyTZ2xa6J6Vt7L8hxmnU/vzE3cyAtAe0I7exZtDE8=;
        fh=h9sn36VfZAcNMDAWw8CdFl40MQ7yt57AhrjtFzJl3Fk=;
        b=C2Wy2qh/z85jdofFpJGrjFaUZ1/+Uyn73QPdp8B6SQhY5igVIwuvv7abIz79fY4I2v
         XT7rftcL95Kr7Z6L4oo9UC4J5Hqh4WbbSmBeJcZHCCkxA33MSGLzMX2+i4eERpcV2UX9
         U7cj2IkbmY5W2h3X+Xjbs3hICOoev2nFU43vCZP6EQa2uOOKMdwCjAuVwm2J8RHN3Dg3
         gY9PZx9DwJjcfn5yOr/jEfKfaPX1NJ6nn4+282Fu8gFMPQIGSrBHL2RWE3A6k5H6IIbQ
         j31E5YHdjbKblao71Pk1PULCXvehRgRw7HEZxHlS9hVWLTBMNHuDEda48c0zCiF7RBNf
         PBcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795116452; x=1795721252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FPIyTZ2xa6J6Vt7L8hxmnU/vzE3cyAtAe0I7exZtDE8=;
        b=VkFFn/FBZCLe9PgTyNrmnAq/uufmOi+UyRXVGBmQWSIu/r8UWqjt/HP515Qu5nBlJp
         ETcoKaXT4Clsgsn5VHz4Ho3qFRRpEUrgP0IpWu9wOPCwCM3yJLv61MwTrv3G94Qh6RBg
         kLIODUYBkKHSEy/I1WtRXnMgwuNUld3Mt96TeV8AwvpOIdSE399z91S4iAFtaQzzXA55
         fFvuJ5+fkYnAV7B8cX6dn+lMoJUk461roX0hRYuNQv4NDtZfE91IBV7O8EvqWGkE3n/n
         s1n3oTLpnzrh12mDVoq4Pe6a8Q37UdS35001ihHg+Xd5/cJbYW5ANCuEW+IbS1TD+nSr
         AcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116452; x=1795721252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPIyTZ2xa6J6Vt7L8hxmnU/vzE3cyAtAe0I7exZtDE8=;
        b=gN15+PxIGBjHaPfmbc4ilza5BiJI3cW6tg7P8yXMBJ+T1VWlobbFcwvbg4I68jMSPx
         UWZ8ABzeBbAcP0HA9kXL8Ur1fUPqwgq9vvYu0MFpeW4vSb8zyJqaoUWAScpoxQ39NvqM
         IMyYqjJwE0tJ2j5DOBO7iy9CvpKkIy5tAmehgKktyNOOSHl00rAF0SM9iWIrl3XiyKlz
         TOi+ouK/6cgmunUBoaKcOMqPp5ykjnaFQ3yMnRtxsCs3cyIsoRs7bxVnd+4E5N0ISLNX
         /GRXLAY9amBOQhTt0JdpRJbfqJhxM1WoiTvipJmETgMvKitULV2Z+oA3XvcMrV0qg22f
         6/fw==
X-Forwarded-Encrypted: i=1; AL+hErFv2iy9c7ZN0Vyjv3KsbJOTt2JGLRbat6nzRUbiGzI2o9Krxi0g0s+xxnZYSewec9JB1NlYNoiI2nA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+admRsU841C0orK7w/8c/ksh6SIXlqfFjWIFfW4D8Oeu/2Eo8Y
	NzKa09Lew+eVUSxShk08rx8o4UaKHDm9J3v29+Cp9fFCcj9qMsHLA91gTqnc7o8MPLL+8AovZ4D
	dEdiBJDeC/ivrPIX6GEaMMqD+1veOH3SFKE2EhUzn9A==
X-Gm-Gg: AYBFou1TdXkKnXGUBQ+brFUcm5HhFUe1cH8E7OH06uSU0ziW+fRxdqA44Mv4Q6J1vL1
	2wKGOXIBI4leHXtEy1yWyDEzOT6+pPYjuMIpos0hLrhc0y1sBiwlOV/0CI/NLB+GL80IsA7dBFu
	AUkjs8csm0Vx4SX0TjzLH1kP5GLsrlki/5pL8Ln1P/m3plulBXFsQBVawiZtvF81s7ekud2bWW+
	FYCDc07Ag2CUdO5YzTvvXTrcABP5Kree1Yv63CqPltUxZwgkbLSVACzoe46eYTEZkRffoJszwaz
	IgPsryFORgG58OC85gPglJTZJeaOzvJ/jQzOk4kpgFaWZf01wcDDuYIDCJmAdQl279wrmIl6yYZ
	KQsq+10KGD3ZXRvwEVmCcgCkMtUuu527HYilsRnKvRlD6atIG20UVKyk=
X-Received: by 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id
 5b1f17b1804b1-4bb887865b5mr15236975e9.0.1795116452430; Thu, 19 Nov 2026
 11:27:32 -0800 (PST)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-pwm-v1-1-adeff0cc366a@gmail.com> <av8GQXBbkf8_sHhX@monoceros>
In-Reply-To: <av8GQXBbkf8_sHhX@monoceros>
From: Wong Steve <shyckless@gmail.com>
Date: Fri, 20 Nov 2026 03:27:19 +0800
X-Gm-Features: Aa3M54qACejcwQO4GeeUlTAXh5NBJM7D7iB7MZWZSjS0J-bqqH1dxZQ9I68b4dg
Message-ID: <CA+X8SdijifK4VwyTWRq8ki7yNrJe1HOHfNW5J1-UamJARkeGFA@mail.gmail.com>
Subject: Re: [PATCH] pwm: Don't dereference the chip after put_device() in __pwm_put()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: m.wilczynski@samsung.com, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Nov 19, 2026, Uwe Kleine-K=C3=B6nig wrote:
> I wonder what ensures that the compiler doesn't reorder put_device() and
> the assignment to owner. Maybe it would be more sensible to call
> module_put() before put_device()?

put_device() is an out-of-line call that may free *chip, so the compiler
has to do the load of chip->owner before the call. But your way is
simpler and doesn't need that argument: pwmchip_release() lives in the
PWM core, so dropping the module reference first is fine. I'll send a
v2 that does that.

Thanks,
Suyuan

Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=
=8819=E6=97=A5=E5=91=A8=E5=9B=9B 22:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 19, 2026 at 10:56:17AM +0000, Suyuan Wang via B4 Relay wrote:
> > From: Suyuan Wang <stevewong@hust.edu.cn>
> >
> > __pwm_put() drops the chip reference the consumer took and then reads t=
he
> > chip to drop the module reference:
> >
> >       put_device(&chip->dev);
> >       module_put(chip->owner);
> >
> > A consumer takes both references in pwm_device_request()
> > (try_module_get(chip->owner) and get_device(&chip->dev)). The chip's ba=
se
> > reference is released by pwmchip_put(), not by pwmchip_remove(), so a
> > consumer can still hold a pwm after the provider has removed and put th=
e
> > chip. When that consumer finally calls pwm_put(), the put_device() here
> > drops the last reference, pwmchip_release() frees the chip, and
> > module_put(chip->owner) then reads the freed chip.
> >
> > Read chip->owner into a local before put_device() and use that.
> >
> > Found with a static analysis tool and checked by hand.
> >
> > Fixes: 4c56b1434b81 ("pwm: Add a struct device to struct pwm_chip")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> > Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> > ---
> > Compile tested on x86_64 (W=3D1 and sparse, no new warnings). I don't h=
ave
> > the hardware.
> > ---
> >  drivers/pwm/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 4c6d716e5fde..8988a7dbe5b1 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -2020,6 +2020,7 @@ EXPORT_SYMBOL_GPL(pwm_get);
> >  static void __pwm_put(struct pwm_device *pwm)
> >  {
> >       struct pwm_chip *chip =3D pwm->chip;
> > +     struct module *owner =3D chip->owner;
> >
> >       /*
> >        * Trigger a warning if a consumer called pwm_put() twice.
> > @@ -2038,7 +2039,7 @@ static void __pwm_put(struct pwm_device *pwm)
> >
> >       put_device(&chip->dev);
> >
> > -     module_put(chip->owner);
> > +     module_put(owner);
> >  }
>
> I wonder what ensures that the compiler doesn't reorder put_device() and
> the assignment to owner. Maybe it would be more sensible to call
> module_put() before put_device()?
>
> Best regards
> Uwe
