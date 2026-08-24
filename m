Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422C41D4F1
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576141; cv=none; b=l8EfhZpxPlTQfsXT4kuDXjmmdB7lA5mIwDx3rXPqSVj2MXTv78quxW1g3j3aFcQZgyJUpQPvtDMXmFHZjuoWMBgrwozOtIBREv5QqJWynFtzMG/5AMMOJz8/RGysp9Bf/RDPstjyuMRQ2f1grKf9irCTFMLmxEJitZyCfgMETno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576141; c=relaxed/simple;
	bh=yYMxWP4A+NRrpVCC8gDaREvOylF196wwLNFk89y0MU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHBa4sPB2tR6R7f/8he8XE4MPf36ttYq1ufF2t87S6i4bYzwC472zjWD5F5G2qu9DCibBQ6M5/GtWPCMF4Iw2aRPL68ogPPoM4+/0nX3mZMnkgLZcnUkWohxEsbL2qRwoEKvAFxtj1VTA60BjThILNVO4wtolGy7Yp0YPxe3XeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDDSpb5q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDDSpb5q"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso5818119a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576138; x=1788180938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qoR/dhTppfDpvNv2/Q5EDuQc2/02Dofvc/NVVx1pJc=;
        b=eDDSpb5qBv4HRdRpoSiMCdJ41a3k/OAohYQZqDBXR1P9+3Ky+NgZF4KLxd0vrBj3Kr
         Bhen6vGTZkCw5Jvc07HVhoDuC+Gl4wCwPVu4ypDwbVPSSoJ3XsBDRnTftuxKC+YgX00R
         HaFJ8msqxmcRuBYYYlzWHKtzuMAh1EOTWa8KQ2J6FDGlNwwR4ter363t+1Dgw0dmorVt
         2wznpYItCA8nZWo0O2CgSXCEjt6Z9XXvqsxYieMU2857ViNsapLWV484vIRhgFfl+3HN
         ApsZpIVCbfzyhVR0ad8QGTVmnYMtUUIB9h6YXy67AxGyIXXcu2ieS4x3bhfrEiItRzbD
         APUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576138; x=1788180938;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qoR/dhTppfDpvNv2/Q5EDuQc2/02Dofvc/NVVx1pJc=;
        b=oK/LOd3O36azJKi9vooKCxWp/xUoXJUCuDjIOewx8qqc/zv+2wRBJJxAMMmdaUOSz/
         nAhrP9+ho8eIL/EQA9aImgA9VLLnvkJRw/5Ugckyss0H1pvNZd4YNhsIOq9ideWSab1a
         QWf+7EJnl0gHgLtMZLRshipk9XzTP3EY2PmflBNJ6fmurVyOQxUtRcj2pIkEqMiat5RU
         SvSefSZ3TmjHd/ZB4C4kldhie4guDoeorNGPWr7AsSQ6W75tAjdQAoEvdR1cGU2Shegw
         93CaQkyGDRY+OazO2k7eFO2gch7MV/OwTmCvib32epFYMJwtaAHd2pZCW4Ljng6vFCXF
         CdIA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5j0Yc+kzj7/g8YueMbj0RDy5RorUwsCViU4ajIC3z3Xw6Yy857stXtkJCEOTKFgDx0I/X52U1EJY=@vger.kernel.org
X-Gm-Message-State: AFuF++mpkzB2ca+PnCtHu5aw7SY6wR07IoGQfyWgmn9RgFCwIqZdnXgU
	QDQlHw4fRWDvG1HBE+ivVvmEN/CY8x6HWmOfGU3okTF+dN6HtrFDmNsj
X-Gm-Gg: AR+sD10pPSK5cwwVD3pf47/KvR1AmKg5xfj+mnSZtELIznFjgF2ZsfFgWMppm0Eux6W
	6trClyThtWXyhlvo++Oj2IVrgsGE9hgNlmpg3JjWuazH8F1wRDo0gnpG95uDQwBVpge00Q2OGjS
	1yxsSR9VDsv9eRSZrm6E5b9VsmHh7xUjbGYfuEo185lI5paYJLQHX1w7wHwVq4HFknfjbVCo9Pp
	L5zbz1pXLx0P/F7EDCh52kZMsNKGSi+3DY1fsOBWxVbA5RL6KwwVz5m74Wmd6nO4XmYf0r/qITK
	eoHyp6hYuKgfc92/iCFHyq+6kvofG3dLkq3Eutynj8dIuL3dI4DmhsydIDbI5/FfCCwV4kAPmMh
	d7RRX9Lsbw2ht/vXNdvbBhvy2Mxl/Rhqplps9S7x2LKykZiG9wG2SpzLEbaTvTwhZBfar+o5njU
	C/yW3g8qMCANNxrS8VnHH7jvz9ktCQCnRkVZ1qCni0q2nquaDnW5J3VWBdFXkJ630nXi6p0qfSU
	ai8bDY+y+mBBg==
X-Received: by 2002:a17:906:794b:b0:c20:f871:1041 with SMTP id a640c23a62f3a-c24925a396fmr1654642766b.7.1787576138141;
        Mon, 24 Aug 2026 05:55:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:dea4:599b:49a8:96f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm1245403066b.39.2026.08.24.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:55:33 -0700 (PDT)
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
Subject: [PATCH v7 1/9] pwm: rzg2l-gpt: Fix macro used for period/duty cycle conversion
Date: Mon, 24 Aug 2026 13:55:07 +0100
Message-ID: <20260824125523.131762-2-biju.das.jz@bp.renesas.com>
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

