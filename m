Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1942379A
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576165; cv=none; b=OmogfPXb5H0tbd9X9Rjm1UeiMRMHgOQso3cKJTLVLUavdffdG3JucDfVVz5AnVMdn3bU766nMnFM29wY20uej7xwzEFB3OEglJnnpQKM+h7GFxP5SU4brl/2yUUqKj21Gc3I6LF5EgQd9NVroVGNJg0ksAi1k4q7pJvaQLypSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576165; c=relaxed/simple;
	bh=YG+IiEVQQovs2Oyy6pGJHFjkdJTDdsD9yEfGJakM0mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twbeeL+1xbtQo7BlXibGdbWC2x7qeHEwl/bmixSAhSFruuRZMPtz+a0e3vpXAX3OFpGWfPLaQ9J+e/TbJZb/XAx4ide46DA5SEYlg7/QmIla53NnlAHafwXt7SlQEMjyJDkiMC84Mocn5tekwqHiOecErPBhdTfCR2+DrFgMwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPZ2gA1p; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPZ2gA1p"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c207cb16cf5so537131966b.1
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576161; x=1788180961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9T6PUvsAbU79P22b+F31n1QypVkr8AsU12//9zas9pI=;
        b=jPZ2gA1ptmVlTpeNlETlAKNvF/PnANob5eiwHNXzRm7jicEM7+Am1x/x3/0fQAr9x9
         JBMU1GEbg9yXQ2c+QB6YOStCKiz/xdeiKvtMFiE3Q9zcXLIhrOdDyKdxqU+t1iBQIvjs
         izcxF+noreF37AOFsTNMeJYh2+a4cm7NnfrNiGCzOR6BgiEAjYxHJ/C5F1+4xtwRJ6Ik
         JzQ8ZdO6QmeVLe44fMTqOsdYHP9iP0UGGTMtf/E3Nr4ztj5tMC0qLdGVSTMts4c6uoHi
         WGyofM/3jgXeIHorhW5IMkmQZtYmg8Utxr2J0vDI4OSN3wGekr0jrtnAaG+axrhLrhm2
         0FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576161; x=1788180961;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9T6PUvsAbU79P22b+F31n1QypVkr8AsU12//9zas9pI=;
        b=dNeKadRcMCxwaTWOANic2ATLQWwvC/Rk1SU6fKDYhua8fUIzpBxt/Z9fIiJ7TdozUy
         vgzIlLTjGXR+E5A7+LbNO51edVeEbbdtkidsOHnMoLE8vtBfD8KviOobT5B864CERkCb
         yuWw3rVay1iXuekKRXN1TgVsK6nQsCqp2xhDzlGs+JF3tWb9pSBX76mGNJo/JrmVC51n
         Svgfj1g9sGE331gupI3mJMQgZsQm1ywsd/4kUbgC189ISJhrC6oJrwSjy9714zWwqvtH
         9ltkFPdD/NZT5jwuOnWGoc8wQtlwR5OeqMwv6IOA2O6L0GxXm255r7Wq7cfXPAESkO79
         oh0A==
X-Forwarded-Encrypted: i=1; AHgh+RruIQE7Al9DNR862zLS7ZlMYImGTvTcZzJbkKFutxFRVsojz11TnRVa0DSa9iI1zTum8J2m70kg1tc=@vger.kernel.org
X-Gm-Message-State: AFuF++nGdb9Fjh8Kabkb5ZsPa8W95NjZ5eayjq1ihfi2CatNL1e57UlT
	w5CB4khf90oVjIkHcLbwEkOP8EQmLiQXAjmVvX+TZFs/rHZZPeQbl9d4
