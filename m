Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5A48B371
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672943; cv=none; b=Ii/NA+SqiqX2X5cWOYi1ENpjxrbE8IKq38EHYTEhaNGLJQ+o3lgnLmx/+rYOWkglSHbJCa/NP/fey7+geCRo7QY4/koP0nyGYalJypRAeyIscgDlq90RS8xB9R7DAg8knUz7kwXqTf2mGMzMUKvn+GZyb4BePWSwOsL0MHmmdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672943; c=relaxed/simple;
	bh=efRF6KROkenLNDxb7TbiGycoeh0/iynB2mbKSlbIWqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQHzvHYn5fEJXH4ydjLMx32xdFmZh3SNjrYw1p4Iuo5hyV5XGyOuF0jT+AOugejtYi8VlJhDPyo2z5GWgUA0E7bPuo9pGSC2WdWcX5EOMl8N/ISKgVtviYS+qeNR7X719jpDxu7QRI4wpxS9cJ0i+dERWB3LQjKc+ja7pcIvuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm94tA7D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm94tA7D"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c52d920b8so703921566b.2
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672937; x=1788277737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KbzPyRA35vt/mJDbnSSeCRH9FEDa0mitnkMN67SloUY=;
        b=Vm94tA7DUOJZEYGfxs7j/BmWtl6ZabRRc9EO+7BTHAMb+cOWYDg9RYOaLDRjndaiQf
         uPIONnQ88dzd4+UXdu8mzHmHRjnYauREz11UWmXU3xHxCmdr2vsuNRCG69jV8vWdSLW+
         2nPlMFFBvc+PEcF/vFxbaJvCcpgCCBYfLWef4g5rQ8xbNda+jUdRCRaaGo7eP3kbWm3w
         X0iwpe2KDHfe2xXqeZpydKpuARylhxV36dOgS8N4E67cH+CFJMuwSTPyks94FHJQUn3U
         V89ChMSjcHYMDbSDOBfRXwrh9lkWWUYGGXeC7273e21UomLF46t7rmPeKvBB+AYLR2VJ
         i7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672937; x=1788277737;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbzPyRA35vt/mJDbnSSeCRH9FEDa0mitnkMN67SloUY=;
        b=CKXTvEkVVcIHf8Me43H//BNkObuejBWKM1oex9bWW3TO5cb6qllCyyh96OJxXRK4rR
         gI8x9BzF12P1BBrhBdrC3Ly/mr0K8Egld+3Ej9Pqf+RmkGwmdqn0EmfvphpfzJywRPvc
         pxZr6jMnSG2uCtlg/tkCRv374XQwqnDo2cHat2urFZ303BE53nyU/7UGvxnLQewO2el9
         w67hnJA5ftDmENx/pcA0Gdw62hBhnKARIiKJV5A16W/TN+be5qcTJUW2/6d8w/tpeXdD
         /gf55uWYfuLpqJGrXys+glftrsw1R4jcftivIk6yryBTtFrjgOYaG6/P5y2IL0WmIRz4
         TV1w==
X-Forwarded-Encrypted: i=1; AHgh+Rp4G9n2qqtYDAF323QKlD3FmxXRtFrztdmIDD3lJdf4JJx5vnX5hXFRgvO8Kpyh4CNKXTRJBoGW26Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lWhzNq6igjZ0gj7/41LsgSakwh3xyTg91hWBgfhrpyw660SbZc
	wwjP6iQ4gglaT3WIJf2+hDSS3cPnxlXerzOIVLmZtIfe1oENDIuDBBZKB+VtNA==
X-Gm-Gg: AR+sD126yz18pmE+ilmvAOFKK2c9o4xFOVisrP9BaPqWtrKxr4hIpc4naStNZm5lHiT
	yUhJACSVbpM6o/FAtbS1PtiJONnWTYcbLX/XHhkrkmmj5hxul40ikcnpf5DCIV9w67pbIvTBD81
	S2Wdl2SWYTCMptDtx7oP8Dj+Vkvdl5xCrDWjFjpsfxeWCR46tyKEeHB/khnDNZo6A4Lm/Czmh8e
	+RCyoXj3FaLEZ5dEyOoqI438mb1xbW5FHLDUFka9MZplZnctKmFzdNiw9nhoXqyK2FY1y4QsxLW
	2sGiIEmcmypOovaT3MIWAWysrJKeKEuuH/vjCgLrHdi+kjec5tdc9MqjHqw7kVPY7JvpfNYSl4V
	Z1mmF3uiEQZLQ/dIqvZnshvMpYuJU5VdS/gd2XLSaN/+6R8yp41XzlABo35OAuTaYD/hVnL+9v4
	Yj/l8aAzVCqTWtvUU2nJ98L7iIKonZ0H0BQpFD4jZyt7x6lHpPUK8MpRKkheYlW9yU5abb8OgHw
	l3DGjfl3PPt
X-Received: by 2002:a17:907:97cd:b0:c21:9cf4:e1b0 with SMTP id a640c23a62f3a-c24e58cfc35mr790555766b.3.1787672936642;
        Tue, 25 Aug 2026 08:48:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd69asm16682066b.18.2026.08.25.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:48:56 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v8 7/9] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Tue, 25 Aug 2026 16:48:35 +0100
Message-ID: <20260825154847.197948-8-biju.das.jz@bp.renesas.com>
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

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 drivers/pwm/pwm-rzg2l-gpt.c | 45 ++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index a5f85a510dee..6f47e14cceab 100644
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
+     operations (GPT0: 8 channels, GPT1: 8 Channels) and each HW channel
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
@@ -469,6 +493,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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
@@ -507,6 +539,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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
@@ -514,6 +552,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0

