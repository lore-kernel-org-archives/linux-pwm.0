Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEF420486
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576155; cv=none; b=TiAoyT8O1vYI1j9SF4BjRVUE+P+AdYcNncpNRLbVV2WqkbwKwBlw/YSkjPIxh1iv5//AIRVDxPjAYKfa0azVZE/FIwl/5qTDpcAgFJ/lA+H+j0d94sGVyYxy3xMHPR0uUvd3pxmq42RPWcM8AgK61sYAnH87XKJn0CGys862zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576155; c=relaxed/simple;
	bh=inSxxGkFCfO+Y6k29RSiQ7EJPmZ0OiQhAM6MDMEWVd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fdyak+vOW5E+rr5Ic5parTmkOkZmMh8htffXRdyayXp5MMhZjgDU49GGbiVr6sWxX1A9ZtvtlHvVp1zwAu3vCr86uplpMg+sKe9wMehTG3E0TUXMttRmSe2YGT5K9w03ZR69jIcxqa/GENCwT5nFt4eHfpyCY2zzm+9kES9jvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfQsgHUf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfQsgHUf"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1f758014b8so366714766b.3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576151; x=1788180951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0qaSHwszAWXEDRTaC8hozpR5IBR7Lde/0WoXfRxEwB8=;
        b=KfQsgHUfITXop2lajZ84edDQE7fOHWkXOps6M3HNtnWfIqPYFFS/6ElIi2Wi1UFa15
         2m8TkhufVXvCaHClbU4vXpfFxy8TRbGUcWiloBujW7SCXTXyF7wiFvBTTvSFMEHXZcmy
         lPm+7qDGibqxRGd8nOqe1INK0/TFsR7VCADLPbdsv88i27oPkmFlbWgPgFzG5d9X35s7
         lm/c3jbMBLUUd0z50qNRUwgWSypR6NOqMMMVV1r159kxwXmzXwLA3vxOawvpw70xYvh1
         ZtUP86yJGYaWGv+1kx/Nre7r0XiaJXKsG5kLF/kTt28Fi8CsMxwsgKmlJV3UFIlBGhcl
         kT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576151; x=1788180951;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qaSHwszAWXEDRTaC8hozpR5IBR7Lde/0WoXfRxEwB8=;
        b=EdVHjt89Z+BOBcz0Br0pqsAUA1gIymRZZAtoy5NDe4rqVbtIShv0sK7xhFOcz7SmzY
         VUALnTOQ1Q8uIXRsMDWWkb3UpoL8SwBcqbcxtfBj3w0ddhAoHbt202O40VFpRNPTRqgh
         CGVj39/Nyg86HSPHBbIJ8iNCqdvKH3VJ38xWpi92FeBs40gfFkjJ2+U+KLZgX9BqCM6n
         62VgzQmR9bBefJ+h2N13BtUK4Y008+c47elQaolfpVCdNc1ppxzpry6ZLVXCAInn3NQK
         F0h3Wn7dSKkk0oxb19cwyMrRQf80ujesS54J5UPpQhWoB0MYa9vC87D5T4IS7GFmyDzl
         /HRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2ovfA0MY1a1Sls8m+64VPYeETQnDGFAdxIjeeWiU3uevbbPN2F7rs3LNpK/fDMo/XdO+D5fwGdas=@vger.kernel.org
X-Gm-Message-State: AFuF++kXTz8w/XqRzQcvAl1ldEvGHSlMJyT05rrKGAXMVXUuO0kaiHWg
	DPVyVr7MirSPWwGTY2jEhP20WvW3WP81pn8ZTfN2h92tyxYgpz5aDmXj
X-Gm-Gg: AR+sD10T/VB1gemDA2k2jBMAx9gxnSS7sN2i5WELVHJKYxtmfKTSx6H/g4xaAF+kGJU
	0pSD3HtqOg06+1s6m//kg37ANaeZ7Ci4yd3q5MRvd+HORrCie3dFqnzdsw9O/aT+GhLoJgsNNCk
	E7pVqFrA+zazG615BfxPR/brvnSdeps/kyak2YbgTeXiUwyclS9yKQEzSnKLJgjHsHcj5Phfq1v
	Q0515mwLIuNzKa9u9NgptEDOzNI8uuzDfbFUPlO2k94KeVQGSFA4ncjNqKuPbRV1OWNW8NjUVFm
	PPKCcsHJTgYPtmPxqzgZ6autwYd+nDi53GFuWrE6+QYgw/0WbdOE5+iC8YXLAQjkta6Y0rjvo4S
	ZJ4nFNdYGuXCS5adeLa6BKKHYBiER5R+8+NeVF7POLoJlRyauIGCvWbweSIqGW3GmkyLqAv28Xs
	hIse1ROOHAumSDuNeWAST0xuHzSxh5vVo+91uliRUVyrW/um0w5QR2KhSpZlXBDJmQtlyOVXonI
	HjCv7aQwQc4nA==
