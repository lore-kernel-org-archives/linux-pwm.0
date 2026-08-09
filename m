Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C037B007
	for <linux-pwm@vger.kernel.org>; Sun,  9 Aug 2026 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786265476; cv=pass; b=MEi82RgNZeENMx6FGmViFPtYdPPqiwcjYYRuYpvySxLD8SG5Yt83BcDeYQcYoKRKqaZJExxb4yexiuZHClMbbOdpUF7KbNHxHnKjnjhDuWfyllNluBa8qSSvfCKRBrPOB/tlUfeErUJg2pYxPVuQqyvDH8dTH99nRj2HNqqE0m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786265476; c=relaxed/simple;
	bh=mxeOjr8LzrRWvEteoIxYWXNLbSsMeg0M2I+VDuuVaoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuobFWxxyFIaUm3Ay63Rl5wHMTesOZ0woKp0zx1EX8nsE0hBARgNfp7isOEw1GAa1W4F+4sYHLOolkzGY/B2qpbgPSQP3hlmXRKJsuN/OegspdJwX3SbeC/IspDJfp2PggsRBZCLuLB1J6vqMA1gY/uDhrV7hM8uTkWfW5EfH2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NN/PFESx; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NN/PFESx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso9365225ad.2
        for <linux-pwm@vger.kernel.org>; Sun, 09 Aug 2026 01:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786265469; cv=none;
        d=google.com; s=arc-20260327;
        b=hugseZ82m0Jz63+118ma5I4nPKM2B5Tnms7a6MgQKQMWrbt6LmbrGFjtiJnsVW7cYz
         7W4gSuXfgqz1lBhqWBmTNheKFNuqLwCvnSxIThfs1IaD5Ei8P6Ob2sDpO0rMD/E6gTHU
         flqcdAc3lsk6mQMWvbNABg3LoDz8QJRNwK8WZl+i1jHvyAE4wiGMd5Nxc1/VlaYmy/aN
         qRsUyENE+UWNOetykQkJtKqs82+0ASGr1RdxP3r96OD319U4/oNIDfU21+z+LOk7hLLY
         kmaiN9cMJxyYg+Q+zr+IYAnUAozfbZma970OjEJDbeMUldBtHGzo09hBFRjhBBMJzN5d
         tDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YlyRsKVhH+LXT8CyaBK8gIYR1x6VG38LxmkLcWoqGkQ=;
        fh=kBcxnsANZ5lQDlyrBDtda4i2yxe/DM3ign7SXzl6Rcw=;
        b=TdKtUhuE3Mj/ZptptHWVA1rrtM1LeK7lGHVo3tooI3qcBhFmTXH9KvrN5SvM1zOLdF
         r8JYqLXJVJl4M74kzaUH3wDhyzJRTaR+EJrG/n3JkOOnDlgvEs9eX59wjEDxWBXZf4sF
         yL2jVTy94ubkvYwwjiIGq4GRTtjQ31fTD5jo93xwM3bPpQbGaCIFBdK4MYGJxuOTnRwB
         zCVOjMawsrd4yXmJcpwNo/KuPQp8lRICfvfOuSj612hOjqwlQVRuiGbHDRyVnmLV6Q+Y
         jcXVnj7R4LKLPopcK75eLMAp/YCxVwZsrtCRec7lkQ+CevvMhaaulsyP0WhRKDqj5pSZ
         4w9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786265469; x=1786870269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YlyRsKVhH+LXT8CyaBK8gIYR1x6VG38LxmkLcWoqGkQ=;
        b=NN/PFESx9fa08asGs52hzJfvVibst0nAh8otZHEh5dsOC/U+vX4HMkCHpOIX2cxvoR
         7HjmVzeOH11grSCF3RCdMsopIMMOHrCA3gIGf7d3n7w5bO9yS5ldR4zjQXendD6YmXPc
         OYDSspGNnaJ9BCLta3A6porlycm3BwdF7d9zlgifJRWfsPrc9jJPSk3zvnzBcQEbIwKN
         SYYhPjDNUS+zrT92uZZ9GvXO2brQ7AWi3qEOQMuompepkvNchkZWqsYBl5A1MLoxC8uL
         nUYx4XcVRxi7Gdx313AiQ1qeFshqIzgk7nR8iMbTw75SA1hEOc0Y9GCSRZ8khu9l8+vS
         RX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786265469; x=1786870269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YlyRsKVhH+LXT8CyaBK8gIYR1x6VG38LxmkLcWoqGkQ=;
        b=C4+9pkGiLpotJkP3KdZ8V+HviFO6X1cbEs/b/O6/2buSHNi7J3tIChtLtFJ/r2diGc
         NW9fprHGXMVmrCJFLQXIsRToMEuTda04kpn4zlsMTK8PBgfUYO93CIKfwrXJFD5Qlh79
         APEvAc146+yCAs95UpLcm2gHKJ20PDLMXS/OhRiR+hpaUZHglHN2Ae5OiADnSSIgA4xU
         lpPUOpdcraQPQJtwo5aKLZ7M4eZVokQ8OKwzmB/q4jR/eCxebEhs5b1L0EWappVXZV+9
         UpEmK78aedYskQyaeRN0C4OgvJbE3kno7fcBNwpOhHQQkYVxXSWaRE9kSdxQeDmSGRjE
         P6SA==
