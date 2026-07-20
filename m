Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8D3A9624
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539266; cv=pass; b=KrIEEzGXffpsSipSqIu4w7ccnnwlYwJpmBPmnnquYjhQsG3fRYAuENWEFP8Y8uCNqpw0/XJtoUBVPz4eDmQQDMYivoEzLMZcO06sGrWsvBs80t/W2DE/oPPKS/RSbJjqmRXrVsPzfnebx+Lh8b6SlNqxLY8p60ov6N9/8nxJ4cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539266; c=relaxed/simple;
	bh=nVoTWQyfEHYdtxuskiX83mBuE4FebcDcTS0211N/3T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r31saz4cXDs8A9QA3MeZ6H+7yneQ2nlV9+L27srmN6f98vFMs48gSseKDyOKbUlbYLTKnWfVX5IgHl1xCi3noE0JcZpRroxYiK1y5AL0B86kO9H8Ci7gNi6GLUnasHHBhsfR1mp6I8wSfbBA6DjUjWL3mf7Xy5s37b0KoRrFK0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pud/9nwv; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pud/9nwv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848593533cbso4120067b3a.3
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 02:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784539263; cv=none;
        d=google.com; s=arc-20260327;
        b=jgpmgGEsKJNb26IZ+8Z1r2OumypN7aK9+VhrNbtDhCyQo0toUJ0/2o7/jOXG/Mp0Ni
         VqDcOpesS0hO3xZhRJCz6Rg/uORbF7yyYCW9TKCqbpG4/3ymGS1gTOACabeYgdDCz3Rw
         1ofgsf/+wGK2Iwl7buFx0a5eNWCr3MlJwKn3Tk4YVWQ5NHs9Vkd2jQKqaRg0mOZHni7F
         2F+hRrBGIP/mhtQMNp+lGbWVo6DI/8CljFqO3SPdieBbL9m0SjiP4cIQ8o1o4JGiHQm2
         EKoYebvHAV+cM/laPe5+841gMhubtqB75hT7DEu8ddo5ABNd72WUJIZ/j8mCj/2liB/I
         W+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFQlNZKrCEhOc+6aXOTGSVDcwURJmp18SbzxbmbgH5Q=;
        fh=DIw6esaHYw1XnbscNdGDqRThYRgN41FcqfeK484ki+Q=;
        b=f/JwEL8e1gyJnsrOY6hJK+zkDwiuxAes7RWaa2z89OtvSnfolGv7O62sOPgdjEf/nV
         oJwBTOqn0hEmfQZ5A9hGdaNzApxSQbdYqc5zpkSy29pkodKtRP1vXNx/NkajHmoYr4fR
         pohsDIHuqv5wJ5fgvysgA5o0jdVDFwQdK8kyuwg4eZXJl1M6z/tmP2zCVwiX356m1qmR
         V4BeiuJH4oEla9fxHTbwh1sOKfnWq4ewHYtKKPXr3/ZeKy2/7uJt6y4W0b2Y4dTxyeqg
         dAUDOAwG0FctZa6m6DZDIvBrjcFOXooXFx+pZD5k9YYSwEgxnqPJ8GWqLkoVxZCCdSFq
         L1/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784539263; x=1785144063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kFQlNZKrCEhOc+6aXOTGSVDcwURJmp18SbzxbmbgH5Q=;
        b=pud/9nwv1/nsl0/vOaReh9UnNRGWCTPk4BeREMHisBxj/A97FhNcFDudkrWjG1jtQ3
         SX8lcbWz1AZyqPz70U9pf2AJzeZDBx3mQWOjvM68xW++oQwIf7fxWL3EnUeEQCapyxWy
         UKyF4J8GANvRZAMD7mnRMdyedgVCFjlcXtXTdcfH40l1CoJJRlb0wCq7bQVi1Gb3S5Fl
         LvySxAOyNZFFecsmLc+PJwvEqyp2npB9akbnXpt7BcOdFCAQjVK4MRM94lyF55AbqeE1
         K9K+ZlIyUM5o7kiVbf1/EB2ZySSP32C1acXA8xPwg1s6g9d15Cv/TP/ptrr8Zl6Q+Hhz
         FHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539263; x=1785144063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFQlNZKrCEhOc+6aXOTGSVDcwURJmp18SbzxbmbgH5Q=;
        b=lS9uDaqMz5Y27S4W0Yp8tLKx/zGgX8hf1NTeOihhk/mcFurrhOjs5yOHnPwat63HqW
         QP18x/JPTHfWqDqAR5BK8d35KMETfvRoiqAC72B2By0+ZcPQJ0F4MtamXGnjeQuwbxfP
         3zUQaxWF7X6ay+oAl8hF/QryIt1MGtqlm4o70k6hI+eXKtB8HptYiik7wvDOwmGSg8Me
         31bWSQzDaNr2EMCKDn0jmk9/4x1Up5peaMslnZaiB9UgsskxcRQ68DMeFcaC3oWz/U5L
         c2j6jr5YK6tidkfAoQUuQ7p9Lqo4lSmh3JpZ7z7spdw8scMwqPxn9Xq9InAmf2qrjW40
         DDdA==
