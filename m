Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300309;
	b=qMFnCA/cr/ICXANDYoOqpPifNZvPgKi35UaQxC/kZfqpRq36kk5GpOdDd0y1YeLzKFZ6
	 NQxI7Eq9aExH8XOSvj4ybeJQ3o3KIwy2gqraJnR8siHZzrU7nVs7hQDjVix+3ozRbIFIJ
	 10vaqeNey45Vei0gXLoMvzWEcLYsTpIg4FEOUgjQ9iZ/V+IkQkRuaf7B0x3CeFF7fgT3T
	 oYQxPo5RC2tvTwjvamI38MlWtIpByQE2EDwjr59Df/bGFC8FmvBMvPnxJfzvhdHARWniZ
	 aVHQi8txNe6Qf8gecNOBQD1rydcN9iCjoOvAM5etTGo+M2mqnaVhJNzWnw0H4xezEwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=QRxyHZ6GOQK27MPndfay3/TIbTozwLg+MmKKevRpGg8=;
	b=dnLrSOFH/ZF5jxQpJ+lysCGcFhscK55gR21+9P90MVVPT/aukskkKIB5hK3oauFj+776
	 wXuY6CL1szzbABjxxUoJ9gbPxl6A20ILMh9ULcqPMCxLMMgMzkWqOWrA90xLDQl7IC+YS
	 NtJFME2pPyf0yddoe7vCKUfo2u4CdHYol2UgON/Er362olW18Nirm5csreR+tNaofIN6V
	 WNacCm5qsr6+ONck5dLLgumLukNlk8oauPp30UkiiEDeA7z0EmeL4jo9/foN/vowqQFqJ
	 RBHaXw7W+SoqhMkSfm0is3HC7BEQZpW4+J8ch4msbNYDGntvpvg3JIGAKypwEfOEVRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WG50PzC1;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE216606A32F
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 18:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE216606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WG50PzC1
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so25118615e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300307; x=1793905107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRxyHZ6GOQK27MPndfay3/TIbTozwLg+MmKKevRpGg8=;
        b=WG50PzC1Ay1I0Glw55AmztxpIWfZDz3eOnGdupteLZ47FerQSrvsFU45bZtvrez1L7
         J63XE2fvRJo0mqUUjrueWa5chtX4l5wHX58h9VDEYhpWZqQR83qwwkto0crUX8hj289G
         c9jzSt9I/Srtz0R6m9Lw9QCfcUb7fP7ot81RKu+knpeyTIPPN1FvV06DHLivduqrS6Bv
         fPb5GQ9ptnErgUgk7139kmbdjQQu8DPx8H4xblwQlfZJ7JMB2ClhbgJ8bMztI411AGZ2
         kmnRrTW8e18m/S01Twl0NvZaOgm5lheM+ladQ23U1W0NPz8Fhv9OacOcgLhcHVaT2ji/
         5W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300307; x=1793905107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRxyHZ6GOQK27MPndfay3/TIbTozwLg+MmKKevRpGg8=;
        b=Jc0u5gPUHjfUkIgB+LEwekXKCq7N9gMb9BvRUTcdwZsmCByqyrrVZmAudY2ExtxuQV
         y5Pd8Wf4XHpCfd3b7XCyP/y9mK2gtEUDnqqdTYK9qAY35QU6NP+fF7eJp45PhQmN3uGA
         yG6P09yIFT929IiCqkNLo4l71F2qV3LuHEH9D1tnskkf26HIPxf/mnAMliYXxt1LGtuH
         12IS2sQbNXHswYDtW/4xQp2e9nD7PSadptgAIeqVJBYZ5Zj0twnKV4mOk+37pQSi86Zy
         XOKY1sMYe8KWnjI29dbrxT4peKFBce1x+8v36LaIhwG3DQBXbjRsgPZIjGXXYsZ1MKMh
         ykww==
X-Gm-Message-State: AFq9FYJfqhAbdIuCM7TxsBddBCJsT9nXy/JWeRr5gXM69Xjp0vHk+BBY
	sGwJ7HUYSNgXfoVagDe8jdBy7CdbtfOt/+tnX+VbcDeNcToJ4Dm60ELk
