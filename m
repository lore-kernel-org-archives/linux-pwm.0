Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300325;
	b=hqvD7CdcvFwPK7q7smTVfsBN7YVVi60JFynJKFu05kxzu1JgMzah92fBPGLi/Wz43i2s
	 bZXqHZEdJxndwGdzBjK6C0LnTDJISMjzWiQgSqCHSAWHGGTesL/1pTnOEFGPXC9bgWGRD
	 bsAV5e0dBZWY+sPRePgf2uwaA1FUM2fLwtGv2Ij40ZxdAETfEQ3sL521woygx5DWvFKeL
	 4y/LHKLEQzw923aqMOBd9iS4r5F5B7WT36b1f7HK2aVku4fFQouv09NgI1gwgWtqd0yFU
	 r2lyFaSsgrDDxeE4NBSzHYuRIh/ZHmDGl9x5LpvfXYFucA2fc+GZjyxQHwiJtTq0HfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=9tJApL13jYD80pBp1MzydfMpvJBp4BlcldlOMSU105M=;
	b=H7Y8AJwWENw1b7n1ecZ2ACSfDEnpXcZk4xbefjNqjea74Jlrhabtr1i2G390GuoQ6pxq
	 fe8XIblj77po/DoaprlQtkf5Zrx5hz9iIYz7N5ico4bR/gW5gwZvRt2JFm5aegRWIF1NC
	 OyQjoM550dnAoQzo++AOlHV8lxMx3hk+BVT5Fq88D8on7S3aNIo1e6LUolBd8xfyrlIoH
	 1Lj5aZq5DYBihV8CArNrArvtul5foe4cfSPS/y33FiubnBRe3NQqj/4dppSLv2iJx2Nz8
	 AmIOQGUFvFx9m/BBCl+lBCkZaW/Ti+LOYZMITzre2C2svx/pw0JY3/bu/0R6OdFafnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROAa1Dd0;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C1606A336
	for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 18:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809C1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ROAa1Dd0
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso21814105e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 29 Oct 2026 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300313; x=1793905113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tJApL13jYD80pBp1MzydfMpvJBp4BlcldlOMSU105M=;
        b=ROAa1Dd045ooc7vRm7+fs8AEm4NbqvkKt7xrNMxkXeL5nrPzcY9TL2+t1ItP41Bj1h
         Gj0Yw+2kJ8l+kNSemYW2kESFfoEU8UMMacjqSSIW0bRFCNfz+Lg97csRo9ivybDKCx6b
         cpbEwu0jXyZr8ncG/j/5+cnp2WBt+SllE1qPUvK8h2/pez0d2nC/ltA0Fzb4kJ4coydJ
         PtGenoP6nkCrUHXTffi0WTzrtc4jcqZTiYNy9Wt8Pq5vm2GDHA99cb6G+ciEU108Ua7M
         /EkqG2KUYwMMnVXEb/aZ/6F3jJD+2ZTqNtV7cNmVggCU99JqaA8ai/SvML8G+PW4/+Ld
         VPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300313; x=1793905113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9tJApL13jYD80pBp1MzydfMpvJBp4BlcldlOMSU105M=;
        b=xPL7LoLv6TJ9Y4i2VxoP5eFgnpzNWJ+zQ5ijwg31kt+ChGrmGCry8RQzJ9hLk6+e+5
         xK4YO47dk6WcjErmhM5wTV/xSkSg7u0AaCoQ8K14Mg9VxKhFJTpO7jlqIp6hVGdZ2Qa9
         eiA8Iag5Wr/56zc5ZywDB7kH9tFp+X8Ab48SUL7/5QxM3I+Z9a5UBs9N7hZASRvwGsFl
         ftSaCNssbb/N2tivll9NBqskv+8YsZNHhWU9rUyws/e2lJRwSiHHQle+MvrDJIgxbK7X
         KTfNrEr6Zoyx8Ixgk9KMS4jrImatGur7Ta2PXUB5EFrA7G+/T7sPqzkR02Qf3OKOniSj
         fcrw==
X-Gm-Message-State: AFq9FYJfYIJYmr7d9GpcMzg9MQM8e0PQ2A3xQkQuH/te1cMrE+hlzdpP
	FpDk2ro/j9rYYPtjOnGEtbad4aja6iJ70DJ/7Cz7O9PsydtYnahNhB7Y
X-Gm-Gg: AYBFou0ihQniByjHo0g41nKXrtameSdBmaAqi8ejOfg1rz78haa2mAJGToL6oXQUtyg
	jbMfEyBWE0XdfLUxr64RtPTMauW2otnrRKbE5OxSWL4OHJgA5075bGzCqBqLZz8Wsmwz5vrs1+v
	D2RapoV938awc8zlpgGh60Pk9NavKaxtPhex+9VYUFwuhqFeMf2hYo5hE73OIt6QDDrUd3eA/WQ
	Oenp8D7qHSjbkAbV/R9r3DZuVVSYXvXqOeiTNczlvSg00Q1WZfkfWmztzYNld71sm3uB/2D1SRU
	H9VAUiLRT6h/c9yLx1vrECsf46TqAJeu3QCgfmLg92G7Ucg2+p0Gr/DrxblYLdWOLWlXdG0ijMn
	0w/3rvfrtlDKU61PjcKicIdaNhB+30Q36ea+AvAvFHJya9yLhoKVERsWyAozjt3wTC1V2NaZ69e
	otVLnnyUJ78kNSewIrselEb2gXIYLGxF74M9mqzPKAVw5fJtaISCR4D5+G2aXP6LKvZJRU1WAIF
	Vh5Uj82Y3iJClA+ie5y5wosvcoJ56pWOVCjxGmusexAhYTmnvL2lqr/0nE2ip8pFOmZoam0WhaI
	RxyMb1m+SvXaidY1HvY+dB0C4P3XsiRgmHGZaE9yzDkQ/hx50qDJsAP5a/pTXJGwi08JPA/VnLz
	nuMEAKykrZFk=
