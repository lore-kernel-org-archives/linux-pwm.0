Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E037268D
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315927; cv=none; b=N2EZxJ0UU4sfmgBN5qq5Ro3+N1iP/KfXu+rlhD5vGByuYEnzbUlvS6uC3VYFS4rBt20pAyXMkeQCUbb+MZvvvOiNNXCyC80zTQayDSHVy+h3rG95uzhDS255WEJYFIjvbgdBLThemDzYccGQHrh5ZuWZhZvj9JMePd9GztTHb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315927; c=relaxed/simple;
	bh=qI0/iXFXVOR+SOwwsLfV9tfW+ickIia9hOREj+cs6Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kw6DsRHyCwqBrqo9dYlwypu6TWieUcS7B/VxHXbhS7/v9oMxSGlv3gmgflIQby/hvg4c660nSF/XtkYC3tT60b9i/kP+b8Y8PEkbJ+li9+qBgrp9kjKiUqZByAyKcxKmbeG/KFSO3wKZEw9OQGMVdXXVK0r83yjPohhlqivbTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=k+Xqk5mc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="k+Xqk5mc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472326ca506so6497497f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2026 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784315921; x=1784920721; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lWIRT5uS2ksF/3R5X9j6L1l/EYTREprkeYSc920eioM=;
        b=k+Xqk5mcnrYxo2SILqvElTOki5892rpl3c2r4hbBx7dsJgrMPC416iVJlRFcMlIhPf
         fFU5L+PIjeDdLERWN1feDbb9Kc0cLfKiyZvYb65TAcZQs89sMjSb7AS62N4XtKYCQHwg
         8KxYWKkCEOwi/vm3k/lttgseM5WtN/oOyp8ttmNOq+Z31EokkGPtEWViTSzMlq/hZf4x
         ciT1550iW00S+2sUnWihv5SBu35AqqTlUBu/RdGfvGlA6PnOnLkpkqUw2Xjr6nU2MjlZ
         rtnj4oYsMJJAbjgmDBNQOLVESkImhqJ7s2UhKV4UZ1DD7/2W9o5iHwJa85b/G5m7GIjb
         mPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315921; x=1784920721;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lWIRT5uS2ksF/3R5X9j6L1l/EYTREprkeYSc920eioM=;
        b=WLHVFgNRrdn5CdJQNaxQtiJP+gkb+ZGI4DC6WlleTvTFqjxY8tmBOZ2x7F6/1//mOV
         Uu/gJmy6SQSXEBfJrZgf6QGbWxsAngqhQrutyzn4pZaH5DBZZkMhgGcgKDH4IqCjjdyp
         Aa8Hf6e7Ya3S+L4/lkh/dfiU76x/C0NyfyDJbUx84x1ryHzNT1B+w3lLQtiQaoxFFOUL
         1/2j+b/Cj7+xu26GWOe9zdE0EeAloXp+J7BkK52MYkYWPowTYYbjBc/oXiYN5AKNqmg7
         tVLbxiuFKcEIPQb5DvExqszH77Q3r59WPn48RHTh3vKa/mWWigocVpcEDFI+1jRNz9+a
         ihNg==
X-Gm-Message-State: AOJu0YyWmKyAzfyFI9l5k/Muv6W4KiRwSp/fzk2YfQUGv4pmdlo7kTWW
	cmbCFZr7JQ8qpu/IAONYsv1ejQeMWvNibVSWXoXm06c3xShFwMCy/6Tt+hHzq5UPHYI=
X-Gm-Gg: AfdE7cmkLcHNimoDTkv9CuMHFRr0fX1ywWmgWFTDfhyZDmnsfvFsId5PjQK99orSJVb
	tcvrCXRJfwM+STYJWNO7Zr6BRh3JCO/fdCHixQyeYjbdYjPynVoNXV9xj3QdgayBWUnhm5qHt4t
	OTydz5ZIW2VE61Vk/p+HYmHWVcwvUeVbHwGg61Fxrwncp1NpRcHJnW9GM0GJwhQBFwGANxRC8iI
	208NodtTJuc0u8q5cT6YLCzW4KEdxOCyGbn/4Ie0aPgLrwkUm3WZTjSgEi63qlZzcdM5yf6CgFn
	lWVuVnmX/uMGVUccb7zrv7tK8SlawGAdxeYTpSsB+60idp0FluSk04fi/b5hG3Ilwdp/w+eZq5W
	YMiktZ6bE6unjpXEqxbrcepJsvhcQfdikTLqH3RKNvrLD7S9TQ2CfXm71DaHMsV+F5yKGxaODk1
	JvaUsmTBB0QlBi+XVr/085EEYLDK93WYPhKe7FdOZOFA==
