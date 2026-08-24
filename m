Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1C41DDF2
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576151; cv=none; b=SBCF060ni/pAjPSOCI2gIW+FsGbzo1UNnWtjeTwAnuM/xT4LAsEV2mBfT/dZ3NmO/PZwoEkWAS0+9g9SbEw/vaRIdXdAD303nRukGWbHBV2gg1CpYeLdJ9oix7SEgKdoVm5yN9cCLXlL1BV9eiUpFpr667u9LMK9C6fGzrKFSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576151; c=relaxed/simple;
	bh=5Kw2fqLXA76dVaAYZYB2XnROiAJp8L2IGAYhDQnqUYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iihAuRIdOMlKAnFABm3UJEhFAtml++PnGoAnVCRJxYEcSkNc2kfwck1vQVlLK8LR9pevoahXMznQAnB43nYY8hzf7WfxwHrkynIXAQOXS0pk+lwoghOkilpU28TXClKo9cT7mkqGAKUDRrw4xtRQX+oPUbFNPEWG2xw8pQTG1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoiK/iPd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoiK/iPd"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso522513666b.3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576148; x=1788180948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TWoXnFxzx1GlYm+udbSxbUhiDJnm5nfEowULKxIdMM=;
        b=aoiK/iPdyaxPuDbBNPsfqka1Kw3S3mQisMsG62wL5ZL514oleu31UAzueq8aoSQCdY
         hT6y58+aPLF6RoKuJiYP84sVJ94l4+mtv9mCb8qIezPA336e7b5137HNOtIwCnovN4Zr
         2QQtMbyT1fo9e4m3IjbPN2+IxzRw2jYreBmhi/qMSnIiBjcY8XmQa8kyYL59OfYtRd76
         a7soNZDwOXRyOblchesbNuPgq+BpwTJkZ3q+kwdCsb/577yMfVxIVbxmiJhMIyAp7DHj
         rtgIOezBfCxufqeFkDA68mRzdDOlUo9DNoxHZYSQS1GqSuo++lrEX5JGFHzPlK5m40jc
         oiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576148; x=1788180948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TWoXnFxzx1GlYm+udbSxbUhiDJnm5nfEowULKxIdMM=;
        b=K7pGYPsH6kWDvn/U6QWcEstqVWGGtTzu4sskglZdaAu5eMiRluG0OGdWq/knlrF983
         3jt2/1F7BQSxjvQWHe63Yp3JwNhf5WzaPCkUFafTlMNaDrvNR4AurkGJXYdt3wU5RiJC
         CzUm1fPKRFOJVDcFBJWb1uBD58xx+NxghaQpE2teP1ClTqLgZ2LvyPQ0qp75xHQj8/Rf
         XVawhk80aCW9pCUTUK9pAiOBbK0Ygtm0V4Y+eKGO+PnspG/NAnSD1NZt2cNRP3Z0p6Vk
         vyK48w1Q8nzLNOGYiuJWJl6CBCtWGu25WWSCTH2NRLI3yUSDXCXj3cqTNkFfhhMQirBN
         X/lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7m5ssWaE/DkrycbcV5+lOZAHmORVc4bXXhEqVyk8Xf5eBZKI+o6UNaPovoB1OZs0f2MM/yZLCYBk=@vger.kernel.org
X-Gm-Message-State: AFuF++noXw/NZnKPkDAQcV76t2PJRNz0Lep4WbszDfFAyMP24sA7NiTz
	dxfuxzOqjUst746f7dwPTRyle3ZY7GD8hnP9dJJNvJILQDacpxJgnh8JjKl/CA==
X-Gm-Gg: AR+sD13pGsTukAh1Pt1fXqhKAEQA/E2qG5nNIPxuhXM0OECoWdEGHRgHH3KaPn90w9M
	1vlwp2ZIRxVoXsbRx1+43j3NjkrNpcPa2OyjvHAro4NviXdeeJB0DGxoZ+NyiWactQ3vB97dN9T
	yCol/HXy/3Kn+lFPn6yBleV5rLRQya9CbMJP1nVtB828WMjZOvoDu7+uojPSxIc+wIsNW8/naTV
	b1uRIXlXoBmEtKHKxQGsrrhBV8FoXbQRKOKc3ThuxukdhETi1Sn41Dpc0mkRNYvfFSrTn40Fu7K
	rVf5IICU6BDYBpv4ua7S8Ge5QQFhejV0flxSF4sNUFHcZw4sAapjz6J3rCR0dlR17WE7C3b8+QF
	Wtx/80KWnrVFqMPEGaFnIa9So/2Xg1JJsjUpFLnWzsEEgj+cS53lsbYRjfyQpHdyhog8emumevf
	FJYrSddq36nkS/SsWPnAWIl4HT62o0VMVcgblqB7ymeDGJ/sFKY3AJcsh5UZNVmuwMHODhxj4h4
	XGqokE9472rLw==
X-Received: by 2002:a17:907:961d:b0:c24:469d:5653 with SMTP id a640c23a62f3a-c246a653373mr2750262766b.21.1787576147560;
        Mon, 24 Aug 2026 05:55:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:dea4:599b:49a8:96f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm1245403066b.39.2026.08.24.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:55:45 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v7 3/9] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Mon, 24 Aug 2026 13:55:09 +0100
Message-ID: <20260824125523.131762-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
References: <20260824125523.131762-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Introduce struct rzg2l_gpt_info to capture SoC-specific hardware
differences, starting with the gtcr_tpcs field mask for the prescaler
bitfield in GTCR. This is needed because the RZ/G3E GPT has a 4-bit
prescaler field versus the 3-bit field on RZ/G2L.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * Updated commit description.
v3->v4:
 * Dropped field_{get,prep} as mainline now support it.
 * Updated commit description.
 * Retained RZG2L_GTCR_TPCS bit definitons
 * Replaced gtcr_tpcs_mask->gtcr_tpcs
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 2d40c59106fb..da2645a42608 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -77,9 +77,14 @@
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+struct rzg2l_gpt_info {
+	u32 gtcr_tpcs;
+};
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
+	const struct rzg2l_gpt_info *info;
 	unsigned long rate_khz;
 	u64 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
@@ -325,7 +330,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	guard(mutex)(&rzg2l_gpt->lock);
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -369,8 +374,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -439,6 +444,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -481,8 +488,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg2l_data = {
+	.gtcr_tpcs = RZG2L_GTCR_TPCS,
+};
+
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-	{ .compatible = "renesas,rzg2l-gpt" },
+	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
-- 
2.43.0

