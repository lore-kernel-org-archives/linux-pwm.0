Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A836C0D6
	for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2026 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481593; cv=none; b=GNUbjT27fAh8piRWvCzIthkXiBnz8J+ljvn25uxVgU/WuCwkMNEwFFSMM7tzSmTWbGsqeQkTeOXNXQ1anv0jFk8xRTR9k0YXLFIg+ecvP1z5TLNLCt84rNfrl8A4+G3MJsn+xUmuaL2LMdmkN6aHB+ua3db3aVom2i7BeYm79ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481593; c=relaxed/simple;
	bh=bMlMzpNZgnDCsAf7WdgXqrfIrIswbj8QSlguBmRvcZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CrJE59o5EF4PjYqJ14CAcvcYvpaam1SjuLFQS5ORJDfWxwRHfkRIoBqZkwY6vPdRLcwJy7aKyeqYIycJesHp69cJ8jl3mTGNcaES9I8et4ZzZzQF/np6KERJgEQmYFNV4CRvExW4aQmRejGeSZPug9JjQ0WpUM8ZfVSPKW/m9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBDC/C1j; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBDC/C1j"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so350367f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 31 Jul 2026 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785481588; x=1786086388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQP3A8Ri8GoyiqwKZFBiae11D7hzkz6JOLVj9BPG99A=;
        b=OBDC/C1jZ9+jAozsXY2s8Rc/YHFbi4FFDx05rOw5zn6wiPmCgZvCWRDO8MYMmfPi2a
         3km9lla+cvTz/6WOTGaOcqPK2si7bXAhyRSinSQJNEuVbpu/24ffC0zbmAT3324+BVrE
         qP3gdI0AtV2+m9wQsmluyWjPrYGIfiOsNk0O1sUCrNmsegzpeRXCVwuFfP9g1+iwrWZh
         5GvyNLRQfqEFdfEu6bU3tDyW+KGu6WuFbYJgBwnUwM2Hasx4Y9lMFxe1x7AvbF0GoEWE
         nSyJW26etJQ15+Jd1P3aMI8Dhq6AetITlFkkZ78Aie6HXDRZY7sWeUpwpQ91hkZ3JiUM
         Xnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785481588; x=1786086388;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQP3A8Ri8GoyiqwKZFBiae11D7hzkz6JOLVj9BPG99A=;
        b=az70LgNz63/ilkFL8BX5M0PYV8UK0cDWyfBzdebneISk0OhrcyLv8fBb/1DZj9xfJH
         pUYT7VtF+NKIu63aYkgKY3WZ8nOmucW+WfKI4B7xoPLbEcWvryOwBnnhqpxOIYFrk4bp
         jQfQauW3IFfImUHRVzgQSR1vtChMYoxcYcyzsrCiXln8m/8TjuCfd5oYmDa/KLYZjXGP
         ow8HDcEoQr/Tz6KQADzYWSCIm7hoYulnbuxHkxfBpcQIgPGFvTP7M+ec6I/vKFHyTn0Z
         91GVT47t8uzPN/4TTxLgDH5wzh/32QFrkFmMY0ouGEqHVgcqCz5Q9c9ucNXIMUUUuLqT
         lpOw==
X-Gm-Message-State: AOJu0YwW2eHHaPsfe8QW/ep3slgh7Uui3Lap0epVdD/joCAo3RocuwPg
	5M3txtjrw2EVg36T+muAdFL1HH/kyHShPskuxxwspRMKdH79ZTvbBZ4Y
