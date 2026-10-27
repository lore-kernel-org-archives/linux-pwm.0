Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068172;
	b=oLeTAxCJGqCRTq/d9hEYn/H16EJoQ3/T8OjmkdM6hndIZ63Ilbaai+84E14tOwEMfONL
	 ygb8KvTAZ9NTMEqfhth9n01dSUIoozWYziwyrebb9y8AFGZPwzNgHOYsX8fMNSLbYD+Sz
	 gaGU86X5keWQwqxziIJFtTLaVfbhzVQWHlcD41BWrfajASYl5kMK17rKqaA9nzzZNOOQi
	 akqst8vHEj6jOqPRZDiQfwMs04AgBcFI/rn5VY/9xExxHwRg6NLgIB2r2mQ0YJoBXr+tL
	 l3Okg1oeZfuifbm83+36H8d5laHXlk3Km/USo4DXTE0r7h+glipUw3GArKQZEeLPeHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AuJpX+R1ikkgXuJg24CUYJMUBGehOWyuliZWHlt8VIY=;
	b=2rfWRYrUA6GlEKXUiYaHvLl9oQU2y1CZQYDwA0qJ9kRyLJlLOPywtUcjTxlUhREf2ZLJ
	 RbQN7cHuWFr75o5dEms4l9cohRKAj41ZCFaEYp5vpcS987VNwuu/+e75CaV2HpYHFOMP6
	 kbljx0wrpkhmqKaU0fgUFjbT27yPuAWv1MXA+s3BYDqrEM7ptJcZyxSFhA4OZ3o3/KTeY
	 L7SVEjYLhnnty40A1D0bVJ7WAyVCd6SuF1+iH7YKK5fPiprhJH1KtkLfNz6xrdsq9KAlX
	 lPbh5KRLxqNZDcDrJNgNFKdWfC5adBhC/vLv5KgmRzPGV6Q+1Xdt02+EeNGS9Tn26dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DbZORDq5;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF0606A31B
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 02:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DF0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DbZORDq5
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so24563405e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 19:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793068169; x=1793672969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuJpX+R1ikkgXuJg24CUYJMUBGehOWyuliZWHlt8VIY=;
        b=DbZORDq5AiubwyjDXTjfusmrCpGrjrHPIfkmc/I3M2s4ChF1YwXLXq07UiJtP1eZkj
         3kTv+zMiGVmJ9VZVJx5T774C5/cdDGDFA26IoBfuaKTc5DcRAo2RV/Lo+DboKBN9SJDr
         sGHCWiaVkpVOeISEegQYs/ehQM0fJY539Emd74GXHT9L06X+ju044jAgfWAj7G40507H
         c68wqbinZcoWx/PhiiESB+TZjMNe8XcrHLO2QMM96N/ZEJRBWNQT8ABehmIwUhGX6dDf
         acUgNiGV0a0oAmth1z5O8a7gYiq0TGObGCbTgvv1BdjkaKh0aQEtlbDk4fwou4m9bebT
         ktkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068169; x=1793672969;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuJpX+R1ikkgXuJg24CUYJMUBGehOWyuliZWHlt8VIY=;
        b=LdAsWFz2/W2OhA7tIfPpNSkgnx7kGPxQ+f1x2aGXwG2Zg1wKwOwFX1JOzzc0gJdV+U
         DtHo5Dg2Lenke/WhiNIdse3nIDvi1pww4sCcxGX17Xr0gaysiN7gmteiW7RdOpTmfrGp
         NZjWDjAy+XyBLO4yK0Vmdcb8kp2UapkMXvgWirC4mmGtlzpOWUvL9oJ4iKQVKTSQ4Wuo
         EQsKhmCIVPHNLCZQEBbe3wpFjZaKIwSL5Il66oeAjxJ/JgViy5Z6IY3XHjbzbFVUO58M
         KkSG80Vl1lewkbz6JuyP98I81V+1wWfh+dYWmk91XosPTd8BevWtfu2knCpfQE7nhX6b
         5l2w==
X-Forwarded-Encrypted: i=1; AKwUvBz4yiQEuf+ztwjUQI30lA8rBiOskedQX/IjFN1vrTm5bebscpVB+jy7VX/70Est9w0m2O42t6YNcCU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoZQRo9FPHlZxLX3afi2sFHUo6macCaF7ikmgCLji/zdxv0NFj
	3JYGK3sC38+G838VJ2e0EJNPX1vyqrqRz8y7rrhVUTfaO6cPJA9buoN+
