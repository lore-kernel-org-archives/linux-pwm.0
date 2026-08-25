Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD43E47B
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672935; cv=none; b=OI6ymMvs75zyeQ2gWEhT+nxGf8dtcFWwwhqnC9UgcMiznHKpQoJYYpMoHeNtAj8RKDjPH4kqKmKZhqsdiQuPPbsoNIbgUZOzF7CAmxJaj74qASNK6IpqKv65o5tVmmfgWWTkeETdMvsRQ+TInauy6gLnkQY2dNUK7olPWpbx3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672935; c=relaxed/simple;
	bh=DvwGC2hiaOQv6vXVCrf81R5oEbk2paFhxZaDMe7ibeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkxCqMhLDLe8jPB67gNo1RSih7afvW2v8HQRdSQ/nBsyRIIO9mB8fYthm3Ey1BH+rmYyA480NXET/uHIP72Z15e7ylVHD0bNoy3+zslHS2VG9EtWE7j1bd2IdbBag4VBXZ8/5hxxbLEbMR07QJEklq6apIB1sQtZbgvd4jcGYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3s0h3T4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3s0h3T4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso244130a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672932; x=1788277732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zPZf7gPmP8B8UD6UqrTKwvbuyubRbJ0al5ye5Ryd+7s=;
        b=c3s0h3T44vKPK5Z+WgyPQblZTtBwOfqG+W9+5ZjtZYJ3jgp3FvtZk+zS7/1zTXDxLQ
         ar/Yh6vKnYZcxY1MmNbBxPfAV7CYYvGuJYxBU3q/XXR9IiW5/c8N2V2W+6sLfOyDtWKJ
         bz/W5GSFe/WRxGoYiBafyL9H/xLvyDoLJLAOK+eviBkfSAOfmJCcQkQKlbYLIOXrkCv9
         yvTy7gsZhq3fPCraIC8seOWwYZBHJsozFMr3ev+FaJNQS19x+FLsa32lpTnMHsHbS+3B
         vb4mKa6jRDumUukvzql06u2x1Jtq1mNSPo3omiOvV0maNLhmGINKPFXsxU/oOABgIAsS
         mqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672932; x=1788277732;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPZf7gPmP8B8UD6UqrTKwvbuyubRbJ0al5ye5Ryd+7s=;
        b=Po0SlKPaYwgI5TcOOBo0Q46HkFLO6MuGoWAEpojiYABPiiDCAEy373/ha9/uIdAE24
         9eUmErdpyw4qAMmY7WQkXKUAPQjlJa/QRly2e0FSLSHTWlgYknDgkS9JelFqyQOWhV7N
         kxi4aaRwI3TQYyFKIHC+f+//df6CjuXJJU5eVd8cXZA4cCfcxOcF75Mg/KRrGrtAgDC9
         1vGMV3kCGPSMyPEGPLy8jxDOd96dEciJxe+xqEZOFHFP19ugjyUtRkA5C5O7eT2V/8SV
         5zHb/tGY2b9LwB4dJo8kgUOZqEc2WACMFoEoVAgq3dcW91So+n//xoYoPJqaOofl9YA8
         figw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5aba2hcjNWEqhU7vDQQv/D2TpDmn2W4j01Ov0ldwHG3UWrs2YT/0wdLUWNfi94iQljkpxBhm5IxE=@vger.kernel.org
X-Gm-Message-State: AFuF++nU6wJrxpT7RBAzeLtRRkCcxvd32+GHNMWgWQyN8Mvn3QOpDVs5
	S46LmVf3y2oVEX3BnX4511bKIy41LE0amIzgGuMwWy5Vlei9dEaTCQ4+
X-Gm-Gg: AR+sD11KoQ+vpg+crHfCZn/QetBgIiMyrgg8SM9uPK9Ym+vqqKNz/8rn2GQFDhYv9GA
	c2Cjked6GMGL+QW5u4GdJFj5rJd8LdsQ3qEqorCTMpykY96v3Ga2Xmov2zOJ3PLMoQOpux8uqo1
	wkZpibW9iMK8eHCNZ88TeWRNn/W/ZThRMKI8CmcF8FW46291Pa6yvvda3QcyPlp6nH5MPE9ATWT
	T65v8GvYSLKuFwY3PLi9a5XmYnUC/4p1Q8hUjRaaJLt37XvupT97Z8V36xj1B5GETM9y2hdnDZt
	L3Q8VAB6vL2iI9d2BqpxxZnGJy6YeAMDKUeJABmF8jc6pycYzfCr4AAQlLzGNsHikS0Ue995y5x
	1ulB9lLfD72XKQdbNQ3rMAoXSealCxnT9EuhDvdHPNUMf9bifL34oiaUGE3ocwGpP2+QCGEiJ6G
	WEaWl927Sc27eGJIyhuju0a/prWuUD5r+TemWvaakhjoRRpHv8GieiBnwI82a4KaQ2RDYyZGYXR
	+gU/ownyyFM
X-Received: by 2002:a17:907:9626:b0:c24:87e3:b8b8 with SMTP id a640c23a62f3a-c249209907amr2738438566b.17.1787672931520;
        Tue, 25 Aug 2026 08:48:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd69asm16682066b.18.2026.08.25.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:48:51 -0700 (PDT)
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
	stable@kernel.org
Subject: [PATCH v8 1/9] pwm: rzg2l-gpt: Fix macro used for period/duty cycle conversion
Date: Tue, 25 Aug 2026 16:48:29 +0100
Message-ID: <20260825154847.197948-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
References: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The driver converts state->period and state->duty_cycle (both in
nanoseconds) into timer ticks by multiplying with rate_khz and
dividing by USEC_PER_SEC. Since rate_khz is expressed in kHz
(cycles per millisecond), the correct divisor is NSEC_PER_MSEC,
not USEC_PER_SEC. Both constants evaluate to 1000000, so this is
a readability/correctness fix with no functional change, and it
keeps the calculation's units self-consistent with the comment
describing the overflow bound.

Update rzg2l_gpt_calculate_period_or_duty() and rzg2l_gpt_config()
accordingly.

Cc: stable@kernel.org
Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * No change.
v7:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 1569f3ba8c53..108fa99f832d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -208,13 +208,13 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 
 	/*
 	 * The calculation doesn't overflow an u64 because prescale ≤ 5 and so
-	 * tmp = val << (2 * prescale) * USEC_PER_SEC
+	 * tmp = val << (2 * prescale) * NSEC_PER_MSEC
 	 *     < 2^32 * 2^10 * 10^6
 	 *     < 2^32 * 2^10 * 2^20
 	 *     = 2^62
 	 */
 	tmp = (u64)val << (2 * prescale);
-	tmp *= USEC_PER_SEC;
+	tmp *= NSEC_PER_MSEC;
 
 	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
 }
@@ -266,7 +266,7 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u8 prescale;
 
 	/* Limit period/duty cycle to max value supported by the HW */
-	period_ticks = mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz, USEC_PER_SEC);
+	period_ticks = mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
 	if (period_ticks > RZG2L_MAX_TICKS)
 		period_ticks = RZG2L_MAX_TICKS;
 	/*
@@ -288,7 +288,7 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	prescale = rzg2l_gpt_calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
 
-	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, USEC_PER_SEC);
+	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, NSEC_PER_MSEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
 	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
-- 
2.43.0