X-Gm-Gg: AR+sD10B/ReZgM1RnpGsd+iBSmTeriPCIwVHf8NkN/rROXuqN1WgCdwGUYFZY7Qpfl5
	gXk1bUJH7i7eElCGhW2bMjDmqa3n9Icp4bPlDcJ+fqCtAEaEc1s1PYMbK/QEaWhziYqY3vrmGiX
	in0SHHdIQM626AUf7OArqiA3H8Lfl0FpF3vcptCoR6Dx8GiEou1NYDZfWMs4yDRL+lF6cm7eQHK
	N2nYu980nDt859DICh1pAXaueBOc46/GZnofXwOxCA7YnxTpE2WceRYCWOMHmxOYj8ssrS3EeKJ
	xcD/rKr+4wn/wp41Rvae5JzgAtQAnly1fJuLz3mav6vYRh73FnZvwiXQwL1ewp0bGsm2v0Hye/E
	/iLQPLfR+vOyYKfPL6RAEesaws+VLf2dolmlS06/wZv5TPJUOtJXiLoed2EVIuh9GK+m2ULKEMn
	EjDkE36e0N8IOTC5SglOsxxaXFo+9PaBJQugi4U+M6oFeXb0s6MTs0SzH6yBNSYNnEG8B4e33/k
	gsxOH4DF/nUiw==
X-Received: by 2002:a17:907:934c:b0:c15:f65a:43a8 with SMTP id a640c23a62f3a-c246a604950mr3000521566b.12.1787576160732;
        Mon, 24 Aug 2026 05:56:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:dea4:599b:49a8:96f5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9c9fsm1245403066b.39.2026.08.24.05.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:56:00 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v7 9/9] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date: Mon, 24 Aug 2026 13:55:15 +0100
Message-ID: <20260824125523.131762-10-biju.das.jz@bp.renesas.com>
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

The General PWM Timer (GPT) is capable of detecting "dead time error
and short-circuits between output pins" and send Output disable
request to poeg(Port Output Enable for GPT).

Add support for linking poeg group with gpt, so that gpt can control
the output disable function by adding rzg2l_gpt_poeg_init() to parse
the renesas,poegs device tree property and establish links between POEG
groups (A–D) and GPT hardware channels (0–7). For each valid, enabled
POEG phandle entry, the driver:
 - Reads the renesas,poeg-id from the POEG node and validates it against
   the supported range
 - Records the GPT–POEG association in a per-chip bitmap (poeg_gpt_link)
 - Configures GTINTAD to route the output disable request to the correct
   POEG group
 - Configures GTIOR (OADF/OBDF fields) to set both output pins to
   high-impedance on an output disable event

Non-enabled POEG nodes are silently skipped.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Added rzg2l_gpt_poeg_link_channels() and used __free for deallocating
   device node pointer.
 * Replaced dev_err()->dev_err_probe() in rzg2l_gpt_poeg_link_channels().
 * Replaced local variable cells with num_poeg_pairs in
   rzg2l_gpt_poeg_init().
v5->v6:
 * Dropped extra space in poegs variable assignment in
   rzg2l_gpt_poeg_init().
 * Updated the comment sections of rzg2l_gpt_poeg_init() with POEG and GPT
   in upper-case and replaced configure->configures.
 * Format specifiers in dev_err() changed from %d to %u in
   rzg2l_gpt_poeg_init().
v5:
 * Updated commit description.
 * Replaced return type of rzg2l_gpt_poeg_init() from void->int and
   probe() checks this return value.
 * Added more error checks in rzg2l_gpt_poeg_init() 
V24 from [1]:
[1] https://lore.kernel.org/all/20250226144531.176819-1-biju.das.jz@bp.renesas.com/
---
 drivers/pwm/pwm-rzg2l-gpt.c | 92 +++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index c61c648f71a8..4e1591d81b51 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -45,6 +45,7 @@
 #define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTINTAD(ch)	(0x38 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub_ch))
@@ -62,12 +63,19 @@
 #define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
 
 #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
 #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
+#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
 #define RZG2L_GTIOR_GTIOx(sub_ch)	((sub_ch) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIOA)
 #define RZG2L_GTIOR_OAE		BIT(8)
 #define RZG2L_GTIOR_OBE		BIT(24)
 #define RZG2L_GTIOR_OxE(sub_ch)		((sub_ch) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
 
+#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
+#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
+#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
+	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE | RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE)
+
 #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
 #define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
 	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
