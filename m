Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B6313E24
	for <linux-pwm@vger.kernel.org>; Sun,  2 Aug 2026 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697583; cv=none; b=XglqLURmsgUzBoGf363TlGr/Xb3MEnqZMqIstNlcpcpNOLYeb6u3uygTuFLELI43bzJM+cZy4hY11UD0e8gd3iVf6GJrM0+mp0H5sL9VrSjbidrjoKHFpGI/wVMjENPcPWF1y8EJER4KcFnO71T8D0BwSUNL8ElTcfCUO+oraec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697583; c=relaxed/simple;
	bh=dpL/spfZkYYMS6fdR08E6oJCNtXn5QKsC3A9jaiLeOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EumJz5q9DzqPH/etlL4xApjIg0JxDhpFV5Rw5QZl69/nqTlnyJlp8nqeT4S3K66pysAX1LQIeIw6SFoR27nVmlJOG0q+e/3rXevrO1o6jEMHEPFD8pTBVTrzOF6X2eLweDmhMDq/qjJ+5CaWWwrGloheIJU8PSIAT3ZKpWk3LGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ/RpO1d; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ/RpO1d"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fdd674e17so388170f8f.1
        for <linux-pwm@vger.kernel.org>; Sun, 02 Aug 2026 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785697579; x=1786302379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hUSRFSKaDJdXKF8v1tTOW5iRagmxvgFbDQxVCfnvEHs=;
        b=KJ/RpO1dJSAGOgY2NKCytbruh9/h08WUQUHDQpbBFNS2qlMGtcenxhJP4dcbhgP2G6
         4/KcoR6KFrYifI5bsKIE1IB99VkHZ1asPAhPQ20W2whMRxQKE4OG0PbIM5eHwjeK0GdN
         jKu/fWLnDUX/W1pDu6ZqlJCzYREzaSrCvSdPq0iwc7l/2SzARw/tePNBybNoDrHlzisX
         +bcmEbIgg4Lc3KQsqoG6qSLTocSbPBepf4DLtvc8TpRozNoDcxwI9dIHa0QVDT7+QWkZ
         ngUc+BCvKT3Hp7nsGwN/CQtEC9jFKfSD9/+xJfqhah/NDScNlJ9iDAaNTorlfb1kONeZ
         XLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785697579; x=1786302379;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hUSRFSKaDJdXKF8v1tTOW5iRagmxvgFbDQxVCfnvEHs=;
        b=R+fxMKPbnhbfV4WmtCpcOJA8zOVIIGluJKDut66Fcb/O+NdckrxBCxfDH/DKY7nS5f
         qm850tDExPoVuqbVw6fTQSpFuS0n2iLU0VYpReKYelBV2eaKQuAcZiFTEXti62vC5xBh
         32pKx5S1NKvcnMQ/jEfqOaWLzR/q8NF187c5UTqxyCodDxCrAkIQh1lMy+fVWXiVilem
         Sxf82CDS0qm7nZ431AEpiawCjXXYUQX4hc/o/aG29gFCry9v3Qk32uAn2xISLI8GNlZy
         SRIH6kWwjLxG9UNTYC83aXVMAnNE5jFwMic/TIIkbch5zxrlgJqQmB2SUjFqpqMM7kg7
         plsw==
X-Gm-Message-State: AOJu0YyE1UZB65sMTCev94+szaIri6sIdJabgQX0RKHfpB4kXfbxXo7L
	jod7RkM2XlGVIsyh2oflH0HqiX7gMbnGpkOWFT6/ajwymikqX9Lc1Ph3k7A4BMGwqoEqcs5x
X-Gm-Gg: AR+sD132elCbyR3Lv+faX8r1qw/AuB3WmwiJE+Z6MNLl9vjZFmOBCUhGiHXi8sc7Ope
	4TqL6ZhOS/CxK2kobLR4/I5CfDsyCdAe5UOjz1MhlIxm5lxRJnH0fZjNBeRFDEkC6LkYD5JWapI
	Vz6doFHZbjmH7B1puxocC3p1o5PM3NQhIyvgcTjbeVGHbRuagmq6SxnUd8nkpFzMA4bWldPvVNp
	1NVamAQOssXoZ8iEFemYy9IzcKyBroDkGTK8+Fnam0d0ueSrqZ2uLERI0hZSK6kR4EJ2OonebsG
	MVM/b/wNxuv15T9G2cnyJ5+0bG2mUKkkez5vxZ9dfqtk783AOsHUcUgkt/uA8dxBqj4BWbR8ZtG
	WT7gyTOjwZAWQNvb28g7D4egwOv4fcgx3XDaCG9kE7EqWq2y/mWpKwmh5PtwtIyRpbk9RcZSh0/
	potkdKkT2ggaa/ecOVPELWlP3Oe3YVXzBkf9QRXC0cVQSJBUm4CwztGOrdufAeKs3EQvljzU02m
	olX1e+Vj2/24L9yKhmYY7WUmsypLrpGFlgQPpd+G3uBgxGpbJt1P8nvnRMHVjBfVDNtYa/ICZBC
	5iU5
