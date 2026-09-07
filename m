Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0956468C07
	for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776654; cv=pass; b=i0Sa92DU903vOMu9yIlBuvGHP/tBWGrWfVrBYLCkrdd6NYsAppALi3tAjCUPk27b8zB5UOBPT5nfEn1BMN+RDpDILCHTP+8xbrgDSk2dXn3ejrXYiZNUm5193gg4DEEB1IV6ynGSfFTEnsSLhj/Q8cTMwIUU6dCb2RrLmbvuIeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776654; c=relaxed/simple;
	bh=h/kK0qgc3s1x1TQMI8jdSnMsN0cifMF6ehU9jP5s5Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAvmDQMCS2yI9+geUhbERBFYPhbcaLgG1xn/ATUmXD5+yA3jQWugeoblbXEE9k3JkQOJJczu2X0xwUQuNvpYRUg5jQW2yJkLLSTKN7C1cUBU+ULVdSdNOiDCUmS4bcXQ/M27cq+OLuRKzCbWCRbOcp5vwpefk+tcBWszFvq7iYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgr03dRc; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgr03dRc"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b4adcce4b1so2227700e87.1
        for <linux-pwm@vger.kernel.org>; Mon, 07 Sep 2026 03:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776650; cv=none;
        d=google.com; s=arc-20260327;
        b=hkZ8g3lKfy2yMviXTBYBgLpH7FQ/v47qGns1N0xWooU0CjIK4tl/aXNiV8ih2f/4Wa
         FO47c6qt2z/5BJ8Nh/P84s0Yxfi2ZjXlGBbiQ0S6SYsh6f6BEZxQysUmK0x/C5dI2OC2
         DLM41qRnwCNplQUtcobFRLAgAeRNDHCS5k+SzAnnSG4be+otuqd1S3bcZ5+UMkvjMfly
         GizUbCLeXSkzHQj/v1e9uO2QufsDFdkXnBc35WGGqMMIBMsnbLP8XZ8ywrCVxlRrZtVB
         NEGDyLjYMR76D9HYQirfNN8wQDAepclGKBg6lMVYN3DDBn3ao/YVI/smG8QFizzLR3dn
         AxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sze87sDIvAPUcCAz3NKWqlz/aBkj79Wm0YpeNvsJ+BU=;
        fh=AhE9uigFlljOEWO17wpq75EJ34vDZC2ObdXPdsQfmmc=;
        b=deVTb1JYSqT+KuBeBsGmcNazDSj8s48180xUxFEXOr4doSzf/XIzzbCKhDLchu8iOa
         g3ZMJ3Vxtz8AIUYRa4bofSssQRFvfCzckON+QK+BUjnT+yJsCBctpHulojntetKfWFd8
         ijYuBMUwCbL0D77yuWxS6tnvkgLTDdaKmXD6AwlddClaDGwChURzY6Ap09LQ+3lAByiZ
         w9/JP00+QliRhzoWPLaxwok3VtjaK7vAX0Hru23Y57oCE3j0W6O4Al68EBlv++qedW9j
         9YeWOO6C1XgDIwzVmwk05fRI5N5joGInNxDdP5On/rM5ZvIkXdW7SsXxD1Z+BegKIsKV
         Y0SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788776650; x=1789381450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sze87sDIvAPUcCAz3NKWqlz/aBkj79Wm0YpeNvsJ+BU=;
        b=Wgr03dRcOSIBMO/sLdJQl/nJrsMIGnH67SaaVAfPca/7ZU7/8/RHqil7B/lTwDlN1f
         MZGGpGcxo1RbE+yAWILAwtt6ZI0FRZiUblL6qY7/PPTUJLE817FBSPQhnxV/sH7Qggkw
         tPKXn0+84//AF7Ljl0+4X9/8Kvk1tWEEuh54u7HVnVa2WYDk6pnj/p04TddlZNMDh35I
         4UWMlAWe1Tq5hmn5fem/TNXltRoqRoaSxpOLf15Zyc0F2dhkX+x2dBTVhppS7YwSoXZl
         cGonFPp4pnBAZ3/aC1EwtbkimnweLeg048pORJLLUpPmU4GQED2A02Lu2gDLGGqG85IV
         OVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776650; x=1789381450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sze87sDIvAPUcCAz3NKWqlz/aBkj79Wm0YpeNvsJ+BU=;
        b=cm6Q65/YPEWmEOLyYJFCn7+wIWOXGbKSqXXzVhocIyBBRW3teY3ZMkWKhF2/4E43So
         MpaBWI+dG9JOqLGeERvLfOsuti90bROAO6g+LNhlxAl27OTocSih4At79fZH4lPWQFky
         O60Db/b+r1dnT+vGtnuHqwhKZm+prW7QlvrG5/QGQ7nH6yZeAJhmXaUouiCRhigb65Ss
         Vf6GcZrHuqFWoXbFrgS/V8nnIo/gAgF2bNcG2T40vJWzY5GgrMeWl82Nxj8pVQGdJVRv
         +8LmAHKEJxOCyN/CBs/6dgnbaCfKqNevFosGjpqDnLupKI0edO5skVjU5cGbiYQu1Exz
         Un8g==
