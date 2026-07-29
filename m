Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD4331ECF
	for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351974; cv=pass; b=p2wrjIB3lCMKhpWDlV3P9C2jaKq9kQhRaM4+7mu6xzY9kyXRNKKnLpo1dc2g27UXXghjLxkGEhm5x8f7xQC7CBusjuyEiHixbBY43oWtq3RFw2mxOfxGjKOdUbof5gMmHFfCoJuJrrcQCpAbPkx8cNnmkDKuwE2w2ve/2E6A0A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351974; c=relaxed/simple;
	bh=wAdu72A3DEXoTjZcNRaRdihUUTgd1Kv+JghHO10IA+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs1Ew76AbkA+JY4i3hHx2CSsindvmJ+3SQLAXVufbidy1m4jt99JdS646XMj9PH3F2HSSLydVfuzAqOnNbu/Yq41ytEVFWQ6H+9IsMsKG9nGLynWh/aVBZyk9zQaVO/tV1XNNrPuzeKWO4mNwv436aakiLOefg8sbBF2I9ijxjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XscG826k; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XscG826k"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so1431478a12.2
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 12:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785351969; cv=none;
        d=google.com; s=arc-20260327;
        b=mevLTHidmqDlXt/VaKuzs2FUpa1Wnh2MuHS3Gr/UcUP1HBOJcloEvmw56QpCM6zzK3
         ebqw6oWywek9oZU7rb15Uz+es671+srP5AcgMmd5GajOwPr+5yILdqnQElu1Yi10JVpH
         TPR1bSsZGSkNkVJbzZ8podzvtUuu3oB+VfVR43GGh8blmWP0R/VodNZiWPjPDC0q6Bgl
         TH4dPc37wQax4ix7G4Dcw6uEuo61sgiTSoMDnhY69wW2WIyYC4c8TNFfKTrY5sisKiCr
         BUoddvRJHvqslo6NWTUDFLcqc0soaBIqZYpF2DhPMPUFwz3KMmbY08BMVljxv5NohtAx
         wU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DZXBsryljzvRAdARemAvVq8vZ8/d5uAOMgvUJOrxQGo=;
        fh=Fewb33uLFtp6esmQJm2y8r9UVU20cjixqS4jlNJm4XE=;
        b=mgsHO1aI8AICIi+HpNFFU2iQouelbCpNZRJw5oDZFhTxE3gMKNwTBFFzZiTR7ycivx
         /Lh9pOgMWgknrVs44ZmfLiATs2RAjzRMeEfoLAAFi1y1Wy9HO9ueq6MzhGIATahHgfAT
         lcQphAqSB6CbUEBzzWmHCNVKRH+vU58UZwe4//Q5kSEiovA8IW1s8/V0GCOUczXOeNry
         f2LnZPQ1QpvZj9BFG+uM7dVubnv/Ne0dg+p6ECK55Sr5kJ140L1kjK40DnBAk39VWp5d
         YqCLkOr1j5webL/NtMhX7qJWwiS35vBCT4OrBVs2hfmWzPyRWylucIqzkcSr4jM4TfNi
         J2rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351969; x=1785956769; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZXBsryljzvRAdARemAvVq8vZ8/d5uAOMgvUJOrxQGo=;
        b=XscG826kFPsTzf15VIzEtkWguGRxdeVLX7qphy039ovATEVGGy32IpTQ12b0OtZDQG
         /7Zkv/y+A7alqLq0ecD2i46Q3iCutF08vhukdOgck0J9AmGq8NMrPgD75c9VXFI1ekmp
         KRc3Z5RddKb0QEkRKQhFUgIlpAzT+hnWzmhk1Hf07vXiMKDMJddeyItDE1yfhN7sakbi
         GEe67LsJgguOS63Dwz2jlJPctXHujr6DXCJ361CQMu1syXlWMwumuNzroORgPuzxCGsI
         f/9jBQddDcWNbyg0wQvcltfYpKw/fih6E4z11rK0F3oY0FEQ1x0MjNnDD3aC+upqkzyg
         5Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351969; x=1785956769;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DZXBsryljzvRAdARemAvVq8vZ8/d5uAOMgvUJOrxQGo=;
        b=OQT9q8XrYLks2whpfMNG2/I9va5k5T/kuSr62lw0L+XEVHvqRknAmskrbj4h/r02Yg
         QmNqO1qENPmIGyPH/QRikIuYBh81GmIlShYEdWzm5Zo9S99lM+XXxQRKAOkk6/JYR51f
         H6A3UJCM7yk0UjN++72eNJSrj5OrRomCnqqoEvgtjmSfK8qJkgnVaHvthGc1SRuSV4MV
         qZM/RT5Tq9FwV5Yo3aH9pj3HAz9gfQXLa3oQjFY9ja8o3Glma8FpLpqCt63MMWTPRqF4
         IQ0myL/YP/lOkLR3h0+BTmN//8DzzWl3VvbG9ub6hnTtbTyK0CDvaYW0h0r87j4MoXb6
         RFVA==