X-Received: by 2002:a05:6000:3113:b0:477:47c6:36e5 with SMTP id ffacd0b85a97d-47f6230dc46mr5668112f8f.25.1784315921371;
        Fri, 17 Jul 2026 12:18:41 -0700 (PDT)
Received: from [192.168.5.218] (88-127-185-231.subs.proxad.net. [88.127.185.231])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm6959880f8f.11.2026.07.17.12.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:18:40 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Fri, 17 Jul 2026 21:18:17 +0200
Subject: [PATCH] pwm: meson: Convert to waveform API
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pwm_meson_convert_to_waveform_api-v1-1-d7dbdae1318d@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPh/WmoC/yXN0QrCIBSA4VcZ5zpBB8vRq0SIs2OdQI+oc8HYu
 2d1+d38/w4FM2GBy7BDxkaFOHao0wDuaeMDBd27YZTjWWolRdqCCVg4GsexYa6mstlsQ885GJt
 IzFqpRfvZ6WmC3kkZPb1/j+vt77IuL3T1G4bj+AAdLElwhQAAAA==
X-Change-ID: 20260710-pwm_meson_convert_to_waveform_api-8711b7f8c755
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21833;
 i=amergnat@baylibre.com; h=from:subject:message-id;
 bh=qI0/iXFXVOR+SOwwsLfV9tfW+ickIia9hOREj+cs6Is=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBqWoAOdg74ltkM/S96oEZdAnGT4r621kzGAdRQD
 U24p20jFUKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCalqADgAKCRArRkmdfjHU
 RQqFD/0WyaGKhnIz+DEeCZTZH2CDpI8Ghx3rSuyXelbc+jQFXSmZf8AxqD4ubMBlkOgV9dd/eH8
 W5g+/4qD13Vy21TUUKBuAI4SBfWhfpDJxrymqw58WdvYvJwUfe5vWU7wM5fYZuHlLF+yx8tQkcI
 W865it0gZWg6PXHlLHJAiRJ9bsREMH/kaJ3j7QGBmDIsD8wZrKNdcf2Vu3r83XO7b2h5/wU64La
 mjK8OQid/GxblQbS6gTvnd/G4ek9W7ZT9Qr4w4p2DQLYBgEzFOdfP1gX5CcAtJhPcXjNloR7tut
 vbWpiTi8Ga+tWXL5s2B9WuIZFJwuSMBUMB6Z2UJBDWGKy4aRV/o7IWfR3UFxeNX/U+NtWok3YuN
 ZBo+Bf+nrb5Y6T/Zya5oyf5QLXA+KLyeTb1yTK35kL5tbU00VsrxzaV8Df9RrL1ZCCNZmvDMDD2
 TZ3yTY54TQW7sg5nskylkbnqxKMYfwUctoGlMNJi2rQwFIomR/uFlUwSE/9xtqpuzmyW5+J5SmF
 dCjO6q7+n2ubFAjP3m0ciNym/7tHzS4apdAK6TAMlBQe7jTpXWyv7y9sABDNtNz7n6HZzqeGrCW
 TNSeS623ApUCznZ2R0uxVL0SMAJ7wsQxeoo60tZpUkTHi8nn4YrixOA3EHUX0Uef4LAOCgVvkli
 GW5vT7/mA3Co5fQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

The PWM subsystem introduced a new waveform abstraction that
describes a PWM signal by period length, duty length and duty offset
instead of period, duty cycle and polarity. The meson driver still
uses the legacy .apply() and .get_state() callbacks and does not
implement the waveform callbacks, so consumers cannot use the
pwm_*_waveform() helper functions with it.

Adopt the new API by implementing .round_waveform_tohw(),
.round_waveform_fromhw(), .read_waveform() and .write_waveform()
with a private meson_pwm_waveform struct holding the hardware
representation. The cached channel state fields (rate, hi, lo,
constant, inverted) are removed; counter values are now computed in
.round_waveform_tohw() via clk_round_rate() without register writes,
then committed in .write_waveform().

