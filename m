Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873948B39D
	for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672939; cv=none; b=YIeRWWNysqBBd0nHDyNtg7HkNfvOdMnZOIwEZhNNhaUZu6+fqHzw+/V5E6xeGqUri/Yw+HYbm3XcmqvPm9xRmPV3M/xS053LMKCAkV47KaEBLcZRCoKkAs7IN6BAYtXlagDtpIJzn3SSxPg7wlpliSfans+iSHRomosZDtL9kVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672939; c=relaxed/simple;
	bh=XXZ5i5IksEBJwAVQKMAf++N15Fqn4fMxzGytdUiCm/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQqYMy+PZCWSfhFcLPIk6G+ZHrL5UuiOe38AEWGUvPTpnIWCa8bq+gU2QKGR/FIWvLdhKM26XLrDiBn1K+sOiWG1JP9wE733CM/QtPjBe6Bhnnqxw+aZ1yM5gsj0Qz++gWQEcugVyB6E+dd+mtUhldkLETovuGsNWIj2theii4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9J7pjkj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9J7pjkj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so885204066b.0
        for <linux-pwm@vger.kernel.org>; Tue, 25 Aug 2026 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672935; x=1788277735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQ8qhR8/HKXyE4EUMBBNGdK4y+PK8YryxX3K0VTnjak=;
        b=M9J7pjkj0WftVRVx4KHhBuoGJF9dAgEJyqWsrc6kw2VkwWMpOzWZzAjda0MtcR0ElP
         +TydhwXz8P0ePH9ZeHUnC4NiIeQxDoyqYqNJTciEI6ckNzLc8i9SUvXcTk/KlR5p1X8G
         nTMAy+9Yk5mnrxZtamv3GvFdWXcRQ0aYvCjR6EKbtvzJuFimM2JJRZAkQqlX/JP1HaNj
         a8zd0kKU4tt0BZVGPrgvqtsvU8GwNuJwMIWtY35TO0Dovgrc5+uLTRXbxxApaWc0WG5y
         4EPsnj/B6F3DJWtvi49KdMIGspVxsfPh31OyP3ag0BxKysOarTDzZ/2YtqUOT0gqmUfb
         KSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672935; x=1788277735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mQ8qhR8/HKXyE4EUMBBNGdK4y+PK8YryxX3K0VTnjak=;
        b=E5iWkJFS/hxsLIvOh/FXACdgO9ivkPAlOfkZ2WqXSbyq+uMKac7KTgU6wZJOElbbzf
         t3kgKdo50fq8rW83siZoRG3nYDJTBr6hA12ewGRm2jW0TTFJe4uO5X+j0+xp3OGzfwcV
         Xr6pcoGyQTY7om5PUNHCz9b7qrF9dsyiQDHV7aLanNhg6P4eXBqmVtw+cn4p0CQe5mPg
         BUEztQeGj61cqPrLqtkRL0aeDx52KzK6xwM4VdmaCaE4gQqulcXs+Nnh+9aMLtx4gola
         IXfh+PhBjohlc7TwqCpAEkEdMMSg4SQDn3km9T308FQ/tWnxwKhUjnsfF1KFtiotVqcE
         Q4Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq8cZv8/VifxHWpU15o8Qvc0UFfOZ/qpJ5LF4GICfJvI0KHnfp/Lin2finZ5XGaB2CFvwL7I5LQLY=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ9NKzhxNZDMelZY/ZBRYRbB4f4B5FTkSbHPQKmSLqRaJ1P4gs
	pbCdGyyo76RjYQ/VJs4LGfHJCoRl7Bt2GqaCRLk5pvvQ2MivSUjGHDl5
X-Gm-Gg: AR+sD13Qvp5KRb4FgKxQTtP9du/ZRJfGyaK1CH3MIAVdREnAeLbbqZ+YB1deSgWrq2w
	vplQWl/cLVozi4bqIolgF0h9W3sOIe5v+eOoKyKAY2y2w2Y6aY14kuHaf2Pfwm3x0N6We1hNvby
	fiqlmaOQ5PMHu2BgV2eAhELD2heU2LoyYvdzV3koHPcIb93Yw2Z+84VdbtSwWRHpx90rUwtSkEz
	thj+eDA5nYm6nyXUy/zJWTHZ1LcqOaFljXz3soOidi90erSc4GM7zxAFfd7D9/ii08ZBDbc6+uB
	tr55Z7MdM1cvpUR+y0c23//pQinuZPRaeoly3kadklsAx53nSR39Arr51zn0s3xqRjlW8OHCGO+
	KG7Xl2W6zHx7nXrLVLj6V/5Exu3mnkJX+3RtndCxTfhldBtUEQFC+keX4ZkZ6fvPOJDDZ9E2hRI
	DdxKSQ9PYj1UjY4QfTWF1TKAsWqFHJSO/qSslmqjdzzB8hQ/xzOBffrtY6VuBgjBXuFrQwb3JCW
	AjUf+7NNXqZ
X-Received: by 2002:a17:907:1c0f:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c24925e4915mr2610407366b.11.1787672934816;
        Tue, 25 Aug 2026 08:48:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:81d:57c0:e4cb:959c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd69asm16682066b.18.2026.08.25.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:48:54 -0700 (PDT)
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
Subject: [PATCH v8 5/9] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Tue, 25 Aug 2026 16:48:33 +0100
Message-ID: <20260825154847.197948-6-biju.das.jz@bp.renesas.com>
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

The RZ/G2L GPT prescaler steps are continuous powers of 4, while RZ/G3E
uses powers of 2 but with a discontinuous sequence. Add a
calculate_prescale function pointer to struct rzg2l_gpt_info to allow
per-SoC prescaler selection logic. Replace the direct call to
rzg2l_gpt_calculate_prescale() in rzg2l_gpt_round_waveform_tohw() with an
indirect call through info->calculate_prescale(). Wire the existing
rzg2l_gpt_calculate_prescale() into rzg2l_data to preserve current RZ/G2L
behaviour.

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
 * No change.
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 47be358cd749..a5f85a510dee 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -78,6 +78,7 @@
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
 struct rzg2l_gpt_info {
+	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs;
 	u8 prescale_mult;
 };
@@ -293,7 +294,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 			wfhw->prescale = rzg2l_gpt->prescale[ch];
 		}
 	} else {
-		wfhw->prescale = rzg2l_gpt_calculate_prescale(period_ticks);
+		wfhw->prescale = info->calculate_prescale(period_ticks);
 		rzg2l_gpt->prescale[ch] = wfhw->prescale;
 	}
 
@@ -507,6 +508,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
 	.prescale_mult = 2,
 };
-- 
2.43.0