X-Gm-Gg: AYBFou3pUn7caTVdGcbxh4LMP9txPL9nlDlbletBf2t84Czre40Ra5a5VRu3duFLR8k
	aepxTqtD9CLaIZXZbreGS/HtQF3RpVVI+Zxm6E9VYB6yXI9joHOOK41xhtu+46eeS0ZyEi8ptV8
	TkpU/XKF/WbnvROyS23VNj5gd2DDSq1HL+9WXU2ypi46XqBtQX2nu4TmvxVL3xpmrcjjPLFoyeI
	wuszXAqFRo5dWWYuoJkYip1bDpJprRKV8x/wl6swELi70J7Wa4PNTq+actZUyt2b/XgopCtgVok
	YQnvl58MNlC7d3JsayuOfJq51OHZafKx3AiBxIgA+ollQN8afe/8QQ4d6yQPl1iRO0ip28cpeai
	yDpdKi4Di3J/JYwJUP70GefsO7iYjpuo1OiKu9iDJsRvtsKoHtL1CuzFXnHN//lRPehwJsfdeYh
	7hU96Fhk8epIiCsFZC2GipMCRCzrIrJm3C4ZMIG91hyIZZh8YQi3ilvj/LwB+x4n2PuD7/L3Icu
	EHbcXblDzYNF9nS0ioxgu4K2k8cKDZjXPgrKrKVFjuHyag4fK9HtiRRJ+eo+j2Uvj2eDMfM2kr1
	Rhi8ET1ZWBae7151MRgRoufGrinEmal16nfOiosvZs1SBMZip0o131JwN793Eu9bLz1taqzDEr/
	6xqkPa2O7W2b9T3f0vgFwktlKpcy6xR7yBsBi4y5o
X-Received: by 2002:a05:600c:3b8a:b0:4a2:d:5ccc with SMTP id 5b1f17b1804b1-4a35ac99e81mr157824335e9.10.1793068169174;
        Mon, 26 Oct 2026 19:29:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-118-122.95.117.pool.telefonica.de. [95.117.118.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm18341906f8f.3.2026.10.26.19.29.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 19:29:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] pwm: atmel: Fix arithmetic overflows for long periods
Date: Tue, 27 Oct 2026 03:27:55 +0100
Message-Id: <20261027022755.52912-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261016161221.16553-1-kmehltretter@gmail.com>
References: <20261016161221.16553-1-kmehltretter@gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

atmel_pwm_calculate_cprd_and_pres() first multiplies the requested
period by the clock rate in a u64 and only then divides by
NSEC_PER_SEC. The product can overflow even when the quotient and the
resulting hardware configuration are representable.

For example, at 12 MHz a 1600 s period has 19.2 billion clock cycles
and fits with prescaler 3, but the intermediate product exceeds U64_MAX.
It wraps and the driver programs a period of about 62.8 s instead. This
remains broken after changing fls() to fls64(). The duty-cycle
calculation has the same overflow.

Use mul_u64_u64_div_u64() for both conversions and use fls64() when
deriving the prescaler. The multiply/divide result cannot overflow if
the clock rate is at most NSEC_PER_SEC, so hold the clock rate exclusive
and validate it at probe time.

The reverse conversion in atmel_pwm_get_state() can overflow too: it
multiplies CPRD or CDTY by NSEC_PER_SEC and then shifts the u64 by the
prescaler. Convert the scaled clock ticks with the overflow-safe,
round-up helper instead. Explicitly saturate values that cannot be
represented by the u64 nanosecond API, rather than relying on the
architecture-specific helper's quotient-overflow behaviour.

Fixes: a9d887dc1c60 ("pwm: Convert period and duty cycle to u64")
Cc: stable@vger.kernel.org
Reported-by: Uwe Kleine-König <ukleinek@kernel.org>
Link: https://lore.kernel.org/r/atnHHaOwTkI78_tc@monoceros
Suggested-by: Uwe Kleine-König <ukleinek@kernel.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v3:
- Use mul_u64_u64_div_u64() for the period conversion as suggested by
  Uwe, and for the analogous duty-cycle conversion.
- Fix the corresponding overflow in the get_state() conversion and
  explicitly saturate results that cannot be represented in nanoseconds.