The hardware invert bit places the duty active phase at the end of the
period on revisions that have it. Input clock rates are kept at or
below 1 GHz so each counter cycle remains representable in nanoseconds
by .round_waveform_fromhw(). Requests for which clk_round_rate() cannot
provide such a rate are rejected. Otherwise, period counts above the
16-bit range are clamped, while a zero count is rounded up to one and
signalled by .round_waveform_tohw() returning 1.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
The PWM core gained a new waveform abstraction that lets drivers
describe the hardware more directly and gives consumers access to
rounding and read-back without touching registers. The meson driver
still uses the legacy .apply() and .get_state() callbacks, so
consumers of its PWMs cannot benefit from the new pwm_*_waveform()
helpers.

This series implements the four waveform callbacks and removes the
cached channel state that the legacy .apply() path relied on.
Settings are now computed without side effects and committed in a
separate step, matching the split the waveform API requires.

Behavioural changes visible to consumers:

- On revisions without the invert bit, a nonzero duty offset is
  rounded down to zero. An inverted polarity request through the
  legacy path produces the same register settings as the previous
  "duty = period - duty" emulation, so the generated signal is
  unchanged for those consumers.

- Disabling a PWM no longer emulates an inactive-high output on
  revisions without the invert bit. The PWM API defines the output
  of a disabled PWM as undefined (this was already the case for
  .apply()), so affected consumers were relying on unspecified
  behaviour. Consumers that need an inactive high output should keep
  the PWM enabled with inverted polarity and zero duty cycle.

- Input clock rates are kept at or below 1 GHz so counter cycles remain
  representable in nanoseconds. Requests for which clk_round_rate()
  cannot provide such a rate are rejected. Otherwise, period counts
  exceeding the 16-bit range are clamped. A zero count is rounded up to
  one, signalled by .round_waveform_tohw() returning 1.

- Reported period and duty cycle values are rounded up instead of
  down, so a returned setting reproduces the same counter values
  when applied again. The constant output bit is now derived from
  the converted counter values, which also covers cases where the
  ns-to-counter conversion yields an empty high or low phase.
  clk_set_rate() failures now propagate as write errors instead of
  being logged and ignored, and .write_waveform() now also fails if
  the input clock rate changed between rounding and writing.

Testing
=======

Tested on a Libre Computer Le Potato (AML-S905X-CC, Amlogic S905X /
GXL SoC) with CONFIG_PWM_DEBUG=y, built in tree. Three PWM nodes were
enabled in the board device tree (pwm_ab, pwm_ef, pwm_AO_ab), exposing
6 channels across the EE and AO clock domains.

The libpwm tools drive the /dev/pwmchipN character device directly, so
the new waveform callbacks are exercised through their own ioctls. All
6 channels went through pwmround for rounding queries (ROUNDWF:
standard, too-short and too-long periods, zero and full duty, duty
offsets, non-representable values), pwmset for rounded and exact
settings (SETROUNDEDWF / SETEXACTWF) with hardware read-back through
debugfs (.read_waveform()), and pwmtestperf duty sweeps. pwmtestperf
was run in all four direction/polarity combinations at 100 us, 1 ms and
10 ms (72 runs), then with a 1 ns step at a non-tick-aligned period so
every duty and duty-offset rounding boundary is crossed (about 24000
boundary checks). PWM_DEBUG's rounding and read-back checks stayed
silent throughout.

ROUNDWF and SETEXACTWF agree as specified: SETEXACTWF applies exactly
representable waveforms and returns -EDOM otherwise. 1 ms is exact on
the EE chips and rounds to 999990 ns on the AO chip, reflecting
each PWM's clock granularity. A 1 ns period request is
rounded up to the shortest representable period with zero duty,
signalled by .round_waveform_tohw() returning 1. Periods too long for
the source clock to represent (349.52 ms on this board) are rejected
with -EINVAL when clk_round_rate() cannot provide a low enough rate.
GXL has no invert bit (has_polarity = false), so nonzero duty offsets
are rounded down to zero and the axg/g12/s4 invert paths are not
exercisable on this board.

The sysfs interface (50%/25%/0%/100% duty, polarity inversion,
enable/disable on all 6 channels) was also exercised and reads back
consistently, confirming no regression for legacy consumers.
---
 drivers/pwm/pwm-meson.c | 372 ++++++++++++++++++++++++++++--------------------
 1 file changed, 215 insertions(+), 157 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8c6bf3d49753..be17aae0941b 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -6,11 +6,11 @@
  * PWM output is achieved by calculating a clock that permits calculating
  * two periods (low and high). The counter then has to be set to switch after
  * N cycles for the first half period.