X-Gm-Gg: AYBFou2MtM0tG23ePjVK9D37T0jardCheoZzDZUSjIEjPncilv2W5Kxk1cvFtT3f/xb
	yjZcxy3qZirCzBPwIs+4Nf0r9emuI8J7ISTWFOyJbHtA5cm6RNLpFyBXEsDwFwh22XY5I9i6K2T
	R+HO8vaGMx5qaP5rLROGU//Lnng7PyCeAhXf0sacpcA9ucc/ur0T6S7L3sfT/fN8lVX9DhyB2Xm
	aAuazm8Rm7qwceg+kVnC2o/3KeE/vk2nhXzRwtpSv+cwSOeOduBWF9VvC9yq9d/c6IjLf5LkSTu
	0tccju+alr2BuvYU6gmc4YILLYIK5ynwEA7k1LeALzP/Dagb5cBR7dYyzqDUdREQbsBl2cRs4Rw
	euqSMKXytEMQ1AFwhuZBA9ll0zAk5qJFVnyNf64uxGFpszOaKWA+m9XciaXjkzn723raXbTOv58
	FSfje8VKC6SLsaGAzCcXFSzDne8ckIqOcPV17+MGSQ8jQipzoA998vjr/J4WcHzerXoOD/oviqa
	rx7F8cnAZUL0pqpDoDUKZs4j9c0Ez2L3qQPow/BESFWvBnw2LOS4LYbUB+4Zn23jJrI93zwGrMI
	6s05+LM8RRE5FUDnRs4B8TW7FULhXB/g5IVQHem3KMihpBw9uRQoDgV0XtY6yZn6Fy1UBUTwUA+
	tOirKtXW5yWU=
X-Received: by 2002:a05:600c:3b02:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4a967202e72mr145048895e9.13.1793300307008;
        Thu, 29 Oct 2026 11:58:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:eafc:6fb2:6c68:5ae0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm94291535e9.10.2026.10.29.11.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:58:26 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 29 Oct 2026 18:58:23 +0000
Subject: [PATCH v9 2/7] pwm: rzg2l-gpt: Convert to waveform callbacks
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-gpt_rzg3e-v9-2-f3a5520388d3@bp.renesas.com>
References: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
In-Reply-To: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793300303; l=14586;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=6WjUirom5UtoCaNHl77k1eEc+AMVL7PNXtJ3osp6aLE=;
 b=rDii/oIxvB/L2Dxnu58QAIGNIIXUronUlNOzUTshinGWq2rSm8TuH5LvZwP3rw/MY+KJyqAtn
 Ev1xoS4fc4MDUaJCy7wG1/AJiUsvs1IhSYWpTPgm61MVLXQpcapX6uu
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Migrate the rzg2l-gpt driver from the legacy .get_state/.apply ops to the
new waveform callback interface.

Introduce struct rzg2l_gpt_waveform to represent a hardware waveform
configuration holding the period register value (gtpr), compare/capture
register value (gtccr), and prescaler (prescale).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * The prescale always initialised (reuse cache only if the sibling is
   running)
 * The round_waveform_tohw() no longer writes the prescale cache.
 * Disabling an idle channel no longer touches the shared registers/
   counter in rzg2l_gpt_write_waveform()
 * The shared registers are only written (and the counter only stopped/
   restarted) when no sibling is running -> no glitch on a running
   sibling in rzg2l_gpt_write_waveform().
 * The rzg2l_gpt_write_waveform() re-validates, under the lock, that the
   sibling still uses the same prescale/period (returns -EBUSY otherwise)
 * Redundant "enable &&" removed in rzg2l_gpt_write_waveform().
 * The rzg2l_gpt_is_ch_enabled() fills *gtcr before the early return.
v7->v8:
 * Cached prescale value.
 * Updated rzg2l_gpt_write_waveform() for caching the period, If the
   channel is already enabled and the user changes its period.
v6->v7:
 * Avoided recalculation of prescale, if is_small_second_period == true.
 * Moved `wfhw->gtccr = 0` into the if block in rzg2l_gpt_config().
v5->v6:
 * Dropped local variables pv and dc from rzg2l_gpt_round_waveform_tohw().
 * Dropped blank line in rzg2l_gpt_round_waveform_tohw().
 * Moved assignment of rzg2l_gpt->period_ticks[ch] to *_write_waveform().
 * Restored clamping of duty_ticks with period_ticks in
   rzg2l_gpt_round_waveform_tohw().
 * Simplified rzg2l_gpt_write_waveform() using else if statement.
 * Dropped local variable gptr in rzg2l_gpt_write_waveform().
 * Moved mutex after early return in rzg2l_gpt_round_waveform_tohw().
v5:
 * Updated commit description.
 * Updated rzg2l_gpt_round_waveform_tohw() to initialize gtccr when the
   period of the second channel is smaller.
 * Replaced period_ticks with RZG2L_MAX_TICKS for the duty_ticks maximum
   value check in rzg2l_gpt_round_waveform_tohw().
v4 from [1]
[1] https://lore.kernel.org/all/20251208152133.269316-3-biju.das.jz@bp.renesas.com/
---
 drivers/pwm/pwm-rzg2l-gpt.c | 273 +++++++++++++++++++++++++++-----------------
 1 file changed, 170 insertions(+), 103 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 108fa99f832d..e9ba0f3bdeb1 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -84,6 +84,14 @@ struct rzg2l_gpt_chip {
 	u64 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
+	u8 prescale[RZG2L_MAX_HW_CHANNELS];
+};
+
+/* This represents a hardware configuration for one channel */
+struct rzg2l_gpt_waveform {
+	u32 gtpr;
+	u32 gtccr;
+	u8 prescale;
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -152,12 +160,16 @@ static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	rzg2l_gpt->channel_request_count[ch]--;
 }
 
