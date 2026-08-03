Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19533C1BD
	for <linux-pwm@vger.kernel.org>; Mon,  3 Aug 2026 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785732495; cv=none; b=YMP3DF5Ipi+O8uNpghfc7xfOI/KVNC74Iv5oK7Zw72tSLhTFPNnxSpJRJoQ28kclCxkooYSMwC93CfdmM/cpCCRjqFVW9Ukynk9lL9wePcUSCoV/yVfw/WfV2Tn6qWCdEaRNkIWMYIBEsz1KjVuooEPzvCsVmp5YGZ/GnCh1Vjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785732495; c=relaxed/simple;
	bh=PXTpUFFxfLcQ8bCrLbv7JGiWMl2bbsUpe/ewaTrtbKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjbil90egE73JWrBlNXKX+3GpUy9We98vqBhdaCpZ+jvPIWwEaOI6meHvDH4lfIWMJtG6QCRNoVl6DrhnN3dgHbC4CSsInEVobvcBJ6p/U2l7Ne27DhDMApFJEKy7n97tAYjiw+uhah3g0nDsrCHWlooP/hWUbdHUGgWauR+cGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvDMmZrR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvDMmZrR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so9654935e9.3
        for <linux-pwm@vger.kernel.org>; Sun, 02 Aug 2026 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785732492; x=1786337292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eidjmnrjKXjAWJf77xTqxScnhJGnGwTlBVkDzO31WGk=;
        b=jvDMmZrRPu/UDJOlLuN5gXnSkgx9ebueylPMRhwIoE0/mnL7JW0pkqwwbGBtN8EfgQ
         VE3XgPlEFsscORG/QnsRSzAVSIoLltcNGX9soQ7jQLVKPB6jYtHeFhXse9r1sMmu5MFD
         WrOv+x0peibqEs0AUPTnZIYqK/RHpTYyiilgJywYs1Z7SUT3RQn3VQ84X1PFqnPUQnnk
         EIWWjVtPwBgrFOpD2pH+LPYsy80iBW8XRXKfbmwS5N48dGIYaznf8Y36c1+RfdePJuPo
         vFJ60F9Pa0+cVU0flaMmL3AZVtZ8JkF4lw0i3D25fdnyZ47vyIDOU8UWh9Hf6t50hiRy
         DfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785732492; x=1786337292;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eidjmnrjKXjAWJf77xTqxScnhJGnGwTlBVkDzO31WGk=;
        b=EFCzm0OVU1LpAqAElA6gFXlZhv3nQVdMpQkuHn3XVWPhzt7ndU1P49ybse0Lx/kCDx
         1qgSdVVaBEeuhRiGkwKMAhVCov2BGlTItke/XGyzRL6QXc3kKO8+oYAwSSq7H0J4jjBe
         xt7kORPXxu64KOxg+hxDEJ1I77LIVTVMszGjapNV8SIE4yplZj4kQNomyX+dZ2MbB1FO
         R08Go0/LU8M0/hy5jU6vkVbNmW+/fu6d5wyPCT5O20jetbdRTrZmupjgxXIvGkxN74mu
         0eEZcI/RHoM3dTfxwDk8uaFl1znlgYnRXv8zRFPkrlJeuwDWfDfIR5gyFsx9O7bL0KSt
         mTqA==
X-Forwarded-Encrypted: i=1; AHgh+RoQynjwfD3JyZyxnu18yroRpUlfExU4FYkQB4VB7aWU5nXVXF3LHnkHtZwGyEUIZg/hDQWj++DpJHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+BL7EQRmsEljQPdoiYiKKPxajWqAeucC0sBDggYKkkDeG+JC
	btY5ix+UZyDvGYUb0GHRmc9M7cCEFRqLJJWGJsqmGUT1bsNVfX/5VRu8