X-Forwarded-Encrypted: i=1; AHgh+RorKx0gtUJF3yqRfQyqE64UUw4csEE65N7620eHxCtL1TwMpy5kUFxUR9lU6GIU+fws3Kg19/ih00U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ve7L74stB3HrZologv+Fo+Jo4VfEHaYDSBRiEgx3q4IGomw1
	heJw2oJfOYQ+wvfwQPA8YpEHQIwQesVK8njbuDJzegoPn/8gxjl7oNqA7Nf+Nf9kGc9wW+/3F4E
	/TgExhoZ871Nx8dA9kYgXEqGSFjWbU+Y=
X-Gm-Gg: AR+sD114R0SI/3G+q5wPindpch1mWEv4FR/r3ZUcizKSuB/wPC5AJquerkqJcwrDLMz
	XPIqTM17FJGZyYJoDnlqtGFPBSmI4fHaPofujeArhXNwyPJj5vlfXezWzY8JQyCF04TZavg7Nn0
	lFd8xR41ePOUQOO9GFq0KhHMjGON+7TnQc/0LYfD5c9mg/gwKglmhrg3btDjB6BgJP4woyftmD0
	hu/f4H5tLswHoEFKnPk+YrEvcGw+hhJJ0Mq9xKxV2CEArB7kvvwdTqk/8bi123+AcuCnNROHBpb
	2SszUr87fAct0JqTKWPIvdd0r2iS4DS/WqMUz6VSrT8GgvAd/V6UeKjIzPtGioX9L1fAbvgBdxu
	0nQ==
X-Received: by 2002:a17:907:a0d1:b0:c1c:4c91:c24d with SMTP id
 a640c23a62f3a-c1f7248682emr457131166b.57.1785351968958; Wed, 29 Jul 2026
 12:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
 <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>
 <12dfeaae-f806-4adc-95f1-97fe10ef748e@roeck-us.net> <amnoV4Vlxmc5QgVC@monoceros>
 <e535a9c5-28a5-470c-be21-95e1812e5e01@roeck-us.net>
In-Reply-To: <e535a9c5-28a5-470c-be21-95e1812e5e01@roeck-us.net>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 29 Jul 2026 16:05:56 -0300
X-Gm-Features: AUfX_myK09lnBqf8bijuFVi6yJ4owlE81-Hh3AUMgJGBEnXoh0IbuXXrjswABFA
Message-ID: <CAJq09z5diKf9HpJ0B_7tyo2-2wPfojyG4pRY1qhRQ3fzx0Gr4A@mail.gmail.com>
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control via
 PWM framework
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter, Uwe,

Thank you both for the detailed reviews. I hope I'll address all the
points discussed in the next version.

> >> No, I won't accept this. It has to be either or. A pwm channel modeled as pwm
> >> subsystem channel must not be visible via hwmon attributes.
> >
> > I didn't look in detail, but maybe my red line is a bit more lax. IMHO
> > it's not OK to be able to modify a setting that results from pushing
> > hwmon knobs using PWM operations or vice-versa. Switching between
> > exclusive use at runtime is IMHO ok.
> >
> It is my call to make, and my call is either-or to avoid confusion.