X-Gm-Message-State: AOJu0YzfNX5JtbXnji/hLT+fg6c207YE+qDW6ulRx1eF8OmUVPXjbViC
	NtJ5bk8Ijsz3AqzvSN21NJnCeys5c0L70ZJuYnji3Hd7VWCl1Cu/Up55XkuWqu/7M6kICswt3JN
	E7aeSFsDuHVqDK7I9bTqDy85mS+e3WhCxFfeUaQg90g==
X-Gm-Gg: AR+sD13yqKkLH/IV/7sWbDCzpXD5GjSNrtrbBx0gROZg2XGIpE5c+VixuFsQwxTzoh7
	2fYBnjmmC3U670sHLkDL3qfRLAEDHr1ejmRQMGwccMEtUBFhXaQ6PTZqKp0VTEUP23LRE1VSm4L
	N9QOWNeIMRt8y61TRqrYrnIXMPyuhEkhPNJc+N+PnFZ7tdTa6yxUFKrrVdK0r09AMODFj1G5Fkc
	Q/gaxnNjX20XgiAGHWR8uchgPuGRcmNixAhuyIK3luHH5txTSI9cIle9eMnuQVCo7OAsZYXuZV1
	ZKk7pCeViJsSE7cAstPnODfKpgOwxSG2EcYFPDXiCSYqWXYG7uV2LeSJHaw6cfnaAQ==
X-Received: by 2002:a17:902:ced1:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2d106a1a2d5mr235383425ad.4.1786265468649; Sun, 09 Aug 2026
 01:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-pwm_meson_convert_to_waveform_api-v1-1-d7dbdae1318d@baylibre.com>
In-Reply-To: <20260717-pwm_meson_convert_to_waveform_api-v1-1-d7dbdae1318d@baylibre.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Sun, 9 Aug 2026 10:51:08 +0200
X-Gm-Features: AUfX_my2c4bqArPmLXEH8Wf4hFHso_g_M9EZslmQ8zjyZAwv_lUTpdPXzbw_HXI
Message-ID: <CAFGrd9qh8bHD5pJuiB-PLfAcYEyuw9ExHEWeAj_JFSp_sm52rQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: Convert to waveform API
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, a gentle ping on this patch. It has been around three weeks since
the submission. Any feedback would be appreciated.

Regards,
Alexandre