- Hold the clock rate exclusive and validate the rate bound required by
  the arithmetic.
- Rebase onto v7.3-rc7.

Testing:
- Built an ARM zImage with clang 22.1.8 and W=1.
- Passed 14 host boundary tests, 53 oracle-checked SAM9X75 QEMU boots,
  and all 20 PWM device-model qtests.
- Passed 89/89 checks on a physical SAM9X75, including overflow cases.
  A 69.175-second period measured 69.210 seconds between interrupts; no
  kernel errors were found.

 drivers/pwm/pwm-atmel.c | 46 +++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 86918523d8..db7a14c66a 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -183,19 +184,18 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 					     unsigned long *cprd, u32 *pres)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	unsigned long long cycles = state->period;
+	unsigned long long cycles;
 	int shift;
 
 	/* Calculate the period cycles and prescale value */
-	cycles *= clkrate;
-	do_div(cycles, NSEC_PER_SEC);
+	cycles = mul_u64_u64_div_u64(state->period, clkrate, NSEC_PER_SEC);
 
 	/*
 	 * The register for the period length is cfg.period_bits bits wide.
 	 * So for each bit the number of clock cycles is wider divide the input
 	 * clock frequency by two using pres and shift cprd accordingly.
 	 */
-	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
+	shift = fls64(cycles) - atmel_pwm->data->cfg.period_bits;
 
 	if (shift > PWM_MAX_PRES) {
 		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
@@ -218,12 +218,23 @@ static void atmel_pwm_calculate_cdty(const struct pwm_state *state,
 {
 	unsigned long long cycles = state->duty_cycle;
 
-	cycles *= clkrate;
-	do_div(cycles, NSEC_PER_SEC);
+	cycles = mul_u64_u64_div_u64(cycles, clkrate, NSEC_PER_SEC);
 	cycles >>= pres;
+
 	*cdty = cprd - cycles;
 }
 
+static u64 atmel_pwm_ticks_to_ns(u64 ticks, unsigned long rate)
+{
+	u64 max_ticks;
+
+	max_ticks = mul_u64_u64_div_u64(U64_MAX, rate, NSEC_PER_SEC);
+	if (ticks > max_ticks)
+		return U64_MAX;
+
+	return mul_u64_u64_div_u64_roundup(ticks, NSEC_PER_SEC, rate);
+}
+
 static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
 				  unsigned long cdty)
 {
@@ -352,24 +363,22 @@ static int atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (sr & (1 << pwm->hwpwm)) {
 		unsigned long rate = clk_get_rate(atmel_pwm->clk);
 		u32 cdty, cprd, pres;
-		u64 tmp;
+		u64 ticks;
 
 		pres = cmr & PWM_CMR_CPRE_MSK;
 
 		cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 					  atmel_pwm->data->regs.period);
-		tmp = (u64)cprd * NSEC_PER_SEC;
-		tmp <<= pres;
-		state->period = DIV64_U64_ROUND_UP(tmp, rate);
+		ticks = (u64)cprd << pres;
+		state->period = atmel_pwm_ticks_to_ns(ticks, rate);
 
 		/* Wait for an updated duty_cycle queued in hardware */
 		atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);
 
 		cdty = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 					  atmel_pwm->data->regs.duty);
-		tmp = (u64)(cprd - cdty) * NSEC_PER_SEC;
-		tmp <<= pres;
-		state->duty_cycle = DIV64_U64_ROUND_UP(tmp, rate);
+		ticks = (u64)(cprd - cdty) << pres;
+		state->duty_cycle = atmel_pwm_ticks_to_ns(ticks, rate);
 
 		state->enabled = true;
 	} else {
@@ -487,6 +496,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
 	struct pwm_chip *chip;
+	unsigned long rate;
 	int ret;
 
 	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*atmel_pwm));
@@ -507,6 +517,16 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
 				     "failed to get prepared PWM clock\n");
 
+	ret = devm_clk_rate_exclusive_get(&pdev->dev, atmel_pwm->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get exclusive PWM clock rate\n");
+
+	rate = clk_get_rate(atmel_pwm->clk);
+	if (!rate || rate > NSEC_PER_SEC)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "invalid PWM clock rate %lu Hz\n", rate);
+
 	chip->ops = &atmel_pwm_ops;
 
 	ret = atmel_pwm_enable_clk_if_on(chip, true);

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.39.5 (Apple Git-154)

