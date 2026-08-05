Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A547124C
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935751; cv=none; b=IHpglAx2mkQ60CZQYhJfwhel/5u4fl6jn1LPBFq/58x4vmU8ALBnIJYbxaq+pbqkRKY5jPZo8kbV8hSBgUkXybWKqyFksRiawOdpPd4xXWkH/Nvczq3+FPUf4E/VQbAQGBFMB8HpM4h9MXYm+QcUMzVSue9exC894qXIV9Ure4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935751; c=relaxed/simple;
	bh=rWZwf1SmZmy+I60NhIjL5+z4C+Nz7YTugxwvI3MpXGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRlWJkwv0GwXI0JTFNGt3MOLEYrxS5QAzq9cdMRuvSLnEb56DrY1CIjI/XsEjs22HtqPvoiB/46r+IAcCj1RraDdy9STKhDGG9499vtWu3K/s1T+EzSOq2VD2uhl/Vnb3XvnyRLieRVV4DTX42UWBC1nLYOEbnq7veofsWgmPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+ZB/KGc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+ZB/KGc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so742341a91.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785935748; x=1786540548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsowAhie0fn+JDFgZmQoMRNcudB/ZaxkZWEVB+SjP1w=;
        b=V+ZB/KGcCtaDUhzGKcko0RPPEFoX1wQ+iAPr9VHD24Pi8+mygCZl+EK+U76uF3m89f
         RkuNWEDL5OepG2kZ2iw0dktkc/1AIrAMJpP8I9v2R3AcLvIBcBNS86jLdzHezf4I6Gk8
         gsA29QMrI/9dPoRtg1sUPW/hUEnDo03iwPm+ILMw8GaUGJEMXLa3V3AgGjUHvEtRXLpw
         AI+VdWfy78O4XiLp5AdV0CuUOvuprABCfMVucW3Yv2emsBvnXMCz4nx9du0V9q0WdO//
         YxFfGOdOVH94MbAY0EgFWaG/JFJSNxLxBLat+mt7FakWDP+icgKO5l2K4xQbpjRDVgm5
         v5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935748; x=1786540548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsowAhie0fn+JDFgZmQoMRNcudB/ZaxkZWEVB+SjP1w=;
        b=OD67LOZCiWk/L3s4MN4ye5/kJcBvcBtZl+ssL2+I3Akvu6ZTCpduWrFmhS7AkqaKaH
         RopMTurO5xn5sg7SQMc+VMbplrp+blh0ufGhvEeqfjELLxryCKCa/Iy+ar/v0z3fbKd9
         fVouE/HWptG5N8kKxK3Pbq9+UIkE4R/TUF1oHtDbdZCK7mPRdPyfNqvzxlXqwQdjBHGE
         LAUJQudbi/jjeEJ/fBv9EaMZOxxCa29mLuqJkdPR1Sx1mHUjgwCGSHZtStcDJDfx1gfi
         0tgYUG9UcpmhuEgxGr/yfAxeXKbfL6sjOX1a6tu6bD1+nmd9BpxQjuieg04Dv1H+O1cO
         m2WQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDYHwxOWe17n5+xtcx2lvpTkqk2KSfpLdLTgA2mqXak/jYQ5ivEL89RQ7uM9vQY66Zs0T4odkikCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H+TZARj9TuveQo9u+XV+2mrJ1DZKwHC5upua/dTbvaC0PtaB
	8eii7ZGdTu7ZuwDRhCw86HRL66pXjV9tIMvCamaMX4yguoXW51ItcLDE
X-Gm-Gg: AR+sD13dD6gqiEgNFcDFRkhKnT85WHcv8+k1GQZuOsffbFm94H4bp9In/pUEnP/8dfP
	1i/RUJjam4fIaxXWrPNAVe6clZVXKe2ciKrqxhsj4EGxcjCFC0gZcVoHpF8bTz+mI7dXFEVOAVr
	rD1E+OzeB4LMtc0eqmPxD/KKUvx2/0kb6ME/B7LnZAW/ZQAaU77tSA+PP2jiFKmUJEH76LdTn5s
	XBLwdIot/4NupBWNGrL/lKXbakNDXyVFKvs9PWX4XoFtvHLqNxnQtrDV2nZk/Pco5Od9G5poEth
	1S1aRSQ4JZdvHwAAVsFLpOvnl20VkspW/GyJwNLmaN8kbKySUs7IdrG1IL1BqG5lZArfUvNc47J
	PgA5ELlkGoT3ThvPNgVsHCZcZvo/4HxsKNpDrCCkTSJIm6ec28dj7vcI1UprBs8qZBQV6WpiW3f
	bpZXC0iyJ/IZ9FQeF9GrQNWZ8GrNalVAYYO1TvHP15tKV3ZoO0B2WsbzmYCzebBLuvagWmR8Y5
X-Received: by 2002:a17:90b:3812:b0:380:f389:447b with SMTP id 98e67ed59e1d1-3903c592834mr6034525a91.11.1785935747648;
        Wed, 05 Aug 2026 06:15:47 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.4.123.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm18292261eec.18.2026.08.05.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:15:45 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 05 Aug 2026 10:15:18 -0300
Subject: [hwmon-next PATCH v6 2/4] hwmon: (adt7470) Add ADT7470_PWM_MAX
 macro
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-adt7470_thermalzone-v6-2-5605a5f95467@gmail.com>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
In-Reply-To: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

Instead of a magic 255, use a macro to refer to it.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index c45b984c02e6..87ddd7b8ddae 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -100,6 +100,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define ADT7470_REG_FAN_MAX(x)	(ADT7470_REG_FAN_MAX_BASE_ADDR + ((x) * 2))
 
 #define ADT7470_PWM_COUNT	4
+#define ADT7470_PWM_MAX		255
 #define ADT7470_REG_PWM(x)	(ADT7470_REG_PWM_BASE_ADDR + (x))
 #define ADT7470_REG_PWM_MAX(x)	(ADT7470_REG_PWM_MAX_BASE_ADDR + (x))
 #define ADT7470_REG_PWM_MIN(x)	(ADT7470_REG_PWM_MIN_BASE_ADDR + (x))
@@ -850,7 +851,7 @@ static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val
 
 	switch (attr) {
 	case hwmon_pwm_input:
-		val = clamp_val(val, 0, 255);
+		val = clamp_val(val, 0, ADT7470_PWM_MAX);
 		mutex_lock(&data->lock);
 		err = regmap_write(data->regmap, ADT7470_REG_PWM(channel),
 				   val);
@@ -910,7 +911,7 @@ static ssize_t pwm_max_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, 0, ADT7470_PWM_MAX);
 
 	mutex_lock(&data->lock);
 	data->pwm_max[attr->index] = temp;
@@ -945,7 +946,7 @@ static ssize_t pwm_min_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, 0, ADT7470_PWM_MAX);
 
 	mutex_lock(&data->lock);
 	data->pwm_min[attr->index] = temp;

-- 
2.55.0