On Fri, Jul 17, 2026 at 9:18=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:
>
> The PWM subsystem introduced a new waveform abstraction that
> describes a PWM signal by period length, duty length and duty offset
> instead of period, duty cycle and polarity. The meson driver still
> uses the legacy .apply() and .get_state() callbacks and does not
> implement the waveform callbacks, so consumers cannot use the
> pwm_*_waveform() helper functions with it.
>
> Adopt the new API by implementing .round_waveform_tohw(),
> .round_waveform_fromhw(), .read_waveform() and .write_waveform()
> with a private meson_pwm_waveform struct holding the hardware
> representation. The cached channel state fields (rate, hi, lo,
> constant, inverted) are removed; counter values are now computed in
> .round_waveform_tohw() via clk_round_rate() without register writes,
> then committed in .write_waveform().
>
> The hardware invert bit places the duty active phase at the end of the
> period on revisions that have it. Input clock rates are kept at or
> below 1 GHz so each counter cycle remains representable in nanoseconds
> by .round_waveform_fromhw(). Requests for which clk_round_rate() cannot
> provide such a rate are rejected. Otherwise, period counts above the
> 16-bit range are clamped, while a zero count is rounded up to one and
> signalled by .round_waveform_tohw() returning 1.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> The PWM core gained a new waveform abstraction that lets drivers
> describe the hardware more directly and gives consumers access to
> rounding and read-back without touching registers. The meson driver
> still uses the legacy .apply() and .get_state() callbacks, so
> consumers of its PWMs cannot benefit from the new pwm_*_waveform()
> helpers.
>
> This series implements the four waveform callbacks and removes the
> cached channel state that the legacy .apply() path relied on.
> Settings are now computed without side effects and committed in a
> separate step, matching the split the waveform API requires.
>
> Behavioural changes visible to consumers:
>
> - On revisions without the invert bit, a nonzero duty offset is
>   rounded down to zero. An inverted polarity request through the
>   legacy path produces the same register settings as the previous
>   "duty =3D period - duty" emulation, so the generated signal is
>   unchanged for those consumers.
>
> - Disabling a PWM no longer emulates an inactive-high output on
>   revisions without the invert bit. The PWM API defines the output
>   of a disabled PWM as undefined (this was already the case for
>   .apply()), so affected consumers were relying on unspecified
>   behaviour. Consumers that need an inactive high output should keep
>   the PWM enabled with inverted polarity and zero duty cycle.
>
> - Input clock rates are kept at or below 1 GHz so counter cycles remain
>   representable in nanoseconds. Requests for which clk_round_rate()
>   cannot provide such a rate are rejected. Otherwise, period counts
>   exceeding the 16-bit range are clamped. A zero count is rounded up to
>   one, signalled by .round_waveform_tohw() returning 1.
>
> - Reported period and duty cycle values are rounded up instead of
>   down, so a returned setting reproduces the same counter values
>   when applied again. The constant output bit is now derived from
>   the converted counter values, which also covers cases where the
>   ns-to-counter conversion yields an empty high or low phase.
>   clk_set_rate() failures now propagate as write errors instead of
>   being logged and ignored, and .write_waveform() now also fails if
>   the input clock rate changed between rounding and writing.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> Tested on a Libre Computer Le Potato (AML-S905X-CC, Amlogic S905X /
> GXL SoC) with CONFIG_PWM_DEBUG=3Dy, built in tree. Three PWM nodes were
> enabled in the board device tree (pwm_ab, pwm_ef, pwm_AO_ab), exposing
> 6 channels across the EE and AO clock domains.
>
> The libpwm tools drive the /dev/pwmchipN character device directly, so
> the new waveform callbacks are exercised through their own ioctls. All
> 6 channels went through pwmround for rounding queries (ROUNDWF:
> standard, too-short and too-long periods, zero and full duty, duty
> offsets, non-representable values), pwmset for rounded and exact
> settings (SETROUNDEDWF / SETEXACTWF) with hardware read-back through
> debugfs (.read_waveform()), and pwmtestperf duty sweeps. pwmtestperf
> was run in all four direction/polarity combinations at 100 us, 1 ms and
> 10 ms (72 runs), then with a 1 ns step at a non-tick-aligned period so
> every duty and duty-offset rounding boundary is crossed (about 24000
> boundary checks). PWM_DEBUG's rounding and read-back checks stayed
> silent throughout.
>
> ROUNDWF and SETEXACTWF agree as specified: SETEXACTWF applies exactly
> representable waveforms and returns -EDOM otherwise. 1 ms is exact on
> the EE chips and rounds to 999990 ns on the AO chip, reflecting
> each PWM's clock granularity. A 1 ns period request is
> rounded up to the shortest representable period with zero duty,
> signalled by .round_waveform_tohw() returning 1. Periods too long for
> the source clock to represent (349.52 ms on this board) are rejected
> with -EINVAL when clk_round_rate() cannot provide a low enough rate.
> GXL has no invert bit (has_polarity =3D false), so nonzero duty offsets
> are rounded down to zero and the axg/g12/s4 invert paths are not
> exercisable on this board.
>
> The sysfs interface (50%/25%/0%/100% duty, polarity inversion,
> enable/disable on all 6 channels) was also exercised and reads back
> consistently, confirming no regression for legacy consumers.
> ---
>  drivers/pwm/pwm-meson.c | 372 ++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 215 insertions(+), 157 deletions(-)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 8c6bf3d49753..be17aae0941b 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -6,11 +6,11 @@
>   * PWM output is achieved by calculating a clock that permits calculatin=
g
>   * two periods (low and high). The counter then has to be set to switch =
after
>   * N cycles for the first half period.
> - * Partly the hardware has no "polarity" setting. This driver reverses t=
he period
> - * cycles (the low length is inverted with the high length) for
> - * PWM_POLARITY_INVERSED. This means that .get_state cannot read the pol=
arity
> - * from the hardware.
> - * Setting the duty cycle will disable and re-enable the PWM output.
> + * Some of the IP block revisions have an invert bit that swaps the high=
 and