X-Gm-Gg: AR+sD114iuvQ1jxH8AHaY8RP/eeN23eKxvBlwG8P4me1HTdRVFGbkFk9Lz6JGxeMkAi
	5p4/XNLX0kpHQlQbOPc0RwUW+LiesHNS/S6jkYTtg6+cf7TWX8hHX3rZo0UXVJSKa86+4KNxWLr
	JR/3k8ShIK4T0lbWjyxm7kjuqlj5AK/2RWvRKcv6oKHkJS6d51sQkVMvUFc9lkpgCqqR4jy8d8N
	bqaFXNN4CQhMBxjTIdA7MrRlorOiLqQJtjaZhFfdXORfwCqYWzfYiPqL72tzQm8iCIF+wOPIpjR
	m+iWChimH1sXlmPkWqr4MYWxj7WV2IplFkgbPCQ2Dce7rUVpTbhDoSXZPYTNh4tBhp0FXcZnY24
	zZHceTZWAc55hc3/b5qJCGLaGYZFIS+ugkUpP9k7HazBMwkYAx+kARv+WBoFq3amo8Umn9BpBCW
	Kh/CKixBG5iUp53BBe9cw89VyDo80FBHrmhjHU0Edir4mYAcMcAj9l654UtA05j1ts1VpuJ408A
	0rnGZsxCPDuVnYkDU001gur7Bm8/UCb6Fyi5H6Fdpg80/iL3vgD6bd6wHTXNKbX+o27PQ==
X-Received: by 2002:a05:600c:3e15:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-4980c649cbcmr183578235e9.3.1785732491559;
        Sun, 02 Aug 2026 21:48:11 -0700 (PDT)