X-Received: by 2002:a17:907:1c9e:b0:c16:3187:997e with SMTP id a640c23a62f3a-c246a4ede76mr2752351766b.7.1787576150539;
        Mon, 24 Aug 2026 05:55:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:dea4:599b:49a8:96f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm1245403066b.39.2026.08.24.05.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:55:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v7 4/9] pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
Date: Mon, 24 Aug 2026 13:55:10 +0100
Message-ID: <20260824125523.131762-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
References: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
Add prescale_mult variable to struct rzg2l_gpt_info for handling this
difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * Dropped extra parameter rzg2l_gpt from rzg2l_gpt_calculate_prescale()
   in rzg2l_gpt_round_waveform_tohw().
 * Updated comment in rzg2l_gpt_calculate_period_or_duty().
v4->v5:
 * No change.
v3->v4:
 * Updated commit header and description
 * Renamed prescale_pow_of_two_mult_factor->prescale_mult
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index da2645a42608..fc77c27f0a97 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -79,6 +79,7 @@
 
 struct rzg2l_gpt_info {
 	u32 gtcr_tpcs;
+	u8 prescale_mult;
 };
 
 struct rzg2l_gpt_chip {
@@ -220,24 +221,29 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 					      u32 val, u8 prescale)
 {
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	u64 tmp;
 
 	/*
-	 * The calculation doesn't overflow an u64 because prescale ≤ 5 and so
-	 * tmp = val << (2 * prescale) * NSEC_PER_MSEC
+	 * The calculation doesn't overflow a u64 because,
+	 * prescale ≤ 5 for info->prescale_mult = 2 and so
+	 * tmp = val << (info->prescale_mult * prescale) * NSEC_PER_MSEC
 	 *     < 2^32 * 2^10 * 10^6
 	 *     < 2^32 * 2^10 * 2^20
 	 *     = 2^62
 	 */
-	tmp = (u64)val << (2 * prescale);
+	tmp = (u64)val << (info->prescale_mult * prescale);
 	tmp *= NSEC_PER_MSEC;
 
 	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
 }
 
-static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
+static u32 rzg2l_gpt_calculate_pv_or_dc(const struct rzg2l_gpt_info *info,
+					u64 period_or_duty_cycle, u8 prescale)
 {
-	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * prescale)),
+	return min_t(u64,
+		     DIV_ROUND_DOWN_ULL(period_or_duty_cycle,
+					1 << (info->prescale_mult * prescale)),
 		     U32_MAX);
 }
 
@@ -247,6 +253,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 					 void *_wfhw)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	bool is_small_second_period = false;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -287,7 +294,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 		wfhw->prescale = rzg2l_gpt_calculate_prescale(period_ticks);
 	}
 
-	wfhw->gtpr = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	wfhw->gtpr = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	if (is_small_second_period) {
 		wfhw->gtccr = 0;
 		return 1;
@@ -296,7 +303,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	wfhw->gtccr = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	wfhw->gtccr = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
 
 	return 0;
 }
@@ -342,9 +349,9 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 	return 0;
 }
 
-static u64 rzg2l_gpt_calculate_cycles(u32 value, u8 prescale)
+static u64 rzg2l_gpt_calculate_cycles(u32 value, u8 mult, u8 prescale)
 {
-	return (u64)value << (2 * prescale);
+	return (u64)value << (mult * prescale);
 }
 
 static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
@@ -352,6 +359,7 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 				    const void *_wfhw)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	const struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -407,6 +415,7 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		 * value for both channels.
 		 */
 		rzg2l_gpt->period_ticks[ch] = rzg2l_gpt_calculate_cycles(wfhw->gtpr,
+									 info->prescale_mult,
 									 wfhw->prescale);
 	} else if (!wfhw->gtpr && rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, NULL)) {
 		rzg2l_gpt_disable(rzg2l_gpt, pwm);
@@ -490,6 +499,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
+	.prescale_mult = 2,
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-- 
2.43.0