> + * low parts of the output. This is used to implement waveforms with
> + * duty_offset_ns + duty_length_ns =3D=3D period_length_ns, i.e. what th=
e legacy
> + * API calls inverted polarity. On the other revisions a nonzero duty_of=
fset_ns
> + * is rounded down to zero.
>   * Disabling the PWM stops the output immediately (without waiting for t=
he
>   * current period to complete first).
>   *
> @@ -35,6 +35,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -96,12 +97,6 @@ static struct meson_pwm_channel_data {
>  };
>
>  struct meson_pwm_channel {
> -       unsigned long rate;
> -       unsigned int hi;
> -       unsigned int lo;
> -       bool constant;
> -       bool inverted;
> -
>         struct clk_mux mux;
>         struct clk_divider div;
>         struct clk_gate gate;
> @@ -156,30 +151,44 @@ static void meson_pwm_free(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>         clk_disable_unprepare(channel->clk);
>  }
>
> -static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
> -                         const struct pwm_state *state)
> +struct meson_pwm_waveform {
> +       unsigned long rate;
> +       u16 hi;
> +       u16 lo;
> +       bool enabled;
> +       bool inverted;
> +};
> +
> +static int meson_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +                                        struct pwm_device *pwm,
> +                                        const struct pwm_waveform *wf,
> +                                        void *_wfhw)
>  {
> +       struct meson_pwm_waveform *wfhw =3D _wfhw;
>         struct meson_pwm *meson =3D to_meson_pwm(chip);
>         struct meson_pwm_channel *channel =3D &meson->channels[pwm->hwpwm=
];
> -       unsigned int cnt, duty_cnt;
> +       u64 cnt, duty_cnt, freq;
>         long fin_freq;
> -       u64 duty, period, freq;
> +       int ret =3D 0;
>
> -       duty =3D state->duty_cycle;
> -       period =3D state->period;
> +       if (wf->period_length_ns =3D=3D 0) {
> +               *wfhw =3D (struct meson_pwm_waveform){
> +                       .enabled =3D false,
> +               };
> +
> +               return 0;
> +       }
>
>         /*
> -        * Note this is wrong. The result is an output wave that isn't re=
ally
> -        * inverted and so is wrongly identified by .get_state as normal.
> -        * Fixing this needs some care however as some machines might rel=
y on
> -        * this.
> +        * Get the highest input clock rate that makes the requested peri=
od
> +        * representable with the 16 bit wide counters, but at most 1 GHz=
 so
> +        * one counter cycle stays at least a nanosecond long, which
> +        * .round_waveform_fromhw() relies on. clk_round_rate() may round=
 up
> +        * past the requested rate, so reject a too-high result below.
>          */
> -       if (state->polarity =3D=3D PWM_POLARITY_INVERSED && !meson->data-=
>has_polarity)
> -               duty =3D period - duty;
> -
> -       freq =3D div64_u64(NSEC_PER_SEC * 0xffffULL, period);
> -       if (freq > ULONG_MAX)
> -               freq =3D ULONG_MAX;
> +       freq =3D div64_u64((u64)NSEC_PER_SEC * FIELD_MAX(PWM_LOW_MASK),
> +                        wf->period_length_ns);
> +       freq =3D min_t(u64, freq, NSEC_PER_SEC);
>
>         fin_freq =3D clk_round_rate(channel->clk, freq);
>         if (fin_freq <=3D 0) {
> @@ -188,180 +197,226 @@ static int meson_pwm_calc(struct pwm_chip *chip, =
struct pwm_device *pwm,
>                 return fin_freq ? fin_freq : -EINVAL;
>         }
>
> -       dev_dbg(pwmchip_parent(chip), "fin_freq: %ld Hz\n", fin_freq);
> -
> -       cnt =3D mul_u64_u64_div_u64(fin_freq, period, NSEC_PER_SEC);
> -       if (cnt > 0xffff) {
> -               dev_err(pwmchip_parent(chip), "unable to get period cnt\n=
");
> +       if (fin_freq > NSEC_PER_SEC) {
> +               dev_err(pwmchip_parent(chip),
> +                       "source clock frequency %ld too high\n", fin_freq=
);
>                 return -EINVAL;
>         }
>
> -       dev_dbg(pwmchip_parent(chip), "period=3D%llu cnt=3D%u\n", period,=
 cnt);
> -
> -       if (duty =3D=3D period) {
> -               channel->hi =3D cnt;
> -               channel->lo =3D 0;
> -               channel->constant =3D true;
> -       } else if (duty =3D=3D 0) {
> -               channel->hi =3D 0;
> -               channel->lo =3D cnt;
> -               channel->constant =3D true;
> -       } else {
> -               duty_cnt =3D mul_u64_u64_div_u64(fin_freq, duty, NSEC_PER=
_SEC);
> -
> -               dev_dbg(pwmchip_parent(chip), "duty=3D%llu duty_cnt=3D%u\=
n", duty, duty_cnt);
> +       /*
> +        * If the requested period is too long to be counted even at the
> +        * lowest possible input clock rate, implement the longest possib=
le
> +        * period instead.
> +        */
> +       cnt =3D mul_u64_u64_div_u64(fin_freq, wf->period_length_ns, NSEC_=
PER_SEC);
> +       cnt =3D min_t(u64, cnt, FIELD_MAX(PWM_LOW_MASK));
> +
> +       if (cnt =3D=3D 0) {
> +               /*
> +                * The requested period is shorter than one cycle of the
> +                * fastest available input clock, implement the minimal
> +                * period with zero duty cycle (the general calculation b=
elow
> +                * yields that as duty_length_ns and duty_offset_ns canno=
t
> +                * exceed the requested period) and signal the rounding u=
p
> +                * in the return value.
> +                */
> +               cnt =3D 1;
> +               ret =3D 1;
> +       }
>
> -               channel->hi =3D duty_cnt;
> -               channel->lo =3D cnt - duty_cnt;
> -               channel->constant =3D false;
> +       duty_cnt =3D mul_u64_u64_div_u64(fin_freq, wf->duty_length_ns, NS=
EC_PER_SEC);
> +       duty_cnt =3D min(duty_cnt, cnt);
> +
> +       *wfhw =3D (struct meson_pwm_waveform){
> +               .rate =3D fin_freq,
> +               .hi =3D duty_cnt,
> +               .lo =3D cnt - duty_cnt,
> +               .enabled =3D true,
> +       };
> +
> +       if (meson->data->has_polarity && duty_cnt) {
> +               u64 offset_cnt =3D mul_u64_u64_div_u64(fin_freq, wf->duty=
_offset_ns,
> +                                                    NSEC_PER_SEC);
> +
> +               /*
> +                * Waveforms with duty_offset_ns + duty_length_ns =3D=3D
> +                * period_length_ns are implemented by inverting the outp=
ut:
> +                * The signal then is low for hi counts (the offset) foll=
owed
> +                * by high for lo counts (the duty cycle). Other nonzero
> +                * duty_offset_ns values are rounded down to 0.
> +                */
> +               if (offset_cnt && duty_cnt + offset_cnt >=3D cnt) {
> +                       swap(wfhw->hi, wfhw->lo);
> +                       wfhw->inverted =3D true;
> +               }
>         }
>
> -       channel->rate =3D fin_freq;
> +       dev_dbg(pwmchip_parent(chip),
> +               "pwm#%u: %llu/%llu [+%llu] @%lu -> hi: %u, lo: %u, invert=
ed: %d\n",
> +               pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns,
> +               wf->duty_offset_ns, wfhw->rate, wfhw->hi, wfhw->lo,
> +               wfhw->inverted);
>
> -       return 0;
> +       return ret;
>  }
>
> -static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +static u64 meson_pwm_cnt_to_ns(unsigned long fin_freq, u32 cnt)
>  {
> -       struct meson_pwm *meson =3D to_meson_pwm(chip);
> -       struct meson_pwm_channel *channel =3D &meson->channels[pwm->hwpwm=
];
> -       struct meson_pwm_channel_data *channel_data;
> -       unsigned long flags;
> -       u32 value;
> -       int err;
> -
> -       channel_data =3D &meson_pwm_per_channel_data[pwm->hwpwm];
> -
> -       err =3D clk_set_rate(channel->clk, channel->rate);
> -       if (err)
> -               dev_err(pwmchip_parent(chip), "setting clock rate failed\=
n");
> -
> -       spin_lock_irqsave(&meson->lock, flags);
> +       return DIV64_U64_ROUND_UP(NSEC_PER_SEC * (u64)cnt, fin_freq);
> +}
>
> -       value =3D FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
> -               FIELD_PREP(PWM_LOW_MASK, channel->lo);
> -       writel(value, meson->base + channel_data->reg_offset);
> +static int meson_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +                                          struct pwm_device *pwm,
> +                                          const void *_wfhw,
> +                                          struct pwm_waveform *wf)
> +{
> +       const struct meson_pwm_waveform *wfhw =3D _wfhw;
>
> -       value =3D readl(meson->base + REG_MISC_AB);
> -       value |=3D channel_data->pwm_en_mask;
> +       if (!wfhw->enabled || !wfhw->rate) {
> +               *wf =3D (struct pwm_waveform){
> +                       .period_length_ns =3D 0,
> +               };
>
> -       if (meson->data->has_constant) {
> -               value &=3D ~channel_data->const_en_mask;
> -               if (channel->constant)
> -                       value |=3D channel_data->const_en_mask;
> +               return 0;
>         }
>
> -       if (meson->data->has_polarity) {
> -               value &=3D ~channel_data->inv_en_mask;
> -               if (channel->inverted)
> -                       value |=3D channel_data->inv_en_mask;
> +       /*
> +        * wfhw->hi and wfhw->lo are u16, so their sum doesn't overflow a=
nd
> +        * NSEC_PER_SEC * (hi + lo) fits into the u64 dividend in
> +        * meson_pwm_cnt_to_ns().
> +        */
> +       wf->period_length_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wfhw->hi=
 + wfhw->lo);
> +
> +       if (wfhw->inverted && wfhw->lo =3D=3D 0) {
> +               /*
> +                * The output is constant low. Report a normal constant-l=
ow
> +                * waveform instead of duty_offset_ns =3D=3D period_lengt=
h_ns
> +                * which wouldn't be a valid waveform description. This
> +                * setting is only reachable when the hardware was progra=
mmed
> +                * by the bootloader as .round_waveform_tohw() never prod=
uces
> +                * it.
> +                */
> +               wf->duty_length_ns =3D 0;
> +               wf->duty_offset_ns =3D 0;
> +       } else if (wfhw->inverted) {
> +               wf->duty_length_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wf=
hw->lo);
> +               wf->duty_offset_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wf=
hw->hi);
> +       } else {
> +               wf->duty_length_ns =3D meson_pwm_cnt_to_ns(wfhw->rate, wf=
hw->hi);
> +               wf->duty_offset_ns =3D 0;
>         }
>
> -       writel(value, meson->base + REG_MISC_AB);
> -
> -       spin_unlock_irqrestore(&meson->lock, flags);
> +       return 0;
>  }
>
> -static void meson_pwm_disable(struct pwm_chip *chip, struct pwm_device *=
pwm)
> +static int meson_pwm_read_waveform(struct pwm_chip *chip,
> +                                  struct pwm_device *pwm,
> +                                  void *_wfhw)
>  {
> +       struct meson_pwm_waveform *wfhw =3D _wfhw;
>         struct meson_pwm *meson =3D to_meson_pwm(chip);
>         struct meson_pwm_channel *channel =3D &meson->channels[pwm->hwpwm=
];
>         struct meson_pwm_channel_data *channel_data;
> -       unsigned long flags;
> -       u32 value;
> +       u32 value, pwm_reg;
>
>         channel_data =3D &meson_pwm_per_channel_data[pwm->hwpwm];
>
> -       spin_lock_irqsave(&meson->lock, flags);
> -
>         value =3D readl(meson->base + REG_MISC_AB);
> -       value &=3D ~channel_data->pwm_en_mask;
> +       if (!(value & channel_data->pwm_en_mask)) {
> +               *wfhw =3D (struct meson_pwm_waveform){
> +                       .enabled =3D false,
> +               };
>
> -       if (meson->data->has_polarity) {
> -               value &=3D ~channel_data->inv_en_mask;
> -               if (channel->inverted)
> -                       value |=3D channel_data->inv_en_mask;
> +               return 0;
>         }
>
> -       writel(value, meson->base + REG_MISC_AB);
> +       pwm_reg =3D readl(meson->base + channel_data->reg_offset);
>
> -       spin_unlock_irqrestore(&meson->lock, flags);
> +       *wfhw =3D (struct meson_pwm_waveform){
> +               .rate =3D clk_get_rate(channel->clk),
> +               .hi =3D FIELD_GET(PWM_HIGH_MASK, pwm_reg),
> +               .lo =3D FIELD_GET(PWM_LOW_MASK, pwm_reg),
> +               .enabled =3D true,
> +               .inverted =3D meson->data->has_polarity &&
> +                           (value & channel_data->inv_en_mask),
> +       };
> +
> +       return 0;
>  }
>
> -static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
> -                          const struct pwm_state *state)
> +static int meson_pwm_write_waveform(struct pwm_chip *chip,
> +                                   struct pwm_device *pwm,
> +                                   const void *_wfhw)
>  {
> +       const struct meson_pwm_waveform *wfhw =3D _wfhw;
>         struct meson_pwm *meson =3D to_meson_pwm(chip);
>         struct meson_pwm_channel *channel =3D &meson->channels[pwm->hwpwm=
];
> -       int err =3D 0;
> -
> -       channel->inverted =3D (state->polarity =3D=3D PWM_POLARITY_INVERS=
ED);
> -
> -       if (!state->enabled) {
> -               if (channel->inverted && !meson->data->has_polarity) {
> -                       /*
> -                        * Some of IP block revisions don't have an "alwa=
ys high"
> -                        * setting which we can use for "inverted disable=
d".
> -                        * Instead we achieve this by setting mux parent =
with
> -                        * highest rate and minimum divider value, result=
ing
> -                        * in the shortest possible duration for one "cou=
nt"
> -                        * and "period =3D=3D duty_cycle". This results i=
n a signal
> -                        * which is LOW for one "count", while being HIGH=
 for
> -                        * the rest of the (so the signal is HIGH for sli=
ghtly
> -                        * less than 100% of the period, but this is the =
best
> -                        * we can achieve).
> -                        */
> -                       channel->rate =3D ULONG_MAX;
> -                       channel->hi =3D ~0;
> -                       channel->lo =3D 0;
> -                       channel->constant =3D true;
> -
> -                       meson_pwm_enable(chip, pwm);
> -               } else {
> -                       meson_pwm_disable(chip, pwm);
> -               }
> -       } else {
> -               err =3D meson_pwm_calc(chip, pwm, state);
> -               if (err < 0)
> +       struct meson_pwm_channel_data *channel_data;
> +       unsigned long flags;
> +       u32 value;
> +       int err;
> +
> +       channel_data =3D &meson_pwm_per_channel_data[pwm->hwpwm];
> +
> +       /*
> +        * Channel clock operations also modify REG_MISC_AB under meson->=
lock,
> +        * including from .request()/.free() outside the pwmchip lock. Se=
t the
> +        * rate before taking meson->lock to avoid recursive locking. Ski=
p
> +        * clk_set_rate() when unchanged because even a no-op re-evaluate=
s the
> +        * mux parent and reparses the device tree.
> +        */
> +       if (wfhw->enabled && clk_get_rate(channel->clk) !=3D wfhw->rate) =
{
> +               err =3D clk_set_rate(channel->clk, wfhw->rate);
> +               if (err) {
> +                       dev_err(pwmchip_parent(chip),
> +                               "setting clock rate failed: %d\n", err);
>                         return err;
> +               }
>
> -               meson_pwm_enable(chip, pwm);
> +               /*
> +                * The rate computed by .round_waveform_tohw() might not =
be
> +                * hit if an input clock changed its rate in between; the
> +                * counter values only implement the promised waveform at
> +                * exactly wfhw->rate.
> +                */
> +               if (clk_get_rate(channel->clk) !=3D wfhw->rate) {
> +                       dev_err(pwmchip_parent(chip),
> +                               "clock rate changed since rounding\n");
> +                       return -EINVAL;
> +               }
>         }
>
> -       return 0;
> -}
> +       spin_lock_irqsave(&meson->lock, flags);
>
> -static u64 meson_pwm_cnt_to_ns(unsigned long fin_freq, u32 cnt)
> -{
> -       return fin_freq ? div64_ul(NSEC_PER_SEC * (u64)cnt, fin_freq) : 0=
;
> -}
> +       if (wfhw->enabled) {
> +               value =3D FIELD_PREP(PWM_HIGH_MASK, wfhw->hi) |
> +                       FIELD_PREP(PWM_LOW_MASK, wfhw->lo);
> +               writel(value, meson->base + channel_data->reg_offset);
>
> -static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> -                              struct pwm_state *state)
> -{
> -       struct meson_pwm *meson =3D to_meson_pwm(chip);
> -       struct meson_pwm_channel_data *channel_data;
> -       unsigned long fin_freq;
> -       unsigned int hi, lo;
> -       u32 value;
> -
> -       channel_data =3D &meson_pwm_per_channel_data[pwm->hwpwm];
> -       fin_freq =3D clk_get_rate(meson->channels[pwm->hwpwm].clk);
> +               value =3D readl(meson->base + REG_MISC_AB);
> +               value |=3D channel_data->pwm_en_mask;
>
> -       value =3D readl(meson->base + REG_MISC_AB);
> -       state->enabled =3D value & channel_data->pwm_en_mask;
> +               if (meson->data->has_constant) {
> +                       value &=3D ~channel_data->const_en_mask;
> +                       /* The signal is constant when one phase is empty=
 */
> +                       if (!wfhw->hi || !wfhw->lo)
> +                               value |=3D channel_data->const_en_mask;
> +               }
>
> -       if (meson->data->has_polarity && (value & channel_data->inv_en_ma=
sk))
> -               state->polarity =3D PWM_POLARITY_INVERSED;
> -       else
> -               state->polarity =3D PWM_POLARITY_NORMAL;
> +               if (meson->data->has_polarity) {
> +                       value &=3D ~channel_data->inv_en_mask;
> +                       if (wfhw->inverted)
> +                               value |=3D channel_data->inv_en_mask;
> +               }
>
> -       value =3D readl(meson->base + channel_data->reg_offset);
> -       lo =3D FIELD_GET(PWM_LOW_MASK, value);
> -       hi =3D FIELD_GET(PWM_HIGH_MASK, value);
> +               writel(value, meson->base + REG_MISC_AB);
> +       } else {
> +               value =3D readl(meson->base + REG_MISC_AB);
> +               value &=3D ~channel_data->pwm_en_mask;
> +               writel(value, meson->base + REG_MISC_AB);
> +       }
>
> -       state->period =3D meson_pwm_cnt_to_ns(fin_freq, lo + hi);
> -       state->duty_cycle =3D meson_pwm_cnt_to_ns(fin_freq, hi);
> +       spin_unlock_irqrestore(&meson->lock, flags);
>
>         return 0;
>  }
> @@ -369,8 +424,11 @@ static int meson_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  static const struct pwm_ops meson_pwm_ops =3D {
>         .request =3D meson_pwm_request,
>         .free =3D meson_pwm_free,
> -       .apply =3D meson_pwm_apply,
> -       .get_state =3D meson_pwm_get_state,
> +       .sizeof_wfhw =3D sizeof(struct meson_pwm_waveform),
> +       .round_waveform_tohw =3D meson_pwm_round_waveform_tohw,
> +       .round_waveform_fromhw =3D meson_pwm_round_waveform_fromhw,
> +       .read_waveform =3D meson_pwm_read_waveform,
> +       .write_waveform =3D meson_pwm_write_waveform,
>  };
>
>  static int meson_pwm_init_clocks_meson8b(struct pwm_chip *chip,
>
> ---
> base-commit: 2e0a43a9e6f2e846f370aa63ea274f5403628b79
> change-id: 20260710-pwm_meson_convert_to_waveform_api-8711b7f8c755
>
> Best regards,
> --
> Alexandre Mergnat <amergnat@baylibre.com>
>