-static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8 hwpwm)
+static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8 hwpwm,
+				    u32 *gtcr)
 {
 	u8 ch = RZG2L_GET_CH(hwpwm);
 	u32 val;
 
 	val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
+	if (gtcr)
+		*gtcr = val;
+
 	if (!(val & RZG2L_GTCR_CST))
 		return false;
 
@@ -219,159 +231,214 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
 }
 
-static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-			       struct pwm_state *state)
-{
-	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
-
-	state->enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
-	if (state->enabled) {
-		u32 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
-		u32 ch = RZG2L_GET_CH(pwm->hwpwm);
-		u8 prescale;
-		u32 val;
-
-		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
-		prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
-
-		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
-		state->period = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, prescale);
-
-		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
-		state->duty_cycle = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, prescale);
-		if (state->duty_cycle > state->period)
-			state->duty_cycle = state->period;
-	}
-
-	state->polarity = PWM_POLARITY_NORMAL;
-
-	return 0;
-}
-
 static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
 {
 	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * prescale)),
 		     U32_MAX);
 }
 
-/* Caller holds the lock while calling rzg2l_gpt_config() */
-static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_waveform *wf,
+					 void *_wfhw)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
-	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	struct rzg2l_gpt_waveform *wfhw = _wfhw;
+	bool is_small_second_period = false;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
 	u64 period_ticks, duty_ticks;
-	unsigned long pv, dc;
-	u8 prescale;
+
+	if (wf->period_length_ns == 0) {
+		*wfhw = (struct rzg2l_gpt_waveform){
+			.gtpr = 0,
+			.gtccr = 0,
+			.prescale = 0,
+		};
+
+		return 0;
+	}
 
 	/* Limit period/duty cycle to max value supported by the HW */
-	period_ticks = mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
+	period_ticks = mul_u64_u64_div_u64(wf->period_length_ns,
+					   rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
 	if (period_ticks > RZG2L_MAX_TICKS)
 		period_ticks = RZG2L_MAX_TICKS;
+
+	guard(mutex)(&rzg2l_gpt->lock);
 	/*
 	 * GPT counter is shared by the two IOs of a single channel, so
 	 * prescale and period can NOT be modified when there are multiple IOs
 	 * in use with different settings.
 	 */
-	if (rzg2l_gpt->channel_request_count[ch] > 1) {
-		u8 sibling_ch = rzg2l_gpt_sibling(pwm->hwpwm);
-
-		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
-			if (period_ticks < rzg2l_gpt->period_ticks[ch])
-				return -EBUSY;
-
-			period_ticks = rzg2l_gpt->period_ticks[ch];
-		}
+	if (rzg2l_gpt->channel_request_count[ch] > 1 &&
+	    rzg2l_gpt_is_ch_enabled(rzg2l_gpt, rzg2l_gpt_sibling(pwm->hwpwm), NULL)) {
+		if (period_ticks < rzg2l_gpt->period_ticks[ch])
+			is_small_second_period = true;
+
+		period_ticks = rzg2l_gpt->period_ticks[ch];
+		wfhw->prescale = rzg2l_gpt->prescale[ch];
+	} else {
+		wfhw->prescale = rzg2l_gpt_calculate_prescale(period_ticks);
 	}
 
-	prescale = rzg2l_gpt_calculate_prescale(period_ticks);
-	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
+	wfhw->gtpr = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	if (is_small_second_period) {
+		wfhw->gtccr = 0;
+		return 1;
+	}
 
-	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
+	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
-
-	/*
-	 * GPT counter is shared by multiple channels, we cache the period ticks
-	 * from the first enabled channel and use the same value for both
-	 * channels.
-	 */
-	rzg2l_gpt->period_ticks[ch] = period_ticks;
+	wfhw->gtccr = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
 
-	/*
-	 * Counter must be stopped before modifying mode, prescaler, timer
-	 * counter and buffer enable registers. These registers are shared
-	 * between both channels. So allow updating these registers only for the
-	 * first enabled channel.
-	 */
-	if (rzg2l_gpt->channel_enable_count[ch] <= 1) {
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
-
-		/* GPT set operating mode (saw-wave up-counting) */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_MD,
-				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
-
-		/* Set count direction */
-		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
-
-		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
+	return 0;
+}
 
-		/* Set period */
-		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
-	}
+static int rzg2l_gpt_round_waveform_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_waveform *wfhw = _wfhw;
 