- * Partly the hardware has no "polarity" setting. This driver reverses the period
- * cycles (the low length is inverted with the high length) for
- * PWM_POLARITY_INVERSED. This means that .get_state cannot read the polarity
- * from the hardware.
- * Setting the duty cycle will disable and re-enable the PWM output.
+ * Some of the IP block revisions have an invert bit that swaps the high and
+ * low parts of the output. This is used to implement waveforms with
+ * duty_offset_ns + duty_length_ns == period_length_ns, i.e. what the legacy
+ * API calls inverted polarity. On the other revisions a nonzero duty_offset_ns
+ * is rounded down to zero.
  * Disabling the PWM stops the output immediately (without waiting for the
  * current period to complete first).
  *
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -96,12 +97,6 @@ static struct meson_pwm_channel_data {
 };
 
 struct meson_pwm_channel {
-	unsigned long rate;
-	unsigned int hi;
-	unsigned int lo;
-	bool constant;
-	bool inverted;
-
 	struct clk_mux mux;
 	struct clk_divider div;
 	struct clk_gate gate;
@@ -156,30 +151,44 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(channel->clk);
 }
 
-static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
-			  const struct pwm_state *state)
+struct meson_pwm_waveform {
+	unsigned long rate;
+	u16 hi;
+	u16 lo;
+	bool enabled;
+	bool inverted;
+};
+
+static int meson_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_waveform *wf,
+					 void *_wfhw)
 {
+	struct meson_pwm_waveform *wfhw = _wfhw;
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int cnt, duty_cnt;
+	u64 cnt, duty_cnt, freq;
 	long fin_freq;
-	u64 duty, period, freq;
+	int ret = 0;
 
-	duty = state->duty_cycle;
-	period = state->period;
+	if (wf->period_length_ns == 0) {
+		*wfhw = (struct meson_pwm_waveform){
+			.enabled = false,
+		};
+
+		return 0;
+	}
 
 	/*
-	 * Note this is wrong. The result is an output wave that isn't really
-	 * inverted and so is wrongly identified by .get_state as normal.
-	 * Fixing this needs some care however as some machines might rely on
-	 * this.
+	 * Get the highest input clock rate that makes the requested period
+	 * representable with the 16 bit wide counters, but at most 1 GHz so
+	 * one counter cycle stays at least a nanosecond long, which
+	 * .round_waveform_fromhw() relies on. clk_round_rate() may round up
+	 * past the requested rate, so reject a too-high result below.
 	 */
-	if (state->polarity == PWM_POLARITY_INVERSED && !meson->data->has_polarity)
-		duty = period - duty;
-
-	freq = div64_u64(NSEC_PER_SEC * 0xffffULL, period);
-	if (freq > ULONG_MAX)
-		freq = ULONG_MAX;
+	freq = div64_u64((u64)NSEC_PER_SEC * FIELD_MAX(PWM_LOW_MASK),
+			 wf->period_length_ns);
+	freq = min_t(u64, freq, NSEC_PER_SEC);
 
 	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq <= 0) {
@@ -188,180 +197,226 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 		return fin_freq ? fin_freq : -EINVAL;
 	}
 
