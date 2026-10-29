Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300308;
	b=BKoaUUt7uKlFMI7Xpk6/VbKCFeTcrltghTeA6NjPM8KuiEY2WbTvSEYm9BHUjxQ8xHZF
	 MSrqdDwDpoCwXE7GGKfp3OUQIP111ZoA7P8jVWX7MKZ4THyv7KskVatHSKkGqGT/Gp+Hp
	 AftTBRTfvEOlb6969SHbZpymXn4NTrIkEE2Am5N03M7lb6v2v6/bJ6ERZDg8bLwZbIEnS
	 dE5eywHQumvS9A4AjLMfWism/E/qUhMDZVB3dmaLAqyLmTl5ErWxOmAMCw3Mjt0KQOfQu
	 mbfPocaq8E8QFKI43spvdL8qvupVo5kphXX0Epk7oY8B675zsWnqMSNG9DCm0sRxl8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ttAFEn+rtoPJmo/PrIZYDo9pnhtVsoutuS9qQ/v2fuI=;
	b=VUJViPCCX4rfa0x5gr2u7rIbo3wJU5jR0bny1vTLdpehfjST+Eqz9z/smpgOKeE0hvDi
	 /YdbFSIKM071HYZ74sL/O8wiADmsNAwgsVhZ4AYJO1rnjDu6wZPjJxrGncqs/If2VkKpl
	 RIFd0gwAMnkbicKynndvkC5IRRH0KQXoIVFE/WZ0dFjyknafL+cOjP2NvwNydVmQjHqAh
	 DiuSjs7albCF0fHhiqI0Gn4bTvAIj3ivJ5R/QthIvi8y+0Gp7RgFRc4WCOptqNJCEaDtC
	 1t5MMxIH3nZJe4t6PKX4eFgMJbkXyZZleDAwaVgD8qGmq1R5s9ZBM6GLeHUOhaA/DMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TV/vTGGO";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F3606A323
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 18:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC2F3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TV/vTGGO
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so21317135e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300306; x=1793905106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttAFEn+rtoPJmo/PrIZYDo9pnhtVsoutuS9qQ/v2fuI=;
        b=TV/vTGGOstd22JNi+XZy5ZyO/VglSYY1PcHwLCZU7JXszjXWAMmrGN1AU7U/g174G1
         ZoTocD4mLiM/kAwdDedfLXCggHPkqJlgrcz1L6SBKfzN7OlndquSs4i0MdiUVtH0HiYB
         cpL8n0h9qYX6JfY7E97Rkea0NKN73L3lhUL1SeX28UQ8FZDX4G9Ucawjc5v+21zdh2qW
         4Y67DSPr2e/4PjV8KwtUVooXpW9hWNCtT42Zb3i3NFUh9yUfHGt+a9dISyJS1BeW1caq
         3vJYxUOC0hNkTwyXGziakzbLOhJbMS58s0zUrz2FtqjzobxIdpKEzcyraYVADp+af41g
         L4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300306; x=1793905106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttAFEn+rtoPJmo/PrIZYDo9pnhtVsoutuS9qQ/v2fuI=;
        b=HJvoS778bXc4tbOGNgZwTg5ckgGvS77JwInDP5Y/MvxkoEH68ROSABdXb92f/eDtIF
         65/8viOpiVdCSp+Nw3yDqResJjTHinU7nMd5En/BfAmh6dPT8TgAcFA2YDAUAM8mL7Lc
         EbtOM1q5mu8dkT8pKg2YRy95eEBXXoDDasbf7LOjHhMe49BHSfDN/MiyT1t2MZs5c+5L
         6LUkKR7Mrmia5ra6R+a58ifG58FrYWJQIzomS0flgMwOmL0NyIrXBxRBWRBmsjwy7qBM
         rD7pcE+SfdpG6hOmC6EN5FZxVpH9gZvBHvQ7uyee1yX+kS2CPHLswnz8CZ47q9bXvzBM
         lkYg==
X-Gm-Message-State: AFq9FYJhFkdUcIG/UxVSfVOX2nNO2yobUoCLYYAoHghoBgmsFaDYHSuQ
	U9twxxVCNKfuSMZO/EQAYnE61AQ8zl10L8tYH32jhrxlO8LX7sMmtuxC
X-Gm-Gg: AYBFou1mGK1RDlSnSfI0o9CLUq/v/E6ou4sZp++JFHYEQK7lLGux4MXqepMXwEOYP60
	Cgjfcdk4oYTM/QdnXljgVRh8QFQMX+5b0HRkviptsmGpbi/NgM4zzmHA15y29inflqAKUG+zSqh
	oGStYVHHOrtio/HWU6xWCnD2yL3KRLkezm2Ac/2kO5quZjwoN6Gt3c4azKQLiydgJF5VYiNNzdG
	ID92CksjL6tCDu75wEh9+cepOdbTfn9iI3t4LOR5ONKsPJu0yP6JmoR+Ycz5uUUk0QY+JXZJtfZ
	FqSZcvuCmji8O1/Kp2VuOH5qyjErr46j/+p0bRUkFSSB4diXSsb7zM3seDnGvmllC/+DdpwCI+Z
	3rHJfFzIlgbe9QjKJTEURCdaLiigg8BNax6wwyk+V2x8yOe9zIeTEKOUXZlpu9fOs9KearlVMy+
	r1eRSyxAQpC7oU4tVRNtIr/IoOHyWB1qWZxMmHDCO4ZrqTDcvGyPkGSDuxHNCW8T7zwgYutZRPu
	RZhpVNUU4KbW3NlBS2RIdOcjPw+N96JlVkk1gRTYlZoMLP+n4i235uqMhLkNuD4z9EZI7gntKcw
	vALAaQTqN2jxrTl/2rbJn3JhF3iNsyGsR4Y9dKt+8bfIaBuA6BxUDKwkRguSw4tmeg==
X-Received: by 2002:a05:600c:a117:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4a9672f93d3mr115987285e9.32.1793300305935;
        Thu, 29 Oct 2026 11:58:25 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:eafc:6fb2:6c68:5ae0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm94291535e9.10.2026.10.29.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:58:25 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 29 Oct 2026 18:58:22 +0000
Subject: [PATCH v9 1/7] pwm: rzg2l-gpt: Update macro used for period/duty
 cycle conversion
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261029-gpt_rzg3e-v9-1-f3a5520388d3@bp.renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793300303; l=2552;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=HAxHMX8kKpEO0nGsxRfolxnfmZwWa8sxppL9xeoqPRU=;
 b=ztJxoP306mi752bvcCsH/DuoHpOMDk0/8Fnbefo5G3q5ChO0cHBc3Sm4YBcxS5zoWweibbXrS
 LU2e9kCH5mADM0XAKB+JpaJJEIK3wdzee3VVJGbhfGUmY+xYmyxX5jA
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

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

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * Updated commit header
 * Dropped fixes tag as there is no functional change.
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