-	/* Set duty cycle */
-	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
+	wf->period_length_ns = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, wfhw->gtpr,
+								  wfhw->prescale);
+	wf->duty_length_ns = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, wfhw->gtccr,
+								wfhw->prescale);
+	wf->duty_offset_ns = 0;
 
-	if (rzg2l_gpt->channel_enable_count[ch] <= 1) {
-		/* Set initial value for counter */
-		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT(ch), 0);
+	return 0;
+}
 
-		/* Set no buffer operation */
-		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
+static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   void *_wfhw)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u32 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	struct rzg2l_gpt_waveform *wfhw = _wfhw;
+	u32 ch = RZG2L_GET_CH(pwm->hwpwm);
+	u32 gtcr;
 
-		/* Restart the counter after updating the registers */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
-				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
+	guard(mutex)(&rzg2l_gpt->lock);
+	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
+		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
+		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
+		if (wfhw->gtccr > wfhw->gtpr)
+			wfhw->gtccr = wfhw->gtpr;
+	} else {
+		*wfhw = (struct rzg2l_gpt_waveform) { };
 	}
 
 	return 0;
 }
 
-static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   const struct pwm_state *state)
+static u64 rzg2l_gpt_calculate_cycles(u32 value, u8 prescale)
 {
-	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
-	bool enabled = pwm->state.enabled;
-	int ret;
+	return (u64)value << (2 * prescale);
+}
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    const void *_wfhw)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_waveform *wfhw = _wfhw;
+	u8 sibling_ch = rzg2l_gpt_sibling(pwm->hwpwm);
+	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	bool self_enabled, sibling_enabled;
+	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
+	u32 gtcr;
 
 	guard(mutex)(&rzg2l_gpt->lock);
-	if (!state->enabled) {
-		if (enabled)
+
+	self_enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, NULL);
+	sibling_enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, &gtcr);
+
+	/* Disable request: shared registers are never touched. */
+	if (!wfhw->gtpr) {
+		if (self_enabled)
 			rzg2l_gpt_disable(rzg2l_gpt, pwm);
 
 		return 0;
 	}
 
-	ret = rzg2l_gpt_config(chip, pwm, state);
-	if (!ret && !enabled)
+	if (sibling_enabled) {
+		/*
+		 * The counter, prescale and period are owned by the
+		 * running sibling. Do not stop the counter. Re-validate, now
+		 * that the lock is held again, that the values computed by
+		 * round_waveform_tohw() still match the running configuration.
+		 */
+		if (FIELD_GET(RZG2L_GTCR_TPCS, gtcr) != wfhw->prescale ||
+		    rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch)) != wfhw->gtpr)
+			return -EBUSY;
+
+		/* Set duty cycle */
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), wfhw->gtccr);
+
+		if (!self_enabled)
+			rzg2l_gpt_enable(rzg2l_gpt, pwm);
+
+		return 0;
+	}
+
+	/*
+	 * No sibling running: this channel owns the counter. Counter must be
+	 * stopped before modifying mode, prescaler, timer counter and buffer
+	 * enable registers.
+	 */
+	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+
+	/* GPT set operating mode (saw-wave up-counting) */
+	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_MD,
+			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
+
+	/* Set count direction */
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
+
+	/* Select count clock */
+	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
+			 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+
+	/* Set period */
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
+
+	/* Set duty cycle */
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), wfhw->gtccr);
+
+	/* Set initial value for counter */
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT(ch), 0);
+
+	/* Set no buffer operation */
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
+
+	/* Cache period and prescale used by the sibling IO */
+	rzg2l_gpt->period_ticks[ch] = rzg2l_gpt_calculate_cycles(wfhw->gtpr, wfhw->prescale);
+	rzg2l_gpt->prescale[ch] = wfhw->prescale;
+
+	if (self_enabled)
+		/* Restart the counter after updating the registers */
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST,
+				 RZG2L_GTCR_CST);
+	else
+		/* Enables the pin output and starts the counter */
 		rzg2l_gpt_enable(rzg2l_gpt, pwm);
 
-	return ret;
+	return 0;
 }
 
 static const struct pwm_ops rzg2l_gpt_ops = {
 	.request = rzg2l_gpt_request,
 	.free = rzg2l_gpt_free,
-	.get_state = rzg2l_gpt_get_state,
-	.apply = rzg2l_gpt_apply,
+	.sizeof_wfhw = sizeof(struct rzg2l_gpt_waveform),
+	.round_waveform_tohw = rzg2l_gpt_round_waveform_tohw,
+	.round_waveform_fromhw = rzg2l_gpt_round_waveform_fromhw,
+	.read_waveform = rzg2l_gpt_read_waveform,
+	.write_waveform = rzg2l_gpt_write_waveform,
 };
 
 static int rzg2l_gpt_probe(struct platform_device *pdev)

-- 
2.43.0