@@ -78,12 +86,17 @@
 	((sub_ch) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
 	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
 
+#define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
+
 #define RZG2L_MAX_HW_CHANNELS	8
 #define RZG2L_CHANNELS_PER_IO	2
 #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+#define RZG2L_MAX_POEG_GROUPS	4
+#define RZG2L_LAST_POEG_GROUP	3
+
 struct rzg2l_gpt_info {
 	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs;
@@ -98,6 +111,7 @@ struct rzg2l_gpt_chip {
 	u64 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 /* This represents a hardware configuration for one channel */
@@ -459,6 +473,80 @@ static const struct pwm_ops rzg2l_gpt_ops = {
 	.write_waveform = rzg2l_gpt_write_waveform,
 };
 
+static int rzg2l_gpt_poeg_link_channels(struct device *dev,
+					struct rzg2l_gpt_chip *rzg2l_gpt,
+					struct of_phandle_args *of_args)
+{
+	struct device_node *np __free(device_node) = of_args->np;
+	u32 poeg_grp, bitpos;
+
+	if (of_args->args[0] >= RZG2L_MAX_HW_CHANNELS)
+		return dev_err_probe(dev, -EINVAL, "Invalid channel %u >= %u\n",
+				     of_args->args[0], RZG2L_MAX_HW_CHANNELS);
+
+	if (!of_device_is_available(of_args->np))
+		/* It's fine to have a phandle to a non-enabled poeg. */
+		return 0;
+
+	if (!of_property_read_u32(of_args->np, "renesas,poeg-id", &poeg_grp)) {
+		if (poeg_grp > RZG2L_LAST_POEG_GROUP)
+			return dev_err_probe(dev, -EINVAL, "Invalid poeg group %u > %u\n",
+					     poeg_grp, RZG2L_LAST_POEG_GROUP);
+
+		bitpos = of_args->args[0] + poeg_grp * RZG2L_MAX_HW_CHANNELS;
+		set_bit(bitpos, rzg2l_gpt->poeg_gpt_link);
+
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(of_args->args[0]),
+				 RZG2L_GTINTAD_GRP_MASK, poeg_grp << 24);
+
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(of_args->args[0]),
+				 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
+				 RZG2L_GTIOR_PIN_DISABLE_SETTING);
+	}
+
+	return 0;
+}
+
+/*
+ * This function links a POEG group{A,B,C,D} with a GPT channel{0..7} and
+ * configures the pin for output disable.
+ */
+static int rzg2l_gpt_poeg_init(struct platform_device *pdev,
+			       struct rzg2l_gpt_chip *rzg2l_gpt)
+{
+	const char *poeg_name = "renesas,poegs";
+	struct of_phandle_args of_args;
+	struct property *poegs;
+	int num_poeg_pairs;
+	int ret;
+
+	poegs = of_find_property(pdev->dev.of_node, poeg_name, NULL);
+	if (!poegs)
+		return 0;
+
+	num_poeg_pairs = of_property_count_u32_elems(pdev->dev.of_node, poeg_name);
+	if (num_poeg_pairs < 0)
+		return num_poeg_pairs;
+
+	if (num_poeg_pairs & 1)
+		return -EINVAL;
+
+	num_poeg_pairs >>= 1;
+	for (unsigned int i = 0; i < num_poeg_pairs; i++) {
+		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						       poeg_name, 1, i,
+						       &of_args);
+		if (ret)
+			return ret;
+
+		ret = rzg2l_gpt_poeg_link_channels(&pdev->dev, rzg2l_gpt, &of_args);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int rzg2l_gpt_probe(struct platform_device *pdev)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt;
@@ -520,6 +608,10 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (rzg2l_gpt->rate_khz * KILO != rate)
 		return dev_err_probe(dev, -EINVAL, "Rate is not multiple of 1000\n");
 
+	ret = rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to link gpt with poeg\n");
+
 	mutex_init(&rzg2l_gpt->lock);
 
 	chip->ops = &rzg2l_gpt_ops;
-- 
2.43.0