X-Gm-Gg: AR+sD13higCoKqFzmguAGCEAmj9w9z7wP3o74mYqvAXU0Wc2ON8RbH5QhP7okOELeFX
	k6u5iIDl1OHtjsdiGClNBrm7Z4AsEzlLErd/j5Un+0SFrSuiSHCN/YUK9XKbnL9nOG+GVbZojKl
	oeeSg1kdLpa3mV0qU0MKF/2szeULo03gzRwkCO6Ii/MJEUPJBlwt9szS7SA4V/IZGoFMcKz+P9U
	FnWwdFrRhbVgqqJGPWE93Bv9+2jNjleSKYmgwqtRVSrzo4/B2ETVrhVnsec6st3R1F2NKY4ILoY
	Kwy9Q6YMtZ5TuI0N+ozsNQBVyWXf6OBlLpG4YsRv4+s83qlRnGn+I4F1oFs3dnnZrG1j1DEaAiv
	YQO3avbyHZl3f0zXui03uIa42uF3118gg0t+jLqfbX6DAJ1EVAJBbQ+lWvF4uJYFstvMeoiAmQs
	SRGPU2fD82f5RvNqKERaQbZQl7diufH3yBO/vry4BKTfGf4VnspLW1SvmKj2miWORsgNDcz8Xha
	sdVsAG07cNsBWgRa52MV1ThS7moDUeKTouxJpe+1Ptz6RdbbRzahJ/229bN/glQae1O7Q==
X-Received: by 2002:a05:6000:25c1:b0:47e:96f4:4a5b with SMTP id ffacd0b85a97d-47fd2b5a058mr2035326f8f.51.1785481587728;
        Fri, 31 Jul 2026 00:06:27 -0700 (PDT)
Received: from rocinante (lfbn-tou-1-1098-107.w90-76.abo.wanadoo.fr. [90.76.164.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ab61sm1276850f8f.25.2026.07.31.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:06:27 -0700 (PDT)
From: Stephane Lepain <stephanelepain@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	Kenneth Kasilag <kenneth@kasilag.me>,
	George Moussalem <george.moussalem@outlook.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Baruch Siach <baruch.siach@siklu.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephane Lepain <stephanelepain@gmail.com>
Subject: [PATCH] pwm: ipq: fix period calculation
Date: Fri, 31 Jul 2026 09:05:42 +0200
Message-ID: <20260731070542.155398-1-stephanelepain@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Also compute hi_div in get_state() in 64-bit; hi_dur * (pre_div + 1) can
exceed 32 bits before the existing promotion.

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
Tested-by: Stephane Lepain <stephanelepain@gmail.com>
Signed-off-by: Stephane Lepain <stephanelepain@gmail.com>
---
 drivers/pwm/pwm-ipq.c | 101 +++++++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index c533739..2d8a013 100644
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
@@ -113,34 +113,85 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty_ns = min(state->duty_cycle, period_ns);
 
 	/*
-	 * Pick the maximal value for PWM_DIV that still allows a
-	 * 100% relative duty cycle. This allows a fine grained
-	 * selection of duty cycles.
+	 * The period spans (pre_div + 1) * (pwm_div + 1) input clocks. Rather
+	 * than fixing pwm_div at its maximum (which gives usable duty
+	 * resolution only for long periods and collapses to ~0% for short
+	 * periods) search for the (pre_div, pwm_div) split whose period best
+	 * approximates the request while leaving pwm_div large enough to
+	 * resolve the duty cycle.
 	 */
-	pwm_div = IPQ_PWM_MAX_DIV - 1;
+	if (ipq_chip->clk_rate > 16ULL * GIGA)
+		return -EINVAL;
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
+	 * to (pwm_div + 1): rounding or a 100% duty request can otherwise push
+	 * hi_dur past the period length and overflow the 16-bit HI_DURATION field
+	 * (which would alias a full-on request down to a near-zero high time)
+	 * and asking the hardware to stay high beyond one period. pwm_div is
+	 * at most IPQ_PWM_MAX_DIV - 1, so pwm_div + 1 always fits the field.
+	 */
+	hi_dur = DIV64_U64_ROUND_CLOSEST(duty_ns * ipq_chip->clk_rate,
+					 (u64)(pre_div + 1) * NSEC_PER_SEC);
+	if (hi_dur > (u64)pwm_div + 1)
+		hi_dur = (u64)pwm_div + 1;
 
 	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
 		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
@@ -186,7 +237,7 @@ static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC,
 					   ipq_chip->clk_rate);
 
-	hi_div = hi_dur * (pre_div + 1);
+	hi_div = (u64)hi_dur * (pre_div + 1);
 	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC,
 					       ipq_chip->clk_rate);
 
-- 
2.55.0

