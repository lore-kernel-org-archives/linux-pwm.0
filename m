Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A548A8C2
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672937; cv=none; b=CxVzaeXxiWhurLMs9mX4AFrhdDv+pqKKfA+0XHvixdIwkELaFl6sRvw1Jrs3sBasGdYE3IufNkgPqK9CVcg41nYIRgrj+viP6dAMimlFxV1dXVmTltnEPCPwPio7tnr8z0711dYEm58G/aXbcYBLJ8F/Vn3+YPJuINwulZJamkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672937; c=relaxed/simple;
	bh=VuB36E1lq8H9yU/laDI8ZESD79W3YHrEkAWuM3sQtc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARnUkofsHQ+oZDkDWE1JQ1E1h9XIiLNidMDKtyVUfs8MjO/rLwQaFKax0kFNSS2ChQYLfTxicK9okHEFT7JF5h4UugG5tkhLrvbFHm4zFMEcBCqGPwi6mznNk1AqFMfZXQhdEFscmNIeOdpI5dTUSpvA6EW6RR0pGucmeiaaQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frZ3Svma; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frZ3Svma"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15f020a223so728495466b.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672933; x=1788277733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0is4BUzYiPNaBY1I22YbPSJWBHP4ENy579LWW0iQKA=;
        b=frZ3SvmaKlAQTefI3KFuiWfeByevL/SYqEDT7htrIqElokL49XUJgFm7Fcy3f7Z03+
         04E+x87Vy2LgAQfrQosEuCD1/CWDErTLqFa+bhwHUBPmUjfOh76lSlNHIRHVeYOEwxTJ
         Kwx26RlI5DbYGZPWxMVD8Jh0HGaPvCMw9CA+QiQuTWK1k+4Y032oTKZ6dsyXq6B1hj8I
         ks2YycRXbr8XRx5TGITcS1DVjalr4mjJ3rxpBmfdp6kGyiwtjFoHyNvk7ddvS2q5iI1G
         VLGtCa9uUSfedRXEEPT/HpVxlXIQ/KXkNypxVA7LKxHZc1vrU1fuBPIOcQshYgD4HqDs
         3aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672933; x=1788277733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0is4BUzYiPNaBY1I22YbPSJWBHP4ENy579LWW0iQKA=;
        b=n63kSkibqxjK77ijYQXQIr+d9udsgCQK9EDwdwFJh8gzP+ZW2ZW59ncYq6LSSIc34h
         gkIKHuAMD3Z8FCrMoNX8IjOMv1ldgZ3jz9zKIVA6/HoawQcAOK0yEhxDrPw1xtHzxdNi
         x/JzJd6pjO21i3Y4KdkOdx/BB+U1+tL68aEoHvvrdnffgh04TUqxDNwQl2hbSKsIhrQB
         BWaPISJuBhFCc6E1Nr5n6g23xjw+rgdArRkMI/s3z8C3vswLg6W+pmxBTX6FYwAO7frG
         LfJhhUbk5Kt2GPI6JOLV54Q/Crtc54/XaBr9wkO9mW5UJHlM3g+RGKGsLZOXPjqQxgTs
         nnSg==
X-Forwarded-Encrypted: i=1; AHgh+RpwRti1t0TDXEi6BKNb1+pajr2Jk+TvsMGsY+uSW4ewoeKSzJsEBZe0lEuOOyfx/NTPVd0nCk4mTzw=@vger.kernel.org
X-Gm-Message-State: AFuF++nUFv4YecV1+hvxjiypZIWSFCoDBmGDz3sAignRDK2X6P2fTn2n
	yEcT0YjEhpdewADbiMG43kgZYXdyStwNdDzhrwcLY2PrTAPlE6AINdHgsUjLtw==
X-Gm-Gg: AR+sD122cgnSJlf+9xNlx7JbVIOBgnDROUjJP6YZZ0xZZpF8KexwjJazOeSqKexifov
	Cp5cL6VlmadMScXrllr3HvreE56+w8WN+hlzbbF7WWGXLUdNu0khK5DG1kx0Hp4LVsqwRU2V0ay
	3fZfC5V1AXBiaHvwSAIfzvo/FcME3YIyEoKpKEh4kK6VG3IMV/isRQr10gq80xvG4tyUEPYAxgL
	4N7iGmzizlxZL6yr00ew2TNhxd5WZ8S8hSxyk1HG4F7n4hxg15QTg9i788W17gwq6yOvR9Jvj4s
	Zf2d2Ca9+4c8Dj/Y2KXxtU8rX74Km14VRkEmwtU7x6/qeHMAlaKAU9xfV7Zl8AQv5/vQd1j85EJ
	uDOJL6y7npV8eXnlyMlChk7RPjgImoMDr7ShSN3Utnjlb0DhFZHiYs8gG1cU44KjdwuzItj48uj
	MBm5iQ5JKYv4RHyyGbGSob3vDQL5NYx7T7fiaR31zJdefgeZP5aPe/l7htOXetb87wDkj4hHpxW
	klb/EkDopgR
X-Received: by 2002:a17:906:99c4:b0:c20:af9d:4544 with SMTP id a640c23a62f3a-c246a4e6388mr3638556166b.6.1787672933181;
        Tue, 25 Aug 2026 08:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd69asm16682066b.18.2026.08.25.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:48:52 -0700 (PDT)
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
Subject: [PATCH v8 3/9] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Tue, 25 Aug 2026 16:48:31 +0100
Message-ID: <20260825154847.197948-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
References: <20260825154847.197948-1-biju.das.jz@bp.renesas.com>
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
v7->v8:
 * No change.
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
index 0a66da0f98c9..87309f519827 100644
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
@@ -328,7 +333,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	guard(mutex)(&rzg2l_gpt->lock);
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -372,8 +377,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -448,6 +453,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -490,8 +497,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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