X-Forwarded-Encrypted: i=1; AHgh+Rp69ttK8IvJuBljueE7jPMbwML1F3D5U8xhLBuAPGjwL8ygBRdOLPoDnh5IgRhBgk5/IhFjTAUoLh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnO+OCuxCgF11GethXkKs/D0JsAu/vJ6GsP5Y6P9EA/sb3CaF
	2irYU0bST/NfAOzhTpEN9E3wfla0bZfEn1g915K4671lsS/VVUanDNz5KNrjbEmzgWf+Ye6sAlP
	1VutDW05PU65m8/SLrVzsP9Dhbcu2pcpGpfXAe0T07g==
X-Gm-Gg: AfdE7ck3m9kZvqGmwCSVxqFNk1IwUuFwmbg6zMFI7V1BNV5snwBb6QfSgXyODqohSbp
	3ho6e/+d7D5ZN/NBcez8m/aVnFs09U/OGgR/IB9Khtx+uUafpcmPMdm3STHNExu5JMW+5ZOWCcv
	pYu3Creb58T98jFZjePr62OjPv9bhsxJmRSDhm4Z9jgf6CltbGrJCGcdDmQaR3oDhc4XP/zFSlJ
	hV7xh3fyYtPLJ82aOEtCnf6RxzcVi53Abjy5fZderbjYgBvSojGDeQa+tMTbRA=
X-Received: by 2002:a05:6a00:3d4b:b0:848:7784:37d6 with SMTP id
 d2e1a72fcca58-84c295526eemr13782465b3a.58.1784539263267; Mon, 20 Jul 2026
 02:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-pwm_meson_convert_to_waveform_api-v1-1-d7dbdae1318d@baylibre.com>
 <20260717192735.3E71E1F000E9@smtp.kernel.org>
In-Reply-To: <20260717192735.3E71E1F000E9@smtp.kernel.org>
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 20 Jul 2026 11:20:50 +0200
X-Gm-Features: AUfX_myvcar7qwuq7Xpd8sJoS8D_uPqo1YRJ3UYnt0Ec3GkeZR_OjanqrOWTVXw
Message-ID: <CAFGrd9rnPVAhiTJi964t0AH=1S8sjDWhy1U2iBs3aaQ=zk+85A@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: Convert to waveform API
To: sashiko-reviews@lists.linux.dev
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 9:27=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Truncation error in hardware waveform quantization breaks legacy=
 polarity inversion.
