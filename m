Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36A2D5432
	for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785300405; cv=none; b=n21DV6/ktvnXJtgPltNeS0XHWNzJv4uDjCHo/aQ4vtHTlRtEPG5IWh7ZVhLsk4IVTnB04XRLgtY9Dwh/F9Gl0ttpOtmZks/RVGw2euOiN9F3IkmRNE7VuGZia3IvB0JRMpOW+KaN6i3ZlSNWcwgX/XlRB6Wz0vFV1ifQgBWzuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785300405; c=relaxed/simple;
	bh=rWZwf1SmZmy+I60NhIjL5+z4C+Nz7YTugxwvI3MpXGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oczIHDVgV9zHpaH08P9L59Wpe6sX5vcbysOt8DTAZMex0ivm2w907Gqabbd1PGaMDllJEGRvii+f41ZlluPqcVzvlUxqZe5nP4Qw4lt1VRJ9jaCZaqiMTZMnY1TB3SQwjLHGk3ueaMtA8Gy0yqKZlNgTWOVuwcF56zkGQUNpcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIEHBQqG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIEHBQqG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so530293a91.2
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2026 21:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785300402; x=1785905202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsowAhie0fn+JDFgZmQoMRNcudB/ZaxkZWEVB+SjP1w=;
        b=SIEHBQqGEFgXbC2VXV7kxS12kxpAT53rF78v828mVe1erULTDz50ne5LNHaRpmYypR
         GV0h8RC81bamgIPop7rsw+ShB40YInRRSNMUrYtK1WFgFxkA8lm60crnNHxNMtpza1hs
         BHOYGNzFSUWZTxQm3Ub7PYCHMoQQMyWxuNRvpTRIox2zQ+u6m93rzC3T47uitc27jTQ1
         z0FXJe1zFAzbDtaIlmTyRka7uMpdONu6Hkxz81B2CaLivSU0naD2GoE7AmCzukmxH1BT
         sYzq34zJxS+AtYvqy5OH3PA/VMAObzwFSfrNTfJn97KOZVMHAtWhsKbTRaeG6frE6uxh
         +ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785300402; x=1785905202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsowAhie0fn+JDFgZmQoMRNcudB/ZaxkZWEVB+SjP1w=;
        b=LWNpY1eT99k7bbWUu3y0oLBwp2imR0Rf4QFRtOyZqYScCvhlRWid8Wg/dmpBVyteQA
         kZTBCb10fQCWzvuyDN6cpsZxK8Y1CD5rHADUIULAUoWdQfJn3aGBTaBSmllI+dPYNDSW
         qpHwVADNsJLZ00DOro0vaHHg0XziG4Sq5pQYGpN0AGJUirQy+rlg/38fNavC8EQzBrh7
         BEKymLRTha42LE6gp+LosmgyM2ptH/6ZrlmhrglmLEd8Lz+lglyjQRZzcpQFNwPp13r9
         oyXvA1nOf8W3CdfkYehs5JyFKmEFPVcodtPgfaLLGGH595DgpXrs//oK10tBhSXr72uL
         Vftw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+epLBNk7icNw85HHfhQiM84VkAf7aG6gQJXmR+U2JJOq8MS791q5L3FxZGtkA3hFbwD+xuvSmCQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRx83nh4zXNTlaJeAw2kfqgRowzpwboa+gvqi6iX+BnMnuKqR
	uB3tTk67MUX+0wbmJhXqLL10mwtAaYM/RRKkNE2WO6jpCCiLI3lYCViq
X-Gm-Gg: AR+sD12x/b5jdPCF1LnTwqxiVhiIJUoknR6ca7XZUXeBhc6XgYa7rlTkpho4rW09a8M
	skuB6x1DsOULdS8FZkyVT/ealFanY7mEQpp514ooofUyvszKTmI7gXVNNGVYkGb1IgZfTlCk7A+
	bgT0lB1kxkgzZjTP3PlWroZUACxJRj0Qw4JgnIL3FX2lSdsQhfFhTFzxcVp2HSwBctePUipt12X
	OOuu7jS9q2+ZYA0Qfx+v+Zo7Gxl7tn9XYh/oNvpkfRF8R7vP8Q018bYUU/k/abgu7+rBkC04d4r
	LTF4U/GYsjYIJEJi93ikzi4HkAjIf57MOhHMbzVkkLtKV7iUqSN1hfggqDZTV1KoNBasRw8IyxO
	zufY5vnvd0s4URyV7yEVWIDY7GbcOml9NjM5ElxRZSfa/fBOYa6YK08JpmNm2oluTdE/dfIGQps
	qvp6WXXDL2F7feM/+fTLg2qbdCBxZKaq3MdFXNOoMArEIFOgNuuDs3mOcFp9rjSLU0iwJSl62oL
	HDA
X-Received: by 2002:a17:90b:3c07:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-38f6a1968f4mr6147224a91.0.1785300402308;
        Tue, 28 Jul 2026 21:46:42 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b6d14bsm4730437eec.10.2026.07.28.21.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:46:41 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 29 Jul 2026 01:46:10 -0300
Subject: [hwmon-next PATCH v4 2/4] hwmon: (adt7470) Add ADT7470_PWM_MAX
 macro
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-adt7470_thermalzone-v4-2-c14039dfa0e6@gmail.com>
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
In-Reply-To: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
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