X-Forwarded-Encrypted: i=1; AKwUvBzM0Mg50NjMW/u6Vli2OZFuAxnu+Q3GYseG+PlqQlP0WxhPh6KRMDwqXI+/Wgqy1Xt0SqEIOsAuksc=@vger.kernel.org
X-Gm-Message-State: AFuF++lNaQNxU2aI7/Xi7bLPEyFMTt2VQ6l3gQg9knmAw6BhGWjV07t8
	ZWobyDhakEZmI4HDLHjsR5d5SWS2/F9U/sfEJIswHEtXNaHX7fZlj1wdrtFoDaeDX55qEXui1cd
	qaM81CAyw1in7gkD9ZEvd+j+PnrhZcg==
X-Gm-Gg: AYBFou3R/utuoTsQjfGNqqGzWdlwkFfnwkIbMUnZOOVwi0lzwEOTclu5K69kREw1HoK
	FZkf9jJFGn6hfPHgBG5HTmAD1Dg+78kpMdAPeBx5ZUAVnkUNzWwYvpBMLAfzHsXsFVGZriyKoKw
	m56wA8str24GivsZyVVors7YN66W0Ol4y9StI3wqeqgPBpQggnbInwqStcBhlH4StHWfPKJLQ0f
	DzTCvbYhnhYY3yiLfQlTtvc4LqHvl5KV+7FqHT+C4Fj7CgSZRzYbbahtu9YKsmIO9Fvlse2alXx
	+n4dQKy4mQAFvjxvvJUaE+JP1Fv27gNCze+cnsp48ui1PAZvAKbIEOZL+7wpZEYkX75p8Ai4rI5
	BpZXWWITcwNnvg0U5FMCJILZ396IofZK/
X-Received: by 2002:a05:6512:3da3:b0:5b6:424:2b07 with SMTP id
 2adb3069b0e04-5b616f544damr5671815e87.32.1788776649388; Mon, 07 Sep 2026
 03:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724044854.33274-1-kr494167@gmail.com> <ap6IbbFqQsBvVSm9@monoceros>
In-Reply-To: <ap6IbbFqQsBvVSm9@monoceros>
From: Surendra Singh <kr494167@gmail.com>
Date: Mon, 7 Sep 2026 15:53:58 +0530
X-Gm-Features: AcwNN1VZPpr0mAZsujEXg1kHRGcC9qS8uQ3m7ACzH5KEHhyJBpaqpcIVWIJYEmw
Message-ID: <CANA_=K2DuzL4h37KTEh15BAtANk_c8tc6h9DqNnJu0e649b4Jg@mail.gmail.com>
Subject: Re: [PATCH] pwm: ipq: prevent potential 32-bit integer overflow in
 hi_div calculation
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: george.moussalem@outlook.com, quic_devipriy@quicinc.com, 
	andersson@kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

Thanks for applying the patch!

I noticed this during code review while comparing how effective_div
was calculated vs hi_div in ipq_pwm_get_state().

It can trigger easily on hardware whenever long periods or low clock
frequencies are configured. Specifically, when (hi_dur * (pre_div +
1)) exceeds UINT_MAX (0xffffffff), 32-bit multiplication overflows
before assignment to the 64-bit hi_div variable, resulting in an
incorrect/truncated duty_cycle being reported via pwm_get_state() to
userspace.

Sending it for 7.2 / current cycle as a bug fix would be great.

Thanks,
Surendra Singh Chouhan

On Mon, 7 Sept 2026 at 15:21, Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> w=
rote:
>
> Hello,
>
> On Fri, Jul 24, 2026 at 10:18:54AM +0530, kr494167@gmail.com wrote:
> > From: Surendra Singh Chouhan <kr494167@gmail.com>
> >
> > In ipq_pwm_get_state(), hi_div was calculated as:
> >   hi_div =3D hi_dur * (pre_div + 1);
> >
> > hi_dur and (pre_div + 1) are both unsigned int (32-bit) values.
> > Evaluating their multiplication using 32-bit arithmetic before assignin=
g to
> > the 64-bit u64 hi_div variable can overflow 32-bit unsigned math.
> >
> > While effective_div explicitly uses (u64)(pwm_div + 1) * (pre_div + 1) =
to
> > prevent overflow, hi_div was missing the (u64) cast.
> >
> > Fix this by casting hi_dur to (u64) before multiplication, matching the
> > precision used for effective_div.
> >
> > Fixes: c436e3e9c265 ("pwm: Driver for qualcomm ipq6018 pwm block")
> > Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
>
> Applied to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
>
> . Did you find this issue by code review or does it trigger easily? If
> the latter you might be able to convince me to send this patch to Linus
> before 7.3.
>
> Best regards
> Uwe
