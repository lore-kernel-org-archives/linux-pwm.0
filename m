Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606AF3AA4F1
	for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2026 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762427; cv=none; b=Vn0oYqOc15FCgo+TaRt5OReVwkC954SeL4GM7X6MWGD15x/weOU3EdeRF60zf3LnUFSosBpLUmOWi0YzFyI3IpuM877ZdKNTWrb0P6qA7vDPvHpxWcrzpc8lkexv7ySCJiQhSzqNm0Mha0SO9+GzV5liriS74tyaXweqhmrCN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762427; c=relaxed/simple;
	bh=rZ8iRBSZE6xpKvhJ0ZOhQ94EMB7ydccG7ry6lP67m40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHQt0e9E2ikq3JXdjEzPN26cw6JhP2AyURXjgVZniD6e6tx646nZnZzAGU8Ni16KLZhi945B7tWPALZvxSz2bLOUj+emyxaSVICLr1CxeIGjOgUTa5VqhBrcucuh5KzO3rLJhv5NSeWeuQhLowyj0Png4fSqrx/liRgNwmXs1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrSgwwQ4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrSgwwQ4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d5cad1a6baso26946135ad.3
        for <linux-pwm@vger.kernel.org>; Sun, 06 Sep 2026 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762424; x=1789367224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcF57hu0+g/ff9yOn0KrB5lQwjHMKCpuTDcWS1ABzmY=;
        b=nrSgwwQ4mP+GDp/Ie1Umg0MgTJOWzUZbn1CzHIT/7zk11giFBiSXHhIAfGb5cPRtYs
         UtfXY7ZOHkFuOWEqnK0g1/i1njA4h0GikT58SCJu6rPyd1xP4kLX9TSDiPpFHhOMek4c
         biJOQev9dP7EPtqWacpajMhlYMDyET1wEg4L1tSHemROFGd3jvCtVftk3eJzUFgnzmoF
         kEO4IJ5HTKQ5MO2kS8RfofjUfo+3r/F/RuZeXVH81D7Nwmd0nSCHoav4OblUVEwsglAk
         zh2xkeUBjk3qWSJ3s0e6+HykZ1m1GfKGB5GQMdIPdS0hkQEXixTfJOChnHwazPzABkPg
         CJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762424; x=1789367224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcF57hu0+g/ff9yOn0KrB5lQwjHMKCpuTDcWS1ABzmY=;
        b=d0UNiF12KAJFiZmV0Pi6oJnas7EJFYi2QzlMFIXD/CCHpR1zEk4+S7h8IJpQJWgqhw
         4TMZGQb/xujGqrABh0PEgz1/xKV6GQe+54zkBO+Rv9iUB8ML/IAJYtkIvfzQYrQO6pib
         D08LwOmVFgL9z9wAvV1KpmaJK55vksxrfMAUV2rWfLUInkzv32tuPa9Tog3gEI4wuQki
         bC1M9puk17+GuyEdybENhs3OJD2ZEkiEAsZKBrgrvgMBRCZnuNoNoWBg65wVEelShw9j
         xlbG41Rs3WyCFmz0pUJk8tkMYdtAP7rA/B5KUwGBJC/+BL2tGbIVKbyCFGv3n52fGF7E
         Xjqg==
X-Gm-Message-State: AFuF++nO5mGUjSqF+LWnvmHFICEyHTTIPe1Zyx8YQhntNFmxyX6OmjLH
	aKdzoD+gU365PInCnw4MhpEBwUpqc+EG2bSBzaMXxvvZGE2c5qiszkYw
X-Gm-Gg: AYBFou3T/EoEB8i+1OU0vrIq7OIzzzWhbSrLMWeAO1bEQ+jC2wrcmQ17a9pgmtVg2YZ
	eaCskT6QqFHkTKu6JtBeUQgSiQB8vGnJg+6aubsEN7FC1iAqZAWHWEx8c/aBhFxNU6lH/xWfz6R
	TSfB4+Ynn/dU4lBmCplUEAk1HDS2L16W/05FK4r8rEYZ27OkPS/cAqMqjLYiEGsDXIe0q1Feu+K
	XXm3PC0fyqQk0gBv1L9r5/biGC1Ele2UsULULaRpZ9wdOMWvZQfbI0x1wA1+US/NYtka3wWECgb
	LM+G0NFpWCQyx83iV1piVGW70cYbUEP6fq87zCZVK1GEWZCUOU2t2z0+280gA18sjKPCdWIOtb1
	WnK87KolyrktHkLhXUt1pqKBhpy3CdRGjNv88yCzvmtYMwO7sv20F6iFP1OBKuQ4tJ7mg3lcHeW
	1T5jumVU23UkkdGHdw0MDttIzA/ASXWPnzmT0LPuAv4EulXkueBO3kYYmFcR/l1cm0epbZZ9KhT
	qEnPfmx/BxkaQ==
X-Received: by 2002:a17:903:1b4c:b0:2d8:d4d3:da4d with SMTP id d9443c01a7336-2db1262325fmr342823045ad.17.1788762424119;
        Sun, 06 Sep 2026 23:27:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm20404392eec.4.2026.09.06.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:27:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: fix typos in comments
Date: Mon,  7 Sep 2026 11:56:58 +0530
Message-ID: <20260907062659.15500-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/pwm/pwm-brcmstb.c | 2 +-
 drivers/pwm/pwm-pca9685.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 790ef7ffbbe5..78378787e4e9 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -101,7 +101,7 @@ static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 value;
 
 	/*
-	 * If asking for a duty_ns equal to period_ns, we need to substract
+	 * If asking for a duty_ns equal to period_ns, we need to subtract
 	 * the period value by 1 to make it shorter than the "on" time and
 	 * produce a flat 100% duty cycle signal, and max out the "on" time
 	 */
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index a2792b803643..3374ed76f8d3 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -54,7 +54,7 @@
 /*
  * The time value of one counter tick. Note that NSEC_PER_SEC is an integer
  * multiple of PCA9685_OSC_CLOCK_HZ, so there is no rounding involved and we're
- * not loosing precision due to the early division.
+ * not losing precision due to the early division.
  */
 #define PCA9685_QUANTUM_NS(_prescale)	((NSEC_PER_SEC / PCA9685_OSC_CLOCK_HZ) * (_prescale + 1))
 
-- 
2.48.1