X-Received: by 2002:a05:600c:8183:b0:4a2:1a:a129 with SMTP id 5b1f17b1804b1-4a9677c92d0mr123815985e9.35.1793300312779;
        Thu, 29 Oct 2026 11:58:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:eafc:6fb2:6c68:5ae0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm94291535e9.10.2026.10.29.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:58:32 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 29 Oct 2026 18:58:28 +0000
Subject: [PATCH v9 7/7] pwm: rzg2l-gpt: Add RZ/G3E support
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
Message-Id: <20261029-gpt_rzg3e-v9-7-f3a5520388d3@bp.renesas.com>
References: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
In-Reply-To: <20261029-gpt_rzg3e-v9-0-f3a5520388d3@bp.renesas.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793300303; l=5197;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=rMti4nVWaXcqMBwGhXa7IT8v4yzgTB4dEpyc6qkRjiM=;
 b=MPzAnHk+d4TjXb6vN0vwjaqQCFI08wtO+hhJ/GBLBNIu4YFoESZUfTHGDuJ8KuU5HgAzDQTtj
 VL0IZpo1idQAMsc+lcltoqN5JKsbqXl5cxXaThMr+PUwBuPuYMHS08Z
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * Updated a comment in limitation section '8 Channels'->'8 channels'.
v7->v8:
 * Updated rzg3e_gpt_calculate_prescale() with >= 64.
v6->v7:
 * No change.
v5->v6:
 * Updated rzg3e_gpt_calculate_prescale().
 * Updated comment in rzg2l_gpt_calculate_period_or_duty().
v4->v5:
 * No change.
v3->v4:
 * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
   rzg3e_data.
v2->v3:
 * No change.
v1->v2:
 * Added link to hardware manual
 * Updated limitation section
 * Collected tag
---
 drivers/pwm/pwm-rzg2l-gpt.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 488839e99464..5ce662559263 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -6,15 +6,21 @@
  *
  * Hardware manual for this IP can be found here
  * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ * https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware
  *
  * Limitations:
  * - Counter must be stopped before modifying Mode and Prescaler.
  * - When PWM is disabled, the output is driven to inactive.
  * - While the hardware supports both polarities, the driver (for now)
  *   only handles normal polarity.
- * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
- *   each HW channel have 2 IOs.
+ * - For RZ/G2L, the General PWM Timer (GPT) has 8 HW channels for PWM
+     operations and each HW channel have 2 IOs (GTIOCn{A, B}).
  * - Each IO is modelled as an independent PWM channel.
+ * - For RZ/G3E, the General PWM Timer (GPT) has 16 HW channels for PWM
+     operations (GPT0: 8 channels, GPT1: 8 channels) and each HW channel
+     have 4 IOs (GTIOCn{A,AN,B,BN}). The 2 extra IOs GTIOCnAN and GTIOCnBN
+     in RZ/G3E are anti-phase signals of GTIOCnA and GTIOCnB. The
+     anti-phase signals of RZ/G3E are not modelled as PWM channel.
  * - When both channels are used, disabling the channel on one stops the
  *   other.
  * - When both channels are used, the period of both IOs in the HW channel
@@ -47,6 +53,7 @@
 #define RZG2L_GTCR_CST		BIT(0)
 #define RZG2L_GTCR_MD		GENMASK(18, 16)
 #define RZG2L_GTCR_TPCS		GENMASK(26, 24)
+#define RZG3E_GTCR_TPCS		GENMASK(26, 23)
 
 #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
 
@@ -147,6 +154,22 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256)
+		prescale = 8;
+	else if (prescaled_period_ticks >= 256)
+		prescale = 10;
+	else
+		prescale = fls(prescaled_period_ticks);
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -228,7 +251,8 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 
 	/*
 	 * The calculation doesn't overflow a u64 because,
-	 * prescale ≤ 5 for info->prescale_mult = 2 and so
+	 * prescale ≤ 5 for info->prescale_mult = 2,
+	 * prescale ≤ 10 for info->prescale_mult = 1, and so
 	 * tmp = val << (info->prescale_mult * prescale) * NSEC_PER_MSEC
 	 *     < 2^32 * 2^10 * 10^6
 	 *     < 2^32 * 2^10 * 2^20
@@ -482,6 +506,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
@@ -520,6 +552,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg3e_data = {
+	.calculate_prescale = rzg3e_gpt_calculate_prescale,
+	.gtcr_tpcs = RZG3E_GTCR_TPCS,
+	.prescale_mult = 1,
+};
+
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
@@ -527,6 +565,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };

-- 
2.43.0