X-Received: by 2002:a05:600c:6989:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4980c664d83mr183574025e9.17.1785697579270;
        Sun, 02 Aug 2026 12:06:19 -0700 (PDT)
Received: from rocinante (lfbn-tou-1-1098-107.w90-76.abo.wanadoo.fr. [90.76.164.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191ef9sm180863885e9.1.2026.08.02.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 12:06:18 -0700 (PDT)
From: Stephane Lepain <stephanelepain@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	Kenneth Kasilag <kenneth@kasilag.me>,
	George Moussalem <george.moussalem@outlook.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Baruch Siach <baruch.siach@siklu.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephane Lepain <stephanelepain@gmail.com>
Subject: [PATCH v2] pwm: ipq: fix period calculation
Date: Sun,  2 Aug 2026 21:05:52 +0200
Message-ID: <20260802190552.76466-1-stephanelepain@gmail.com>
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
 drivers/pwm/pwm-ipq.c   |  91 ++++++++++----
 t/drivers/pwm/pwm-ipq.c | 264 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 26 deletions(-)
 create mode 100644 t/drivers/pwm/pwm-ipq.c

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
diff --git a/t/drivers/pwm/pwm-ipq.c b/t/drivers/pwm/pwm-ipq.c
new file mode 100644
index 0000000..c533739
--- /dev/null
+++ b/t/drivers/pwm/pwm-ipq.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
+ *
+ * Limitations:
+ * - The PWM controller has no publicly available datasheet.
+ * - Each of the four channels is programmed via two 32-bit registers
+ *   (REG0 and REG1 at 8-byte stride).
+ * - Period and duty-cycle reconfiguration is fully atomic: new divider,
+ *   pre-divider, and high-duration values are latched by setting the
+ *   UPDATE bit (bit 30 in REG1). The hardware applies the new settings
+ *   at the beginning of the next period without disabling the output,
+ *   so the currently running period is always completed.
+ * - On disable (clearing the ENABLE bit 31 in REG1), the hardware
+ *   finishes the current period before stopping the output. The pin
+ *   is then driven to the inactive (low) level.
+ * - Upon disabling, the hardware resets the pre-divider (PRE_DIV) and divider
+ *   fields (PWM_DIV) in REG0 and REG1 to 0x0000 and 0x0001 respectively.
+ * - Only normal polarity is supported.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/math64.h>
+#include <linux/of_device.h>
+#include <linux/bitfield.h>
+#include <linux/units.h>
+
+/* The frequency range supported is 1 Hz to 100 Mhz (clock rate) */
+#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
+#define IPQ_PWM_MIN_PERIOD_NS	10
+
+/*
+ * Two 32-bit registers for each PWM: REG0, and REG1.
+ * Base offset for PWM #i is at 8 * #i.
+ */
+#define IPQ_PWM_REG0			0
+#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
+#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
+
+#define IPQ_PWM_REG1			4
+#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
+/*
+ * Enable bit is set to enable output toggling in pwm device.
+ * Update bit is set to trigger the change and is unset automatically
+ * to reflect the changed divider and high duration values in register.
+ */
+#define IPQ_PWM_REG1_UPDATE		BIT(30)
+#define IPQ_PWM_REG1_ENABLE		BIT(31)
+
+/*
+ * The max value specified for each field is based on the number of bits
+ * in the pwm control register for that field (16-bit)
+ */
+#define IPQ_PWM_MAX_DIV			FIELD_MAX(IPQ_PWM_REG0_PWM_DIV)
+
+struct ipq_pwm_chip {
+	void __iomem *mem;
+	unsigned long clk_rate;
+};
+
+static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned int reg)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
+	unsigned int off = 8 * pwm->hwpwm + reg;
+
+	return readl(ipq_chip->mem + off);
+}
+
+static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
+			      unsigned int val)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
+	unsigned int off = 8 * pwm->hwpwm + reg;
+
+	writel(val, ipq_chip->mem + off);
+}
+
+static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
+	unsigned int pre_div, pwm_div;
+	u64 period_ns, duty_ns;
+	unsigned long val = 0;
+	unsigned long hi_dur;
+
+	if (!state->enabled) {
+		/* clear IPQ_PWM_REG1_ENABLE */
+		ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, IPQ_PWM_REG1_UPDATE);
+		return 0;
+	}
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Check the upper and lower bounds for the period as per
+	 * hardware limits
+	 */
+	if (state->period < IPQ_PWM_MIN_PERIOD_NS)
+		return -ERANGE;
+	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
+	duty_ns = min(state->duty_cycle, period_ns);
+
+	/*
+	 * Pick the maximal value for PWM_DIV that still allows a
+	 * 100% relative duty cycle. This allows a fine grained
+	 * selection of duty cycles.
+	 */
+	pwm_div = IPQ_PWM_MAX_DIV - 1;
+
+	/*
+	 * although mul_u64_u64_div_u64 returns a u64, in practice it
+	 * won't overflow due to above constraints. Take the max period
+	 * of 10^9 (NSEC_PER_SEC) and the pwm_div + 1 (IPQ_PWM_MAX_DIV)
+	 *  10^9 * 10^8
+	 * ------------- => which fits well into a 32-bit unsigned int.
+	 * 10^9 * 65,535
+	 */
+	pre_div = mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
+				      (u64)NSEC_PER_SEC * (pwm_div + 1));
+
+	if (!pre_div)
+		return -ERANGE;
+
+	pre_div -= 1;
+
+	if (pre_div > IPQ_PWM_MAX_DIV)
+		pre_div = IPQ_PWM_MAX_DIV;
+
+	/* pwm duty = HI_DUR * (PRE_DIV + 1) / clk_rate */
+	hi_dur = mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
+				     (u64)NSEC_PER_SEC * (pre_div + 1));
+
+	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
+		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
+
+	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
+
+	/* PWM enable toggle needs a separate write to REG1 */
+	val |= IPQ_PWM_REG1_UPDATE | IPQ_PWM_REG1_ENABLE;
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
+
+	return 0;
+}
+
+static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
+	unsigned int pre_div, pwm_div, hi_dur;
+	u64 effective_div, hi_div;
+	u32 reg0, reg1;
+
+	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
+	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
+
+	if (!state->enabled)
+		return 0;
+
+	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
+	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
+	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
+
+	effective_div = (u64)(pwm_div + 1) * (pre_div + 1);
+
+	/*
+	 * effective_div <= 0x100000000, so the multiplication doesn't overflow.
+	 */
+	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC,
+					   ipq_chip->clk_rate);
+
+	hi_div = hi_dur * (pre_div + 1);
+	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC,
+					       ipq_chip->clk_rate);
+
+	/*
+	 * ensure a valid config is passed back to PWM core in case duty_cycle
+	 * is > period (>100%)
+	 */
+	state->duty_cycle = min(state->duty_cycle, state->period);
+
+	return 0;
+}
+
+static const struct pwm_ops ipq_pwm_ops = {
+	.apply = ipq_pwm_apply,
+	.get_state = ipq_pwm_get_state,
+};
+
+static int ipq_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ipq_pwm_chip *pwm;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pwm = ipq_pwm_from_chip(chip);
+
+	pwm->mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->mem))
+		return dev_err_probe(dev, PTR_ERR(pwm->mem),
+				     "Failed to acquire resource\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to lock clock rate\n");
+
+	pwm->clk_rate = clk_get_rate(clk);
+	if (!pwm->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "Failed due to clock rate being zero\n");
+
+	chip->ops = &ipq_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id pwm_ipq_dt_match[] = {
+	{ .compatible = "qcom,ipq6018-pwm", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
+
+static struct platform_driver ipq_pwm_driver = {
+	.driver = {
+		.name = "ipq-pwm",
+		.of_match_table = pwm_ipq_dt_match,
+	},
+	.probe = ipq_pwm_probe,
+};
+
+module_platform_driver(ipq_pwm_driver);
+
+MODULE_DESCRIPTION("Qualcomm IPQ PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