> - [Medium] Independent rounding in waveform readback produces an invalid =
state where duty + offset > period.
> --
...
> > +     if (meson->data->has_polarity && duty_cnt) {
> > +             u64 offset_cnt =3D mul_u64_u64_div_u64(fin_freq, wf->duty=
_offset_ns,
> > +                                                  NSEC_PER_SEC);
> > +
> > +             /*
> > +              * Waveforms with duty_offset_ns + duty_length_ns =3D=3D
> > +              * period_length_ns are implemented by inverting the outp=
ut:
> > +              * The signal then is low for hi counts (the offset) foll=
owed
> > +              * by high for lo counts (the duty cycle). Other nonzero
> > +              * duty_offset_ns values are rounded down to 0.
> > +              */
> > +             if (offset_cnt && duty_cnt + offset_cnt >=3D cnt) {
>
> [Severity: High]
> Could integer division truncation cause this check to fail for inverted
> waveforms?
>
> If duty_cnt and offset_cnt are calculated with independent truncation, th=
eir
> sum might end up strictly less than cnt even when the original lengths su=
m to
> the period.
>
> Would this cause the driver to incorrectly fall back to normal polarity w=
ith a
> zero offset?
>

At a sub-count boundary floor(duty) + floor(offset) can be cnt - 1 instead =
of
cnt, so an inverted request can indeed fall back to a non-inverted setting =
with
duty_offset rounded down to 0. That is a valid result, not a failure:
.round_waveform_tohw() must round every quantity down and only has to retur=
n a
waveform not exceeding the request (see the contract above
pwm_set_waveform_might_sleep() and pwm_check_rounding() in drivers/pwm/core=
.c).
duty_offset 0 <=3D requested duty_offset, so the result stays within the co=
ntract
and CONFIG_PWM_DEBUG accepts it.

The same count-based test is used by pwm-stm32.c (duty_ticks + offset_ticks=
 >=3D
arr + 1). So the conservative count-based check is intentional. No change.

> > +     /*
> > +      * wfhw->hi and wfhw->lo are u16, so their sum doesn't overflow a=
nd
> > +      * NSEC_PER_SEC * (hi + lo) fits into the u64 dividend in
> > +      * meson_pwm_cnt_to_ns().
> > +      */
> > +     wf->period_length_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wfhw->hi=
 + wfhw->lo);
> > +
> > +     if (wfhw->inverted && wfhw->lo =3D=3D 0) {
> > +             /*
> > +              * The output is constant low. Report a normal constant-l=
ow
> > +              * waveform instead of duty_offset_ns =3D=3D period_lengt=
h_ns
> > +              * which wouldn't be a valid waveform description. This
> > +              * setting is only reachable when the hardware was progra=
mmed
> > +              * by the bootloader as .round_waveform_tohw() never prod=
uces
> > +              * it.
> > +              */
> > +             wf->duty_length_ns =3D 0;
> > +             wf->duty_offset_ns =3D 0;
> > +     } else if (wfhw->inverted) {
> > +             wf->duty_length_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wf=
hw->lo);
> > +             wf->duty_offset_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wf=
hw->hi);
>
> [Severity: Medium]
> Since meson_pwm_cnt_to_ns() explicitly rounds up, can rounding duty_lengt=
h_ns
> and duty_offset_ns independently result in their sum exceeding
> period_length_ns?
>
> For example, if rate is 333333333 Hz and both hi and lo counts are 1,
> period_length_ns rounds up to 7 ns, while duty_length_ns and duty_offset_=
ns
> would each round up to 4 ns. Their sum (8 ns) would exceed the period len=
gth,
> potentially leading to integer underflow in consumers attempting to calcu=
late
> the remaining period time.

duty_offset_ns + duty_length_ns > period_length_ns is not an invalid wavefo=
rm.
The waveform API requires only duty_length_ns <=3D period_length_ns and
duty_offset_ns < period_length_ns (pwm_wf_valid() in drivers/pwm/core.c); t=
he
sum is deliberately allowed to exceed the period and represents the high ph=
ase
wrapping past the period end, i.e. inverted polarity (see the kerneldoc on
struct pwm_waveform in include/linux/pwm.h). For the example {period 7, dut=
y 4,
offset 4} both invariants hold (4 <=3D 7, 4 < 7), so it is valid.

The core handles it explicitly: pwm_wf2state() maps
duty_length + duty_offset >=3D period to PWM_POLARITY_INVERSED with
duty_cycle =3D period - duty_length =3D 3 ns, so there is no underflow. Rou=
nding
each reported value up independently is what pwm-stm32.c, pwm_th1520.rs and
pwm-axi-pwmgen.c do as well; it is required so that feeding the reported
waveform back through .round_waveform_tohw() reproduces the same counters.
No change.

Alexandre Mergnat