Guenter, I agree and followed your strict "either-or" directive. If
the device is bound via the PWM framework (i.e., #pwm-cells is present
in the DT), the driver completely hides all legacy hwmon PWM
attributes.

One implementation detail: currently, the driver hides the hwmon
attributes only if #pwm-cells is present and IS_REACHABLE(CONFIG_PWM)
is true. If the DTS has #pwm-cells but the PWM framework is disabled
in the kernel, it emits a dev_warn and falls back to exposing the
hwmon attributes. Please let me know if you would prefer to
unconditionally hide the hwmon attributes merely based on the presence
of the DT property, regardless of the CONFIG_PWM state.

> > +static int adt7470_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > +                                        struct pwm_device *pwm,
> > +                                        const struct pwm_waveform *wf,
> > +                                        void *_wfhw)
> > +{
> > +     struct adt7470_data *data = pwmchip_get_drvdata(chip);
> > +     struct adt7470_pwm_wfhw *wfhw = _wfhw;
> > +     u64 period_ns;
> > +
> > +     if (wf->duty_length_ns == 0) {
> > +             wfhw->val = 0;
> > +             return 0;
> > +     }
> > +
> > +     /*
> > +      * The PWM frequency (period) is a single chip-wide setting shared by
> > +      * all 4 channels, so it cannot be changed on a per-pwm_device basis
> > +      * through this API. The duty cycle is rounded against the currently
> > +      * configured hardware period rather than the period requested in
> > +      * @wf; round_waveform_fromhw() reports the actual resulting
> > +      * waveform back so the core/consumer can detect a mismatch.
> > +      */
> > +     period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, data->pwm_freq);
> > +     wfhw->val = min_t(u64,
> > +                       mul_u64_u64_div_u64(wf->duty_length_ns, ADT7470_PWM_MAX, period_ns),
> > +                       ADT7470_PWM_MAX);
>
> This is wrong. Please test your driver with PWM_DEBUG enabled, this
> should emit warnings.
>
> Here the right thing is (untested):
>
>         if (!wf->period_length_ns) {
>                 wfhw->val = 0;
>                 return 0;
>         }
>
>         actual_period = NSEC_PER_SEC / data->pwm_freq;
>
>         if (wf->duty_length_ns >= actual_period)
>                 val = ADT7470_PWM_MAX;
>         else
>                 val = mul_u64_u64_div_u64(wf->duty_length_ns, ADT7470_PWM_MAX, actual_period);
>
>         return (actual_period < wf->period_length_ns) ? 0 : 1;

Uwe, thank you for the waveform callbacks snippet. It was much
cleaner. I only had to make one small mathematical adjustment to the
actual_period calculation in tohw() to satisfy CONFIG_PWM_DEBUG.

When using a truncating division (NSEC_PER_SEC / data->pwm_freq), it
triggered a "Wrong rounding" error during testing:

pwm pwmchip0: Wrong rounding: requested 714285/714286 [+0], result
714286/714286 [+0]

For example, at 1400 Hz, the truncating division gives an
actual_period of 714285 ns. If the framework requests a duty cycle of
714285 ns and a period of 714286 ns, the evaluation (714285 * 255) /
714285 yields a register value of 255. When read back in fromhw()
(which correctly rounds the period up to 714286 ns), the resulting
duty cycle becomes 714286 ns. Since 714286 > 714285, CONFIG_PWM_DEBUG
rightfully complains about the duty cycle inflation.

To ensure the calculated register value is strictly rounded down, I
changed the actual_period denominator in tohw() to use
DIV_ROUND_UP_ULL(NSEC_PER_SEC, data->pwm_freq). Maximizing the
denominator guarantees the resulting duty cycle fraction never
inflates, effectively passing all strict debug checks.

Thanks again for the time and guidance.

Best regards,

Luiz