Received: from rocinante (lfbn-tou-1-1098-107.w90-76.abo.wanadoo.fr. [90.76.164.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm90376415e9.1.2026.08.02.21.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 21:48:11 -0700 (PDT)
From: Stephane Lepain <stephanelepain@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-pwm@vger.kernel.org,
	Kenneth Kasilag <kenneth@kasilag.me>,
	George Moussalem <george.moussalem@outlook.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Baruch Siach <baruch.siach@siklu.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephane Lepain <stephanelepain@gmail.com>
Subject: [PATCH v3] pwm: ipq: fix period calculation
Date: Mon,  3 Aug 2026 06:47:48 +0200
Message-ID: <20260803044748.27116-1-stephanelepain@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731070427.155221-1-stephanelepain@gmail.com>
References: <20260731070427.155221-1-stephanelepain@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kenneth Kasilag <kenneth@kasilag.me>

ipq_pwm_apply() fixes pwm_div at its maximum and derives only pre_div
from the requested period. Since the period spans
(pre_div + 1) * (pwm_div + 1) input clocks, pinning pwm_div near its
maximum forces pre_div towards zero for short periods: once pre_div
rounds to 0 the shortest representable period is (pwm_div + 1) / clk_rate,
and any shorter request is rejected outright:

	pre_div = mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
				      (u64)NSEC_PER_SEC * (pwm_div + 1));
	if (!pre_div)
		return -ERANGE;

Four-wire fans commonly expect a ~25 kHz PWM, which is therefore
unusable. On an IPQ6018 with the PWM block clocked at 100 MHz, a
40,000 ns (25 kHz) request computes floor(0.061) == 0 and returns
-ERANGE deterministically. Where a request is not rejected outright, the
high duration truncates to 0 and the output collapses to ~0% duty.

Search for the (pre_div, pwm_div) pair whose period best approximates
the request instead of fixing pwm_div. Starting pre_div at the smallest
value that keeps pwm_div within its field and stopping once pre_div
exceeds pwm_div bounds the loop and keeps pwm_div as large as possible
for fine duty resolution. For a 25 kHz request at 100 MHz this selects
pre_div = 0, pwm_div = 3999, i.e. exactly 4000 clocks, with full 0..4000
duty resolution.

While reworking the high-duration computation, round it to nearest
rather than truncating, so mid-range duty cycles are not biased low, and
clamp it to pwm_div + 1. Rounding, or a 100% duty request, could
otherwise push hi_dur past the period length and overflow the 16-bit
HI_DURATION field.

This was first fixed downstream in OpenWrt for the qualcommbe target
after testing on the Askey SBE1V1K, and has since been applied to
OpenWrt's qualcommax target as well.

Tested on a GL.iNet GL-AXT1800 (IPQ6018, 100 MHz PWM clock) whose DTS
requests a 25 kHz period for its four-wire fan:

  pwms = <&pwm 1 40000 0>;

Before, pwm-fan failed to probe on every boot:

  pwm-fan pwm-fan: failed to enable PWM
  pwm-fan pwm-fan: Failed to configure PWM: -34
  pwm-fan pwm-fan: probe with driver pwm-fan failed with error -34

The same failure is reproducible without pwm-fan, straight from sysfs:

  # echo 40000   > period; echo 1 > enable   -> write error (-ERANGE)
  # echo 2700000 > period; echo 1 > enable   -> succeeds

Because probe returns before the tachometer IRQ is requested and before
fan-supply is claimed, the board also lost fan RPM reporting and its
vcc_fan regulator stayed disabled, leaving the DTS cooling-maps with no
cooling device to bind to.

After, pwm-fan probes cleanly and the fan is confirmed spinning by its
own tachometer:

  /sys/class/hwmon/hwmon7/name                          = pwmfan
  /sys/devices/platform/pwm-fan/hwmon/hwmon7/fan1_input = 3548
  /sys/class/regulator/regulator.3 (vcc_fan)            = enabled
  /sys/class/thermal/cooling_device1                    = pwm-fan

with idle SoC temperature dropping from ~76 °C to ~51 °C.

Fixes: c436e3e9c265 ("pwm: Driver for qualcomm ipq6018 pwm block")
Signed-off-by: Kenneth Kasilag <kenneth@kasilag.me>
[Stephane: dropped the explanatory comment, the unreachable
 clk_rate > 16 GHz bound and the unrelated hi_div cast, per review]
Tested-by: Stephane Lepain <stephanelepain@gmail.com>
Signed-off-by: Stephane Lepain <stephanelepain@gmail.com>
---
Changes in v3:
- Resend: v2 accidentally carried a stray copy of the whole driver at
  t/drivers/pwm/pwm-ipq.c (a leftover verification directory that got
  swept into the commit). Only drivers/pwm/pwm-ipq.c is touched here.
- No functional change from v2.

Changes in v2 (per Konrad Dybcio's review):
- Dropped the explanatory comment above the divider search; the rationale
  lives in the commit message.
- Dropped the "clk_rate > 16 * GIGA" bound. period_ns is already clamped
  to IPQ_PWM_MAX_PERIOD_NS (1e9), so period_ns * clk_rate only overflows
  u64 above ~18.4 GHz, i.e. ~184x the 100 MHz this block runs at; the
  check was unreachable.
- Dropped the "(u64)hi_div" cast as unrelated. It is not a live bug
  either: hi_dur and pre_div both come from 16-bit fields, so the worst
  case 65535 * 65536 = 4294901760 still fits u32 (effective_div on the
  line above genuinely does need the cast, at 65536 * 65536).
- Behaviour is unchanged: for 40,000 ns at 100 MHz the search still
  selects pre_div = 0, pwm_div = 3999.

 drivers/pwm/pwm-ipq.c | 91 ++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index c533739..797559d 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -89,10 +89,10 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
-	unsigned int pre_div, pwm_div;
-	u64 period_ns, duty_ns;
+	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
+	u64 period_ns, duty_ns, period_rate, min_diff;
 	unsigned long val = 0;
-	unsigned long hi_dur;
+	u64 hi_dur;
 
 	if (!state->enabled) {
 		/* clear IPQ_PWM_REG1_ENABLE */
@@ -112,35 +112,74 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
 	duty_ns = min(state->duty_cycle, period_ns);
 
-	/*
-	 * Pick the maximal value for PWM_DIV that still allows a
-	 * 100% relative duty cycle. This allows a fine grained
-	 * selection of duty cycles.
-	 */
-	pwm_div = IPQ_PWM_MAX_DIV - 1;
+	period_rate = period_ns * ipq_chip->clk_rate;
+
+	best_pre_div = IPQ_PWM_MAX_DIV;
+	best_pwm_div = IPQ_PWM_MAX_DIV;
+	min_diff = period_rate;
 
 	/*
-	 * although mul_u64_u64_div_u64 returns a u64, in practice it
-	 * won't overflow due to above constraints. Take the max period
-	 * of 10^9 (NSEC_PER_SEC) and the pwm_div + 1 (IPQ_PWM_MAX_DIV)
-	 *  10^9 * 10^8
-	 * ------------- => which fits well into a 32-bit unsigned int.
-	 * 10^9 * 65,535
+	 * Smaller pre_div than this cannot represent the period (pwm_div would
+	 * have to exceed its field), so start the search there.
 	 */
-	pre_div = mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
-				      (u64)NSEC_PER_SEC * (pwm_div + 1));
-
-	if (!pre_div)
-		return -ERANGE;
+	pre_div = div64_u64(period_rate,
+			    (u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
+
+	for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
+		u64 remainder;
+
+		pwm_div = div64_u64_rem(period_rate,
+					(u64)NSEC_PER_SEC * (pre_div + 1),
+					&remainder);
+		/* pwm_div is unsigned; the swap check below catches underflow */
+		pwm_div--;
+
+		/*
+		 * Swapping pre_div and pwm_div yields the same period but a
+		 * larger pwm_div gives finer duty resolution, so once pre_div
+		 * exceeds pwm_div every further candidate is strictly worse.
+		 */
+		if (pre_div > pwm_div)
+			break;
+
+		/* need room for 100% duty, where hi_dur == pwm_div + 1 */
+		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
+			continue;
+
+		if (remainder < min_diff) {
+			best_pre_div = pre_div;
+			best_pwm_div = pwm_div;
+			min_diff = remainder;
+
+			if (min_diff == 0)
+				break;
+		}
+	}
 
-	pre_div -= 1;
+	pre_div = best_pre_div;
+	pwm_div = best_pwm_div;
 
-	if (pre_div > IPQ_PWM_MAX_DIV)
-		pre_div = IPQ_PWM_MAX_DIV;
+	/*
+	 * If the search found no usable candidate, best_pwm_div is left at
+	 * IPQ_PWM_MAX_DIV; cap it so pwm_div + 1 still fits the 16-bit field
+	 * and 100% duty remains expressible.
+	 */
+	if (pwm_div > IPQ_PWM_MAX_DIV - 1)
+		pwm_div = IPQ_PWM_MAX_DIV - 1;
 
-	/* pwm duty = HI_DUR * (PRE_DIV + 1) / clk_rate */
-	hi_dur = mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
-				     (u64)NSEC_PER_SEC * (pre_div + 1));
+	/*
+	 * high duration = duty_ratio * (pwm_div + 1)
+	 *              = duty_ns * clk_rate / ((pre_div + 1) * NSEC_PER_SEC)
+	 *
+	 * Round to nearest to avoid biasing every duty cycle low, then clamp
+	 * to (pwm_div + 1): rounding or a 100% request can otherwise push
+	 * hi_dur past the period, overflowing the 16-bit HI_DURATION field
+	 * and asking the hardware to stay high beyond one period.
+	 */
+	hi_dur = DIV64_U64_ROUND_CLOSEST(duty_ns * ipq_chip->clk_rate,
+					 (u64)(pre_div + 1) * NSEC_PER_SEC);
+	if (hi_dur > (u64)pwm_div + 1)
+		hi_dur = (u64)pwm_div + 1;
 
 	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
 		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
-- 
2.55.0