-	dev_dbg(pwmchip_parent(chip), "fin_freq: %ld Hz\n", fin_freq);
-
-	cnt = mul_u64_u64_div_u64(fin_freq, period, NSEC_PER_SEC);
-	if (cnt > 0xffff) {
-		dev_err(pwmchip_parent(chip), "unable to get period cnt\n");
+	if (fin_freq > NSEC_PER_SEC) {
+		dev_err(pwmchip_parent(chip),
+			"source clock frequency %ld too high\n", fin_freq);
 		return -EINVAL;
 	}
 
-	dev_dbg(pwmchip_parent(chip), "period=%llu cnt=%u\n", period, cnt);
-
-	if (duty == period) {
-		channel->hi = cnt;
-		channel->lo = 0;
-		channel->constant = true;
-	} else if (duty == 0) {
-		channel->hi = 0;
-		channel->lo = cnt;
-		channel->constant = true;
-	} else {
-		duty_cnt = mul_u64_u64_div_u64(fin_freq, duty, NSEC_PER_SEC);
-
-		dev_dbg(pwmchip_parent(chip), "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+	/*
+	 * If the requested period is too long to be counted even at the
+	 * lowest possible input clock rate, implement the longest possible
+	 * period instead.
+	 */
+	cnt = mul_u64_u64_div_u64(fin_freq, wf->period_length_ns, NSEC_PER_SEC);
+	cnt = min_t(u64, cnt, FIELD_MAX(PWM_LOW_MASK));
+
+	if (cnt == 0) {
+		/*
+		 * The requested period is shorter than one cycle of the
+		 * fastest available input clock, implement the minimal
+		 * period with zero duty cycle (the general calculation below
+		 * yields that as duty_length_ns and duty_offset_ns cannot
+		 * exceed the requested period) and signal the rounding up
+		 * in the return value.
+		 */
+		cnt = 1;
+		ret = 1;
+	}
 
-		channel->hi = duty_cnt;
-		channel->lo = cnt - duty_cnt;
-		channel->constant = false;
+	duty_cnt = mul_u64_u64_div_u64(fin_freq, wf->duty_length_ns, NSEC_PER_SEC);
+	duty_cnt = min(duty_cnt, cnt);
+
+	*wfhw = (struct meson_pwm_waveform){
+		.rate = fin_freq,
+		.hi = duty_cnt,
+		.lo = cnt - duty_cnt,
+		.enabled = true,
+	};
+
+	if (meson->data->has_polarity && duty_cnt) {
+		u64 offset_cnt = mul_u64_u64_div_u64(fin_freq, wf->duty_offset_ns,
+						     NSEC_PER_SEC);
+
+		/*
+		 * Waveforms with duty_offset_ns + duty_length_ns ==
+		 * period_length_ns are implemented by inverting the output:
+		 * The signal then is low for hi counts (the offset) followed
+		 * by high for lo counts (the duty cycle). Other nonzero
+		 * duty_offset_ns values are rounded down to 0.
+		 */
+		if (offset_cnt && duty_cnt + offset_cnt >= cnt) {
+			swap(wfhw->hi, wfhw->lo);
+			wfhw->inverted = true;
+		}
 	}
 
-	channel->rate = fin_freq;
+	dev_dbg(pwmchip_parent(chip),
+		"pwm#%u: %llu/%llu [+%llu] @%lu -> hi: %u, lo: %u, inverted: %d\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns,
+		wf->duty_offset_ns, wfhw->rate, wfhw->hi, wfhw->lo,
+		wfhw->inverted);
 
-	return 0;
+	return ret;
 }
 
-static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static u64 meson_pwm_cnt_to_ns(unsigned long fin_freq, u32 cnt)
 {
-	struct meson_pwm *meson = to_meson_pwm(chip);
-	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	struct meson_pwm_channel_data *channel_data;
-	unsigned long flags;
-	u32 value;
-	int err;
-
-	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
-
-	err = clk_set_rate(channel->clk, channel->rate);
-	if (err)
-		dev_err(pwmchip_parent(chip), "setting clock rate failed\n");
-
-	spin_lock_irqsave(&meson->lock, flags);
+	return DIV64_U64_ROUND_UP(NSEC_PER_SEC * (u64)cnt, fin_freq);
+}
 
-	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
-		FIELD_PREP(PWM_LOW_MASK, channel->lo);
-	writel(value, meson->base + channel_data->reg_offset);
+static int meson_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	const struct meson_pwm_waveform *wfhw = _wfhw;
 
-	value = readl(meson->base + REG_MISC_AB);
-	value |= channel_data->pwm_en_mask;
+	if (!wfhw->enabled || !wfhw->rate) {
+		*wf = (struct pwm_waveform){
+			.period_length_ns = 0,
+		};
 
-	if (meson->data->has_constant) {
-		value &= ~channel_data->const_en_mask;
-		if (channel->constant)
-			value |= channel_data->const_en_mask;
+		return 0;
 	}
 
-	if (meson->data->has_polarity) {
-		value &= ~channel_data->inv_en_mask;
-		if (channel->inverted)
-			value |= channel_data->inv_en_mask;
+	/*
+	 * wfhw->hi and wfhw->lo are u16, so their sum doesn't overflow and
+	 * NSEC_PER_SEC * (hi + lo) fits into the u64 dividend in
+	 * meson_pwm_cnt_to_ns().
+	 */
+	wf->period_length_ns = meson_pwm_cnt_to_ns(wfhw->rate, wfhw->hi + wfhw->lo);
+
+	if (wfhw->inverted && wfhw->lo == 0) {
+		/*
+		 * The output is constant low. Report a normal constant-low
+		 * waveform instead of duty_offset_ns == period_length_ns
+		 * which wouldn't be a valid waveform description. This
+		 * setting is only reachable when the hardware was programmed
+		 * by the bootloader as .round_waveform_tohw() never produces
+		 * it.
+		 */
+		wf->duty_length_ns = 0;
+		wf->duty_offset_ns = 0;
+	} else if (wfhw->inverted) {
+		wf->duty_length_ns = meson_pwm_cnt_to_ns(wfhw->rate, wfhw->lo);
+		wf->duty_offset_ns = meson_pwm_cnt_to_ns(wfhw->rate, wfhw->hi);
+	} else {
+		wf->duty_length_ns = meson_pwm_cnt_to_ns(wfhw->rate, wfhw->hi);
+		wf->duty_offset_ns = 0;
 	}
 
-	writel(value, meson->base + REG_MISC_AB);
-
-	spin_unlock_irqrestore(&meson->lock, flags);
+	return 0;
 }
 
-static void meson_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int meson_pwm_read_waveform(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   void *_wfhw)
 {
+	struct meson_pwm_waveform *wfhw = _wfhw;
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
-	unsigned long flags;
-	u32 value;
+	u32 value, pwm_reg;
 
 	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
-	spin_lock_irqsave(&meson->lock, flags);
-
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~channel_data->pwm_en_mask;
+	if (!(value & channel_data->pwm_en_mask)) {
+		*wfhw = (struct meson_pwm_waveform){
+			.enabled = false,
+		};
 
-	if (meson->data->has_polarity) {
-		value &= ~channel_data->inv_en_mask;
-		if (channel->inverted)
-			value |= channel_data->inv_en_mask;
+		return 0;
 	}
 
-	writel(value, meson->base + REG_MISC_AB);
+	pwm_reg = readl(meson->base + channel_data->reg_offset);
 
-	spin_unlock_irqrestore(&meson->lock, flags);
+	*wfhw = (struct meson_pwm_waveform){
+		.rate = clk_get_rate(channel->clk),
+		.hi = FIELD_GET(PWM_HIGH_MASK, pwm_reg),
+		.lo = FIELD_GET(PWM_LOW_MASK, pwm_reg),
+		.enabled = true,
+		.inverted = meson->data->has_polarity &&
+			    (value & channel_data->inv_en_mask),
+	};
+
+	return 0;
 }
 
-static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   const struct pwm_state *state)
+static int meson_pwm_write_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    const void *_wfhw)
 {
+	const struct meson_pwm_waveform *wfhw = _wfhw;
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	int err = 0;
-
-	channel->inverted = (state->polarity == PWM_POLARITY_INVERSED);
-
-	if (!state->enabled) {
-		if (channel->inverted && !meson->data->has_polarity) {
-			/*
-			 * Some of IP block revisions don't have an "always high"
-			 * setting which we can use for "inverted disabled".
-			 * Instead we achieve this by setting mux parent with
-			 * highest rate and minimum divider value, resulting
-			 * in the shortest possible duration for one "count"
-			 * and "period == duty_cycle". This results in a signal
-			 * which is LOW for one "count", while being HIGH for
-			 * the rest of the (so the signal is HIGH for slightly
-			 * less than 100% of the period, but this is the best
-			 * we can achieve).
-			 */
-			channel->rate = ULONG_MAX;
-			channel->hi = ~0;
-			channel->lo = 0;
-			channel->constant = true;
-
-			meson_pwm_enable(chip, pwm);
-		} else {
-			meson_pwm_disable(chip, pwm);
-		}
-	} else {
-		err = meson_pwm_calc(chip, pwm, state);
-		if (err < 0)
+	struct meson_pwm_channel_data *channel_data;
+	unsigned long flags;
+	u32 value;
+	int err;
+
+	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
+
+	/*
+	 * Channel clock operations also modify REG_MISC_AB under meson->lock,
+	 * including from .request()/.free() outside the pwmchip lock. Set the
+	 * rate before taking meson->lock to avoid recursive locking. Skip
+	 * clk_set_rate() when unchanged because even a no-op re-evaluates the
+	 * mux parent and reparses the device tree.
+	 */
+	if (wfhw->enabled && clk_get_rate(channel->clk) != wfhw->rate) {
+		err = clk_set_rate(channel->clk, wfhw->rate);
+		if (err) {
+			dev_err(pwmchip_parent(chip),
+				"setting clock rate failed: %d\n", err);
 			return err;
+		}
 
-		meson_pwm_enable(chip, pwm);
+		/*
+		 * The rate computed by .round_waveform_tohw() might not be
+		 * hit if an input clock changed its rate in between; the
+		 * counter values only implement the promised waveform at
+		 * exactly wfhw->rate.
+		 */
+		if (clk_get_rate(channel->clk) != wfhw->rate) {
+			dev_err(pwmchip_parent(chip),
+				"clock rate changed since rounding\n");
+			return -EINVAL;
+		}
 	}
 
-	return 0;
-}
+	spin_lock_irqsave(&meson->lock, flags);
 
-static u64 meson_pwm_cnt_to_ns(unsigned long fin_freq, u32 cnt)
-{
-	return fin_freq ? div64_ul(NSEC_PER_SEC * (u64)cnt, fin_freq) : 0;
-}
+	if (wfhw->enabled) {
+		value = FIELD_PREP(PWM_HIGH_MASK, wfhw->hi) |
+			FIELD_PREP(PWM_LOW_MASK, wfhw->lo);
+		writel(value, meson->base + channel_data->reg_offset);
 
-static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-			       struct pwm_state *state)
-{
-	struct meson_pwm *meson = to_meson_pwm(chip);
-	struct meson_pwm_channel_data *channel_data;
-	unsigned long fin_freq;
-	unsigned int hi, lo;
-	u32 value;
-
-	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
-	fin_freq = clk_get_rate(meson->channels[pwm->hwpwm].clk);
+		value = readl(meson->base + REG_MISC_AB);
+		value |= channel_data->pwm_en_mask;
 
-	value = readl(meson->base + REG_MISC_AB);
-	state->enabled = value & channel_data->pwm_en_mask;
+		if (meson->data->has_constant) {
+			value &= ~channel_data->const_en_mask;
+			/* The signal is constant when one phase is empty */
+			if (!wfhw->hi || !wfhw->lo)
+				value |= channel_data->const_en_mask;
+		}
 
-	if (meson->data->has_polarity && (value & channel_data->inv_en_mask))
-		state->polarity = PWM_POLARITY_INVERSED;
-	else
-		state->polarity = PWM_POLARITY_NORMAL;
+		if (meson->data->has_polarity) {
+			value &= ~channel_data->inv_en_mask;
+			if (wfhw->inverted)
+				value |= channel_data->inv_en_mask;
+		}
 
-	value = readl(meson->base + channel_data->reg_offset);
-	lo = FIELD_GET(PWM_LOW_MASK, value);
-	hi = FIELD_GET(PWM_HIGH_MASK, value);
+		writel(value, meson->base + REG_MISC_AB);
+	} else {
+		value = readl(meson->base + REG_MISC_AB);
+		value &= ~channel_data->pwm_en_mask;
+		writel(value, meson->base + REG_MISC_AB);
+	}
 
-	state->period = meson_pwm_cnt_to_ns(fin_freq, lo + hi);
-	state->duty_cycle = meson_pwm_cnt_to_ns(fin_freq, hi);
+	spin_unlock_irqrestore(&meson->lock, flags);
 
 	return 0;
 }
@@ -369,8 +424,11 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops meson_pwm_ops = {
 	.request = meson_pwm_request,
 	.free = meson_pwm_free,
-	.apply = meson_pwm_apply,
-	.get_state = meson_pwm_get_state,
+	.sizeof_wfhw = sizeof(struct meson_pwm_waveform),
+	.round_waveform_tohw = meson_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = meson_pwm_round_waveform_fromhw,
+	.read_waveform = meson_pwm_read_waveform,
+	.write_waveform = meson_pwm_write_waveform,
 };
 
 static int meson_pwm_init_clocks_meson8b(struct pwm_chip *chip,

---
base-commit: 2e0a43a9e6f2e846f370aa63ea274f5403628b79
change-id: 20260710-pwm_meson_convert_to_waveform_api-8711b7f8c755

Best regards,
--  
Alexandre Mergnat <amergnat@baylibre.com>

